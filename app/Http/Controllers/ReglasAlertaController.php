<?php

namespace App\Http\Controllers;

use App\Http\Requests\ReglasAlertaStoreRequest;
use App\Http\Requests\ReglasAlertaUpdateRequest;
use App\Models\ReglasAlerta;
use App\Models\User;
use App\Services\ReglasAlertaService;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Response;
use Illuminate\Validation\ValidationException;
use Inertia\Inertia;
use Inertia\Response as ResponseInertia;

class ReglasAlertaController extends Controller
{
    public function __construct(private ReglasAlertaService $reglas_alertaService) {}

    /**
     * Página index
     *
     * @return Response
     */
    public function index(): ResponseInertia
    {
        return Inertia::render("Admin/ReglasAlertas/Index");
    }

    /**
     * Listado de reglas_alertas sin ids: 1 y 2
     *
     * @return JsonResponse
     */
    public function listado(): JsonResponse
    {
        return response()->JSON([
            "reglas_alertas" => $this->reglas_alertaService->listado()
        ]);
    }

    public function paginado(Request $request)
    {
        $perPage = $request->perPage;
        $page = (int)($request->input("page", 1));
        $search = (string)$request->input("search", "");
        $orderBy = $request->orderBy;
        $orderAsc = $request->orderAsc;

        $columnsSerachLike = [
            "nombre",
            "descripcion",
        ];
        $columnsFilter = [];
        $columnsBetweenFilter = [];
        $arrayOrderBy = [];
        if ($orderBy && $orderAsc) {
            $arrayOrderBy = [
                [$orderBy, $orderAsc]
            ];
        }

        $reglas_alertas = $this->reglas_alertaService->listadoPaginado($perPage, $page, $search, $columnsSerachLike, $columnsFilter, $columnsBetweenFilter, $arrayOrderBy);
        return response()->JSON([
            "data" => $reglas_alertas->items(),
            "total" => $reglas_alertas->total(),
            "lastPage" => $reglas_alertas->lastPage()
        ]);
    }

    /**
     * Registrar un nuevo reglas_alerta
     *
     * @param ReglasAlertaStoreRequest $request
     * @return RedirectResponse|Response
     */
    public function store(ReglasAlertaStoreRequest $request): RedirectResponse|Response
    {
        DB::beginTransaction();
        try {
            // crear el ReglasAlerta
            $this->reglas_alertaService->crear($request->validated());
            DB::commit();
            return redirect()->route("reglas_alertas.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Mostrar un reglas_alerta
     *
     * @param ReglasAlerta $reglas_alerta
     * @return JsonResponse
     */
    public function show(ReglasAlerta $reglas_alerta): JsonResponse
    {
        return response()->JSON($reglas_alerta);
    }

    public function update(ReglasAlerta $reglas_alerta, ReglasAlertaUpdateRequest $request)
    {
        DB::beginTransaction();
        try {
            // actualizar reglas_alerta
            $this->reglas_alertaService->actualizar($request->validated(), $reglas_alerta);
            DB::commit();
            return redirect()->route("reglas_alertas.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Eliminar reglas_alerta
     *
     * @param ReglasAlerta $reglas_alerta
     * @return JsonResponse|Response
     */
    public function destroy(ReglasAlerta $reglas_alerta): JsonResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->reglas_alertaService->eliminar($reglas_alerta);
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
