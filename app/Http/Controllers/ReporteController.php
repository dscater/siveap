<?php

namespace App\Http\Controllers;

use App\Models\AlertaEpidemiologica;
use App\Models\CasoEpidemiologico;
use App\Models\Certificado;
use App\Models\CertificadoDetalle;
use App\Models\Cliente;
use App\Models\Configuracion;
use App\Models\HistorialAccion;
use App\Models\Inscripcion;
use App\Models\Pago;
use App\Models\TipoCertificado;
use App\Models\User;
use App\Services\ReporteService;
use App\Services\ReporteServiceTcpdf;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Inertia\Inertia;
use PDF;
use Carbon\Carbon;
use FPDF;
use Illuminate\Support\Facades\DB;
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\IOFactory;
use PhpOffice\PhpSpreadsheet\Worksheet\Drawing;
use PhpOffice\PhpSpreadsheet\Cell\Coordinate;
use PhpOffice\PhpSpreadsheet\Worksheet\PageSetup;

class ReporteController extends Controller
{
    public $titulo = [
        'font' => [
            'bold' => true,
            'size' => 12,
            'family' => 'Times New Roman'
        ],
        'borders' => [
            'allBorders' => [
                'borderStyle' => \PhpOffice\PhpSpreadsheet\Style\Border::BORDER_NONE,
            ],
        ],
    ];

    public $textoBold = [
        'font' => [
            'bold' => true,
            'size' => 10,
        ],
    ];

    public $headerTabla = [
        'font' => [
            'bold' => true,
            'size' => 10,
            'color' => ['argb' => 'ffffff'],
        ],
        'alignment' => [
            'vertical' => \PhpOffice\PhpSpreadsheet\Style\Alignment::VERTICAL_CENTER,
        ],
        'borders' => [
            'allBorders' => [
                'borderStyle' => \PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN,
            ],
        ],
        'fill' => [
            'fillType' => \PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID,
            'color' => ['rgb' => '203764']
        ],
    ];

    public $headerTablaRed = [
        'font' => [
            'bold' => true,
            'size' => 10,
            'color' => ['argb' => 'ffffff'],
        ],
        'alignment' => [
            'vertical' => \PhpOffice\PhpSpreadsheet\Style\Alignment::VERTICAL_CENTER,
        ],
        'borders' => [
            'allBorders' => [
                'borderStyle' => \PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN,
            ],
        ],
        'fill' => [
            'fillType' => \PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID,
            'color' => ['rgb' => 'f02222']
        ],
    ];

    public $headerTabla2 = [
        'font' => [
            'bold' => true,
            'size' => 10,
            'color' => ['argb' => '000000'],
        ],
        'alignment' => [
            'vertical' => \PhpOffice\PhpSpreadsheet\Style\Alignment::VERTICAL_CENTER,
        ],
        'borders' => [
            'allBorders' => [
                'borderStyle' => \PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN,
            ],
        ],
    ];

    public $bodyTabla = [
        'font' => [
            'size' => 10,
        ],
        'alignment' => [
            'vertical' => \PhpOffice\PhpSpreadsheet\Style\Alignment::VERTICAL_CENTER,
            // 'horizontal' => \PhpOffice\PhpSpreadsheet\Style\Alignment::HORIZONTAL_CENTER,
        ],
        'borders' => [
            'allBorders' => [
                'borderStyle' => \PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN,
            ],
        ],
    ];

    public $textLeft = [
        'alignment' => [
            'horizontal' => \PhpOffice\PhpSpreadsheet\Style\Alignment::HORIZONTAL_LEFT,
        ],
    ];

    public $textRight = [
        'alignment' => [
            'horizontal' => \PhpOffice\PhpSpreadsheet\Style\Alignment::HORIZONTAL_RIGHT,
        ],
    ];

    public $textCenter = [
        'alignment' => [
            'horizontal' => \PhpOffice\PhpSpreadsheet\Style\Alignment::HORIZONTAL_CENTER,
        ],
    ];

    public $bg0 = [
        'fill' => [
            'fillType' => \PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID,
            'color' => ['rgb' => 'cff3f3']
        ],
    ];

    public $bg1 = [
        'fill' => [
            'fillType' => \PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID,
            'color' => ['rgb' => 'ffe9ff']
        ],
    ];

    public $bg2 = [
        'fill' => [
            'fillType' => \PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID,
            'color' => ['rgb' => 'f7ffe0']
        ],
    ];

    public $bg3 = [
        'fill' => [
            'fillType' => \PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID,
            'color' => ['rgb' => 'ecfcdd']
        ],
    ];

    public $bg4 = [
        'fill' => [
            'fillType' => \PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID,
            'color' => ['rgb' => 'faeee4']
        ],
    ];

    private $configuracion = null;
    public function __construct()
    {
        $this->configuracion = Configuracion::first();
        if (!$this->configuracion) {
            $this->configuracion = new Configuracion([
                "nombre_sistema" => "MEDINTER S.A.",
                "alias" => "MD",
                "logo" => "logo.png",
                "fono" => "2222222",
                "dir" => "LOS OLIVOS",
            ]);
        }
    }

    public function usuarios()
    {
        return Inertia::render("Admin/Reportes/Usuarios");
    }

    public function r_usuarios(Request $request)
    {
        ini_set('memory_limit', '1024M');
        set_time_limit(-1);
        $role_id =  $request->role_id;
        $formato =  $request->formato;
        $usuarios = User::select("users.*")
            ->where('id', '!=', 1);

        if ($role_id != 'todos') {
            $usuarios->where('role_id', $role_id);
        }

        $usuarios = $usuarios->get();

        if ($formato == 'pdf') {
            $pdf = PDF::loadView('reportes.usuarios', compact('usuarios'))->setPaper('legal', 'landscape');

            // ENUMERAR LAS PÁGINAS USANDO CANVAS
            $pdf->output();
            $dom_pdf = $pdf->getDomPDF();
            $canvas = $dom_pdf->get_canvas();
            $alto = $canvas->get_height();
            $ancho = $canvas->get_width();
            $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

            return $pdf->stream('usuarios.pdf');
        } else {
            $spreadsheet = new Spreadsheet();
            $spreadsheet->getProperties()
                ->setCreator("ADMIN")
                ->setLastModifiedBy('Administración')
                ->setTitle('Registros')
                ->setSubject('Registros')
                ->setDescription('Registros')
                ->setKeywords('PHPSpreadsheet')
                ->setCategory('Listado');

            $sheet = $spreadsheet->getActiveSheet();

            $spreadsheet->getDefaultStyle()->getFont()->setName('Arial');

            $fila = 1;
            if (file_exists(public_path() . '/imgs/' . $this->configuracion->logo)) {
                $drawing = new \PhpOffice\PhpSpreadsheet\Worksheet\Drawing();
                $drawing->setName('logo');
                $drawing->setDescription('logo');
                $drawing->setPath(public_path() . '/imgs/' . $this->configuracion->logo); // put your path and image here
                $drawing->setCoordinates('A' . $fila);
                $drawing->setOffsetX(5);
                $drawing->setOffsetY(0);
                $drawing->setHeight(70);
                $drawing->setWorksheet($sheet);
            }

            $fila = 2;
            $sheet->setCellValue('A' . $fila, $this->configuracion->nombre_sistema);
            $sheet->mergeCells("A" . $fila . ":K" . $fila);  //COMBINAR CELDAS
            $sheet->getStyle('A' . $fila . ':K' . $fila)->getAlignment()->setHorizontal('center');
            $sheet->getStyle('A' . $fila . ':K' . $fila)->applyFromArray($this->titulo);
            $fila++;
            $sheet->setCellValue('A' . $fila, "LISTA DE USUARIOS");
            $sheet->mergeCells("A" . $fila . ":K" . $fila);  //COMBINAR CELDAS
            $sheet->getStyle('A' . $fila . ':K' . $fila)->getAlignment()->setHorizontal('center');
            $sheet->getStyle('A' . $fila . ':K' . $fila)->applyFromArray($this->titulo);
            $fila++;
            $fila++;
            $sheet->setCellValue('A' . $fila, 'N°');
            $sheet->setCellValue('B' . $fila, 'USUARIO');
            $sheet->setCellValue('C' . $fila, 'PATERNO');
            $sheet->setCellValue('D' . $fila, 'MATERNO');
            $sheet->setCellValue('E' . $fila, 'NOMBRE(S)');
            $sheet->setCellValue('F' . $fila, 'C.I.');
            $sheet->setCellValue('G' . $fila, 'DIRECCIÓN');
            $sheet->setCellValue('H' . $fila, 'CORREO');
            $sheet->setCellValue('I' . $fila, 'TELÉFONO/CELULAR');
            $sheet->setCellValue('J' . $fila, 'TIPO');
            $sheet->setCellValue('K' . $fila, 'ACCESO');
            $sheet->getStyle('A' . $fila . ':K' . $fila)->applyFromArray($this->headerTabla);
            $fila++;

            foreach ($usuarios as $key => $item) {
                $sheet->setCellValue('A' . $fila, $key + 1);
                $sheet->setCellValue('B' . $fila, $item->usuario);
                $sheet->setCellValue('C' . $fila, $item->paterno);
                $sheet->setCellValue('D' . $fila, $item->materno);
                $sheet->setCellValue('E' . $fila, $item->nombre);
                $sheet->setCellValue('F' . $fila, $item->full_ci);
                $sheet->setCellValue('G' . $fila, $item->dir);
                $sheet->setCellValue('H' . $fila, $item->correo);
                $sheet->setCellValue('I' . $fila, $item->fono);
                $sheet->setCellValue('J' . $fila, $item->tipo);
                $sheet->setCellValue('K' . $fila, $item->acceso == 1 ? 'HABILITADO' : 'DENEGADO');
                $sheet->getStyle('A' . $fila . ':K' . $fila)->applyFromArray($this->bodyTabla);
                $fila++;
            }

            $sheet->getColumnDimension('A')->setWidth(6);
            $sheet->getColumnDimension('B')->setWidth(20);
            $sheet->getColumnDimension('C')->setWidth(15);
            $sheet->getColumnDimension('D')->setWidth(10);
            $sheet->getColumnDimension('E')->setWidth(15);
            $sheet->getColumnDimension('F')->setWidth(20);
            $sheet->getColumnDimension('G')->setWidth(15);
            $sheet->getColumnDimension('H')->setWidth(15);
            $sheet->getColumnDimension('I')->setWidth(15);
            $sheet->getColumnDimension('J')->setWidth(15);
            $sheet->getColumnDimension('K')->setWidth(15);

            foreach (range('A', 'K') as $columnID) {
                $sheet->getStyle($columnID)->getAlignment()->setWrapText(true);
            }

            $sheet->getPageSetup()->setOrientation(\PhpOffice\PhpSpreadsheet\Worksheet\PageSetup::ORIENTATION_LANDSCAPE);
            $sheet->getPageMargins()->setTop(0.5);
            $sheet->getPageMargins()->setRight(0.1);
            $sheet->getPageMargins()->setLeft(0.1);
            $sheet->getPageMargins()->setBottom(0.1);
            $sheet->getPageSetup()->setPrintArea('A:K');
            $sheet->getPageSetup()->setFitToWidth(1);
            $sheet->getPageSetup()->setFitToHeight(0);

            return response()->streamDownload(
                function () use ($spreadsheet) {
                    $writer = IOFactory::createWriter($spreadsheet, 'Xlsx');
                    $writer->save('php://output');
                },
                'usuarios_' . time() . '.xlsx',
                [
                    'Content-Type' => 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
                ]
            );
        }
    }

    public function casos_epidemiologicos()
    {
        return Inertia::render("Admin/Reportes/CasosEpidemiologicos");
    }

    public function r_casos_epidemiologicos(Request $request)
    {
        ini_set('memory_limit', '1024M');
        set_time_limit(-1);
        $comunidad_id =  $request->comunidad_id;
        $centro_id =  $request->centro_id;
        $enfermedad_id =  $request->enfermedad_id;
        $tipo_caso =  $request->tipo_caso;
        $gravedad =  $request->gravedad;
        $estado =  $request->estado;
        $fecha_ini =  $request->fecha_ini;
        $fecha_fin =  $request->fecha_fin;
        $formato =  $request->formato;
        $casos_epidemiologicos = CasoEpidemiologico::select("caso_epidemiologicos.*");

        if ($comunidad_id != 'todos') {
            $casos_epidemiologicos->where('comunidad_id', $comunidad_id);
        }

        if ($centro_id != 'todos') {
            $casos_epidemiologicos->where('centro_id', $centro_id);
        }

        if ($enfermedad_id != 'todos') {
            $casos_epidemiologicos->where('enfermedad_id', $enfermedad_id);
        }

        if ($tipo_caso != 'todos') {
            $casos_epidemiologicos->where('tipo_caso', $tipo_caso);
        }

        if ($gravedad != 'todos') {
            $casos_epidemiologicos->where('gravedad', $gravedad);
        }

        if ($estado != 'todos') {
            $casos_epidemiologicos->where('estado', $estado);
        }

        if ($fecha_ini && $fecha_fin) {
            $casos_epidemiologicos->whereBetween('fecha_diagnostico', [$fecha_ini, $fecha_fin]);
        }

        $casos_epidemiologicos = $casos_epidemiologicos->get();
        $pdf = PDF::loadView('reportes.casos_epidemiologicos', compact('casos_epidemiologicos'))->setPaper('letter', 'landscape');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->stream('casos_epidemiologicos.pdf');
    }

    public function alerta_epidemiologicas()
    {
        return Inertia::render("Admin/Reportes/AlertaEpidemiologicas");
    }

    public function r_alerta_epidemiologicas(Request $request)
    {
        ini_set('memory_limit', '1024M');
        set_time_limit(-1);
        $comunidad_id =  $request->comunidad_id;
        $enfermedad_id =  $request->enfermedad_id;
        $nivel_alerta =  $request->nivel_alerta;
        $estado =  $request->estado;
        $fecha_ini =  $request->fecha_ini;
        $fecha_fin =  $request->fecha_fin;
        $formato =  $request->formato;
        $alerta_epidemiologicas = AlertaEpidemiologica::select("alerta_epidemiologicas.*");

        if ($comunidad_id != 'todos') {
            $alerta_epidemiologicas->where('comunidad_id', $comunidad_id);
        }

        if ($enfermedad_id != 'todos') {
            $alerta_epidemiologicas->where('enfermedad_id', $enfermedad_id);
        }

        if ($nivel_alerta != 'todos') {
            $alerta_epidemiologicas->where('nivel_alerta', $nivel_alerta);
        }

        if ($estado != 'todos') {
            $alerta_epidemiologicas->where('estado', $estado);
        }

        if ($fecha_ini && $fecha_fin) {
            $alerta_epidemiologicas->whereBetween('fecha', [$fecha_ini, $fecha_fin]);
        }

        $alerta_epidemiologicas = $alerta_epidemiologicas->get();
        $pdf = PDF::loadView('reportes.alerta_epidemiologicas', compact('alerta_epidemiologicas'))->setPaper('letter', 'landscape');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->stream('alerta_epidemiologicas.pdf');
    }


    public function seguimientos()
    {
        return Inertia::render("Admin/Reportes/Seguimientos");
    }

    public function r_seguimientos(Request $request)
    {
        ini_set('memory_limit', '1024M');
        set_time_limit(-1);
        $comunidad_id =  $request->comunidad_id;
        $centro_id =  $request->centro_id;
        $caso_epidemiologico_id =  $request->caso_epidemiologico_id;
        $enfermedad_id =  $request->enfermedad_id;
        $tipo_caso =  $request->tipo_caso;
        $gravedad =  $request->gravedad;
        $estado =  $request->estado;
        $fecha_ini =  $request->fecha_ini;
        $fecha_fin =  $request->fecha_fin;
        $formato =  $request->formato;
        $casos_epidemiologicos = CasoEpidemiologico::select("caso_epidemiologicos.*");

        if ($comunidad_id != 'todos') {
            $casos_epidemiologicos->where('comunidad_id', $comunidad_id);
        }

        if ($centro_id != 'todos') {
            $casos_epidemiologicos->where('centro_id', $centro_id);
        }

        if ($caso_epidemiologico_id != 'todos') {
            $casos_epidemiologicos->where('id', $caso_epidemiologico_id);
        }

        if ($enfermedad_id != 'todos') {
            $casos_epidemiologicos->where('enfermedad_id', $enfermedad_id);
        }

        if ($tipo_caso != 'todos') {
            $casos_epidemiologicos->where('tipo_caso', $tipo_caso);
        }

        if ($gravedad != 'todos') {
            $casos_epidemiologicos->where('gravedad', $gravedad);
        }

        if ($estado != 'todos') {
            $casos_epidemiologicos->where('estado', $estado);
        }

        if ($fecha_ini && $fecha_fin && $caso_epidemiologico_id == 'todos') {
            $casos_epidemiologicos->whereBetween('fecha_diagnostico', [$fecha_ini, $fecha_fin]);
        }

        $casos_epidemiologicos = $casos_epidemiologicos->get();
        $pdf = PDF::loadView('reportes.seguimientos', compact('casos_epidemiologicos'))->setPaper('letter', 'portrait');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->stream('seguimientos.pdf');
    }
}
