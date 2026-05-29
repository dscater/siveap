<?php

namespace App\Services;

use App\Services\HistorialAccionService;
use App\Models\AlertaEpidemiologica;
use App\Models\CasoEpidemiologico;
use App\Models\Comunidad;
use App\Models\Enfermedad;
use App\Models\Notificacion;
use App\Models\ReglasAlerta;
use App\Models\User;
use Illuminate\Http\UploadedFile;
use Exception;
use Illuminate\Container\Attributes\Auth;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\ValidationException;

class AlertaEpidemiologicaService
{
    private $modulo = "ALERTAS EPIDEMIOLOGICAS";
    private $urlApi = 'http://127.0.0.1:8000/analizar';

    public function __construct(private  CargarArchivoService $cargarArchivoService, private HistorialAccionService $historialAccionService, private NotificacionService $notificacion_service) {}

    public function listado(): Collection
    {
        $alerta_epidemiologicas = AlertaEpidemiologica::select("alerta_epidemiologicas.*")->get();
        return $alerta_epidemiologicas;
    }
    /**
     * Lista de alerta_epidemiologicas paginado con filtros
     *
     * @param integer $length
     * @param integer $page
     * @param string $search
     * @param array $columnsSerachLike
     * @param array $columnsFilter
     * @return LengthAwarePaginator
     */
    public function listadoPaginado(
        int $length,
        int $page,
        string $search,
        array $orderBy = [],
        string $estado = "",
        string $comunidad_id = "",
        string $enfermedad_id = "",
    ): LengthAwarePaginator {
        $alerta_epidemiologicas = AlertaEpidemiologica::select("alerta_epidemiologicas.*")
            ->with(["comunidad:id,nombre", "enfermedad:id,nombre"]);

        $alerta_epidemiologicas->when($estado, function ($q) use ($estado) {
            $q->where("estado", $estado);
        });

        $alerta_epidemiologicas->when($comunidad_id, function ($q) use ($comunidad_id) {
            $q->where("comunidad_id", $comunidad_id);
        });

        $alerta_epidemiologicas->when($enfermedad_id, function ($q) use ($enfermedad_id) {
            $q->where("enfermedad_id", $enfermedad_id);
        });

        // Ordenamiento
        foreach ($orderBy as $value) {
            if (isset($value[0], $value[1])) {
                $alerta_epidemiologicas->orderBy($value[0], $value[1]);
            }
        }

        $alerta_epidemiologicas = $alerta_epidemiologicas->paginate($length, ['*'], 'page', $page);
        return $alerta_epidemiologicas;
    }

    /**
     * Crear alerta_epidemiologica
     *
     * @param array $datos
     * @return AlertaEpidemiologica
     */
    public function crear(array $datos): AlertaEpidemiologica
    {
        $alerta_epidemiologica = AlertaEpidemiologica::create([
            "nombre" => mb_strtoupper($datos["nombre"]),
            "latitud" => $datos["latitud"],
            "longitud" => $datos["longitud"],
        ]);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UNA ALERTA EPIDEMIOLOGICA", $alerta_epidemiologica);

        return $alerta_epidemiologica;
    }

    /**
     * Actualizar alerta_epidemiologica
     *
     * @param array $datos
     * @param AlertaEpidemiologica $alerta_epidemiologica
     * @return AlertaEpidemiologica
     */
    public function actualizar(array $datos, AlertaEpidemiologica $alerta_epidemiologica): AlertaEpidemiologica
    {
        $old_alerta_epidemiologica = clone $alerta_epidemiologica;

        $alerta_epidemiologica->update([
            "nombre" => mb_strtoupper($datos["nombre"]),
            "latitud" => $datos["latitud"],
            "longitud" => $datos["longitud"],
        ]);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ UNA ALERTA EPIDEMIOLOGICA", $old_alerta_epidemiologica, $alerta_epidemiologica->withoutRelations());

        return $alerta_epidemiologica;
    }

    /**
     * Eliminar alerta_epidemiologica
     *
     * @param AlertaEpidemiologica $alerta_epidemiologica
     * @return boolean
     */
    public function eliminar(AlertaEpidemiologica $alerta_epidemiologica): bool|Exception
    {
        // TODO: VERIFICAR RELACIONES

        $old_alerta_epidemiologica = clone $alerta_epidemiologica;
        $alerta_epidemiologica->delete();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ UNA ALERTA EPIDEMIOLOGICA", $old_alerta_epidemiologica, $alerta_epidemiologica);

        return true;
    }

    public function verificarAlertas()
    {
        $enfermedades = Enfermedad::all();

        $comunidades = Comunidad::all();

        foreach ($enfermedades as $enfermedad) {

            // BUSCAR REGLA ACTIVA
            $regla = ReglasAlerta::query()
                ->where('enfermedad_id', $enfermedad->id)
                ->where('status', 1)
                ->first();

            // CONFIGURACIÓN POR DEFECTO
            $umbral = $regla?->umbral ?? 5;

            // TODO:
            // mover a configuraciones generales
            $ventanaDias = 7;

            foreach ($comunidades as $comunidad) {

                // OBTENER CASOS
                $casos = CasoEpidemiologico::query()
                    ->where('enfermedad_id', $enfermedad->id)
                    ->where('comunidad_id', $comunidad->id)
                    ->whereIn('tipo_caso', [
                        'PROBABLE',
                        'CONFIRMADO'
                    ])
                    ->whereIn('gravedad', [
                        'MODERADO',
                        'GRAVE',
                        'CRITICO',
                    ])
                    ->whereIn('estado', [
                        'ACTIVO',
                    ])
                    ->whereBetween(
                        'fecha_diagnostico',
                        [
                            now()->subDays($ventanaDias),
                            now()
                        ]
                    )
                    ->orderBy('fecha_diagnostico')
                    ->get();

                // SI NO EXISTEN CASOS
                if ($casos->isEmpty()) {
                    continue;
                }

                // TOTAL CONFIRMADOS
                // $totalConfirmados = $casos->count();
                $totalConfirmados = 100; //PRUEBAS

                // VALIDAR UMBRAL
                if ($totalConfirmados < $umbral) {
                    Log::debug("
                    {$enfermedad->nombre}
                    no supera el umbral
                ");
                    // SI EXISTE ALERTA ACTIVA
                    // MARCAR COMO CONTROLADO
                    $alertaActiva = AlertaEpidemiologica::query()
                        ->where('comunidad_id', $comunidad->id)
                        ->where('enfermedad_id', $enfermedad->id)
                        ->where('estado', 'ACTIVO')
                        ->first();

                    if ($alertaActiva) {
                        $alertaActiva->update([
                            'estado' => 'CONTROLADO',
                            'fecha_control' => now(),
                        ]);
                    }
                    continue;
                }

                // AGRUPAR POR FECHA
                $dias = $casos
                    ->groupBy(function ($item) {
                        return $item
                            ->fecha_diagnostico
                            ->format('Y-m-d');
                    })
                    ->map(function ($items, $fecha) {
                        return [
                            'fecha' => $fecha,
                            'confirmados' => $items->count(),
                            'activos' => $items
                                ->where('estado', 'ACTIVO')
                                ->count(),
                            'graves' => $items
                                ->whereIn('gravedad', [
                                    'GRAVE',
                                    'CRITICO'
                                ])
                                ->count(),
                            'fallecidos' => $items
                                ->where('estado', 'FALLECIDO')
                                ->count(),
                        ];
                    })
                    ->values();
                // PAYLOAD PARA FASTAPI
                // $payload = [
                //     'enfermedad_id' => $enfermedad->id,
                //     'comunidad_id' => $comunidad->id,
                //     'dias' => $dias
                // ];
                // DATOS PRUEBAS
                $payload = $this->datosPruebaAlerta(
                    $enfermedad->id,
                    $comunidad->id
                );
                try {
                    // ENVIAR A FASTAPI
                    $response = Http::timeout(30)
                        ->post(
                            $this->urlApi,
                            $payload
                        );

                    // ERROR API
                    if ($response->failed()) {
                        Log::error("
                        Error FastAPI:
                        {$response->body()}
                    ");
                        continue;
                    }

                    $resultado = $response->json();

                    // BUSCAR ALERTA ACTIVA
                    $alertaActiva = AlertaEpidemiologica::query()
                        ->where('comunidad_id', $comunidad->id)
                        ->where('enfermedad_id', $enfermedad->id)
                        ->where('estado', 'ACTIVO')
                        ->first();

                    DB::beginTransaction();

                    // SI YA EXISTE ALERTA
                    if ($alertaActiva) {
                        $alertaActiva->update([
                            'nivel_alerta' => $resultado['riesgo'],
                            'indice' => $resultado['indice'],
                            'prediccion' => $resultado['prediccion'],
                            'crecimiento' => $resultado['crecimiento'],
                            'confirmados' => $resultado['confirmados'],
                            'activos' => $resultado['activos'],
                            'graves' => $resultado['graves'],
                            'fallecidos' => $resultado['fallecidos'],
                            'fecha' => now(),
                            'ultima_actualizacion' => now(),
                        ]);
                        $alerta_epidemiologica = $alertaActiva;
                    } else {
                        // CREAR NUEVA ALERTA
                        $alerta_epidemiologica =
                            AlertaEpidemiologica::create([
                                'comunidad_id' => $comunidad->id,
                                'enfermedad_id' => $enfermedad->id,
                                'nivel_alerta' => $resultado['riesgo'],
                                'indice' => $resultado['indice'],
                                'prediccion' => $resultado['prediccion'],
                                'crecimiento' => $resultado['crecimiento'],
                                'confirmados' => $resultado['confirmados'],
                                'activos' => $resultado['activos'],
                                'graves' => $resultado['graves'],
                                'fallecidos' => $resultado['fallecidos'],
                                'fecha' => now(),
                                'ultima_actualizacion' => now(),
                                'estado' => 'ACTIVO'
                            ]);

                        // GENERAR NOTIFICACIÓN
                        $this->notificacion_service->crear([
                            "descripcion" => "{$alerta_epidemiologica->nivel_alerta}: Se detectó incremento de casos de {$enfermedad->nombre}",
                            "modulo" => "AlertaEpidemiologica",
                            "tipo" => "ALERTA",
                            "registro_id" => $alerta_epidemiologica->id,
                        ]);
                    }

                    // SI EL RIESGO BAJA
                    if ($resultado['indice'] <= 20) {
                        $alerta_epidemiologica->update([
                            'estado' => 'CONTROLADO',
                            'fecha_control' => now(),
                        ]);
                    }
                    DB::commit();
                    // Log::debug($resultado);
                } catch (\Exception $e) {

                    DB::rollBack();

                    Log::error($e->getMessage());
                }
            }
        }
    }

    public function datosPruebaAlerta($enfermedad_id, $comunidad_id)
    {
        return [
            'enfermedad_id' => $enfermedad_id,
            'comunidad_id' => $comunidad_id,
            'dias' => [
                [
                    'fecha' => '2026-05-20',
                    'confirmados' => 2,
                    'activos' => 2,
                    'graves' => 0,
                    'fallecidos' => 0,
                ],

                [
                    'fecha' => '2026-05-21',
                    'confirmados' => 4,
                    'activos' => 3,
                    'graves' => 1,
                    'fallecidos' => 0,
                ],

                [
                    'fecha' => '2026-05-22',
                    'confirmados' => 7,
                    'activos' => 6,
                    'graves' => 2,
                    'fallecidos' => 0,
                ],

                [
                    'fecha' => '2026-05-23',
                    'confirmados' => 10,
                    'activos' => 8,
                    'graves' => 3,
                    'fallecidos' => 1,
                ],
            ]
        ];
    }
}
