<?php

namespace App\Services;


class EstadoService
{
    public function listado()
    {
        return [
            [
                "value" => "EN SEGUIMIENTO",
                "label" => "EN SEGUIMIENTO",
            ],
            [
                "value" => "ACTIVO",
                "label" => "ACTIVO",
            ],
            [
                "value" => "RECUPERADO",
                "label" => "RECUPERADO",
            ],
            [
                "value" => "FALLECIDO",
                "label" => "FALLECIDO",
            ],
            [
                "value" => "DESCARTADO",
                "label" => "DESCARTADO",
            ]
        ];
    }
}
