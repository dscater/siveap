<?php

namespace App\Http\Controllers;

use App\Http\Requests\PacienteStoreRequest;
use App\Http\Requests\PacienteUpdateRequest;
use App\Models\Paciente;
use App\Models\User;
use App\Services\PacienteService;
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

class PacienteController extends Controller
{
    public function __construct(private PacienteService $pacienteService) {}

    /**
     * Página index
     *
     * @return Response
     */
    public function index(): ResponseInertia
    {
        return Inertia::render("Admin/Pacientes/Index");
    }

    /**
     * Listado de pacientes sin ids: 1 y 2
     *
     * @return JsonResponse
     */
    public function listado(): JsonResponse
    {
        return response()->JSON([
            "pacientes" => $this->pacienteService->listado()
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

        $pacientes = $this->pacienteService->listadoPaginado($perPage, $page, $search, $columnsSerachLike, $columnsFilter, $columnsBetweenFilter, $arrayOrderBy);
        return response()->JSON([
            "data" => $pacientes->items(),
            "total" => $pacientes->total(),
            "lastPage" => $pacientes->lastPage()
        ]);
    }

    /**
     * Registrar un nuevo paciente
     *
     * @param PacienteStoreRequest $request
     * @return RedirectResponse|Response
     */
    public function store(PacienteStoreRequest $request): RedirectResponse|Response
    {
        DB::beginTransaction();
        try {
            // crear el Paciente
            $this->pacienteService->crear($request->validated());
            DB::commit();
            return redirect()->route("pacientes.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Mostrar un paciente
     *
     * @param Paciente $paciente
     * @return JsonResponse
     */
    public function show(Paciente $paciente): JsonResponse
    {
        return response()->JSON($paciente);
    }

    public function update(Paciente $paciente, PacienteUpdateRequest $request)
    {
        DB::beginTransaction();
        try {
            // actualizar paciente
            $this->pacienteService->actualizar($request->validated(), $paciente);
            DB::commit();
            return redirect()->route("pacientes.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Eliminar paciente
     *
     * @param Paciente $paciente
     * @return JsonResponse|Response
     */
    public function destroy(Paciente $paciente): JsonResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->pacienteService->eliminar($paciente);
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
