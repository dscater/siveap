<?php

namespace App\Services;

use App\Models\CasoEpidemiologico;
use App\Services\HistorialAccionService;
use App\Models\Centro;
use App\Models\User;
use Illuminate\Http\UploadedFile;
use Exception;
use Illuminate\Container\Attributes\Auth;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Validation\ValidationException;

class CentroService
{
    private $modulo = "CENTROS";

    public function __construct(private  CargarArchivoService $cargarArchivoService, private HistorialAccionService $historialAccionService) {}

    public function listado(): Collection
    {
        $centros = Centro::select("centros.*")->get();
        return $centros;
    }
    /**
     * Lista de centros paginado con filtros
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
        $centros = Centro::select("centros.*");

        // Filtros exactos
        foreach ($columnsFilter as $key => $value) {
            if (!is_null($value)) {
                $centros->where("centros.$key", $value);
            }
        }

        // Filtros por rango
        foreach ($columnsBetweenFilter as $key => $value) {
            if (isset($value[0], $value[1])) {
                $centros->whereBetween("centros.$key", $value);
            }
        }

        // Búsqueda en múltiples columnas con LIKE
        if (!empty($search) && !empty($columnsSerachLike)) {
            $centros->where(function ($query) use ($search, $columnsSerachLike) {
                foreach ($columnsSerachLike as $col) {
                    $query->orWhere("$col", "LIKE", "%$search%");
                }
            });
        }

        // Ordenamiento
        foreach ($orderBy as $value) {
            if (isset($value[0], $value[1])) {
                $centros->orderBy($value[0], $value[1]);
            }
        }


        $centros = $centros->paginate($length, ['*'], 'page', $page);
        return $centros;
    }

    /**
     * Crear centro
     *
     * @param array $datos
     * @return Centro
     */
    public function crear(array $datos): Centro
    {
        $centro = Centro::create([
            "nombre" => mb_strtoupper($datos["nombre"]),
            "fono_correo" => $datos["fono_correo"],
            "direccion" => mb_strtoupper($datos["direccion"]),
        ]);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UN CENTRO", $centro);

        return $centro;
    }

    /**
     * Actualizar centro
     *
     * @param array $datos
     * @param Centro $centro
     * @return Centro
     */
    public function actualizar(array $datos, Centro $centro): Centro
    {
        $old_centro = clone $centro;

        $centro->update([
            "nombre" => mb_strtoupper($datos["nombre"]),
            "fono_correo" => $datos["fono_correo"],
            "direccion" => mb_strtoupper($datos["direccion"]),
        ]);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ UN CENTRO", $old_centro, $centro->withoutRelations());

        return $centro;
    }

    /**
     * Eliminar centro
     *
     * @param Centro $centro
     * @return boolean
     */
    public function eliminar(Centro $centro): bool|Exception
    {
        $usos = CasoEpidemiologico::where("centro_id", $centro->id)->count();
        if (count($usos) > 0) {
            throw new Exception("No es posible eliminar el registro porque esta ligado a otros registros");
        }

        $old_centro = clone $centro;
        $centro->delete();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ UN CENTRO", $old_centro, $centro);

        return true;
    }
}
