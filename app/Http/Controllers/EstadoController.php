<?php

namespace App\Http\Controllers;

use App\Services\EstadoService;
use Illuminate\Http\Request;

class EstadoController extends Controller
{
    public function __construct(private EstadoService $estado_service) {}

    public function listado()
    {
        return response()->JSON($this->estado_service->listado());
    }
}
