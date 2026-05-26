<?php

namespace App\Http\Controllers;

use App\Http\Requests\SeguimientoStoreRequest;
use App\Http\Requests\SeguimientoUpdateRequest;
use App\Models\CasoEpidemiologico;
use App\Models\Seguimiento;
use App\Models\User;
use App\Services\SeguimientoService;
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

class SeguimientoController extends Controller
{
    public function __construct(private SeguimientoService $seguimientoService) {}

    /**
     * Página index
     *
     * @return Response
     */
    public function index(CasoEpidemiologico $caso_epidemiologico): ResponseInertia
    {
        $caso_epidemiologico = $caso_epidemiologico->load([
            "paciente",
            "enfermedad",
            "centro",
            "comunidad",
        ]);
        return Inertia::render("Admin/Seguimientos/Index", compact("caso_epidemiologico"));
    }

    /**
     * Listado de seguimientos sin ids: 1 y 2
     *
     * @return JsonResponse
     */
    public function listado(): JsonResponse
    {
        return response()->JSON([
            "seguimientos" => $this->seguimientoService->listado()
        ]);
    }

    public function paginado(Request $request)
    {
        $perPage = $request->perPage;
        $page = (int)($request->input("page", 1));
        $search = (string)$request->input("search", "");
        $caso_epidemiologico_id = (string)$request->input("caso_epidemiologico_id", "");
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

        $seguimientos = $this->seguimientoService->listadoPaginado($perPage, $page, $search, $columnsSerachLike, $columnsFilter, $columnsBetweenFilter, $arrayOrderBy, $caso_epidemiologico_id);
        return response()->JSON([
            "data" => $seguimientos->items(),
            "total" => $seguimientos->total(),
            "lastPage" => $seguimientos->lastPage()
        ]);
    }

    /**
     * Registrar un nuevo seguimiento
     *
     * @param SeguimientoStoreRequest $request
     * @return RedirectResponse|Response
     */
    public function store(SeguimientoStoreRequest $request): RedirectResponse|Response
    {
        DB::beginTransaction();
        try {
            // crear el Seguimiento
            $seguimiento = $this->seguimientoService->crear($request->validated());
            DB::commit();
            return redirect()->route("seguimientos.index", $seguimiento->caso_epidemiologico_id)->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Mostrar un seguimiento
     *
     * @param Seguimiento $seguimiento
     * @return JsonResponse
     */
    public function show(Seguimiento $seguimiento): JsonResponse
    {
        return response()->JSON($seguimiento);
    }

    public function update(Seguimiento $seguimiento, SeguimientoUpdateRequest $request)
    {
        DB::beginTransaction();
        try {
            // actualizar seguimiento
            $seguimiento = $this->seguimientoService->actualizar($request->validated(), $seguimiento);
            DB::commit();
            return redirect()->route("seguimientos.index", $seguimiento->caso_epidemiologico_id)->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Eliminar seguimiento
     *
     * @param Seguimiento $seguimiento
     * @return JsonResponse|Response
     */
    public function destroy(Seguimiento $seguimiento): JsonResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->seguimientoService->eliminar($seguimiento);
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
