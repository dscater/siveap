<?php

namespace App\Services;

use App\Models\CasoEpidemiologico;
use App\Models\Comunidad;
use App\Models\Enfermedad;
use Carbon\Carbon;
use Exception;
use Illuminate\Container\Attributes\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\ValidationException;

class PrediccionService
{
    private $urlApi = 'http://127.0.0.1:8000/predecir';
    private $prueba = false;

    public function realizarPredicciones(
        $dias_predecir = 7,
        $enfermedad_id = null,
        $comunidad_id = null
    ) {

        $resultados = [];

        /**
         * COMUNIDADES
         */
        $comunidades = Comunidad::query()
            ->when(
                $comunidad_id,
                function ($q) use ($comunidad_id) {

                    $q->where(
                        'id',
                        $comunidad_id
                    );
                }
            )
            ->get();

        /**
         * ENFERMEDADES
         */
        $enfermedades = Enfermedad::query()
            ->when(
                $enfermedad_id,
                function ($q) use ($enfermedad_id) {
                    $q->where(
                        'id',
                        $enfermedad_id
                    );
                }
            )
            ->get();

        /**
         * RECORRER COMUNIDADES
         */
        foreach ($comunidades as $comunidad) {
            /**
             * DATA COMUNIDAD
             */
            $comunidadData = [
                'comunidad_id' => $comunidad->id,
                'comunidad' => $comunidad->nombre,
                'latitud' => $comunidad->latitud,
                'longitud' => $comunidad->longitud,
                'enfermedades' => []
            ];

            /**
             * RECORRER ENFERMEDADES
             */
            foreach ($enfermedades as $enfermedad) {

                /**
                 * CONSULTAR CASOS
                 */
                $casos = CasoEpidemiologico::query()
                    ->where('comunidad_id', $comunidad->id)
                    ->where('enfermedad_id', $enfermedad->id)
                    // no interesa el estado; solo si se confirmo o es probable
                    ->whereIn(
                        'tipo_caso',
                        [
                            'PROBABLE',
                            'CONFIRMADO'
                        ]
                    )
                    ->whereBetween(
                        'fecha_diagnostico',
                        [
                            now()->subDays(30),
                            now()
                        ]
                    )
                    ->orderBy(
                        'fecha_diagnostico'
                    )
                    ->get();

                /**
                 * SI NO EXISTEN CASOS
                 */
                if ($casos->isEmpty()) {
                    continue;
                }

                /**
                 * AGRUPAR HISTORICO
                 */
                $dias = $casos
                    ->groupBy(function ($item) {
                        return Carbon::parse(
                            $item->fecha_diagnostico
                        )->format('Y-m-d');
                    })
                    ->map(function ($items, $fecha) {
                        return [
                            'fecha' => $fecha,
                            'confirmados' => $items->count(),
                        ];
                    })
                    ->values()
                    ->toArray();

                /**
                 * PAYLOAD FASTAPI
                 */
                if ($this->prueba) {
                    // PRUEBAS
                    $payload = $this->datosPrueba($enfermedad_id, $comunidad_id, $dias_predecir);
                } else {
                    $payload = [
                        'enfermedad_id' => $enfermedad->id,
                        'comunidad_id' => $comunidad->id,
                        'dias_predecir' => $dias_predecir,
                        'dias' => $dias
                    ];
                }


                /**
                 * VALIDAR MINIMO
                 */
                if (count($payload["dias"]) < 3) {
                    continue;
                }

                // Log::debug($payload);

                /**
                 * CONSUMIR API
                 */
                $response = Http::timeout(30)

                    ->post(
                        $this->urlApi,
                        $payload
                    );

                /**
                 * VALIDAR ERROR API
                 */
                if ($response->failed()) {
                    Log::error(
                        $response->body()
                    );
                    continue;
                }

                /**
                 * RESPUESTA
                 */
                $prediccion = $response->json();

                /**
                 * AGREGAR ENFERMEDAD
                 */
                $comunidadData['enfermedades'][] = [
                    'enfermedad_id' => $enfermedad->id,
                    'enfermedad' => $enfermedad->nombre,
                    'riesgo' => $prediccion['riesgo'],
                    'crecimiento' => $prediccion['crecimiento'],
                    'historico' => $dias,
                    'predicciones' => $prediccion['predicciones'],
                ];
            }

            /**
             * VALIDAR SI TIENE ENFERMEDADES
             */
            // if (count($comunidadData['enfermedades']) > 0) {
            $resultados[] = $comunidadData;
            // }
        }

        return $resultados;
    }

    public function datosPrueba($enfermedad_id, $comunidad_id, $dias_predecir)
    {
        return  [
            'enfermedad_id' => $enfermedad_id,
            'comunidad_id' => $comunidad_id,
            'dias_predecir' => $dias_predecir,
            'dias' => [
                [
                    'fecha' => '2026-05-01',
                    'confirmados' => random_int(6, 12),
                ],
                [
                    'fecha' => '2026-05-02',
                    'confirmados' => random_int(1, 20),
                ],
                [
                    'fecha' => '2026-05-03',
                    'confirmados' => random_int(0, 20),
                ]
            ]
        ];
    }
}
