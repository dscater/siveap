<?php

namespace App\Http\Controllers;

use App\Services\TipoSintomaService;
use Illuminate\Http\Request;

class TipoSintomaController extends Controller
{
    public function __construct(private TipoSintomaService $tipo_sintoma_service) {}

    public function listado()
    {
        return response()->JSON($this->tipo_sintoma_service->listado());
    }
}
