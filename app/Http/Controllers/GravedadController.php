<?php

namespace App\Http\Controllers;

use App\Services\GravedadService;
use Illuminate\Http\Request;

class GravedadController extends Controller
{
    public function __construct(private GravedadService $gravedad_service) {}

    public function listado()
    {
        return response()->JSON($this->gravedad_service->listado());
    }
}
