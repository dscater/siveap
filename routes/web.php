<?php

use App\Http\Controllers\AlertaEpidemiologicaController;
use App\Http\Controllers\CasoEpidemiologicoController;
use App\Http\Controllers\CategoriaEnfermedadController;
use App\Http\Controllers\CentroController;
use App\Http\Controllers\ComunidadController;
use App\Http\Controllers\ConfiguracionController;
use App\Http\Controllers\EnfermedadContingenciaController;
use App\Http\Controllers\EnfermedadController;
use App\Http\Controllers\EnfermedadSintomaController;
use App\Http\Controllers\EstadoController;
use App\Http\Controllers\GravedadController;
use App\Http\Controllers\InicioController;
use App\Http\Controllers\NivelAlertaController;
use App\Http\Controllers\NotificacionUserController;
use App\Http\Controllers\PacienteController;
use App\Http\Controllers\PrediccionController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\ReglasAlertaController;
use App\Http\Controllers\ReporteController;
use App\Http\Controllers\RoleController;
use App\Http\Controllers\SeguimientoController;
use App\Http\Controllers\TipoTransmisionController;
use App\Http\Controllers\TipoCasoController;
use App\Http\Controllers\TipoSintomaController;
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
    Route::get('/casosEpidemiologicosLinea', [InicioController::class, 'casosEpidemiologicosLinea'])->name('casosEpidemiologicosLinea');
    Route::get('/cantidadActivosControlados', [InicioController::class, 'cantidadActivosControlados'])->name('cantidadActivosControlados');
    Route::get('/topEnfermedades', [InicioController::class, 'topEnfermedades'])->name('topEnfermedades');

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

    // ROLES
    Route::get("roles/api", [RoleController::class, 'api'])->name("roles.api");
    Route::get("roles/paginado", [RoleController::class, 'paginado'])->name("roles.paginado");
    Route::get("roles/listado", [RoleController::class, 'listado'])->name("roles.listado");
    Route::post("roles/actualizaPermiso/{role}", [RoleController::class, 'actualizaPermiso'])->name("roles.actualizaPermiso");
    Route::resource("roles", RoleController::class)->only(
        ["index", "store", "edit", "show", "update", "destroy"]
    );

    // NOTIFICACION USERS
    Route::get("notificacion_users", [NotificacionUserController::class, 'index'])->name("notificacion_users.index");
    Route::get("notificacion_users/paginado", [NotificacionUserController::class, 'paginado'])->name("notificacion_users.paginado");
    Route::get("notificacion_users/getNotificacions", [NotificacionUserController::class, 'getNotificacions'])->name("notificacion_users.getNotificacions");
    Route::get("notificacion_users/show/{notificacion}", [NotificacionUserController::class, 'show'])->name("notificacion_users.show");

    // TIPO USUARIOS
    Route::get("tipo_usuarios/listado", [TipoUsuarioController::class, 'listado'])->name("tipo_usuarios.listado");

    // TIPO CASOS
    Route::get("tipo_casos/listado", [TipoCasoController::class, 'listado'])->name("tipo_casos.listado");

    // TIPO SINSTOMAS
    Route::get("tipo_sintomas/listado", [TipoSintomaController::class, 'listado'])->name("tipo_sintomas.listado");

    // GRAVEDAD
    Route::get("gravedads/listado", [GravedadController::class, 'listado'])->name("gravedads.listado");

    // ESTADOS
    Route::get("estados/listado", [EstadoController::class, 'listado'])->name("estados.listado");

    // NIVEL ALERTAS
    Route::get("nivel_alertas/listado", [NivelAlertaController::class, 'listado'])->name("nivel_alertas.listado");

    // COMUNIDADES
    Route::get("comunidads/paginado", [ComunidadController::class, 'paginado'])->name("comunidads.paginado");
    Route::get("comunidads/listado", [ComunidadController::class, 'listado'])->name("comunidads.listado");
    Route::resource("comunidads", ComunidadController::class)->only(
        ["index", "store", "edit", "show", "update", "destroy"]
    );

    // ALERTAS EPIDEMIOLOGICAS
    Route::get("alerta_epidemiologicas/paginado", [AlertaEpidemiologicaController::class, 'paginado'])->name("alerta_epidemiologicas.paginado");
    Route::get("alerta_epidemiologicas/listado", [AlertaEpidemiologicaController::class, 'listado'])->name("alerta_epidemiologicas.listado");
    Route::get("alerta_epidemiologicas/verificarAlertas", [AlertaEpidemiologicaController::class, 'verificarAlertas'])->name("alerta_epidemiologicas.verificarAlertas");
    Route::get("alerta_epidemiologicas/getInfo/{alerta_epidemiologica}", [AlertaEpidemiologicaController::class, 'getInfo'])->name("alerta_epidemiologicas.getInfo");
    Route::resource("alerta_epidemiologicas", AlertaEpidemiologicaController::class)->only(
        ["index", "store", "edit", "show", "update", "destroy"]
    );

    // PREDICCIONES
    Route::get("prediccions", [PrediccionController::class, 'index'])->name("prediccions.index");
    Route::get("prediccions/realizarPrediccions", [PrediccionController::class, 'realizarPrediccions'])->name("prediccions.realizarPrediccions");

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
    Route::resource("categoria_enfermedads", CategoriaEnfermedadController::class)->only(
        ["index", "store", "edit", "show", "update", "destroy"]
    );

    // TIPO TRANSMISIONS
    Route::get("tipo_transmisions/paginado", [TipoTransmisionController::class, 'paginado'])->name("tipo_transmisions.paginado");
    Route::get("tipo_transmisions/listado", [TipoTransmisionController::class, 'listado'])->name("tipo_transmisions.listado");
    Route::resource("tipo_transmisions", TipoTransmisionController::class)->only(
        ["index", "store", "edit", "show", "update", "destroy"]
    );

    // ENFERMEDADES
    Route::get("enfermedads/paginado", [EnfermedadController::class, 'paginado'])->name("enfermedads.paginado");
    Route::get("enfermedads/listado", [EnfermedadController::class, 'listado'])->name("enfermedads.listado");
    Route::resource("enfermedads", EnfermedadController::class)->only(
        ["index", "store", "edit", "show", "update", "destroy"]
    );

    // REGLAS DE ALERTA
    Route::get("reglas_alertas/paginado", [ReglasAlertaController::class, 'paginado'])->name("reglas_alertas.paginado");
    Route::get("reglas_alertas/listado", [ReglasAlertaController::class, 'listado'])->name("reglas_alertas.listado");
    Route::resource("reglas_alertas", ReglasAlertaController::class)->only(
        ["index", "store", "edit", "show", "update", "destroy"]
    );

    // ENFERMEDAD CONTINGENCIAS
    Route::get("enfermedad_contingencias/paginado", [EnfermedadContingenciaController::class, 'paginado'])->name("enfermedad_contingencias.paginado");
    Route::get("enfermedad_contingencias/listado", [EnfermedadContingenciaController::class, 'listado'])->name("enfermedad_contingencias.listado");
    Route::resource("enfermedad_contingencias", EnfermedadContingenciaController::class)->only(
        ["index", "store", "edit", "show", "update", "destroy"]
    );

    // ENFERMEDAD SINTOMAS
    Route::get("enfermedad_sintomas/paginado", [EnfermedadSintomaController::class, 'paginado'])->name("enfermedad_sintomas.paginado");
    Route::get("enfermedad_sintomas/listado", [EnfermedadSintomaController::class, 'listado'])->name("enfermedad_sintomas.listado");
    Route::resource("enfermedad_sintomas", EnfermedadSintomaController::class)->only(
        ["index", "store", "edit", "show", "update", "destroy"]
    );

    // PACIENTES
    Route::get("pacientes/paginado", [PacienteController::class, 'paginado'])->name("pacientes.paginado");
    Route::get("pacientes/listado", [PacienteController::class, 'listado'])->name("pacientes.listado");
    Route::resource("pacientes", PacienteController::class)->only(
        ["index", "store", "edit", "show", "update", "destroy"]
    );

    // CASOS EPIDEMIOLOGICOS
    Route::get("caso_epidemiologicos/paginado", [CasoEpidemiologicoController::class, 'paginado'])->name("caso_epidemiologicos.paginado");
    Route::get("caso_epidemiologicos/listado", [CasoEpidemiologicoController::class, 'listado'])->name("caso_epidemiologicos.listado");
    Route::resource("caso_epidemiologicos", CasoEpidemiologicoController::class)->only(
        ["index", "store", "edit", "show", "update", "destroy"]
    );

    // SEGUIMIENTOS
    Route::get("seguimientos/paginado", [SeguimientoController::class, 'paginado'])->name("seguimientos.paginado");
    Route::get("seguimientos/listado", [SeguimientoController::class, 'listado'])->name("seguimientos.listado");
    Route::get("seguimientos/{caso_epidemiologico}", [SeguimientoController::class, 'index'])->name("seguimientos.index");
    Route::resource("seguimientos", SeguimientoController::class)->only(
        ["store", "edit", "show", "update", "destroy"]
    );

    // REPORTES
    Route::get('reportes/usuarios', [ReporteController::class, 'usuarios'])->name("reportes.usuarios");
    Route::get('reportes/r_usuarios', [ReporteController::class, 'r_usuarios'])->name("reportes.r_usuarios");

    Route::get('reportes/fichas', [ReporteController::class, 'fichas'])->name("reportes.fichas");
    Route::get('reportes/r_fichas', [ReporteController::class, 'r_fichas'])->name("reportes.r_fichas");

    Route::get('reportes/casos_epidemiologicos', [ReporteController::class, 'casos_epidemiologicos'])->name("reportes.casos_epidemiologicos");
    Route::get('reportes/r_casos_epidemiologicos', [ReporteController::class, 'r_casos_epidemiologicos'])->name("reportes.r_casos_epidemiologicos");

    Route::get('reportes/alerta_epidemiologicas', [ReporteController::class, 'alerta_epidemiologicas'])->name("reportes.alerta_epidemiologicas");
    Route::get('reportes/r_alerta_epidemiologicas', [ReporteController::class, 'r_alerta_epidemiologicas'])->name("reportes.r_alerta_epidemiologicas");

    Route::get('reportes/seguimientos', [ReporteController::class, 'seguimientos'])->name("reportes.seguimientos");
    Route::get('reportes/r_seguimientos', [ReporteController::class, 'r_seguimientos'])->name("reportes.r_seguimientos");
});
require __DIR__ . '/auth.php';
