<?php

namespace App\Services;

use App\Services\HistorialAccionService;
use App\Models\CasoEpidemiologico;
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

        if (Auth::user()->tipo = 'CENTRO MÉDICO') {
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

        // Filtros exactos
        foreach ($columnsFilter as $key => $value) {
            if (!is_null($value)) {
                $caso_epidemiologicos->where("caso_epidemiologicos.$key", $value);
            }
        }

        // Filtros por rango
        foreach ($columnsBetweenFilter as $key => $value) {
            if (isset($value[0], $value[1])) {
                $caso_epidemiologicos->whereBetween("caso_epidemiologicos.$key", $value);
            }
        }

        // Búsqueda en múltiples columnas con LIKE
        if (!empty($search) && !empty($columnsSerachLike)) {
            $caso_epidemiologicos->where(function ($query) use ($search, $columnsSerachLike) {
                foreach ($columnsSerachLike as $col) {
                    $query->orWhere("$col", "LIKE", "%$search%");
                }
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
            "centro_id" => $centro_id,
            "comunidad_id" => $datos["comunidad_id"],
            "user_id" => Auth::user()->id,
            "fi_sintomas" => $datos["fi_sintomas"],
            "fecha_diagnostico" => $datos["fecha_diagnostico"],
            "tipo_caso" => $datos["tipo_caso"],
            "gravedad" => $datos["gravedad"],
            "estado" => $datos["estado"],
            "contacto" => $datos["contacto"],
            "hospitalizacion" => $datos["hospitalizacion"],
            "observaciones" => $datos["observaciones"],
            "fecha_registro" => date("Y-m-d")
        ]);

        $caso_epidemiologico->codigo = $this->generarCodigoCaso($caso_epidemiologico);
        $caso_epidemiologico->save();


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
            "centro_id" => $centro_id,
            "comunidad_id" => $datos["comunidad_id"],
            "fi_sintomas" => $datos["fi_sintomas"],
            "fecha_diagnostico" => $datos["fecha_diagnostico"],
            "tipo_caso" => $datos["tipo_caso"],
            "gravedad" => $datos["gravedad"],
            "estado" => $datos["estado"],
            "contacto" => $datos["contacto"],
            "hospitalizacion" => $datos["hospitalizacion"],
            "observaciones" => $datos["observaciones"],
        ]);

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
