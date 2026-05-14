<?php

namespace App\Services;

use App\Services\HistorialAccionService;
use App\Models\TipoTransmision;
use App\Models\User;
use Illuminate\Http\UploadedFile;
use Exception;
use Illuminate\Container\Attributes\Auth;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Validation\ValidationException;

class TipoTransmisionService
{
    private $modulo = "TIPO DE TRANSMISIÓN";

    public function __construct(private  CargarArchivoService $cargarArchivoService, private HistorialAccionService $historialAccionService) {}

    public function listado(): Collection
    {
        $tipo_transmisions = TipoTransmision::select("tipo_transmisions.*")->get();
        return $tipo_transmisions;
    }
    /**
     * Lista de tipo_transmisions paginado con filtros
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
        $tipo_transmisions = TipoTransmision::select("tipo_transmisions.*");

        // Filtros exactos
        foreach ($columnsFilter as $key => $value) {
            if (!is_null($value)) {
                $tipo_transmisions->where("tipo_transmisions.$key", $value);
            }
        }

        // Filtros por rango
        foreach ($columnsBetweenFilter as $key => $value) {
            if (isset($value[0], $value[1])) {
                $tipo_transmisions->whereBetween("tipo_transmisions.$key", $value);
            }
        }

        // Búsqueda en múltiples columnas con LIKE
        if (!empty($search) && !empty($columnsSerachLike)) {
            $tipo_transmisions->where(function ($query) use ($search, $columnsSerachLike) {
                foreach ($columnsSerachLike as $col) {
                    $query->orWhere("$col", "LIKE", "%$search%");
                }
            });
        }

        // Ordenamiento
        foreach ($orderBy as $value) {
            if (isset($value[0], $value[1])) {
                $tipo_transmisions->orderBy($value[0], $value[1]);
            }
        }


        $tipo_transmisions = $tipo_transmisions->paginate($length, ['*'], 'page', $page);
        return $tipo_transmisions;
    }

    /**
     * Crear tipo_transmision
     *
     * @param array $datos
     * @return TipoTransmision
     */
    public function crear(array $datos): TipoTransmision
    {
        $tipo_transmision = TipoTransmision::create([
            "nombre" => mb_strtoupper($datos["nombre"]),
        ]);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UNA SUCURSAL", $tipo_transmision);

        return $tipo_transmision;
    }

    /**
     * Actualizar tipo_transmision
     *
     * @param array $datos
     * @param TipoTransmision $tipo_transmision
     * @return TipoTransmision
     */
    public function actualizar(array $datos, TipoTransmision $tipo_transmision): TipoTransmision
    {
        $old_tipo_transmision = clone $tipo_transmision;

        $tipo_transmision->update([
            "nombre" => mb_strtoupper($datos["nombre"]),
        ]);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ UNA SUCURSAL", $old_tipo_transmision, $tipo_transmision->withoutRelations());

        return $tipo_transmision;
    }

    /**
     * Eliminar tipo_transmision
     *
     * @param TipoTransmision $tipo_transmision
     * @return boolean
     */
    public function eliminar(TipoTransmision $tipo_transmision): bool|Exception
    {
        // TODO: VERIFICAR RELACIONES

        $old_tipo_transmision = clone $tipo_transmision;
        $tipo_transmision->delete();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ UNA SUCURSAL", $old_tipo_transmision, $tipo_transmision);

        return true;
    }
}
