<?php

namespace App\Services;

class TipoSintomaService
{
    public function listado()
    {
        return [
            [
                "value" => "SOSPECHA",
                "label" => "SOSPECHA",
            ],
            [
                "value" => "SIN SIGNOS DE ALARMA",
                "label" => "SIN SIGNOS DE ALARMA",
            ],
            [
                "value" => "CON SIGNOS DE ALARMA",
                "label" => "CON SIGNOS DE ALARMA",
            ],
            [
                "value" => "GRAVE",
                "label" => "GRAVE",
            ],
        ];
    }
}
