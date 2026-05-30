<?php

namespace Database\Seeders;

use App\Models\Modulo;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class ModuloTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // GESTIÓN DE USUARIOS
        Modulo::create([
            "modulo" => "Gestión de usuarios",
            "nombre" => "usuarios.index",
            "accion" => "VER",
            "descripcion" => "VER LA LISTA DE USUARIOS"
        ]);

        Modulo::create([
            "modulo" => "Gestión de usuarios",
            "nombre" => "usuarios.create",
            "accion" => "CREAR",
            "descripcion" => "CREAR USUARIOS"
        ]);

        Modulo::create([
            "modulo" => "Gestión de usuarios",
            "nombre" => "usuarios.edit",
            "accion" => "EDITAR",
            "descripcion" => "EDITAR USUARIOS"
        ]);

        Modulo::create([
            "modulo" => "Gestión de usuarios",
            "nombre" => "usuarios.destroy",
            "accion" => "ELIMINAR",
            "descripcion" => "ELIMINAR USUARIOS"
        ]);

        // ROLES Y PERMISOS
        Modulo::create([
            "modulo" => "Roles y Permisos",
            "nombre" => "roles.index",
            "accion" => "VER",
            "descripcion" => "VER LA LISTA DE ROLES Y PERMISOS"
        ]);

        Modulo::create([
            "modulo" => "Roles y Permisos",
            "nombre" => "roles.create",
            "accion" => "CREAR",
            "descripcion" => "CREAR ROLES Y PERMISOS"
        ]);

        Modulo::create([
            "modulo" => "Roles y Permisos",
            "nombre" => "roles.edit",
            "accion" => "EDITAR",
            "descripcion" => "EDITAR ROLES Y PERMISOS"
        ]);

        Modulo::create([
            "modulo" => "Roles y Permisos",
            "nombre" => "roles.destroy",
            "accion" => "ELIMINAR",
            "descripcion" => "ELIMINAR ROLES Y PERMISOS"
        ]);

        // CONFIGURACIÓN DEL SISTEMA
        Modulo::create([
            "modulo" => "Configuración",
            "nombre" => "configuracions.index",
            "accion" => "VER",
            "descripcion" => "VER INFORMACIÓN DE LA CONFIGURACIÓN DEL SISTEMA"
        ]);

        Modulo::create([
            "modulo" => "Configuración",
            "nombre" => "configuracions.edit",
            "accion" => "EDITAR",
            "descripcion" => "EDITAR LA CONFIGURACIÓN DEL SISTEMA"
        ]);

        // CENTROS
        Modulo::create([
            "modulo" => "Gestión de centros",
            "nombre" => "centros.index",
            "accion" => "VER",
            "descripcion" => "VER LA LISTA DE CENTROS"
        ]);

        Modulo::create([
            "modulo" => "Gestión de centros",
            "nombre" => "centros.create",
            "accion" => "CREAR",
            "descripcion" => "CREAR CENTROS"
        ]);

        Modulo::create([
            "modulo" => "Gestión de centros",
            "nombre" => "centros.edit",
            "accion" => "EDITAR",
            "descripcion" => "EDITAR CENTROS"
        ]);

        Modulo::create([
            "modulo" => "Gestión de centros",
            "nombre" => "centros.destroy",
            "accion" => "ELIMINAR",
            "descripcion" => "ELIMINAR CENTROS"
        ]);

        // ENFERMEDADES
        Modulo::create([
            "modulo" => "Gestión de enfermedades",
            "nombre" => "enfermedads.index",
            "accion" => "VER",
            "descripcion" => "VER LA LISTA DE ENFERMEDADES"
        ]);

        Modulo::create([
            "modulo" => "Gestión de enfermedades",
            "nombre" => "enfermedads.create",
            "accion" => "CREAR",
            "descripcion" => "CREAR ENFERMEDADES"
        ]);

        Modulo::create([
            "modulo" => "Gestión de enfermedades",
            "nombre" => "enfermedads.edit",
            "accion" => "EDITAR",
            "descripcion" => "EDITAR ENFERMEDADES"
        ]);

        Modulo::create([
            "modulo" => "Gestión de enfermedades",
            "nombre" => "enfermedads.destroy",
            "accion" => "ELIMINAR",
            "descripcion" => "ELIMINAR ENFERMEDADES"
        ]);

        // CONTINGENCIAS
        Modulo::create([
            "modulo" => "Gestión de contingencias",
            "nombre" => "enfermedad_contingencias.index",
            "accion" => "VER",
            "descripcion" => "VER LA LISTA DE CONTINGENCIAS"
        ]);

        Modulo::create([
            "modulo" => "Gestión de contingencias",
            "nombre" => "enfermedad_contingencias.create",
            "accion" => "CREAR",
            "descripcion" => "CREAR CONTINGENCIAS"
        ]);

        Modulo::create([
            "modulo" => "Gestión de contingencias",
            "nombre" => "enfermedad_contingencias.edit",
            "accion" => "EDITAR",
            "descripcion" => "EDITAR CONTINGENCIAS"
        ]);

        Modulo::create([
            "modulo" => "Gestión de contingencias",
            "nombre" => "enfermedad_contingencias.destroy",
            "accion" => "ELIMINAR",
            "descripcion" => "ELIMINAR CONTINGENCIAS"
        ]);

        // REGLAS DE ALERTA
        Modulo::create([
            "modulo" => "Gestión de reglas de alerta",
            "nombre" => "reglas_alertas.index",
            "accion" => "VER",
            "descripcion" => "VER LA LISTA DE REGLAS DE ALERTA"
        ]);

        Modulo::create([
            "modulo" => "Gestión de reglas de alerta",
            "nombre" => "reglas_alertas.create",
            "accion" => "CREAR",
            "descripcion" => "CREAR REGLAS DE ALERTA"
        ]);

        Modulo::create([
            "modulo" => "Gestión de reglas de alerta",
            "nombre" => "reglas_alertas.edit",
            "accion" => "EDITAR",
            "descripcion" => "EDITAR REGLAS DE ALERTA"
        ]);

        Modulo::create([
            "modulo" => "Gestión de reglas de alerta",
            "nombre" => "reglas_alertas.destroy",
            "accion" => "ELIMINAR",
            "descripcion" => "ELIMINAR REGLAS DE ALERTA"
        ]);

        // CATEGORÍA DE ENFERMEDADES
        Modulo::create([
            "modulo" => "Gestión de categoría de enfermedades",
            "nombre" => "categoria_enfermedads.index",
            "accion" => "VER",
            "descripcion" => "VER LA LISTA DE CATEGORÍA DE ENFERMEDADES"
        ]);

        Modulo::create([
            "modulo" => "Gestión de categoría de enfermedades",
            "nombre" => "categoria_enfermedads.create",
            "accion" => "CREAR",
            "descripcion" => "CREAR CATEGORÍA DE ENFERMEDADES"
        ]);

        Modulo::create([
            "modulo" => "Gestión de categoría de enfermedades",
            "nombre" => "categoria_enfermedads.edit",
            "accion" => "EDITAR",
            "descripcion" => "EDITAR CATEGORÍA DE ENFERMEDADES"
        ]);

        Modulo::create([
            "modulo" => "Gestión de categoría de enfermedades",
            "nombre" => "categoria_enfermedads.destroy",
            "accion" => "ELIMINAR",
            "descripcion" => "ELIMINAR CATEGORÍA DE ENFERMEDADES"
        ]);

        // TIPO DE TRANSMISIONES
        Modulo::create([
            "modulo" => "Gestión de tipo de transmisiones",
            "nombre" => "tipo_transmisions.index",
            "accion" => "VER",
            "descripcion" => "VER LA LISTA DE TIPO DE TRANSMISIONES"
        ]);

        Modulo::create([
            "modulo" => "Gestión de tipo de transmisiones",
            "nombre" => "tipo_transmisions.create",
            "accion" => "CREAR",
            "descripcion" => "CREAR TIPO DE TRANSMISIONES"
        ]);

        Modulo::create([
            "modulo" => "Gestión de tipo de transmisiones",
            "nombre" => "tipo_transmisions.edit",
            "accion" => "EDITAR",
            "descripcion" => "EDITAR TIPO DE TRANSMISIONES"
        ]);

        Modulo::create([
            "modulo" => "Gestión de tipo de transmisiones",
            "nombre" => "tipo_transmisions.destroy",
            "accion" => "ELIMINAR",
            "descripcion" => "ELIMINAR TIPO DE TRANSMISIONES"
        ]);

        // COMUNIDADES
        Modulo::create([
            "modulo" => "Gestión de comunidades",
            "nombre" => "comunidads.index",
            "accion" => "VER",
            "descripcion" => "VER LA LISTA DE COMUNIDADES"
        ]);

        Modulo::create([
            "modulo" => "Gestión de comunidades",
            "nombre" => "comunidads.create",
            "accion" => "CREAR",
            "descripcion" => "CREAR COMUNIDADES"
        ]);

        Modulo::create([
            "modulo" => "Gestión de comunidades",
            "nombre" => "comunidads.edit",
            "accion" => "EDITAR",
            "descripcion" => "EDITAR COMUNIDADES"
        ]);

        Modulo::create([
            "modulo" => "Gestión de comunidades",
            "nombre" => "comunidads.destroy",
            "accion" => "ELIMINAR",
            "descripcion" => "ELIMINAR COMUNIDADES"
        ]);

        // PACIENTES
        Modulo::create([
            "modulo" => "Gestión de pacientes",
            "nombre" => "pacientes.index",
            "accion" => "VER",
            "descripcion" => "VER LA LISTA DE PACIENTES"
        ]);

        Modulo::create([
            "modulo" => "Gestión de pacientes",
            "nombre" => "pacientes.create",
            "accion" => "CREAR",
            "descripcion" => "CREAR PACIENTES"
        ]);

        Modulo::create([
            "modulo" => "Gestión de pacientes",
            "nombre" => "pacientes.edit",
            "accion" => "EDITAR",
            "descripcion" => "EDITAR PACIENTES"
        ]);

        Modulo::create([
            "modulo" => "Gestión de pacientes",
            "nombre" => "pacientes.destroy",
            "accion" => "ELIMINAR",
            "descripcion" => "ELIMINAR PACIENTES"
        ]);

        // NOTIFICACIONES
        Modulo::create([
            "modulo" => "Gestión de notificaciones",
            "nombre" => "notificacions.index",
            "accion" => "RECIBIR Y VER NOTIFICACIONES",
            "descripcion" => "RECIBIR Y VER NOTIFICACIONES"
        ]);

        // PREDICCIONES
        Modulo::create([
            "modulo" => "Gestión de predicciones epidemiológicas",
            "nombre" => "prediccions.index",
            "accion" => "VER Y GENERAR PREDICCONES",
            "descripcion" => "VER Y GENERAR PREDICCIONES EPIDEMIOLÓGICAS"
        ]);

        // CASOS EPIDEMIOLÓGICOS
        Modulo::create([
            "modulo" => "Gestión de casos epidemiológicos",
            "nombre" => "caso_epidemiologicos.index",
            "accion" => "VER",
            "descripcion" => "VER LA LISTA DE CASOS EPIDEMIOLÓGICOS"
        ]);

        Modulo::create([
            "modulo" => "Gestión de casos epidemiológicos",
            "nombre" => "caso_epidemiologicos.create",
            "accion" => "CREAR",
            "descripcion" => "CREAR CASOS EPIDEMIOLÓGICOS"
        ]);

        Modulo::create([
            "modulo" => "Gestión de casos epidemiológicos",
            "nombre" => "caso_epidemiologicos.edit",
            "accion" => "EDITAR",
            "descripcion" => "EDITAR CASOS EPIDEMIOLÓGICOS"
        ]);

        Modulo::create([
            "modulo" => "Gestión de casos epidemiológicos",
            "nombre" => "caso_epidemiologicos.destroy",
            "accion" => "ELIMINAR",
            "descripcion" => "ELIMINAR CASOS EPIDEMIOLÓGICOS"
        ]);

        // SEGUIMIENTOS
        Modulo::create([
            "modulo" => "Gestión de seguimientos",
            "nombre" => "seguimientos.index",
            "accion" => "VER",
            "descripcion" => "VER LA LISTA DE SEGUIMIENTOS DE CASOS EPIDEMIOLÓGICOS"
        ]);

        Modulo::create([
            "modulo" => "Gestión de seguimientos",
            "nombre" => "seguimientos.create",
            "accion" => "CREAR",
            "descripcion" => "CREAR SEGUIMIENTOS DE CASOS EPIDEMIOLÓGICOS"
        ]);

        Modulo::create([
            "modulo" => "Gestión de seguimientos",
            "nombre" => "seguimientos.edit",
            "accion" => "EDITAR",
            "descripcion" => "EDITAR SEGUIMIENTOS DE CASOS EPIDEMIOLÓGICOS"
        ]);

        Modulo::create([
            "modulo" => "Gestión de seguimientos",
            "nombre" => "seguimientos.destroy",
            "accion" => "ELIMINAR",
            "descripcion" => "ELIMINAR SEGUIMIENTOS DE CASOS EPIDEMIOLÓGICOS"
        ]);

        // ALERTAS EPIDEMIOLÓGICAS
        Modulo::create([
            "modulo" => "Gestión de alertas epidemiológicas",
            "nombre" => "alerta_epidemiologicas.index",
            "accion" => "VER",
            "descripcion" => "VER LA LISTA DE ALERTAS EPIDEMIOLÓGICAS"
        ]);

        // Modulo::create([
        //     "modulo" => "Gestión de alertas epidemiológicas",
        //     "nombre" => "alerta_epidemiologicas.create",
        //     "accion" => "CREAR",
        //     "descripcion" => "CREAR ALERTAS EPIDEMIOLÓGICAS"
        // ]);

        Modulo::create([
            "modulo" => "Gestión de alertas epidemiológicas",
            "nombre" => "alerta_epidemiologicas.edit",
            "accion" => "EDITAR",
            "descripcion" => "EDITAR ALERTAS EPIDEMIOLÓGICAS"
        ]);

        Modulo::create([
            "modulo" => "Gestión de alertas epidemiológicas",
            "nombre" => "alerta_epidemiologicas.destroy",
            "accion" => "ELIMINAR",
            "descripcion" => "ELIMINAR ALERTAS EPIDEMIOLÓGICAS"
        ]);

        // REPORTES
        Modulo::create([
            "modulo" => "Reportes",
            "nombre" => "reportes.usuarios",
            "accion" => "REPORTE LISTA DE USUARIOS",
            "descripcion" => "GENERAR REPORTES DE LISTA DE USUARIOS"
        ]);

        Modulo::create([
            "modulo" => "Reportes",
            "nombre" => "reportes.casos_epidemiologicos",
            "accion" => "REPORTE CASOS EPIDEMIOLÓGICOS",
            "descripcion" => "GENERAR REPORTES DE CASOS EPIDEMIOLÓGICOS"
        ]);

        Modulo::create([
            "modulo" => "Reportes",
            "nombre" => "reportes.alerta_epidemiologicas",
            "accion" => "REPORTE ALERTAS EPIDEMIOLÓGICAS",
            "descripcion" => "GENERAR REPORTES DE ALERTAS EPIDEMIOLÓGICAS"
        ]);

        Modulo::create([
            "modulo" => "Reportes",
            "nombre" => "reportes.seguimientos",
            "accion" => "REPORTE SEGUIMIENTO POR CASOS",
            "descripcion" => "GENERAR REPORTES DE SEGUIMIENTO POR CASOS"
        ]);
    }
}
