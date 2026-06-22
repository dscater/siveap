<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>CasosEpidemiologicos</title>
    <style type="text/css">
        * {
            font-family: sans-serif;
        }

        @page {
            margin-top: 0.7cm;
            margin-bottom: 0.3cm;
            margin-left: 0.3cm;
            margin-right: 0.3cm;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
            page-break-before: avoid;
        }

        table thead tr th,
        tbody tr td {
            padding: 3px;
            word-wrap: break-word;
        }

        table thead tr th {
            font-size: 8pt;
        }

        table tbody tr td {
            padding: 1px;
            font-size: 7pt;
        }


        .encabezado {
            width: 100%;
        }

        .logo img {
            position: absolute;
            height: 90px;
            top: -20px;
            left: 0px;
        }

        .logo2 img {
            position: absolute;
            height: 90px;
            top: -20px;
            right: 0px;
        }

        h2.titulo {
            width: 450px;
            margin: auto;
            margin-top: 0PX;
            text-align: center;
            font-size: 14pt;
        }

        .texto {
            width: 250px;
            text-align: center;
            margin: auto;
            font-weight: bold;
            font-size: 1.1em;
        }

        .fecha {
            width: 250px;
            text-align: center;
            margin: auto;
            font-weight: normal;
            font-size: 0.85em;
        }

        .total {
            text-align: right;
            padding-right: 15px;
            font-weight: bold;
        }

        table {
            width: 100%;
        }

        table thead {
            background: rgb(236, 236, 236)
        }

        tr {
            page-break-inside: avoid !important;
        }

        .centreado {
            padding-left: 0px;
            text-align: center;
        }

        .datos {
            margin-left: 15px;
            border-top: solid 1px;
            border-collapse: collapse;
            width: 250px;
        }

        .txt {
            font-weight: bold;
            text-align: right;
            padding-right: 5px;
        }

        .txt_center {
            font-weight: bold;
            text-align: center;
        }

        .b_top {
            border-top: solid 1px black;
        }

        .gray {
            background: rgb(202, 202, 202);
        }

        .bg-principal {
            background: #153f59;
            color: white;
        }

        .img_celda img {
            width: 45px;
        }

        .bold {
            font-weight: bold;
        }

        .text-md {
            font-size: 8.5pt;
        }

        .text-lg {
            font-size: 9.5pt;
        }

        .firma {
            height: 40px;
        }
    </style>
</head>

<body>
    @inject('configuracion', 'App\Models\Configuracion')
    @php
        $cont = 0;
    @endphp
    @foreach ($caso_epidemiologicos as $item)
        <div class="encabezado">
            <div class="logo">
                <img src="{{ $configuracion->first()->logo_b64 }}">
            </div>
            <div class="logo2">
                <img src="{{ $configuracion->first()->logo2_b64 }}">
            </div>
            <h2 class="titulo">
                {{ $configuracion->first()->razon_social }}
            </h2>
            <h4 class="texto">FICHA EPIDEMIOLÓIGICA</h4>
        </div>

        <table style="margin-top:30px;">
            <tbody>
                <tr>
                    <td class="gray bold text-lg">1. DATOS GENERALES</td>
                </tr>
            </tbody>
        </table>
        <table border="1">
            <tbody>
                <tr>
                    <td colspan="3">Fecha de notificación</td>
                    <td rowspan="2" width="20%">Departamento:<br />
                        {{ $item->departamento }}</td>
                    <td rowspan="2" width="20%">Municipio:<br />
                        {{ $item->departamento }}</td>
                    <td rowspan="2" width="20%">Localidad/Comunidad:<br />
                        {{ $item->comunidad->nombre }}</td>
                    <td rowspan="2" width="20%">Red de Salud:<br />
                        {{ $item->red_salud }}</td>
                </tr>
                <tr>
                    <td width="8%">{{ date('d', strtotime($item->fecha_diagnostico)) }}</td>
                    <td width="8%">{{ date('m', strtotime($item->fecha_diagnostico)) }}</td>
                    <td width="8%">{{ date('Y', strtotime($item->fecha_diagnostico)) }}</td>
                </tr>
            </tbody>
        </table>
        <table border="1">
            <tbody>
                <tr>
                    <td>Establecimiento de Salud notificante:<br />
                        {{ $item->centro->nombre }}</td>
                    <td>
                        Público ( {{ $item->tipo == 'PÚBLICO' ? 'X' : '' }} )<br />
                        Seguro salud ( {{ $item->tipo == 'SEGURO SALUD' ? 'X' : '' }} )<br />
                        Privado ( {{ $item->tipo == 'PRIVADO' ? 'X' : '' }} )<br />
                        Otro ( {{ $item->tipo == 'OTRO' ? 'X' : '' }} )<br />
                    </td>
                    <td>Teléfono o correo electrónico del Establecimiento:<br />
                        {{ $item->centro->fono_correo }}</td>
                    <td>
                        Caso captado en búsqueda activa (
                        {{ $item->captado == 'CASO CAPTADO EN BUSQUEDA ACTUAL' ? 'X' : '' }} )<br />
                        Atención en servicio de salud (
                        {{ $item->captado == 'ATENCIÓN EN SERVICIO DE SALUD' ? 'X' : '' }} )<br />
                        Otro, especificar ( {{ $item->captado == 'OTRO' ? 'X' : '' }} )<br />
                        {{ $item->captado == 'OTRO' ? $item->captado_desc : '' }}
                    </td>
                </tr>
            </tbody>
        </table>
        <table style="margin-top:0px;">
            <tbody>
                <tr>
                    <td class="gray bold text-lg">2. DATOS DEL PACIENTE</td>
                </tr>
            </tbody>
        </table>
        <table border="1">
            <tbody>
                <tr>
                    <td rowspan="2">Nombres: {{ $item->paciente->nombre }}</td>
                    <td rowspan="2">Apellido Paterno: {{ $item->paciente->paterno }}</td>
                    <td rowspan="2">Apellido Materno: {{ $item->paciente->materno }}</td>
                    <td colspan="2">Sexo/edad</td>
                    <td rowspan="2">Teléfono <br />{{ $item->paciente->fono }}</td>
                    <td>Ocupación <br />{{ $item->paciente->ocupacion }}</td>
                </tr>
                <tr>
                    <td>Masculino<br />{{ $item->paciente->sexo == 'MASCULINO' ? 'X - ' . $item->paciente->edad . ' años' : '' }}
                    </td>
                    <td>Femenino<br />{{ $item->paciente->sexo == 'FEMENINO' ? 'X - ' . $item->paciente->edad . ' años' : '' }}
                    </td>
                    <td>C.I. {{ $item->paciente->full_ci }}</td>
                </tr>
            </tbody>
        </table>
        <table style="margin-top:0px;">
            <tbody>
                <tr>
                    <td class="gray text-md">Residencia del Paciente</td>
                </tr>
            </tbody>
        </table>
        <table border="1">
            <tbody>
                <tr>
                    <td>Departamento: {{ $item->paciente->departamento }}</td>
                    <td>Municipio: {{ $item->paciente->municipio }}</td>
                    <td>Ciudad/Localidad/Comunidad: {{ $item->paciente->comunidad->nombre }}</td>
                    <td>Barrio/Zona/U.V.: {{ $item->paciente->zona }}</td>
                </tr>
            </tbody>
        </table>
        <table style="margin-top:0px;">
            <tbody>
                <tr>
                    <td class="gray bold text-lg">3. ANTECEDENTES EPIDEMIOLÓGICOS</td>
                </tr>
            </tbody>
        </table>
        <table border="1">
            <tbody>
                <tr>
                    <td colspan="5">Lugar probable de Infeccción. ¿Vísito algún lugar endémico de
                        {{ $item->enfermedad->nombre }},
                        en las últimas semanas?</td>
                </tr>
                <tr>
                    <td>País/Lugar: <br />
                        {{ $item->pais_lpi }}</td>
                    <td>Departamento: <br />
                        {{ $item->departamento_lpi }}</td>

                    <td>Provincia/Municipio: <br />
                        {{ $item->municipio_lpi }}</td>
                    <td>Ciudad/Localidad/Comunidad: <br />
                        {{ $item->comunidad_lpi ? $item->comunidad_lpi->nombre : '' }}</td>
                    <td>Barrio/Zona/U.V.: <br />
                        {{ $item->zona_lpi }}</td>
                </tr>
                <tr>
                    <td colspan="5">Lugar de inicio de signos y síntomas</td>
                </tr>
                <tr>
                    <td>País/Lugar: <br />
                        {{ $item->pais_lis }}</td>
                    <td>Departamento: <br />
                        {{ $item->departamento_lis }}</td>

                    <td>Provincia/Municipio: <br />
                        {{ $item->municipio_lis }}</td>
                    <td>Ciudad/Localidad/Comunidad: <br />
                        {{ $item->comunidad_lis ? $item->comunidad_lis->nombre : '' }}</td>
                    <td>Barrio/Zona/U.V.: <br />
                        {{ $item->zona_lis }}</td>
                </tr>
                <tr>
                    <td colspan="2">Si es mujer, esta embarazada SI
                        ({{ $item->paciente->sexo == 'FEMENINO' && $item->embarazada == 1 ? 'X' : '' }})
                        NO ({{ $item->paciente->sexo == 'FEMENINO' && $item->embarazada == 0 ? 'X' : '' }})
                    </td>
                    <td>FUMA:
                        {{ $item->paciente->sexo == 'FEMENINO' && $item->fuma ? $item->fuma : '' }}
                    </td>
                    <td colspan="2">Fecha probable pato:
                        {{ $item->paciente->sexo == 'FEMENINO' && $item->embarazada == 1 ? $item->fecha_parto : '' }}
                    </td>
                </tr>
            </tbody>
        </table>
        <table style="margin-top:0px;">
            <tbody>
                <tr>
                    <td class="gray bold text-lg">4. DATOS CLÍNICOS</td>
                    <td class="gray bold">(Marque con una X los signos y síntomas que presenta el paciente)</td>
                </tr>
            </tbody>
        </table>
        <table border="1">
            <tbody>
                <tr>
                    <td>Fecha inicio de Síntomas</td>
                    <td>Día {{ date('d', strtotime($item->fi_sintomas)) }}</td>
                    <td>Mes {{ date('m', strtotime($item->fi_sintomas)) }}</td>
                    <td>Año {{ date('Y', strtotime($item->fi_sintomas)) }}</td>
                    <td>Semana epidemiológica</td>
                    <td>{{ $item->semana }}</td>
                </tr>
            </tbody>
        </table>
        @php
            $sintomasAgrupados = collect($item->caso_sintomas)->groupBy(function ($elem) {
                return $elem->enfermedad_sintoma->tipo;
            });
        @endphp
        @foreach ($sintomasAgrupados as $tipo => $sintomas)
            <table border="1">
                <tbody>
                    <tr>
                        <td class="gray bold">
                            {{ $tipo }} DE {{ $item->enfermedad->nombre }}
                        </td>
                    </tr>
                </tbody>
            </table>
            <table border="1">
                <tbody>
                    <tr>
                        @foreach ($sintomas as $sintoma)
                            <td>
                                {{ $sintoma->enfermedad_sintoma->nombre }}
                            </td>
                            <td class="centreado" width="{{ $sintoma->input == 0 ? '3%' : '10%' }}">
                                @if ($sintoma->input == 0)
                                    {{ $sintoma->valor == 'true' ? 'X' : '' }}
                                @else
                                    {{ $sintoma->valor }}
                                @endif
                            </td>
                        @endforeach
                    </tr>
                </tbody>
            </table>
        @endforeach

        <table style="margin-top:0px;">
            <tbody>
                <tr>
                    <td class="gray bold text-lg">5. HOSPITALIZACIÓN</td>
                </tr>
            </tbody>
        </table>
        <table border="1">
            <tbody>
                <tr>
                    <td>Fué hospitalizado(a)? SI ({{ $item->hospitalizacion == 1 ? 'X' : '' }}) NO
                        ({{ $item->hospitalizacion == 0 ? 'X' : '' }})</td>
                    <td>
                        Día {{ date('d', strtotime($item->fecha_hospitalizacion)) }}
                    </td>
                    <td>
                        Mes {{ date('m', strtotime($item->fecha_hospitalizacion)) }}
                    </td>
                    <td>
                        Año {{ date('Y', strtotime($item->fecha_hospitalizacion)) }}
                    </td>
                    <td>
                        Establecimiento de Salud: {{ $item->establecimiento }}
                    </td>
                </tr>
                <tr>
                    <td>Hospitalizado(a)? U TI. SI ({{ $item->hospitalizacion_uti == 1 ? 'X' : '' }}) NO
                        ({{ $item->hospitalizacion_uti == 0 ? 'X' : '' }})</td>
                    <td>
                        Día
                        {{ $item->hostpitalizacion_uti == 1 ? date('d', strtotime($item->fecha_hospitalizacion_uti)) : '' }}
                    </td>
                    <td>
                        Mes
                        {{ $item->hostpitalizacion_uti == 1 ? date('m', strtotime($item->fecha_hospitalizacion_uti)) : '' }}
                    </td>
                    <td>
                        Año
                        {{ $item->hostpitalizacion_uti == 1 ? date('Y', strtotime($item->fecha_hospitalizacion_uti)) : '' }}
                    </td>
                    <td>
                        Establecimiento de Salud: {{ $item->establecimiento_uti }}
                    </td>
                </tr>
            </tbody>
        </table>
        <table border="1">
            <tbody>
                <tr>
                    <td>Tipo de Alta: Médica</td>
                    <td>{{ $item->tipo_alta == 'MÉDICA' ? 'X' : '' }}</td>
                    <td>Solicitada</td>
                    <td width="3%">{{ $item->tipo_alta == 'SOLICITADA' ? 'X' : '' }}</td>
                    <td>Fuga</td>
                    <td width="3%">{{ $item->tipo_alta == 'FUGA' ? 'X' : '' }}</td>
                    <td>Defunción</td>
                    <td width="3%">{{ $item->tipo_alta == 'DEFUNCIÓN' ? 'X' : '' }}</td>
                    <td>
                        Fecha Defunción
                    </td>
                    <td>
                        Día
                        {{ $item->tipo_alta == 'DEFUNCIÓN' ? date('d', strtotime($item->fecha_falle)) : '' }}
                    </td>
                    <td>
                        Mes
                        {{ $item->tipo_alta == 'DEFUNCIÓN' ? date('m', strtotime($item->fecha_falle)) : '' }}
                    </td>
                    <td>
                        Año
                        {{ $item->tipo_alta == 'DEFUNCIÓN' ? date('Y', strtotime($item->fecha_falle)) : '' }}
                    </td>
                </tr>
            </tbody>
        </table>
        <table style="margin-top:0px;">
            <tbody>
                <tr>
                    <td class="gray bold text-lg">6. DEFINICIÓN DE CASO</td>
                </tr>
            </tbody>
        </table>
        <table border="1">
            <tbody>
                <tr>
                    <td>Caso sospechoso de {{ $item->enfermedad->nombre }}</td>
                    <td width="4%">{{ $item->tipo_caso == 'SOSPECHOSO' ? 'X' : '' }}</td>
                    <td>Caso confirmado de {{ $item->enfermedad->nombre }}</td>
                    <td width="4%">{{ $item->tipo_caso == 'CONFIRMADO' ? 'X' : '' }}</td>
                    <td>Por Laboratorio</td>
                    <td width="4%">{{ $item->laboratorio == 1 ? 'X' : '' }}</td>
                    <td>Por Nexto Epidemiológico</td>
                    <td width="4%">{{ $item->nexo == 1 ? 'X' : '' }}</td>
                </tr>
            </tbody>
        </table>
        <table style="margin-top:0px;">
            <tbody>
                <tr>
                    <td class="gray bold text-lg">7. EXÁMENES DE LABORATORIO</td>
                </tr>
            </tbody>
        </table>
        <table border="1">
            <tbody>
                <tr>
                    <td>Se tomo muestra SI ({{ $item->muestra == 1 ? 'X' : '' }}) NO
                        ({{ $item->muestra == 0 ? 'X' : '' }})</td>
                    <td>
                        Fecha de toma de muestra:
                    </td>
                    <td>
                        Día
                        {{ $item->muestra == 1 ? date('d', strtotime($item->fecha_muestra)) : '' }}
                    </td>
                    <td>
                        Mes
                        {{ $item->muestra == 1 ? date('m', strtotime($item->fecha_muestra)) : '' }}
                    </td>
                    <td>
                        Año
                        {{ $item->muestra == 1 ? date('Y', strtotime($item->fecha_muestra)) : '' }}
                    </td>
                    <td>Tipo demuestra: </td>
                    <td>Suero ({{ $item->tipo_muestra == 'SUERO' ? 'X' : '' }}) Orina
                        ({{ $item->tipo_muestra == 'ORINA' ? 'X' : '' }}) Otro
                        ({{ $item->tipo_muestra == 'OTRO' ? 'X' : '' }})</td>
                </tr>
            </tbody>
        </table>
        <table border="1">
            <tbody>
                <tr>
                    <td>{{ $item->enfermedad->nombre }}:</td>
                    <td>Resultado RT-PCR: +({{ $item->rt_pcr == 1 ? 'X' : '' }})
                        -({{ $item->rt_pcr == 0 ? 'X' : '' }})</td>
                    <td>Resultado Serológico: </td>
                    <td>IgM +({{ $item->igm == 1 ? 'X' : '' }}) -({{ $item->igm == 0 ? 'X' : '' }}) n/c
                        ({{ $item->igm_nc == 1 ? 'X' : '' }})</td>
                    <td>IgG +({{ $item->igg == 1 ? 'X' : '' }}) -({{ $item->igg == 0 ? 'X' : '' }}) n/c
                        ({{ $item->igg_nc == 1 ? 'X' : '' }})</td>
                    <td>Observación: {{ $item->observacion_lab }}</td>
            </tbody>
        </table>
        <table style="margin-top:0px;">
            <tbody>
                <tr>
                    <td class="gray bold text-lg">8. CROQUIS DE UBICACIÓN DE DOMICILIO DE PACIENTE</td>
                </tr>
            </tbody>
        </table>
        <table border="1">
            <tbody>
                <tr>
                    <td>
                        <img src="{{ $configuracion->first()->croquis64 }}" alt="Croquis" width="100%">
                    </td>
                </tr>
            </tbody>
        </table>
        <table style="margin-top:0px;">
            <tbody>
                <tr>
                    <td class="gray bold text-lg">DATOS DE LA PERSONA QUE NOTIFICA</td>
                </tr>
            </tbody>
        </table>
        <table border="1">
            <tbody>
                <tr>
                    <td colspan="2">Nombre y Cargo: {{ $item->user->full_name }} -
                        {{ $item->user->role->nombre }}
                    </td>
                    <td>Establecimiento de Salud: {{ $item->user->centro ? $item->user->centro->nombre : '' }}</td>
                    <td rowspan="2" class="centreado">
                        <div class=firma></div>FIRMA Y SELLO DEL RESPONSABLE DEL LLENADO DE LA FICHA
                    </td>
                </tr>
                <tr>
                    <td>Teléfono/Celular: {{ $item->user->fono }}</td>
                    <td>Correo electrónico: {{ $item->user->correo }}</td>
                    <td>SEDES: </td>
                </tr>
            </tbody>
        </table>
    @endforeach
</body>

</html>
