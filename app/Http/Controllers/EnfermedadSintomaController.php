<?php

namespace App\Http\Controllers;

use App\Http\Requests\EnfermedadSintomaStoreRequest;
use App\Http\Requests\EnfermedadSintomaUpdateRequest;
use App\Models\EnfermedadSintoma;
use App\Models\User;
use App\Services\EnfermedadSintomaService;
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

class EnfermedadSintomaController extends Controller
{
    public function __construct(private EnfermedadSintomaService $enfermedad_sintomaService) {}

    /**
     * Página index
     *
     * @return Response
     */
    public function index(): ResponseInertia
    {
        return Inertia::render("Admin/EnfermedadSintomas/Index");
    }

    /**
     * Listado de enfermedad_sintomas sin ids: 1 y 2
     *
     * @return JsonResponse
     */
    public function listado(Request $request): JsonResponse
    {
        return response()->JSON([
            "enfermedad_sintomas" => $this->enfermedad_sintomaService->listado($request->input("enfermedad_id", ""))
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

        $enfermedad_sintomas = $this->enfermedad_sintomaService->listadoPaginado($perPage, $page, $search, $columnsSerachLike, $columnsFilter, $columnsBetweenFilter, $arrayOrderBy);
        return response()->JSON([
            "data" => $enfermedad_sintomas->items(),
            "total" => $enfermedad_sintomas->total(),
            "lastPage" => $enfermedad_sintomas->lastPage()
        ]);
    }

    /**
     * Registrar un nuevo enfermedad_sintoma
     *
     * @param EnfermedadSintomaStoreRequest $request
     * @return RedirectResponse|Response
     */
    public function store(EnfermedadSintomaStoreRequest $request): RedirectResponse|Response
    {
        DB::beginTransaction();
        try {
            // crear el EnfermedadSintoma
            $this->enfermedad_sintomaService->crear($request->validated());
            DB::commit();
            return redirect()->route("enfermedad_sintomas.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Mostrar un enfermedad_sintoma
     *
     * @param EnfermedadSintoma $enfermedad_sintoma
     * @return JsonResponse
     */
    public function show(EnfermedadSintoma $enfermedad_sintoma): JsonResponse
    {
        return response()->JSON($enfermedad_sintoma);
    }

    public function update(EnfermedadSintoma $enfermedad_sintoma, EnfermedadSintomaUpdateRequest $request)
    {
        DB::beginTransaction();
        try {
            // actualizar enfermedad_sintoma
            $this->enfermedad_sintomaService->actualizar($request->validated(), $enfermedad_sintoma);
            DB::commit();
            return redirect()->route("enfermedad_sintomas.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Eliminar enfermedad_sintoma
     *
     * @param EnfermedadSintoma $enfermedad_sintoma
     * @return JsonResponse|Response
     */
    public function destroy(EnfermedadSintoma $enfermedad_sintoma): JsonResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->enfermedad_sintomaService->eliminar($enfermedad_sintoma);
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
