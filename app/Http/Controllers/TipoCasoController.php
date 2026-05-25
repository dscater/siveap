<?php

namespace App\Http\Controllers;

use App\Services\TipoCasoService;
use Illuminate\Http\Request;

class TipoCasoController extends Controller
{
    public function __construct(private TipoCasoService $tipo_caso_service) {}

    public function listado()
    {
        return response()->JSON($this->tipo_caso_service->listado());
    }
}
