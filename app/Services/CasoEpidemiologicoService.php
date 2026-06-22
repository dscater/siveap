<?php

namespace App\Services;

use App\Services\HistorialAccionService;
use App\Models\CasoEpidemiologico;
use App\Models\CasoSintoma;
use App\Models\User;
use Illuminate\Http\UploadedFile;
use Exception;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\ValidationException;

class CasoEpidemiologicoService
{
    private $modulo = "CASOS EPIDEMIOLOGICOS";

    public function __construct(private  CargarArchivoService $cargarArchivoService, private HistorialAccionService $historialAccionService, private SeguimientoService $seguimiento_service) {}

    public function listado(): Collection
    {
        $caso_epidemiologicos = CasoEpidemiologico::select("caso_epidemiologicos.*");

        if (Auth::user()->tipo == 'CENTRO MÉDICO') {
            $caso_epidemiologicos->where("centro_id", Auth::user()->centro_id);
        }

        $caso_epidemiologicos = $caso_epidemiologicos->get();

        return $caso_epidemiologicos;
    }
    /**
     * Lista de caso_epidemiologicos paginado con filtros
     *
     * @param integer $length
     * @param integer $page
     * @param string $search
     * @param array $columnsSerachLike
     * @param array $columnsFilter
     * @return LengthAwarePaginator
     */
    public function listadoPaginado(int $length, int $page, string $search, array $columnsSerachLike = [], array $columnsFilter = [], array $columnsBetweenFilter = [], array $orderBy = []): LengthAwarePaginator
    {
        $caso_epidemiologicos = CasoEpidemiologico::select("caso_epidemiologicos.*")
            ->with(["paciente", "enfermedad:id,nombre", "centro:id,nombre", "comunidad:id,nombre", "user:id,nombre,paterno,materno"])
            ->withCount(["seguimientos"]);

        if (Auth::user()->tipo == 'CENTRO MÉDICO') {
            $caso_epidemiologicos->where("centro_id", Auth::user()->centro_id);
        }

        if (!empty($search)) {
            $caso_epidemiologicos->where(function ($q) use ($search) {
                $q->whereHas("paciente", function ($q2) use ($search) {
                    $q2->buscarNombre($search);
                });
                $q->orWhere("codigo", "LIKE", "%$search%");
                $q->orWhereHas("enfermedad", function ($q2) use ($search) {
                    $q2->where("nombre", "LIKE", "%$search%");
                });
            });
        }

        // Ordenamiento
        foreach ($orderBy as $value) {
            if (isset($value[0], $value[1])) {
                $caso_epidemiologicos->orderBy($value[0], $value[1]);
            }
        }


        $caso_epidemiologicos = $caso_epidemiologicos->paginate($length, ['*'], 'page', $page);
        return $caso_epidemiologicos;
    }

    /**
     * Crear caso_epidemiologico
     *
     * @param array $datos
     * @return CasoEpidemiologico
     */
    public function crear(array $datos): CasoEpidemiologico
    {
        $centro_id = $datos["centro_id"];
        if (Auth::user()->tipo == 'CENTRO MÉDICO') {
            $centro_id = Auth::user()->centro_id;
        }

        $caso_epidemiologico = CasoEpidemiologico::create([
            "codigo" => "",
            "paciente_id" => $datos["paciente_id"],
            "enfermedad_id" => $datos["enfermedad_id"],
            "departamento" => $datos["departamento"],
            "municipio" => $datos["municipio"],
            "red_salud" => $datos["red_salud"],
            "tipo" => $datos["tipo"],
            "captado" => $datos["captado"],
            "captado_desc" => $datos["captado_desc"],
            "pais_lpi" => $datos["pais_lpi"],
            "departamento_lpi" => $datos["departamento_lpi"],
            "municipio_lpi" => $datos["municipio_lpi"],
            "comunidad_id_lpi" => $datos["comunidad_id_lpi"],
            "zona_lpi" => $datos["zona_lpi"],
            "pais_lis" => $datos["pais_lis"],
            "departamento_lis" => $datos["departamento_lis"],
            "municipio_lis" => $datos["municipio_lis"],
            "comunidad_id_lis" => $datos["comunidad_id_lis"],
            "zona_lis" => $datos["zona_lis"],
            "embarazada" => $datos["embarazada"],
            "fuma" => $datos["fuma"],
            "fecha_parto" => $datos["fecha_parto"],
            "centro_id" => $centro_id,
            "comunidad_id" => $datos["comunidad_id"],
            "user_id" => Auth::user()->id,
            "fi_sintomas" => $datos["fi_sintomas"],
            "semana" => $datos["semana"],
            "fecha_falle" => $datos["fecha_falle"],
            "fecha_diagnostico" => $datos["fecha_diagnostico"],
            "tipo_caso" => $datos["tipo_caso"],
            "gravedad" => $datos["gravedad"],
            "estado" => $datos["estado"],
            "contacto" => $datos["contacto"],
            "hospitalizacion" => $datos["hospitalizacion"],
            "tipo_alta" => $datos["tipo_alta"],
            "fecha_hospitalizacion" => $datos["fecha_hospitalizacion"],
            "establecimiento" => $datos["establecimiento"],
            "hospitalizacion_uti" => $datos["hospitalizacion_uti"],
            "fecha_hospitalizacion_uti" => $datos["fecha_hospitalizacion_uti"],
            "establecimiento_uti" => $datos["establecimiento_uti"],
            "laboratorio" => $datos["laboratorio"],
            "nexo" => $datos["nexo"],
            "muestra" => $datos["muestra"],
            "fecha_muestra" => $datos["fecha_muestra"],
            "tipo_muestra" => $datos["tipo_muestra"],
            "rt_pcr" => $datos["rt_pcr"],
            "igm" => $datos["igm"],
            "igm_nc" => $datos["igm_nc"] == NULL ? 0 : $datos["igm_nc"],
            "igg" => $datos["igg"],
            "igg_nc" => $datos["igg_nc"] == NULL ? 0 : $datos["igg_nc"],
            "observacion_lab" => $datos["observacion_lab"],
            "observaciones" => $datos["observaciones"],
            "fecha_registro" => date("Y-m-d")
        ]);

        $caso_epidemiologico->codigo = $this->generarCodigoCaso($caso_epidemiologico);
        $caso_epidemiologico->save();

        // sintomas
        Log::debug($datos["caso_sintomas"]);
        if (isset($datos["caso_sintomas"])) {
            foreach ($datos["caso_sintomas"] as $item) {
                $caso_epidemiologico->caso_sintomas()->create([
                    "enfermedad_sintoma_id" => $item["enfermedad_sintoma_id"],
                    "valor" => $item["valor"] ?? '',
                ]);
            }
        }

        // 1er seguimiento
        $this->seguimiento_service->crear([
            "caso_epidemiologico_id" => $caso_epidemiologico->id,
            "fecha" => $caso_epidemiologico->fecha_diagnostico,
            "gravedad" => $caso_epidemiologico->gravedad,
            "estado" => $caso_epidemiologico->estado,
            "observaciones" => $caso_epidemiologico->observaciones,
        ]);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UN CASO EPIDEMIOLOGICO", $caso_epidemiologico);

        return $caso_epidemiologico;
    }

    public function generarCodigoCaso($caso_epidemiologico)
    {

        $numero = $caso_epidemiologico->id;
        if ($numero < 10) {
            $numero = '0000' . $caso_epidemiologico->id;
        } elseif ($numero < 100) {
            $numero = '000' . $caso_epidemiologico->id;
        } elseif ($numero < 1000) {
            $numero = '00' . $caso_epidemiologico->id;
        } elseif ($numero < 10000) {
            $numero = '0' . $caso_epidemiologico->id;
        }

        $codigo = "CE-" . date("Y") . "-" . $numero;
        return $codigo;
    }

    /**
     * Actualizar caso_epidemiologico
     *
     * @param array $datos
     * @param CasoEpidemiologico $caso_epidemiologico
     * @return CasoEpidemiologico
     */
    public function actualizar(array $datos, CasoEpidemiologico $caso_epidemiologico): CasoEpidemiologico
    {
        $old_caso_epidemiologico = clone $caso_epidemiologico;

        $centro_id = $datos["centro_id"];
        if (Auth::user()->tipo == 'CENTRO MÉDICO') {
            $centro_id = Auth::user()->centro_id;
        }
        $caso_epidemiologico->update([
            "paciente_id" => $datos["paciente_id"],
            "enfermedad_id" => $datos["enfermedad_id"],
            "departamento" => $datos["departamento"],
            "municipio" => $datos["municipio"],
            "red_salud" => $datos["red_salud"],
            "tipo" => $datos["tipo"],
            "captado" => $datos["captado"],
            "captado_desc" => $datos["captado_desc"],
            "pais_lpi" => $datos["pais_lpi"],
            "departamento_lpi" => $datos["departamento_lpi"],
            "municipio_lpi" => $datos["municipio_lpi"],
            "comunidad_id_lpi" => $datos["comunidad_id_lpi"],
            "zona_lpi" => $datos["zona_lpi"],
            "pais_lis" => $datos["pais_lis"],
            "departamento_lis" => $datos["departamento_lis"],
            "municipio_lis" => $datos["municipio_lis"],
            "comunidad_id_lis" => $datos["comunidad_id_lis"],
            "zona_lis" => $datos["zona_lis"],
            "embarazada" => $datos["embarazada"],
            "fuma" => $datos["fuma"],
            "fecha_parto" => $datos["fecha_parto"],
            "centro_id" => $centro_id,
            "comunidad_id" => $datos["comunidad_id"],
            // "user_id" => Auth::user()->id,
            "fi_sintomas" => $datos["fi_sintomas"],
            "semana" => $datos["semana"],
            "fecha_falle" => $datos["fecha_falle"],
            "fecha_diagnostico" => $datos["fecha_diagnostico"],
            "tipo_caso" => $datos["tipo_caso"],
            "gravedad" => $datos["gravedad"],
            "estado" => $datos["estado"],
            "contacto" => $datos["contacto"],
            "hospitalizacion" => $datos["hospitalizacion"],
            "tipo_alta" => $datos["tipo_alta"],
            "fecha_hospitalizacion" => $datos["fecha_hospitalizacion"],
            "establecimiento" => $datos["establecimiento"],
            "hospitalizacion_uti" => $datos["hospitalizacion_uti"],
            "fecha_hospitalizacion_uti" => $datos["fecha_hospitalizacion_uti"],
            "establecimiento_uti" => $datos["establecimiento_uti"],
            "laboratorio" => $datos["laboratorio"],
            "nexo" => $datos["nexo"],
            "muestra" => $datos["muestra"],
            "fecha_muestra" => $datos["fecha_muestra"],
            "tipo_muestra" => $datos["tipo_muestra"],
            "rt_pcr" => $datos["rt_pcr"],
            "igm" => $datos["igm"],
            "igm_nc" => $datos["igm_nc"],
            "igg" => $datos["igg"],
            "igg_nc" => $datos["igg_nc"],
            "observacion_lab" => $datos["observacion_lab"],
            "observaciones" => $datos["observaciones"],
            // "fecha_registro" => date("Y-m-d")
        ]);

        // sintomas
        if (isset($datos["caso_sintomas"])) {
            foreach ($datos["caso_sintomas"] as $item) {
                if ($item["id"] == 0) {
                    $caso_epidemiologico->caso_sintomas()->create([
                        "enfermedad_sintoma_id" => $item["enfermedad_sintoma_id"],
                        "valor" => $item["valor"],
                    ]);
                } else {
                    $caso_sintoma = CasoSintoma::findOrFail($item["id"]);
                    $caso_sintoma->update([
                        "valor" => $item["valor"]
                    ]);
                }
            }
        }

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ UN CASO EPIDEMIOLOGICO", $old_caso_epidemiologico, $caso_epidemiologico->withoutRelations());

        return $caso_epidemiologico;
    }

    /**
     * Eliminar caso_epidemiologico
     *
     * @param CasoEpidemiologico $caso_epidemiologico
     * @return boolean
     */
    public function eliminar(CasoEpidemiologico $caso_epidemiologico): bool|Exception
    {
        $old_caso_epidemiologico = clone $caso_epidemiologico;
        $caso_epidemiologico->delete();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ UN CASO EPIDEMIOLOGICO", $old_caso_epidemiologico, $caso_epidemiologico);

        return true;
    }
}
