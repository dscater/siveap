<?php

namespace App\Services;

class NivelAlertaService
{
    public function listado()
    {
        return [
            [
                "value" => "BAJO",
                "label" => "BAJO",
            ],
            [
                "value" => "MEDIO",
                "label" => "MEDIO",
            ],
            [
                "value" => "ALTO",
                "label" => "ALTO",
            ],
            [
                "value" => "CRITICO",
                "label" => "CRITICO",
            ]
        ];
    }
}
