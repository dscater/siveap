<?php

namespace App\Services;

use App\Services\HistorialAccionService;
use App\Models\CategoriaEnfermedad;
use App\Models\User;
use Illuminate\Http\UploadedFile;
use Exception;
use Illuminate\Container\Attributes\Auth;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Validation\ValidationException;

class CategoriaEnfermedadService
{
    private $modulo = "CATEGORÍA DE ENFERMEDAD";

    public function __construct(private  CargarArchivoService $cargarArchivoService, private HistorialAccionService $historialAccionService) {}

    public function listado(): Collection
    {
        $categoria_enfermedads = CategoriaEnfermedad::select("categoria_enfermedads.*")->get();
        return $categoria_enfermedads;
    }
    /**
     * Lista de categoria_enfermedads paginado con filtros
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
        $categoria_enfermedads = CategoriaEnfermedad::select("categoria_enfermedads.*");

        // Filtros exactos
        foreach ($columnsFilter as $key => $value) {
            if (!is_null($value)) {
                $categoria_enfermedads->where("categoria_enfermedads.$key", $value);
            }
        }

        // Filtros por rango
        foreach ($columnsBetweenFilter as $key => $value) {
            if (isset($value[0], $value[1])) {
                $categoria_enfermedads->whereBetween("categoria_enfermedads.$key", $value);
            }
        }

        // Búsqueda en múltiples columnas con LIKE
        if (!empty($search) && !empty($columnsSerachLike)) {
            $categoria_enfermedads->where(function ($query) use ($search, $columnsSerachLike) {
                foreach ($columnsSerachLike as $col) {
                    $query->orWhere("$col", "LIKE", "%$search%");
                }
            });
        }

        // Ordenamiento
        foreach ($orderBy as $value) {
            if (isset($value[0], $value[1])) {
                $categoria_enfermedads->orderBy($value[0], $value[1]);
            }
        }


        $categoria_enfermedads = $categoria_enfermedads->paginate($length, ['*'], 'page', $page);
        return $categoria_enfermedads;
    }

    /**
     * Crear categoria_enfermedad
     *
     * @param array $datos
     * @return CategoriaEnfermedad
     */
    public function crear(array $datos): CategoriaEnfermedad
    {
        $categoria_enfermedad = CategoriaEnfermedad::create([
            "nombre" => mb_strtoupper($datos["nombre"]),
        ]);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UNA SUCURSAL", $categoria_enfermedad);

        return $categoria_enfermedad;
    }

    /**
     * Actualizar categoria_enfermedad
     *
     * @param array $datos
     * @param CategoriaEnfermedad $categoria_enfermedad
     * @return CategoriaEnfermedad
     */
    public function actualizar(array $datos, CategoriaEnfermedad $categoria_enfermedad): CategoriaEnfermedad
    {
        $old_categoria_enfermedad = clone $categoria_enfermedad;

        $categoria_enfermedad->update([
            "nombre" => mb_strtoupper($datos["nombre"]),
        ]);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ UNA SUCURSAL", $old_categoria_enfermedad, $categoria_enfermedad->withoutRelations());

        return $categoria_enfermedad;
    }

    /**
     * Eliminar categoria_enfermedad
     *
     * @param CategoriaEnfermedad $categoria_enfermedad
     * @return boolean
     */
    public function eliminar(CategoriaEnfermedad $categoria_enfermedad): bool|Exception
    {
        // TODO: VERIFICAR RELACIONES

        $old_categoria_enfermedad = clone $categoria_enfermedad;
        $categoria_enfermedad->delete();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ UNA SUCURSAL", $old_categoria_enfermedad, $categoria_enfermedad);

        return true;
    }
}
