<?php

namespace App\Services;

use App\Services\HistorialAccionService;
use App\Models\ReglasAlerta;
use App\Models\User;
use Illuminate\Http\UploadedFile;
use Exception;
use Illuminate\Container\Attributes\Auth;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Validation\ValidationException;

class ReglasAlertaService
{
    private $modulo = "REGLAS DE ALERTA";

    public function __construct(private  CargarArchivoService $cargarArchivoService, private HistorialAccionService $historialAccionService) {}

    public function listado(): Collection
    {
        $reglas_alertas = ReglasAlerta::select("reglas_alertas.*")->get();
        return $reglas_alertas;
    }
    /**
     * Lista de reglas_alertas paginado con filtros
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
        $reglas_alertas = ReglasAlerta::select("reglas_alertas.*")
            ->with(["enfermedad:id,nombre"])
            ->where("status", 1);

        // Filtros exactos
        foreach ($columnsFilter as $key => $value) {
            if (!is_null($value)) {
                $reglas_alertas->where("reglas_alertas.$key", $value);
            }
        }

        // Filtros por rango
        foreach ($columnsBetweenFilter as $key => $value) {
            if (isset($value[0], $value[1])) {
                $reglas_alertas->whereBetween("reglas_alertas.$key", $value);
            }
        }

        // Búsqueda en múltiples columnas con LIKE
        if (!empty($search) && !empty($columnsSerachLike)) {
            $reglas_alertas->where(function ($query) use ($search, $columnsSerachLike) {
                foreach ($columnsSerachLike as $col) {
                    $query->orWhere("$col", "LIKE", "%$search%");
                }
            });
        }

        // Ordenamiento
        foreach ($orderBy as $value) {
            if (isset($value[0], $value[1])) {
                $reglas_alertas->orderBy($value[0], $value[1]);
            }
        }


        $reglas_alertas = $reglas_alertas->paginate($length, ['*'], 'page', $page);
        return $reglas_alertas;
    }

    /**
     * Crear reglas_alerta
     *
     * @param array $datos
     * @return ReglasAlerta
     */
    public function crear(array $datos): ReglasAlerta
    {
        $reglas_alerta = ReglasAlerta::create([
            "enfermedad_id" => $datos["enfermedad_id"],
            "umbral" => $datos["umbral"],
        ]);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UNA REGLA DE ALERTA", $reglas_alerta);

        return $reglas_alerta;
    }

    /**
     * Actualizar reglas_alerta
     *
     * @param array $datos
     * @param ReglasAlerta $reglas_alerta
     * @return ReglasAlerta
     */
    public function actualizar(array $datos, ReglasAlerta $reglas_alerta): ReglasAlerta
    {
        $old_reglas_alerta = clone $reglas_alerta;

        $reglas_alerta->update([
            "enfermedad_id" => $datos["enfermedad_id"],
            "umbral" => $datos["umbral"],
        ]);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ UNA REGLA DE ALERTA", $old_reglas_alerta, $reglas_alerta->withoutRelations());

        return $reglas_alerta;
    }

    /**
     * Eliminar reglas_alerta
     *
     * @param ReglasAlerta $reglas_alerta
     * @return boolean
     */
    public function eliminar(ReglasAlerta $reglas_alerta): bool|Exception
    {
        $old_reglas_alerta = clone $reglas_alerta;
        $reglas_alerta->delete();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ UNA REGLA DE ALERTA", $old_reglas_alerta, $reglas_alerta);

        return true;
    }
}
