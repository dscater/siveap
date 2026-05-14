<?php

namespace App\Http\Controllers;

use App\Http\Requests\ComunidadStoreRequest;
use App\Http\Requests\ComunidadUpdateRequest;
use App\Models\Comunidad;
use App\Models\User;
use App\Services\ComunidadService;
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

class ComunidadController extends Controller
{
    public function __construct(private ComunidadService $comunidadService) {}

    /**
     * Página index
     *
     * @return Response
     */
    public function index(): ResponseInertia
    {
        return Inertia::render("Admin/Comunidads/Index");
    }

    /**
     * Listado de comunidads sin ids: 1 y 2
     *
     * @return JsonResponse
     */
    public function listado(): JsonResponse
    {
        return response()->JSON([
            "comunidads" => $this->comunidadService->listado()
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

        $comunidads = $this->comunidadService->listadoPaginado($perPage, $page, $search, $columnsSerachLike, $columnsFilter, $columnsBetweenFilter, $arrayOrderBy);
        return response()->JSON([
            "data" => $comunidads->items(),
            "total" => $comunidads->total(),
            "lastPage" => $comunidads->lastPage()
        ]);
    }

    /**
     * Registrar un nuevo comunidad
     *
     * @param ComunidadStoreRequest $request
     * @return RedirectResponse|Response
     */
    public function store(ComunidadStoreRequest $request): RedirectResponse|Response
    {
        DB::beginTransaction();
        try {
            // crear el Comunidad
            $this->comunidadService->crear($request->validated());
            DB::commit();
            return redirect()->route("comunidads.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Mostrar un comunidad
     *
     * @param Comunidad $comunidad
     * @return JsonResponse
     */
    public function show(Comunidad $comunidad): JsonResponse
    {
        return response()->JSON($comunidad);
    }

    public function update(Comunidad $comunidad, ComunidadUpdateRequest $request)
    {
        DB::beginTransaction();
        try {
            // actualizar comunidad
            $this->comunidadService->actualizar($request->validated(), $comunidad);
            DB::commit();
            return redirect()->route("comunidads.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Eliminar comunidad
     *
     * @param Comunidad $comunidad
     * @return JsonResponse|Response
     */
    public function destroy(Comunidad $comunidad): JsonResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->comunidadService->eliminar($comunidad);
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
