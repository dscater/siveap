<?php

namespace App\Http\Controllers;

use App\Http\Requests\CategoriaEnfermedadStoreRequest;
use App\Http\Requests\CategoriaEnfermedadUpdateRequest;
use App\Models\CategoriaEnfermedad;
use App\Models\User;
use App\Services\CategoriaEnfermedadService;
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

class CategoriaEnfermedadController extends Controller
{
    public function __construct(private CategoriaEnfermedadService $categoria_enfermedadService) {}

    /**
     * Página index
     *
     * @return Response
     */
    public function index(): ResponseInertia
    {
        return Inertia::render("Admin/CategoriaEnfermedads/Index");
    }

    /**
     * Listado de categoria_enfermedads sin ids: 1 y 2
     *
     * @return JsonResponse
     */
    public function listado(): JsonResponse
    {
        return response()->JSON([
            "categoria_enfermedads" => $this->categoria_enfermedadService->listado()
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

        $categoria_enfermedads = $this->categoria_enfermedadService->listadoPaginado($perPage, $page, $search, $columnsSerachLike, $columnsFilter, $columnsBetweenFilter, $arrayOrderBy);
        return response()->JSON([
            "data" => $categoria_enfermedads->items(),
            "total" => $categoria_enfermedads->total(),
            "lastPage" => $categoria_enfermedads->lastPage()
        ]);
    }

    /**
     * Registrar un nuevo categoria_enfermedad
     *
     * @param CategoriaEnfermedadStoreRequest $request
     * @return RedirectResponse|Response
     */
    public function store(CategoriaEnfermedadStoreRequest $request): RedirectResponse|Response
    {
        DB::beginTransaction();
        try {
            // crear el CategoriaEnfermedad
            $this->categoria_enfermedadService->crear($request->validated());
            DB::commit();
            return redirect()->route("categoria_enfermedads.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Mostrar un categoria_enfermedad
     *
     * @param CategoriaEnfermedad $categoria_enfermedad
     * @return JsonResponse
     */
    public function show(CategoriaEnfermedad $categoria_enfermedad): JsonResponse
    {
        return response()->JSON($categoria_enfermedad);
    }

    public function update(CategoriaEnfermedad $categoria_enfermedad, CategoriaEnfermedadUpdateRequest $request)
    {
        DB::beginTransaction();
        try {
            // actualizar categoria_enfermedad
            $this->categoria_enfermedadService->actualizar($request->validated(), $categoria_enfermedad);
            DB::commit();
            return redirect()->route("categoria_enfermedads.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Eliminar categoria_enfermedad
     *
     * @param CategoriaEnfermedad $categoria_enfermedad
     * @return JsonResponse|Response
     */
    public function destroy(CategoriaEnfermedad $categoria_enfermedad): JsonResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->categoria_enfermedadService->eliminar($categoria_enfermedad);
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
