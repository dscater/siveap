<?php

namespace Database\Seeders;

use App\Models\Enfermedad;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class EnfermedadTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Enfermedad::create([
            "nombre" => mb_strtoupper("Dengue"),
            "categoria_enfermedad_id" => 6,
            "tipo_transmision_id" => 5,
            "descripcion" => mb_strtoupper("Enfermedad viral transmitida por mosquitos.")
        ]);

        Enfermedad::create([
            "nombre" => mb_strtoupper("Malaria"),
            "categoria_enfermedad_id" => 3,
            "tipo_transmision_id" => 5,
            "descripcion" => mb_strtoupper("Enfermedad parasitaria transmitida por mosquitos.")
        ]);

        Enfermedad::create([
            "nombre" => mb_strtoupper("Chikungunya"),
            "categoria_enfermedad_id" => 1,
            "tipo_transmision_id" => 5,
            "descripcion" => mb_strtoupper("Enfermedad viral transmitida por mosquitos.")
        ]);

        Enfermedad::create([
            "nombre" => mb_strtoupper("Zika"),
            "categoria_enfermedad_id" => 1,
            "tipo_transmision_id" => 5,
            "descripcion" => mb_strtoupper("Virus transmitido principalmente por mosquitos.")
        ]);

        Enfermedad::create([
            "nombre" => mb_strtoupper("COVI-19"),
            "categoria_enfermedad_id" => 1,
            "tipo_transmision_id" => 1,
            "descripcion" => mb_strtoupper("Enfermedad respiratoria causada por coronavirus.")
        ]);

        Enfermedad::create([
            "nombre" => mb_strtoupper("Influenza"),
            "categoria_enfermedad_id" => 4,
            "tipo_transmision_id" => 1,
            "descripcion" => mb_strtoupper("Infección respiratoria viral.")
        ]);

        Enfermedad::create([
            "nombre" => mb_strtoupper("Tuberculosis"),
            "categoria_enfermedad_id" => 2,
            "tipo_transmision_id" => 1,
            "descripcion" => mb_strtoupper("Enfermedad bacteriana respiratoria.")
        ]);

        Enfermedad::create([
            "nombre" => mb_strtoupper("Neumonía"),
            "categoria_enfermedad_id" => 4,
            "tipo_transmision_id" => 1,
            "descripcion" => mb_strtoupper("Infección que inflama los pulmones.")
        ]);

        Enfermedad::create([
            "nombre" => mb_strtoupper("Diarre aguda"),
            "categoria_enfermedad_id" => 5,
            "tipo_transmision_id" => 3,
            "descripcion" => mb_strtoupper("Trastorno gastrointestinal generalmente infeccioso.")
        ]);

        Enfermedad::create([
            "nombre" => mb_strtoupper("Cólera"),
            "categoria_enfermedad_id" => 2,
            "tipo_transmision_id" => 3,
            "descripcion" => mb_strtoupper("Enfermedad bacteriana transmitida por agua contaminada.")
        ]);

        Enfermedad::create([
            "nombre" => mb_strtoupper("Hepatiti A"),
            "categoria_enfermedad_id" => 1,
            "tipo_transmision_id" => 9,
            "descripcion" => mb_strtoupper("Infección hepática viral.")
        ]);

        Enfermedad::create([
            "nombre" => mb_strtoupper("Parasitosi intestinal"),
            "categoria_enfermedad_id" => 3,
            "tipo_transmision_id" => 9,
            "descripcion" => mb_strtoupper("Infección intestinal causada por parásitos.")
        ]);

        Enfermedad::create([
            "nombre" => mb_strtoupper("Leptospirosis"),
            "categoria_enfermedad_id" => 2,
            "tipo_transmision_id" => 3,
            "descripcion" => mb_strtoupper("Enfermedad bacteriana asociada a agua contaminada.")
        ]);

        Enfermedad::create([
            "nombre" => mb_strtoupper("Rabia"),
            "categoria_enfermedad_id" => 7,
            "tipo_transmision_id" => 8,
            "descripcion" => mb_strtoupper("Enfermedad viral transmitida por animales.")
        ]);

        Enfermedad::create([
            "nombre" => mb_strtoupper("Sarampión"),
            "categoria_enfermedad_id" => 1,
            "tipo_transmision_id" => 1,
            "descripcion" => mb_strtoupper("Enfermedad viral altamente contagiosa.")
        ]);

        Enfermedad::create([
            "nombre" => mb_strtoupper("Varicela"),
            "categoria_enfermedad_id" => 1,
            "tipo_transmision_id" => 2,
            "descripcion" => mb_strtoupper("Infección viral contagiosa.")
        ]);

        Enfermedad::create([
            "nombre" => mb_strtoupper("Escabiosis"),
            "categoria_enfermedad_id" => 8,
            "tipo_transmision_id" => 2,
            "descripcion" => mb_strtoupper("Enfermedad de la piel causada por ácaros.")
        ]);

        Enfermedad::create([
            "nombre" => mb_strtoupper("Salmonelosis"),
            "categoria_enfermedad_id" => 2,
            "tipo_transmision_id" => 4,
            "descripcion" => mb_strtoupper("Infección bacteriana transmitida por alimentos.")
        ]);
    }
}
