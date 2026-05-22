<?php

namespace App\Services;

use App\Services\HistorialAccionService;
use App\Models\Enfermedad;
use App\Models\User;
use Illuminate\Http\UploadedFile;
use Exception;
use Illuminate\Container\Attributes\Auth;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Validation\ValidationException;

class EnfermedadService
{
    private $modulo = "ENFERMDADES";

    public function __construct(private  CargarArchivoService $cargarArchivoService, private HistorialAccionService $historialAccionService) {}

    public function listado(): Collection
    {
        $enfermedads = Enfermedad::select("enfermedads.*")->get();
        return $enfermedads;
    }
    /**
     * Lista de enfermedads paginado con filtros
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
        $enfermedads = Enfermedad::select("enfermedads.*")
            ->with(["categoria_enfermedad:id,nombre", "tipo_transmision:id,nombre"]);

        // Filtros exactos
        foreach ($columnsFilter as $key => $value) {
            if (!is_null($value)) {
                $enfermedads->where("enfermedads.$key", $value);
            }
        }

        // Filtros por rango
        foreach ($columnsBetweenFilter as $key => $value) {
            if (isset($value[0], $value[1])) {
                $enfermedads->whereBetween("enfermedads.$key", $value);
            }
        }

        // Búsqueda en múltiples columnas con LIKE
        if (!empty($search) && !empty($columnsSerachLike)) {
            $enfermedads->where(function ($query) use ($search, $columnsSerachLike) {
                foreach ($columnsSerachLike as $col) {
                    $query->orWhere("$col", "LIKE", "%$search%");
                }
            });
        }

        // Ordenamiento
        foreach ($orderBy as $value) {
            if (isset($value[0], $value[1])) {
                $enfermedads->orderBy($value[0], $value[1]);
            }
        }


        $enfermedads = $enfermedads->paginate($length, ['*'], 'page', $page);
        return $enfermedads;
    }

    /**
     * Crear enfermedad
     *
     * @param array $datos
     * @return Enfermedad
     */
    public function crear(array $datos): Enfermedad
    {
        $enfermedad = Enfermedad::create([
            "nombre" => mb_strtoupper($datos["nombre"]),
            "categoria_enfermedad_id" => $datos["categoria_enfermedad_id"],
            "tipo_transmision_id" => $datos["tipo_transmision_id"],
            "descripcion" => mb_strtoupper($datos["descripcion"]),
        ]);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UNA ENFERMEDAD", $enfermedad);

        return $enfermedad;
    }

    /**
     * Actualizar enfermedad
     *
     * @param array $datos
     * @param Enfermedad $enfermedad
     * @return Enfermedad
     */
    public function actualizar(array $datos, Enfermedad $enfermedad): Enfermedad
    {
        $old_enfermedad = clone $enfermedad;

        $enfermedad->update([
            "nombre" => mb_strtoupper($datos["nombre"]),
            "categoria_enfermedad_id" => $datos["categoria_enfermedad_id"],
            "tipo_transmision_id" => $datos["tipo_transmision_id"],
            "descripcion" => mb_strtoupper($datos["descripcion"]),
        ]);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ UNA ENFERMEDAD", $old_enfermedad, $enfermedad->withoutRelations());

        return $enfermedad;
    }

    /**
     * Eliminar enfermedad
     *
     * @param Enfermedad $enfermedad
     * @return boolean
     */
    public function eliminar(Enfermedad $enfermedad): bool|Exception
    {
        // TODO: VERIFICAR RELACIONES

        $old_enfermedad = clone $enfermedad;
        $enfermedad->delete();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ UNA ENFERMEDAD", $old_enfermedad, $enfermedad);

        return true;
    }
}
