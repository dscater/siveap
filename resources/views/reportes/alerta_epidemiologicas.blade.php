<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>AlertasEpidemiologicas</title>
    <style type="text/css">
        * {
            font-family: sans-serif;
        }

        @page {
            margin-top: 1cm;
            margin-bottom: 0.3cm;
            margin-left: 0.3cm;
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
        <h4 class="texto">ALERTAS EPIDEMIOLÓGICAS</h4>
        <h4 class="fecha">Expedido: {{ date('d-m-Y') }}</h4>
    </div>
    <table border="1">
        <thead class="bg-principal">
            <tr>
                <th>NRO.</th>
                <th>COMUNIDAD</th>
                <th>ENFERMEDAD</th>
                <th>NIVEL DE ALERTA</th>
                <th>FECHA ALERTA</th>
                <th>FECHA FIN</th>
                <th>INDICE</th>
                <th>PREDICCIÓN</th>
                <th>CRECIMIENTO</th>
                <th>CONFIRMADOS</th>
                <th>ACTIVOS</th>
                <th>GRAVES</th>
                <th>FALLECIDOS</th>
                <th>ESTADO</th>
            </tr>
        </thead>
        <tbody>
            @php
                $cont = 1;
            @endphp
            @foreach ($alerta_epidemiologicas as $item)
                <tr>
                    <td>{{ $cont++ }}</td>
                    <td>{{ $item->comunidad->nombre }}</td>
                    <td>{{ $item->enfermedad->nombre }}</td>
                    <td>{{ $item->nivel_alerta }}</td>
                    <td>{{ $item->fecha_t }}</td>
                    <td>{{ $item->fecha_fin_t }}</td>
                    <td>{{ $item->indice }}</td>
                    <td>{{ $item->prediccion }}</td>
                    <td>{{ $item->crecimento }}</td>
                    <td>{{ $item->confirmados }}</td>
                    <td>{{ $item->activos }}</td>
                    <td>{{ $item->graves }}</td>
                    <td>{{ $item->fallecidos }}</td>
                    <td>{{ $item->estado }}</td>
                </tr>
            @endforeach
        </tbody>
    </table>
</body>

</html>
