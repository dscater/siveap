<?php

namespace App\Http\Controllers;

use App\Http\Requests\CasoEpidemiologicoStoreRequest;
use App\Http\Requests\CasoEpidemiologicoUpdateRequest;
use App\Models\CasoEpidemiologico;
use App\Models\User;
use App\Services\CasoEpidemiologicoService;
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

class CasoEpidemiologicoController extends Controller
{
    public function __construct(private CasoEpidemiologicoService $caso_epidemiologicoService) {}

    /**
     * Página index
     *
     * @return Response
     */
    public function index(): ResponseInertia
    {
        return Inertia::render("Admin/CasoEpidemiologicos/Index");
    }

    /**
     * Listado de caso_epidemiologicos sin ids: 1 y 2
     *
     * @return JsonResponse
     */
    public function listado(): JsonResponse
    {
        return response()->JSON([
            "caso_epidemiologicos" => $this->caso_epidemiologicoService->listado()
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

        $caso_epidemiologicos = $this->caso_epidemiologicoService->listadoPaginado($perPage, $page, $search, $columnsSerachLike, $columnsFilter, $columnsBetweenFilter, $arrayOrderBy);
        return response()->JSON([
            "data" => $caso_epidemiologicos->items(),
            "total" => $caso_epidemiologicos->total(),
            "lastPage" => $caso_epidemiologicos->lastPage()
        ]);
    }

    /**
     * Registrar un nuevo caso_epidemiologico
     *
     * @param CasoEpidemiologicoStoreRequest $request
     * @return RedirectResponse|Response
     */
    public function store(CasoEpidemiologicoStoreRequest $request): RedirectResponse|Response
    {
        DB::beginTransaction();
        try {
            // crear el CasoEpidemiologico
            $this->caso_epidemiologicoService->crear($request->validated());
            DB::commit();
            return redirect()->route("caso_epidemiologicos.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Mostrar un caso_epidemiologico
     *
     * @param CasoEpidemiologico $caso_epidemiologico
     * @return JsonResponse
     */
    public function show(CasoEpidemiologico $caso_epidemiologico): JsonResponse
    {
        return response()->JSON($caso_epidemiologico);
    }

    public function update(CasoEpidemiologico $caso_epidemiologico, CasoEpidemiologicoUpdateRequest $request)
    {
        DB::beginTransaction();
        try {
            // actualizar caso_epidemiologico
            $this->caso_epidemiologicoService->actualizar($request->validated(), $caso_epidemiologico);
            DB::commit();
            return redirect()->route("caso_epidemiologicos.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Eliminar caso_epidemiologico
     *
     * @param CasoEpidemiologico $caso_epidemiologico
     * @return JsonResponse|Response
     */
    public function destroy(CasoEpidemiologico $caso_epidemiologico): JsonResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->caso_epidemiologicoService->eliminar($caso_epidemiologico);
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
