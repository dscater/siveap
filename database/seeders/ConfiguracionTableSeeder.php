<?php

namespace Database\Seeders;

use App\Models\Configuracion;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class ConfiguracionTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Configuracion::create([
            "nombre_sistema" => "SIVEAP",
            "alias" => "SIVEAP",
            "razon_social" => "SIVEAP S.A.",
            "nit" => "11111111111",
            "dir" => "LOS PEDREGALES #223",
            "fono" => "2323232 - 7776666",
            "actividad" => "ACTIVIDAD EMPRESA",
            "correo" => "siveap@gmail.com",
            "logo" => "logo.jpg",
            "logo2" => "logo2.jpg"
        ]);
    }
}
