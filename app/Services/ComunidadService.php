<?php

namespace App\Services;

use App\Services\HistorialAccionService;
use App\Models\Comunidad;
use App\Models\User;
use Illuminate\Http\UploadedFile;
use Exception;
use Illuminate\Container\Attributes\Auth;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Validation\ValidationException;

class ComunidadService
{
    private $modulo = "COMUNIDADES";

    public function __construct(private  CargarArchivoService $cargarArchivoService, private HistorialAccionService $historialAccionService) {}

    public function listado(): Collection
    {
        $comunidads = Comunidad::select("comunidads.*")->get();
        return $comunidads;
    }
    /**
     * Lista de comunidads paginado con filtros
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
        $comunidads = Comunidad::select("comunidads.*");

        // Filtros exactos
        foreach ($columnsFilter as $key => $value) {
            if (!is_null($value)) {
                $comunidads->where("comunidads.$key", $value);
            }
        }

        // Filtros por rango
        foreach ($columnsBetweenFilter as $key => $value) {
            if (isset($value[0], $value[1])) {
                $comunidads->whereBetween("comunidads.$key", $value);
            }
        }

        // Búsqueda en múltiples columnas con LIKE
        if (!empty($search) && !empty($columnsSerachLike)) {
            $comunidads->where(function ($query) use ($search, $columnsSerachLike) {
                foreach ($columnsSerachLike as $col) {
                    $query->orWhere("$col", "LIKE", "%$search%");
                }
            });
        }

        // Ordenamiento
        foreach ($orderBy as $value) {
            if (isset($value[0], $value[1])) {
                $comunidads->orderBy($value[0], $value[1]);
            }
        }


        $comunidads = $comunidads->paginate($length, ['*'], 'page', $page);
        return $comunidads;
    }

    /**
     * Crear comunidad
     *
     * @param array $datos
     * @return Comunidad
     */
    public function crear(array $datos): Comunidad
    {
        $comunidad = Comunidad::create([
            "nombre" => mb_strtoupper($datos["nombre"]),
            "latitud" => $datos["latitud"],
            "longitud" => $datos["longitud"],
        ]);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UNA SUCURSAL", $comunidad);

        return $comunidad;
    }

    /**
     * Actualizar comunidad
     *
     * @param array $datos
     * @param Comunidad $comunidad
     * @return Comunidad
     */
    public function actualizar(array $datos, Comunidad $comunidad): Comunidad
    {
        $old_comunidad = clone $comunidad;

        $comunidad->update([
            "nombre" => mb_strtoupper($datos["nombre"]),
            "latitud" => $datos["latitud"],
            "longitud" => $datos["longitud"],
        ]);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ UNA SUCURSAL", $old_comunidad, $comunidad->withoutRelations());

        return $comunidad;
    }

    /**
     * Eliminar comunidad
     *
     * @param Comunidad $comunidad
     * @return boolean
     */
    public function eliminar(Comunidad $comunidad): bool|Exception
    {
        // TODO: VERIFICAR RELACIONES

        $old_comunidad = clone $comunidad;
        $comunidad->delete();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ UNA SUCURSAL", $old_comunidad, $comunidad);

        return true;
    }
}
