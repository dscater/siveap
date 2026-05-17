<?php

use App\Http\Controllers\AlertaEpidemiologicaController;
use App\Http\Controllers\CategoriaEnfermedadController;
use App\Http\Controllers\CentroController;
use App\Http\Controllers\ComunidadController;
use App\Http\Controllers\ConfiguracionController;
use App\Http\Controllers\EnfermedadController;
use App\Http\Controllers\InicioController;
use App\Http\Controllers\PacienteController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\ReporteController;
use App\Http\Controllers\RoleController;
use App\Http\Controllers\TipoTransmisionController;
use App\Http\Controllers\TipoUsuarioController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\UsuarioController;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

Route::get('/', function () {
    if (Auth::check()) {
        return redirect()->route('inicio');
    }
    return Inertia::render('Auth/Login');
});

Route::get('/login', function () {
    if (Auth::check()) {
        return redirect()->route('inicio');
    }
    return Inertia::render('Auth/Login');
})->name("login");

Route::get("configuracions/getConfiguracion", [ConfiguracionController::class, 'getConfiguracion'])->name("configuracions.getConfiguracion");

Route::get('/clear-cache', function () {
    Artisan::call('config:cache');
    Artisan::call('config:clear');
    Artisan::call('optimize');
    return 'Cache eliminado <a href="/">Ir al inicio</a>';
})->name('clear.cache');

Route::get("sincronizarInicio", [CertificadoEmitidoController::class, 'sincronizarInicio']);

// ADMINISTRACION
Route::middleware(['auth', 'permisoUsuario'])->prefix("admin")->group(function () {
    // INICIO
    Route::get('/inicio', [InicioController::class, 'inicio'])->name('inicio');
    Route::get('/certificadosEmitidosLinea', [InicioController::class, 'certificadosEmitidosLinea'])->name('certificadosEmitidosLinea');
    Route::get('/cantidadTramitesNormal', [InicioController::class, 'cantidadTramitesNormal'])->name('cantidadTramitesNormal');

    // CONFIGURACION
    Route::resource("configuracions", ConfiguracionController::class)->only(
        ["index", "show", "update"]
    );

    // USUARIO
    Route::get('profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::patch('profile/update_foto', [ProfileController::class, 'update_foto'])->name('profile.update_foto');
    Route::delete('profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
    Route::get("getUser", [UserController::class, 'getUser'])->name('users.getUser');
    Route::get("permisosUsuario", [UserController::class, 'permisosUsuario']);

    // USUARIOS
    Route::put("usuarios/password/{user}", [UsuarioController::class, 'actualizaPassword'])->name("usuarios.password");
    Route::get("usuarios/paginado", [UsuarioController::class, 'paginado'])->name("usuarios.paginado");
    Route::get("usuarios/listado", [UsuarioController::class, 'listado'])->name("usuarios.listado");
    Route::get("usuarios/listado/byTipo", [UsuarioController::class, 'byTipo'])->name("usuarios.byTipo");
    Route::get("usuarios/show/{user}", [UsuarioController::class, 'show'])->name("usuarios.show");
    Route::put("usuarios/update/{user}", [UsuarioController::class, 'update'])->name("usuarios.update");
    Route::delete("usuarios/{user}", [UsuarioController::class, 'destroy'])->name("usuarios.destroy");
    Route::resource("usuarios", UsuarioController::class)->only(
        ["index", "store"]
    );

    // TIPO USUARIOS
    Route::get("tipo_usuarios/listado", [TipoUsuarioController::class, 'listado'])->name("tipo_usuarios.listado");

    // ALERTAS EPIDEMIOLOGICAS
    Route::get("alerta_epidemiologicas", [AlertaEpidemiologicaController::class, 'index'])->name("alerta_epidemiologicas.index");

    // ROLES
    Route::get("roles/api", [RoleController::class, 'api'])->name("roles.api");
    Route::get("roles/paginado", [RoleController::class, 'paginado'])->name("roles.paginado");
    Route::get("roles/listado", [RoleController::class, 'listado'])->name("roles.listado");
    Route::post("roles/actualizaPermiso/{role}", [RoleController::class, 'actualizaPermiso'])->name("roles.actualizaPermiso");
    Route::resource("roles", RoleController::class)->only(
        ["index", "store", "edit", "show", "update", "destroy"]
    );

    // COMUNIDADES
    Route::get("comunidads/paginado", [ComunidadController::class, 'paginado'])->name("comunidads.paginado");
    Route::get("comunidads/listado", [ComunidadController::class, 'listado'])->name("comunidads.listado");
    Route::post("comunidads/actualizaPermiso/{role}", [ComunidadController::class, 'actualizaPermiso'])->name("comunidads.actualizaPermiso");
    Route::resource("comunidads", ComunidadController::class)->only(
        ["index", "store", "edit", "show", "update", "destroy"]
    );

    // CENTROS
    Route::get("centros/paginado", [CentroController::class, 'paginado'])->name("centros.paginado");
    Route::get("centros/listado", [CentroController::class, 'listado'])->name("centros.listado");
    Route::post("centros/actualizaPermiso/{role}", [CentroController::class, 'actualizaPermiso'])->name("centros.actualizaPermiso");
    Route::resource("centros", CentroController::class)->only(
        ["index", "store", "edit", "show", "update", "destroy"]
    );


    // CATEGORIA ENFERMEDADES
    Route::get("categoria_enfermedads/paginado", [CategoriaEnfermedadController::class, 'paginado'])->name("categoria_enfermedads.paginado");
    Route::get("categoria_enfermedads/listado", [CategoriaEnfermedadController::class, 'listado'])->name("categoria_enfermedads.listado");
    Route::post("categoria_enfermedads/actualizaPermiso/{role}", [CategoriaEnfermedadController::class, 'actualizaPermiso'])->name("categoria_enfermedads.actualizaPermiso");
    Route::resource("categoria_enfermedads", CategoriaEnfermedadController::class)->only(
        ["index", "store", "edit", "show", "update", "destroy"]
    );

    // TIPO TRANSMISIONS
    Route::get("tipo_transmisions/paginado", [TipoTransmisionController::class, 'paginado'])->name("tipo_transmisions.paginado");
    Route::get("tipo_transmisions/listado", [TipoTransmisionController::class, 'listado'])->name("tipo_transmisions.listado");
    Route::post("tipo_transmisions/actualizaPermiso/{role}", [TipoTransmisionController::class, 'actualizaPermiso'])->name("tipo_transmisions.actualizaPermiso");
    Route::resource("tipo_transmisions", TipoTransmisionController::class)->only(
        ["index", "store", "edit", "show", "update", "destroy"]
    );

    // ENFERMEDADES
    Route::get("enfermedads/paginado", [EnfermedadController::class, 'paginado'])->name("enfermedads.paginado");
    Route::get("enfermedads/listado", [EnfermedadController::class, 'listado'])->name("enfermedads.listado");
    Route::post("enfermedads/actualizaPermiso/{role}", [EnfermedadController::class, 'actualizaPermiso'])->name("enfermedads.actualizaPermiso");
    Route::resource("enfermedads", EnfermedadController::class)->only(
        ["index", "store", "edit", "show", "update", "destroy"]
    );

    // PACIENTES
    Route::get("pacientes/paginado", [PacienteController::class, 'paginado'])->name("pacientes.paginado");
    Route::get("pacientes/listado", [PacienteController::class, 'listado'])->name("pacientes.listado");
    Route::post("pacientes/actualizaPermiso/{role}", [PacienteController::class, 'actualizaPermiso'])->name("pacientes.actualizaPermiso");
    Route::resource("pacientes", PacienteController::class)->only(
        ["index", "store", "edit", "show", "update", "destroy"]
    );

    // CASOS
    Route::get("caso_epidemiologicos/paginado", [CasoEpidemiologicoController::class, 'paginado'])->name("caso_epidemiologicos.paginado");
    Route::get("caso_epidemiologicos/listado", [CasoEpidemiologicoController::class, 'listado'])->name("caso_epidemiologicos.listado");
    Route::post("caso_epidemiologicos/actualizaPermiso/{role}", [CasoEpidemiologicoController::class, 'actualizaPermiso'])->name("caso_epidemiologicos.actualizaPermiso");
    Route::resource("caso_epidemiologicos", CasoEpidemiologicoController::class)->only(
        ["index", "store", "edit", "show", "update", "destroy"]
    );

    // REPORTES
    Route::get('reportes/usuarios', [ReporteController::class, 'usuarios'])->name("reportes.usuarios");
    Route::get('reportes/r_usuarios', [ReporteController::class, 'r_usuarios'])->name("reportes.r_usuarios");
});
require __DIR__ . '/auth.php';
