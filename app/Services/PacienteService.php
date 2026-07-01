<?php

namespace App\Services;

use App\Models\CasoEpidemiologico;
use App\Services\HistorialAccionService;
use App\Models\Paciente;
use App\Models\User;
use Illuminate\Http\UploadedFile;
use Exception;
use Illuminate\Container\Attributes\Auth;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Validation\ValidationException;
use Illuminate\Support\Str;

class PacienteService
{
    private $modulo = "PACIENTES";

    public function __construct(private  CargarArchivoService $cargarArchivoService, private HistorialAccionService $historialAccionService) {}

    public function listado(): Collection
    {
        $pacientes = Paciente::select("pacientes.*")->get();
        return $pacientes;
    }
    /**
     * Lista de pacientes paginado con filtros
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
        $pacientes = Paciente::select("pacientes.*")
            ->with(["comunidad:id,nombre"]);

        // Filtros exactos
        foreach ($columnsFilter as $key => $value) {
            if (!is_null($value)) {
                $pacientes->where("pacientes.$key", $value);
            }
        }

        // Filtros por rango
        foreach ($columnsBetweenFilter as $key => $value) {
            if (isset($value[0], $value[1])) {
                $pacientes->whereBetween("pacientes.$key", $value);
            }
        }

        // Búsqueda en múltiples columnas con LIKE
        if (!empty($search) && !empty($columnsSerachLike)) {
            $pacientes->where(function ($query) use ($search, $columnsSerachLike) {
                foreach ($columnsSerachLike as $col) {
                    $query->orWhere("$col", "LIKE", "%$search%");
                }
            });
        }

        // Ordenamiento
        foreach ($orderBy as $value) {
            if (isset($value[0], $value[1])) {
                $pacientes->orderBy($value[0], $value[1]);
            }
        }


        $pacientes = $pacientes->paginate($length, ['*'], 'page', $page);
        return $pacientes;
    }

    /**
     * Crear paciente
     *
     * @param array $datos
     * @return Paciente
     */
    public function crear(array $datos): Paciente
    {
        $paciente = Paciente::create([
            "nombre" => mb_strtoupper($datos["nombre"]),
            "paterno" => mb_strtoupper($datos["paterno"]),
            "materno" => mb_strtoupper($datos["materno"]) ?? NULL,
            "ci" => $datos["ci"],
            "ci_exp" => $datos["ci_exp"],
            "sexo" => mb_strtoupper($datos["sexo"]),
            "fecha_nac" => $datos["fecha_nac"],
            "dir" => mb_strtoupper($datos["dir"]),
            "latitud" => $datos["latitud"],
            "longitud" => $datos["longitud"],
            "fono" => $datos["fono"],
            "ocupacion" => mb_strtoupper($datos["ocupacion"]),
            "departamento" => mb_strtoupper($datos["departamento"]),
            "municipio" => mb_strtoupper($datos["municipio"]),
            "zona" => mb_strtoupper($datos["zona"]),
            "apoderado" => mb_strtoupper($datos["apoderado"]),
            "comunidad_id" => $datos["comunidad_id"],
            "fecha_registro" => date("Y-m-d")
        ]);

        $paciente->capturaMapa = $this->guardarImagenB64($datos["capturaMapa"], public_path("imgs/pacientes/mapas"), $paciente->id . Str::uuid());
        $paciente->save();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UN PACIENTE", $paciente);

        return $paciente;
    }


    public function guardarImagenB64($b64, string $ruta, string $nombre = null): string
    {
        if (empty($b64)) {
            throw new \Exception("No se recibió ninguna imagen.");
        }

        if (!preg_match('/^data:image\/(\w+);base64,/', $b64, $tipo)) {
            throw new \Exception("Formato de imagen no válido.");
        }

        $extension = strtolower($tipo[1]);

        $b64 = substr($b64, strpos($b64, ',') + 1);
        $b64 = str_replace(' ', '+', $b64);

        $contenido = base64_decode($b64);

        if ($contenido === false) {
            throw new \Exception("La imagen Base64 es inválida.");
        }

        // Crear la carpeta si no existe
        if (!is_dir($ruta)) {
            mkdir($ruta, 0755, true);
        }

        $nombreArchivo = $nombre ?? Str::uuid();
        $nombreArchivo .= '.' . $extension;

        file_put_contents(
            $ruta . DIRECTORY_SEPARATOR . $nombreArchivo,
            $contenido
        );

        return $nombreArchivo;
    }

    /**
     * Actualizar paciente
     *
     * @param array $datos
     * @param Paciente $paciente
     * @return Paciente
     */
    public function actualizar(array $datos, Paciente $paciente): Paciente
    {
        $old_paciente = clone $paciente;

        $paciente->update([
            "nombre" => mb_strtoupper($datos["nombre"]),
            "paterno" => mb_strtoupper($datos["paterno"]),
            "materno" => mb_strtoupper($datos["materno"]) ?? NULL,
            "ci" => $datos["ci"],
            "ci_exp" => $datos["ci_exp"],
            "sexo" => mb_strtoupper($datos["sexo"]),
            "fecha_nac" => $datos["fecha_nac"],
            "dir" => mb_strtoupper($datos["dir"]),
            "latitud" => $datos["latitud"],
            "longitud" => $datos["longitud"],
            "fono" => $datos["fono"],
            "ocupacion" => mb_strtoupper($datos["ocupacion"]),
            "departamento" => mb_strtoupper($datos["departamento"]),
            "municipio" => mb_strtoupper($datos["municipio"]),
            "zona" => mb_strtoupper($datos["zona"]),
            "apoderado" => mb_strtoupper($datos["apoderado"]),
            "comunidad_id" => $datos["comunidad_id"],
        ]);

        if ($paciente->capturaMapa) {
            \File::delete(public_path("imgs/pacientes/mapas/" . $paciente->capturaMapa));
        }

        $paciente->capturaMapa = $this->guardarImagenB64($datos["capturaMapa"], public_path("imgs/pacientes/mapas"), $paciente->id . Str::uuid());
        $paciente->save();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ UN PACIENTE", $old_paciente, $paciente->withoutRelations());

        return $paciente;
    }

    /**
     * Eliminar paciente
     *
     * @param Paciente $paciente
     * @return boolean
     */
    public function eliminar(Paciente $paciente): bool|Exception
    {
        $usos = CasoEpidemiologico::where("paciente_id", $paciente->id)->count();
        if (count($usos) > 0) {
            throw new Exception("No es posible eliminar el registro porque esta ligado a otros registros");
        }

        $old_paciente = clone $paciente;
        $paciente->delete();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ UN PACIENTE", $old_paciente, $paciente);

        return true;
    }
}
