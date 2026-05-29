<?php

namespace App\Services;

use App\Services\HistorialAccionService;
use App\Models\Seguimiento;
use App\Models\User;
use Illuminate\Http\UploadedFile;
use Exception;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\Auth;
use Illuminate\Validation\ValidationException;

class SeguimientoService
{
    private $modulo = "SEGUIMIENTO";

    public function __construct(private  CargarArchivoService $cargarArchivoService, private HistorialAccionService $historialAccionService) {}

    public function listado(): Collection
    {
        $seguimientos = Seguimiento::select("seguimientos.*")->get();
        return $seguimientos;
    }
    /**
     * Lista de seguimientos paginado con filtros
     *
     * @param integer $length
     * @param integer $page
     * @param string $search
     * @param array $columnsSerachLike
     * @param array $columnsFilter
     * @return LengthAwarePaginator
     */
    public function listadoPaginado(int $length, int $page, string $search, array $columnsSerachLike = [], array $columnsFilter = [], array $columnsBetweenFilter = [], array $orderBy = [], $caso_epidemiologico_id): LengthAwarePaginator
    {
        $seguimientos = Seguimiento::select("seguimientos.*")
            ->with(["user", "caso_epidemiologico.paciente", "caso_epidemiologico.enfermedad", "caso_epidemiologico.centro", "caso_epidemiologico.comunidad"])
            ->where("caso_epidemiologico_id", $caso_epidemiologico_id);

        // Filtros exactos
        foreach ($columnsFilter as $key => $value) {
            if (!is_null($value)) {
                $seguimientos->where("seguimientos.$key", $value);
            }
        }

        // Filtros por rango
        foreach ($columnsBetweenFilter as $key => $value) {
            if (isset($value[0], $value[1])) {
                $seguimientos->whereBetween("seguimientos.$key", $value);
            }
        }

        // Búsqueda en múltiples columnas con LIKE
        if (!empty($search) && !empty($columnsSerachLike)) {
            $seguimientos->where(function ($query) use ($search, $columnsSerachLike) {
                foreach ($columnsSerachLike as $col) {
                    $query->orWhere("$col", "LIKE", "%$search%");
                }
            });
        }

        // Ordenamiento
        foreach ($orderBy as $value) {
            if (isset($value[0], $value[1])) {
                $seguimientos->orderBy($value[0], $value[1]);
            }
        }


        $seguimientos = $seguimientos->paginate($length, ['*'], 'page', $page);
        return $seguimientos;
    }

    /**
     * Crear seguimiento
     *
     * @param array $datos
     * @return Seguimiento
     */
    public function crear(array $datos): Seguimiento
    {
        $seguimiento = Seguimiento::create([
            "caso_epidemiologico_id" => mb_strtoupper($datos["caso_epidemiologico_id"]),
            "fecha" => $datos["fecha"],
            "gravedad" => $datos["gravedad"],
            "estado" => $datos["estado"],
            "observaciones" => mb_strtoupper($datos["observaciones"]),
            "user_id" => Auth::user()->id
        ]);

        // actualizar estado y gravedad del caso
        $caso_epidemiologico = $seguimiento->caso_epidemiologico;
        $caso_epidemiologico->gravedad = $datos["gravedad"];
        $caso_epidemiologico->estado = $datos["estado"];
        $caso_epidemiologico->save();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UN SEGUIMIENTO", $seguimiento);

        return $seguimiento;
    }

    /**
     * Actualizar seguimiento
     *
     * @param array $datos
     * @param Seguimiento $seguimiento
     * @return Seguimiento
     */
    public function actualizar(array $datos, Seguimiento $seguimiento): Seguimiento
    {
        $old_seguimiento = clone $seguimiento;

        $seguimiento->update([
            "caso_epidemiologico_id" => mb_strtoupper($datos["caso_epidemiologico_id"]),
            "fecha" => $datos["fecha"],
            "gravedad" => $datos["gravedad"],
            "estado" => $datos["estado"],
            "observaciones" => mb_strtoupper($datos["observaciones"]),
        ]);

        $esUltimo = Seguimiento::orderBy("id", "desc")->get()->first();
        if ($esUltimo->id == $seguimiento->id) {
            // SI ES ultimo actualizar estado y gravedad del caso
            $caso_epidemiologico = $seguimiento->caso_epidemiologico;
            $caso_epidemiologico->gravedad = $datos["gravedad"];
            $caso_epidemiologico->estado = $datos["estado"];
            $caso_epidemiologico->save();
        }

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ UN SEGUIMIENTO", $old_seguimiento, $seguimiento->withoutRelations());

        return $seguimiento;
    }

    /**
     * Eliminar seguimiento
     *
     * @param Seguimiento $seguimiento
     * @return boolean
     */
    public function eliminar(Seguimiento $seguimiento): bool|Exception
    {
        $old_seguimiento = clone $seguimiento;
        $seguimiento->delete();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ UN SEGUIMIENTO", $old_seguimiento, $seguimiento);

        return true;
    }
}
