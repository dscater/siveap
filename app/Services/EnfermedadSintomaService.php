<?php

namespace App\Services;

use App\Models\CasoSintoma;
use App\Services\HistorialAccionService;
use App\Models\EnfermedadSintoma;
use App\Models\User;
use Illuminate\Http\UploadedFile;
use Exception;
use Illuminate\Container\Attributes\Auth;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Validation\ValidationException;

class EnfermedadSintomaService
{
    private $modulo = "SINTOMAS DE ENFERMEDADS";

    public function __construct(private  CargarArchivoService $cargarArchivoService, private HistorialAccionService $historialAccionService) {}

    public function listado($enfermedad_id = ""): Collection
    {
        $enfermedad_sintomas = EnfermedadSintoma::select("enfermedad_sintomas.*")
            ->with(["enfermedad"]);

        if ($enfermedad_id) {
            $enfermedad_sintomas->where("enfermedad_id", $enfermedad_id);
        }

        $enfermedad_sintomas = $enfermedad_sintomas->get();
        return $enfermedad_sintomas;
    }
    /**
     * Lista de enfermedad_sintomas paginado con filtros
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
        $enfermedad_sintomas = EnfermedadSintoma::select("enfermedad_sintomas.*")
            ->with(["enfermedad:id,nombre"]);
        // Filtros exactos
        foreach ($columnsFilter as $key => $value) {
            if (!is_null($value)) {
                $enfermedad_sintomas->where("enfermedad_sintomas.$key", $value);
            }
        }

        // Filtros por rango
        foreach ($columnsBetweenFilter as $key => $value) {
            if (isset($value[0], $value[1])) {
                $enfermedad_sintomas->whereBetween("enfermedad_sintomas.$key", $value);
            }
        }

        // Búsqueda en múltiples columnas con LIKE
        if (!empty($search) && !empty($columnsSerachLike)) {
            $enfermedad_sintomas->where(function ($query) use ($search, $columnsSerachLike) {
                foreach ($columnsSerachLike as $col) {
                    $query->orWhere("$col", "LIKE", "%$search%");
                }
            });
        }

        // Ordenamiento
        foreach ($orderBy as $value) {
            if (isset($value[0], $value[1])) {
                $enfermedad_sintomas->orderBy($value[0], $value[1]);
            }
        }


        $enfermedad_sintomas = $enfermedad_sintomas->paginate($length, ['*'], 'page', $page);
        return $enfermedad_sintomas;
    }

    /**
     * Crear enfermedad_sintoma
     *
     * @param array $datos
     * @return EnfermedadSintoma
     */
    public function crear(array $datos): EnfermedadSintoma
    {
        $enfermedad_sintoma = EnfermedadSintoma::create([
            "enfermedad_id" => $datos["enfermedad_id"],
            "nombre" => $datos["nombre"],
            "tipo" => $datos["tipo"],
            "input" => $datos["input"],
        ]);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UN SINTOMA DE ENFERMEDAD", $enfermedad_sintoma);

        return $enfermedad_sintoma;
    }

    /**
     * Actualizar enfermedad_sintoma
     *
     * @param array $datos
     * @param EnfermedadSintoma $enfermedad_sintoma
     * @return EnfermedadSintoma
     */
    public function actualizar(array $datos, EnfermedadSintoma $enfermedad_sintoma): EnfermedadSintoma
    {
        $old_enfermedad_sintoma = clone $enfermedad_sintoma;

        $enfermedad_sintoma->update([
            "enfermedad_id" => $datos["enfermedad_id"],
            "nombre" => $datos["nombre"],
            "tipo" => $datos["tipo"],
            "input" => $datos["input"],
        ]);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ UN SINTOMA DE ENFERMEDAD", $old_enfermedad_sintoma, $enfermedad_sintoma->withoutRelations());

        return $enfermedad_sintoma;
    }

    /**
     * Eliminar enfermedad_sintoma
     *
     * @param EnfermedadSintoma $enfermedad_sintoma
     * @return boolean
     */
    public function eliminar(EnfermedadSintoma $enfermedad_sintoma): bool|Exception
    {
        $old_enfermedad_sintoma = clone $enfermedad_sintoma;

        $usos = CasoSintoma::where("enfermedad_sintoma_id", $enfermedad_sintoma->id)->count();
        if ($usos > 0) {
            throw new Exception("No se puede eliminar el registro porque tiene registros en casos epidemiologicos");
        }

        $enfermedad_sintoma->delete();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ UN SINTOMA DE ENFERMEDAD", $old_enfermedad_sintoma, $enfermedad_sintoma);

        return true;
    }
}
