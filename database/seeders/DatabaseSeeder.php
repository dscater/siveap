<?php

namespace Database\Seeders;

use App\Models\Modulo;
use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    use WithoutModelEvents;

    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // User::factory(10)->create();

        // User::factory()->create([
        //     'name' => 'Test User',
        //     'email' => 'test@example.com',
        // ]);


        // Modulo::create([
        //     "modulo" => "Gestión de sintomas",
        //     "nombre" => "enfermedad_sintomas.index",
        //     "accion" => "VER",
        //     "descripcion" => "VER LA LISTA DE SINTOMAS"
        // ]);

        // Modulo::create([
        //     "modulo" => "Gestión de sintomas",
        //     "nombre" => "enfermedad_sintomas.create",
        //     "accion" => "CREAR",
        //     "descripcion" => "CREAR SINTOMAS"
        // ]);

        // Modulo::create([
        //     "modulo" => "Gestión de sintomas",
        //     "nombre" => "enfermedad_sintomas.edit",
        //     "accion" => "EDITAR",
        //     "descripcion" => "EDITAR SINTOMAS"
        // ]);

        // Modulo::create([
        //     "modulo" => "Gestión de sintomas",
        //     "nombre" => "enfermedad_sintomas.destroy",
        //     "accion" => "ELIMINAR",
        //     "descripcion" => "ELIMINAR SINTOMAS"
        // ]);


        // Modulo::create([
        //     "modulo" => "Reportes",
        //     "nombre" => "reportes.fichas",
        //     "accion" => "REPORTE FICHAS DE CASOS EPIDEMIOLÓGICOS",
        //     "descripcion" => "GENERAR REPORTES DE FICHAS DE CASOS EPIDEMIOLÓGICOS"
        // ]);


        // $this->call([
        //     ConfiguracionTableSeeder::class,
        //     RoleTableSeeder::class,
        //     UserTableSeeder::class
        // ]);
    }
}
