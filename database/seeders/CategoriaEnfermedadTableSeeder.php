<?php

namespace Database\Seeders;

use App\Models\CategoriaEnfermedad;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class CategoriaEnfermedadTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        CategoriaEnfermedad::create([
            "nombre" => mb_strtoupper("Viral"),
        ]);
        CategoriaEnfermedad::create([
            "nombre" => mb_strtoupper("Bacteriana"),
        ]);
        CategoriaEnfermedad::create([
            "nombre" => mb_strtoupper("Parasitaria"),
        ]);
        CategoriaEnfermedad::create([
            "nombre" => mb_strtoupper("Respiratoria"),
        ]);
        CategoriaEnfermedad::create([
            "nombre" => mb_strtoupper("Gastrointestinal"),
        ]);
        CategoriaEnfermedad::create([
            "nombre" => mb_strtoupper("Vectorial"),
        ]);
        CategoriaEnfermedad::create([
            "nombre" => mb_strtoupper("Zoonótica"),
        ]);
        CategoriaEnfermedad::create([
            "nombre" => mb_strtoupper("Dermatológica"),
        ]);
    }
}
