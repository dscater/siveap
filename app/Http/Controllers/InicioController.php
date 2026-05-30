<?php

namespace App\Http\Controllers;

use App\Models\AlertaEpidemiologica;
use App\Models\CasoEpidemiologico;
use App\Models\Certificado;
use App\Models\CertificadoDetalle;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Inertia\Inertia;

class InicioController extends Controller
{

    public function verificaLogin()
    {
        $sw = false;
        if (Auth::check()) {
            $sw = true;
        }

        return response()->JSON(["sw" => $sw]);
    }

    public function inicio()
    {
        $array_infos = UserController::getInfoBoxUser();

        return Inertia::render('Admin/Home', compact('array_infos'));
    }

    public function login()
    {
        return Inertia::render("Auth/Login");
    }

    public function casosEpidemiologicosLinea(Request $request)
    {
        $tipo =  $request->tipo;
        $centro_id =  $request->centro_id;
        $enfermedad_id =  $request->enfermedad_id;
        $recorrido = [];

        if ($tipo == 'semanal') {
            $fecha = Carbon::now("America/La_Paz");

            for ($i = 6; $i >= 0; $i--) {
                $recorrido[] = $fecha->copy()->subDays($i)->format("Y-m-d");
            }
        }
        if ($tipo == 'meses') {
            $fecha = Carbon::now("America/La_Paz");
            $mes_actual = $fecha->month;

            for ($i = 1; $i <= $mes_actual; $i++) {
                $recorrido[] = Carbon::create(null, $i, 1)->format("m");
            }
        }
        if ($tipo == 'gestion') {
            $recorrido = CasoEpidemiologico::selectRaw("YEAR(fecha_registro) as gestion")
                ->groupBy("gestion")
                ->orderBy("gestion")
                ->pluck("gestion")
                ->toArray();
        }

        $data = [];

        $categories = [];
        $array_meses = [
            "01" => "Enero",
            "02" => "Febrero",
            "03" => "Marzo",
            "04" => "Abril",
            "05" => "Mayo",
            "06" => "Junio",
            "07" => "Julio",
            "08" => "Agosto",
            "09" => "Septiembre",
            "10" => "Octubre",
            "11" => "Noviembre",
            "12" => "Diciembre",
        ];
        $total_final = 0;
        foreach ($recorrido as $item) {
            if ($tipo == 'semanal') {
                $total = CasoEpidemiologico::whereDate('fecha_registro', $item);
                if (!empty($centro_id)) {
                    $total->where("centro_id", $centro_id);
                }
                if (!empty($enfermedad_id)) {
                    $total->where("enfermedad_id", $enfermedad_id);
                }
                if (Auth::user()->tipo == 'CENTRO MÉDICO') {
                    $total->where("centro_id", Auth::user()->centro_id);
                }
                $total = $total->count();
                $categories[] = date("d/m/Y", strtotime($item));
            }

            if ($tipo == 'meses') {
                $total = CasoEpidemiologico::whereMonth('fecha_registro', $item);
                if (!empty($centro_id)) {
                    $total->where("centro_id", $centro_id);
                }
                if (!empty($enfermedad_id)) {
                    $total->where("enfermedad_id", $enfermedad_id);
                }
                if (Auth::user()->tipo == 'CENTRO MÉDICO') {
                    $total->where("centro_id", Auth::user()->centro_id);
                }
                $total->whereYear('fecha_registro', Carbon::now()->year);
                $total = $total->count();
                $categories[] = $array_meses[$item];
            }

            if ($tipo == 'gestion') {
                $total = CasoEpidemiologico::whereYear('fecha_registro', $item);
                if (!empty($centro_id)) {
                    $total->where("centro_id", $centro_id);
                }
                if (!empty($enfermedad_id)) {
                    $total->where("enfermedad_id", $enfermedad_id);
                }
                if (Auth::user()->tipo == 'CENTRO MÉDICO') {
                    $total->where("centro_id", Auth::user()->centro_id);
                }
                $total = $total->count();
                $categories[] = $item;
            }

            $total_final += (float)$total;
            $data[] = (float)$total;
        }

        return response()->JSON([
            "categories" => $categories,
            "data" => $data,
            "total_final" => $total_final
        ]);
    }

    public function cantidadActivosControlados(Request $request)
    {
        $enfermedad_id =  $request->enfermedad_id;

        $activos = AlertaEpidemiologica::where("estado", "ACTIVO");

        if (!empty($enfermedad_id)) {
            $activos->where("enfermedad_id", $enfermedad_id);
        }

        $activos = $activos->count();
        $controlados = AlertaEpidemiologica::where("estado", "CONTROLADO");
        if (!empty($enfermedad_id)) {
            $controlados->where("enfermedad_id", $enfermedad_id);
        }

        $controlados = $controlados->count();

        $data = [
            ["name" => "ACTIVOS", "y" => (float)$activos, "color" => "#fadd36"],
            ["name" => "CONTROLADOS", "y" => (float)$controlados, "color" => "#198754"],
        ];

        $total_final = (float)$activos + (float)$controlados;

        return response()->JSON([
            "data" => $data,
            "total_final" => $total_final
        ]);
    }

    public function topEnfermedades()
    {
        $topEnfermedades = CasoEpidemiologico::query()
            ->selectRaw("
        enfermedad_id,
        COUNT(*) as total
    ")
            ->with('enfermedad')
            ->whereIn(
                'tipo_caso',
                ['PROBABLE', 'CONFIRMADO']
            )
            ->groupBy('enfermedad_id')
            ->orderByDesc('total')
            ->limit(10)
            ->get()
            ->map(function ($item) {
                return [
                    'enfermedad' => $item->enfermedad->nombre,
                    'casos' => $item->total
                ];
            });

        return $topEnfermedades;
    }
}
