<?php

namespace App\Services;

use App\Services\HistorialAccionService;
use App\Models\EnfermedadContingencia;
use App\Models\User;
use Illuminate\Http\UploadedFile;
use Exception;
use Illuminate\Container\Attributes\Auth;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Validation\ValidationException;

class EnfermedadContingenciaService
{
    private $modulo = "CONTINGENCIAS";

    public function __construct(private  CargarArchivoService $cargarArchivoService, private HistorialAccionService $historialAccionService) {}

    public function listado(): Collection
    {
        $enfermedad_contingencias = EnfermedadContingencia::select("enfermedad_contingencias.*")->get();
        return $enfermedad_contingencias;
    }
    /**
     * Lista de enfermedad_contingencias paginado con filtros
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
        $enfermedad_contingencias = EnfermedadContingencia::select("enfermedad_contingencias.*")
            ->with(["enfermedad:id,nombre"]);

        // Filtros exactos
        foreach ($columnsFilter as $key => $value) {
            if (!is_null($value)) {
                $enfermedad_contingencias->where("enfermedad_contingencias.$key", $value);
            }
        }

        // Filtros por rango
        foreach ($columnsBetweenFilter as $key => $value) {
            if (isset($value[0], $value[1])) {
                $enfermedad_contingencias->whereBetween("enfermedad_contingencias.$key", $value);
            }
        }

        // Búsqueda en múltiples columnas con LIKE
        if (!empty($search) && !empty($columnsSerachLike)) {
            $enfermedad_contingencias->where(function ($query) use ($search, $columnsSerachLike) {
                foreach ($columnsSerachLike as $col) {
                    $query->orWhere("$col", "LIKE", "%$search%");
                }
            });
        }

        // Ordenamiento
        foreach ($orderBy as $value) {
            if (isset($value[0], $value[1])) {
                $enfermedad_contingencias->orderBy($value[0], $value[1]);
            }
        }


        $enfermedad_contingencias = $enfermedad_contingencias->paginate($length, ['*'], 'page', $page);
        return $enfermedad_contingencias;
    }

    /**
     * Crear enfermedad_contingencia
     *
     * @param array $datos
     * @return EnfermedadContingencia
     */
    public function crear(array $datos): EnfermedadContingencia
    {
        $enfermedad_contingencia = EnfermedadContingencia::create([
            "enfermedad_id" => $datos["enfermedad_id"],
            "descripcion" => $datos["descripcion"],
        ]);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UNA CONTINGENCIA", $enfermedad_contingencia);

        return $enfermedad_contingencia;
    }

    /**
     * Actualizar enfermedad_contingencia
     *
     * @param array $datos
     * @param EnfermedadContingencia $enfermedad_contingencia
     * @return EnfermedadContingencia
     */
    public function actualizar(array $datos, EnfermedadContingencia $enfermedad_contingencia): EnfermedadContingencia
    {
        $old_enfermedad_contingencia = clone $enfermedad_contingencia;

        $enfermedad_contingencia->update([
            "enfermedad_id" => $datos["enfermedad_id"],
            "descripcion" => $datos["descripcion"],
        ]);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ UNA CONTINGENCIA", $old_enfermedad_contingencia, $enfermedad_contingencia->withoutRelations());

        return $enfermedad_contingencia;
    }

    /**
     * Eliminar enfermedad_contingencia
     *
     * @param EnfermedadContingencia $enfermedad_contingencia
     * @return boolean
     */
    public function eliminar(EnfermedadContingencia $enfermedad_contingencia): bool|Exception
    {
        $old_enfermedad_contingencia = clone $enfermedad_contingencia;
        $enfermedad_contingencia->delete();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ UNA CONTINGENCIA", $old_enfermedad_contingencia, $enfermedad_contingencia);

        return true;
    }
}
