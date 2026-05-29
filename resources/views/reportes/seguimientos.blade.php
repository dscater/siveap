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
            margin-top: 0.3cm;
            margin-bottom: 0.3cm;
            margin-left: 1cm;
            margin-right: 0.3cm;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
            margin-top: 20px;
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

        .derecha {
            text-align: right;
        }

        .nuevo {
            page-break-after: always;
        }
    </style>
</head>

<body>
    @inject('configuracion', 'App\Models\Configuracion')
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
        <h4 class="texto">SEGUIMIENTOS POR CASOS EPIDEMIOLÓGICOS</h4>
        <h4 class="fecha">Expedido: {{ date('d-m-Y') }}</h4>
    </div>
    @php
        $cont_caso = 0;
    @endphp
    @foreach ($casos_epidemiologicos as $item)
        <table>
            <tbody>
                <tr>
                    <td class="bold" width="12%">Código: </td>
                    <td>{{ $item->codigo }}</td>
                    <td class="bold">Fecha Inicio Sintomas: </td>
                    <td>{{ $item->fi_sintomas_t }}</td>
                    <td class="bold">Fecha Diagnostico: </td>
                    <td>{{ $item->fecha_diagnostico_t }}</td>
                </tr>
                <tr>
                    <td class="bold">Nombre Paciente: </td>
                    <td>{{ $item->paciente->full_name }}</td>
                    <td class="bold">Edad: </td>
                    <td>{{ $item->paciente->edad }} años</td>
                    <td class="bold">Sexo: </td>
                    <td>{{ $item->paciente->sexo }}</td>
                </tr>
                <tr>
                    <td class="bold">Dirección: </td>
                    <td>{{ $item->paciente->dir }}</td>
                    <td class="bold">Teléfono: </td>
                    <td>{{ $item->paciente->fono }}</td>
                    <td class="bold">Comunidad: </td>
                    <td>{{ $item->paciente->comunidad->nombre }}</td>
                </tr>
                <tr>
                    <td class="bold">Hospitalización: </td>
                    <td>{{ $item->hospitalizacion == 1 ? 'SI' : 'NO' }}</td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
            </tbody>
        </table>
        <h4 class="texto">Seguimiento</h4>
        <table border="1">
            <thead>
                <tr>
                    <th>Nro.</th>
                    <th>Fecha</th>
                    <th>Gravedad</th>
                    <th>Estado</th>
                    <th>Observaciones</th>
                </tr>
            </thead>
            <tbody>
                @php
                    $cont = 1;
                @endphp
                @foreach ($item->seguimientos as $seguimiento)
                    <tr>
                        <td>{{ $cont++ }}</td>
                        <td>{{ $seguimiento->fecha_t }}</td>
                        <td>{{ $seguimiento->gravedad }}</td>
                        <td>{{ $seguimiento->estado }}</td>
                        <td>{{ $seguimiento->observaciones }}</td>
                    </tr>
                @endforeach
            </tbody>
        </table>
        @php
            $cont_caso++;
        @endphp
        @if ($cont_caso < count($casos_epidemiologicos))
            <div class="nuevo"></div>
        @endif
    @endforeach
</body>

</html>
