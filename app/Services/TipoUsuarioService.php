<?php

namespace App\Services;

class TipoUsuarioService
{
    public function listado()
    {
        return [
            [
                "value" => "ADMINISTRACIÓN",
                "label" => "ADMINISTRACIÓN",
            ],
            [
                "value" => "CENTRO MÉDICO",
                "label" => "CENTRO MÉDICO",
            ],
        ];
    }
}
