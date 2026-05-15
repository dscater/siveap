<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class TipoUsuarioController extends Controller
{

    public function listado()
    {
        return response()->JSON([
            [
                "value" => "ADMINISTRACIÓN",
                "label" => "ADMINISTRACIÓN",
            ],
            [
                "value" => "CENTRO MÉDICO",
                "label" => "CENTRO MÉDICO",
            ]
        ]);
    }
}
