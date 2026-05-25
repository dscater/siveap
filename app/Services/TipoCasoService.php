<?php

namespace App\Services;

class TipoCasoService
{
    public function listado()
    {
        return [
            [
                "value" => "SOSPECHOSO",
                "label" => "SOSPECHOSO",
            ],
            [
                "value" => "PROBABLE",
                "label" => "PROBABLE",
            ],
            [
                "value" => "CONFIRMADO",
                "label" => "CONFIRMADO",
            ],
            [
                "value" => "DESCARTADO",
                "label" => "DESCARTADO",
            ]
        ];
    }
}
