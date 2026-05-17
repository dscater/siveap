<?php

namespace App\Http\Controllers;

use App\Http\Requests\EnfermedadStoreRequest;
use App\Http\Requests\EnfermedadUpdateRequest;
use App\Models\Enfermedad;
use App\Models\User;
use App\Services\EnfermedadService;
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

class EnfermedadController extends Controller
{
    public function __construct(private EnfermedadService $enfermedadService) {}

    /**
     * Página index
     *
     * @return Response
     */
    public function index(): ResponseInertia
    {
        return Inertia::render("Admin/Enfermedads/Index");
    }

    /**
     * Listado de enfermedads sin ids: 1 y 2
     *
     * @return JsonResponse
     */
    public function listado(): JsonResponse
    {
        return response()->JSON([
            "enfermedads" => $this->enfermedadService->listado()
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

        $enfermedads = $this->enfermedadService->listadoPaginado($perPage, $page, $search, $columnsSerachLike, $columnsFilter, $columnsBetweenFilter, $arrayOrderBy);
        return response()->JSON([
            "data" => $enfermedads->items(),
            "total" => $enfermedads->total(),
            "lastPage" => $enfermedads->lastPage()
        ]);
    }

    /**
     * Registrar un nuevo enfermedad
     *
     * @param EnfermedadStoreRequest $request
     * @return RedirectResponse|Response
     */
    public function store(EnfermedadStoreRequest $request): RedirectResponse|Response
    {
        DB::beginTransaction();
        try {
            // crear el Enfermedad
            $this->enfermedadService->crear($request->validated());
            DB::commit();
            return redirect()->route("enfermedads.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Mostrar un enfermedad
     *
     * @param Enfermedad $enfermedad
     * @return JsonResponse
     */
    public function show(Enfermedad $enfermedad): JsonResponse
    {
        return response()->JSON($enfermedad);
    }

    public function update(Enfermedad $enfermedad, EnfermedadUpdateRequest $request)
    {
        DB::beginTransaction();
        try {
            // actualizar enfermedad
            $this->enfermedadService->actualizar($request->validated(), $enfermedad);
            DB::commit();
            return redirect()->route("enfermedads.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Eliminar enfermedad
     *
     * @param Enfermedad $enfermedad
     * @return JsonResponse|Response
     */
    public function destroy(Enfermedad $enfermedad): JsonResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->enfermedadService->eliminar($enfermedad);
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
