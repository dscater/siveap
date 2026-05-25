<?php

namespace App\Services;

class GravedadService
{
    public function listado()
    {
        return [
            [
                "value" => "LEVE",
                "label" => "LEVE",
            ],
            [
                "value" => "MODERADO",
                "label" => "MODERADO",
            ],
            [
                "value" => "GRAVE",
                "label" => "GRAVE",
            ],
            [
                "value" => "CRITICO",
                "label" => "CRITICO",
            ]
        ];
    }
}
