<?php

namespace App\Http\Controllers;

use App\Services\AlertaEpidemiologicaService;
use Illuminate\Http\Request;
use Inertia\Inertia;

class AlertaEpidemiologicaController extends Controller
{
    public function __construct(private AlertaEpidemiologicaService $alerta_epidemiologica_service) {}

    public function index()
    {
        $this->alerta_epidemiologica_service->verificarAlertas();
        return Inertia::render("Admin/AlertaEpidemiologicas/Index");
    }
}
