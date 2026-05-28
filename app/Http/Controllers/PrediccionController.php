<?php

namespace App\Http\Controllers;

use App\Models\Comunidad;
use App\Models\Enfermedad;
use App\Services\PrediccionService;
use Illuminate\Http\Request;
use Inertia\Inertia;

class PrediccionController extends Controller
{
    public function __construct(private PrediccionService $prediccion_service) {}
    public function index()
    {

        $comunidads = Comunidad::all();
        $enfermedads = Enfermedad::all();
        return Inertia::render("Admin/Prediccions/Index", compact("comunidads", "enfermedads"));
    }

    public function realizarPrediccions(Request $request)
    {
        return response()->JSON([
            "prediccions" => $this->prediccion_service->realizarPredicciones($request->dias_predecir ?? 7, $request->enfermedad_id ?? null, $request->comunidad_id ?? null)
        ]);
    }
}
