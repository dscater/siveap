<?php

namespace App\Http\Controllers;

use App\Http\Requests\TipoTransmisionStoreRequest;
use App\Http\Requests\TipoTransmisionUpdateRequest;
use App\Models\TipoTransmision;
use App\Models\User;
use App\Services\TipoTransmisionService;
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

class TipoTransmisionController extends Controller
{
    public function __construct(private TipoTransmisionService $tipo_transmisionService) {}

    /**
     * Página index
     *
     * @return Response
     */
    public function index(): ResponseInertia
    {
        return Inertia::render("Admin/TipoTransmisions/Index");
    }

    /**
     * Listado de tipo_transmisions sin ids: 1 y 2
     *
     * @return JsonResponse
     */
    public function listado(): JsonResponse
    {
        return response()->JSON([
            "tipo_transmisions" => $this->tipo_transmisionService->listado()
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

        $tipo_transmisions = $this->tipo_transmisionService->listadoPaginado($perPage, $page, $search, $columnsSerachLike, $columnsFilter, $columnsBetweenFilter, $arrayOrderBy);
        return response()->JSON([
            "data" => $tipo_transmisions->items(),
            "total" => $tipo_transmisions->total(),
            "lastPage" => $tipo_transmisions->lastPage()
        ]);
    }

    /**
     * Registrar un nuevo tipo_transmision
     *
     * @param TipoTransmisionStoreRequest $request
     * @return RedirectResponse|Response
     */
    public function store(TipoTransmisionStoreRequest $request): RedirectResponse|Response
    {
        DB::beginTransaction();
        try {
            // crear el TipoTransmision
            $this->tipo_transmisionService->crear($request->validated());
            DB::commit();
            return redirect()->route("tipo_transmisions.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Mostrar un tipo_transmision
     *
     * @param TipoTransmision $tipo_transmision
     * @return JsonResponse
     */
    public function show(TipoTransmision $tipo_transmision): JsonResponse
    {
        return response()->JSON($tipo_transmision);
    }

    public function update(TipoTransmision $tipo_transmision, TipoTransmisionUpdateRequest $request)
    {
        DB::beginTransaction();
        try {
            // actualizar tipo_transmision
            $this->tipo_transmisionService->actualizar($request->validated(), $tipo_transmision);
            DB::commit();
            return redirect()->route("tipo_transmisions.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Eliminar tipo_transmision
     *
     * @param TipoTransmision $tipo_transmision
     * @return JsonResponse|Response
     */
    public function destroy(TipoTransmision $tipo_transmision): JsonResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->tipo_transmisionService->eliminar($tipo_transmision);
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
