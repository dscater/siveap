<?php

namespace App\Http\Controllers;

use App\Http\Requests\CentroStoreRequest;
use App\Http\Requests\CentroUpdateRequest;
use App\Models\Centro;
use App\Models\User;
use App\Services\CentroService;
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

class CentroController extends Controller
{
    public function __construct(private CentroService $centroService) {}

    /**
     * Página index
     *
     * @return Response
     */
    public function index(): ResponseInertia
    {
        return Inertia::render("Admin/Centros/Index");
    }

    /**
     * Listado de centros sin ids: 1 y 2
     *
     * @return JsonResponse
     */
    public function listado(): JsonResponse
    {
        return response()->JSON([
            "centros" => $this->centroService->listado()
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

        $centros = $this->centroService->listadoPaginado($perPage, $page, $search, $columnsSerachLike, $columnsFilter, $columnsBetweenFilter, $arrayOrderBy);
        return response()->JSON([
            "data" => $centros->items(),
            "total" => $centros->total(),
            "lastPage" => $centros->lastPage()
        ]);
    }

    /**
     * Registrar un nuevo centro
     *
     * @param CentroStoreRequest $request
     * @return RedirectResponse|Response
     */
    public function store(CentroStoreRequest $request): RedirectResponse|Response
    {
        DB::beginTransaction();
        try {
            // crear el Centro
            $this->centroService->crear($request->validated());
            DB::commit();
            return redirect()->route("centros.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Mostrar un centro
     *
     * @param Centro $centro
     * @return JsonResponse
     */
    public function show(Centro $centro): JsonResponse
    {
        return response()->JSON($centro);
    }

    public function update(Centro $centro, CentroUpdateRequest $request)
    {
        DB::beginTransaction();
        try {
            // actualizar centro
            $this->centroService->actualizar($request->validated(), $centro);
            DB::commit();
            return redirect()->route("centros.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Eliminar centro
     *
     * @param Centro $centro
     * @return JsonResponse|Response
     */
    public function destroy(Centro $centro): JsonResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->centroService->eliminar($centro);
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
