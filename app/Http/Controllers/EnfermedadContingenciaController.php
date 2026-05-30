<?php

namespace App\Http\Controllers;

use App\Http\Requests\EnfermedadContingenciaStoreRequest;
use App\Http\Requests\EnfermedadContingenciaUpdateRequest;
use App\Models\EnfermedadContingencia;
use App\Models\User;
use App\Services\EnfermedadContingenciaService;
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

class EnfermedadContingenciaController extends Controller
{
    public function __construct(private EnfermedadContingenciaService $enfermedad_contingenciaService) {}

    /**
     * Página index
     *
     * @return Response
     */
    public function index(): ResponseInertia
    {
        return Inertia::render("Admin/EnfermedadContingencias/Index");
    }

    /**
     * Listado de enfermedad_contingencias sin ids: 1 y 2
     *
     * @return JsonResponse
     */
    public function listado(): JsonResponse
    {
        return response()->JSON([
            "enfermedad_contingencias" => $this->enfermedad_contingenciaService->listado()
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

        $enfermedad_contingencias = $this->enfermedad_contingenciaService->listadoPaginado($perPage, $page, $search, $columnsSerachLike, $columnsFilter, $columnsBetweenFilter, $arrayOrderBy);
        return response()->JSON([
            "data" => $enfermedad_contingencias->items(),
            "total" => $enfermedad_contingencias->total(),
            "lastPage" => $enfermedad_contingencias->lastPage()
        ]);
    }

    /**
     * Registrar un nuevo enfermedad_contingencia
     *
     * @param EnfermedadContingenciaStoreRequest $request
     * @return RedirectResponse|Response
     */
    public function store(EnfermedadContingenciaStoreRequest $request): RedirectResponse|Response
    {
        DB::beginTransaction();
        try {
            // crear el EnfermedadContingencia
            $this->enfermedad_contingenciaService->crear($request->validated());
            DB::commit();
            return redirect()->route("enfermedad_contingencias.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Mostrar un enfermedad_contingencia
     *
     * @param EnfermedadContingencia $enfermedad_contingencia
     * @return JsonResponse
     */
    public function show(EnfermedadContingencia $enfermedad_contingencia): JsonResponse
    {
        return response()->JSON($enfermedad_contingencia);
    }

    public function update(EnfermedadContingencia $enfermedad_contingencia, EnfermedadContingenciaUpdateRequest $request)
    {
        DB::beginTransaction();
        try {
            // actualizar enfermedad_contingencia
            $this->enfermedad_contingenciaService->actualizar($request->validated(), $enfermedad_contingencia);
            DB::commit();
            return redirect()->route("enfermedad_contingencias.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Eliminar enfermedad_contingencia
     *
     * @param EnfermedadContingencia $enfermedad_contingencia
     * @return JsonResponse|Response
     */
    public function destroy(EnfermedadContingencia $enfermedad_contingencia): JsonResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->enfermedad_contingenciaService->eliminar($enfermedad_contingencia);
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
