<?php

namespace App\Http\Controllers;

use App\Models\AlertaEpidemiologica;
use App\Models\CasoEpidemiologico;
use App\Models\Certificado;
use App\Models\Cliente;
use App\Models\LoginUser;
use App\Models\Paciente;
use App\Models\User;
use App\Services\PermisoService;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class UserController extends Controller
{


    public function __construct() {}

    public function permisosUsuario(Request $request)
    {
        $permisoService = new PermisoService();
        return response()->JSON([
            "permisos" => $permisoService->getPermisosUser()
        ]);
    }

    public function getUser()
    {
        return response()->JSON([
            "user" => Auth::user()->load(["role"])
        ]);
    }

    public static function getInfoBoxUser()
    {
        $permisos = [];
        $array_infos = [];
        if (Auth::check()) {
            $oUser = new User();
            $permisos = $oUser->permisos;
            if ($permisos == '*' || (is_array($permisos) && in_array('usuarios.index', $permisos))) {
                $array_infos[] = [
                    'label' => 'USUARIOS',
                    'cantidad' => User::where('id', '!=', 1)->count(),
                    'color' => 'bgWhite',
                    'icon' => "fa-users",
                    "url" => "usuarios.index"
                ];
            }
            if ($permisos == '*' || (is_array($permisos) && in_array('caso_epidemiologicos.index', $permisos))) {
                $array_infos[] = [
                    'label' => 'CASOS EPIDEMIOLÓGICOS',
                    'cantidad' => CasoEpidemiologico::count(),
                    'color' => 'bgWhite',
                    'icon' => "fa-user-friends",
                    "url" => "caso_epidemiologicos.index"
                ];
            }
            if ($permisos == '*' || (is_array($permisos) && in_array('alerta_epidemiologicas.index', $permisos))) {
                $array_infos[] = [
                    'label' => 'ALERTAS EPIDEMIOLÓGICAS',
                    'cantidad' => AlertaEpidemiologica::count(),
                    'color' => 'bgWhite',
                    'icon' => "fa-map",
                    "url" => "alerta_epidemiologicas.index"
                ];
            }
            if ($permisos == '*' || (is_array($permisos) && in_array('pacientes.index', $permisos))) {
                $array_infos[] = [
                    'label' => 'PACIENTES',
                    'cantidad' => Paciente::count(),
                    'color' => 'bgWhite',
                    'icon' => "fa-user-friends",
                    "url" => "pacientes.index"
                ];
            }
        }


        return $array_infos;
    }
}
