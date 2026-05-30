<?php

namespace App\Http\Controllers;

use App\Http\Requests\AlertaEpidemiologicaUpdateRequest;
use App\Models\AlertaEpidemiologica;
use App\Models\Comunidad;
use App\Models\Enfermedad;
use App\Models\NotificacionUser;
use App\Services\AlertaEpidemiologicaService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Response;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\DB;
use Inertia\Response as ResponseInertia;
use Illuminate\Validation\ValidationException;
use Inertia\Inertia;

class AlertaEpidemiologicaController extends Controller
{
    public function __construct(private AlertaEpidemiologicaService $alerta_epidemiologica_service) {}

    public function index()
    {
        $comunidads = Comunidad::all();
        $enfermedads = Enfermedad::all();
        return Inertia::render("Admin/AlertaEpidemiologicas/Index", compact("comunidads", "enfermedads"));
    }

    public function show(AlertaEpidemiologica $alerta_epidemiologica, Request $request)
    {
        $notificacionUserId = $request->input('notificacion_user_id');
        if ($notificacionUserId) {
            $notificacion_user = NotificacionUser::find($notificacionUserId);
            $notificacion_user->visto = 1;
            $notificacion_user->save();
        }

        $alerta_epidemiologica = $alerta_epidemiologica->load(["comunidad", "enfermedad.categoria_enfermedad", "enfermedad.tipo_transmision", "enfermedad.enfermedad_contingencia"]);
        return Inertia::render("Admin/AlertaEpidemiologicas/Show", compact("alerta_epidemiologica"));
    }

    public function getInfo(AlertaEpidemiologica $alerta_epidemiologica)
    {
        $alerta_epidemiologica = $alerta_epidemiologica->load(["comunidad", "enfermedad.categoria_enfermedad", "enfermedad.tipo_transmision", "enfermedad.enfermedad_contingencia"]);
        return response()->JSON($alerta_epidemiologica);
    }

    public function verificarAlertas()
    {
        $this->alerta_epidemiologica_service
            ->verificarAlertas();

        $alertas = AlertaEpidemiologica::query()
            ->with([
                "comunidad",
                "enfermedad"
            ])
            ->where("estado", "ACTIVO")
            ->get()
            ->groupBy("comunidad_id")
            ->map(function ($items) {
                $comunidad = $items->first()->comunidad;
                return [
                    "comunidad_id" => $comunidad->id,
                    "comunidad" => $comunidad->nombre,
                    "latitud" => $comunidad->latitud,
                    "longitud" => $comunidad->longitud,
                    // NIVEL MÁS ALTO
                    "nivel_alerta" => $items
                        ->max("indice"),
                    "alertas" => $items
                        ->map(function ($item) {
                            return [
                                "enfermedad" => $item->enfermedad->nombre,
                                "nivel_alerta" => $item->nivel_alerta,
                                "indice" => $item->indice,
                                "confirmados" => $item->confirmados,
                            ];
                        })
                        ->values()
                ];
            })
            ->values();
        return response()->json([
            "alertas" => $alertas
        ]);
    }

    /**
     * Listado de alerta_epidemiologicas sin ids: 1 y 2
     *
     * @return JsonResponse
     */
    public function listado(): JsonResponse
    {
        return response()->JSON([
            "alerta_epidemiologicas" => $this->alerta_epidemiologica_service->listado()
        ]);
    }

    public function paginado(Request $request)
    {
        $perPage = $request->perPage;
        $page = (int)($request->input("page", 1));
        $search = (string)$request->input("search", "");
        $estado = (string)$request->input("estado", "");
        $comunidad_id = (string)$request->input("comunidad_id", "");
        $enfermedad_id = (string)$request->input("enfermedad_id", "");
        $orderBy = $request->orderBy;
        $orderAsc = $request->orderAsc;

        $arrayOrderBy = [];
        if ($orderBy && $orderAsc) {
            $arrayOrderBy = [
                [$orderBy, $orderAsc]
            ];
        }

        $alerta_epidemiologicas = $this->alerta_epidemiologica_service->listadoPaginado($perPage, $page, $search, $arrayOrderBy, $estado, $comunidad_id, $enfermedad_id);
        return response()->JSON([
            "data" => $alerta_epidemiologicas->items(),
            "total" => $alerta_epidemiologicas->total(),
            "lastPage" => $alerta_epidemiologicas->lastPage()
        ]);
    }

    public function update(AlertaEpidemiologica $alerta_epidemiologica, AlertaEpidemiologicaUpdateRequest $request)
    {
        DB::beginTransaction();
        try {
            // actualizar alerta_epidemiologica
            $this->alerta_epidemiologica_service->actualizar($request->validated(), $alerta_epidemiologica);
            DB::commit();
            return redirect()->route("alerta_epidemiologicas.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function destroy(AlertaEpidemiologica $alerta_epidemiologica): JsonResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->alerta_epidemiologica_service->eliminar($alerta_epidemiologica);
            DB::commit();
            return response()->JSON([
                'sw' => true,
                'message' => 'El registro se eliminó correctamente'
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }
}
