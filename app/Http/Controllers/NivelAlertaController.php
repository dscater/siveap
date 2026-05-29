<?php

namespace App\Http\Controllers;

use App\Services\NivelAlertaService;
use Illuminate\Http\Request;

class NivelAlertaController extends Controller
{
    public function __construct(private NivelAlertaService $nivel_alerta_service) {}

    public function listado()
    {
        return response()->JSON($this->nivel_alerta_service->listado());
    }
}
