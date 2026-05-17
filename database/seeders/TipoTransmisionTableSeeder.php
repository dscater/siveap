<?php

namespace Database\Seeders;

use App\Models\TipoTransmision;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class TipoTransmisionTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        TipoTransmision::create([
            "nombre" => mb_strtoupper("Respiratoria")
        ]);

        TipoTransmision::create([
            "nombre" => mb_strtoupper("Contacto directo")
        ]);

        TipoTransmision::create([
            "nombre" => mb_strtoupper("Agua contaminada")
        ]);


        TipoTransmision::create([
            "nombre" => mb_strtoupper("Alimentos contaminados")
        ]);

        TipoTransmision::create([
            "nombre" => mb_strtoupper("Vectorial")
        ]);

        TipoTransmision::create([
            "nombre" => mb_strtoupper("Sexual")
        ]);

        TipoTransmision::create([
            "nombre" => mb_strtoupper("Sangre")
        ]);

        TipoTransmision::create([
            "nombre" => mb_strtoupper("Animal-Humano")
        ]);


        TipoTransmision::create([
            "nombre" => mb_strtoupper("Fecal-oral")
        ]);
    }
}
