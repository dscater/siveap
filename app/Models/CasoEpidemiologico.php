<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;

class CasoEpidemiologico extends Model
{
    protected $fillable = [
        "codigo",
        "paciente_id",
        "enfermedad_id",
        "departamento",
        "municipio",
        "centro_id",
        "comunidad_id",
        "red_salud",
        "tipo", // PUBLICO,SEGURO,PRIVADO,OTRO
        "captado",
        "captado_desc",
        "user_id",
        "pais_lpi",
        "departamento_lpi",
        "municipio_lpi",
        "comunidad_id_lpi",
        "zona_lpi",
        "pais_lis",
        "departamento_lis",
        "municipio_lis",
        "comunidad_id_lis",
        "zona_lis",
        "embarazada",
        "fuma",
        "fecha_parto",
        "fi_sintomas", // FECHA INICIO SINTOMAS
        "fecha_diagnostico", // FECHA DIAGNOSTICO POR DEFECTO
        "semana",
        "tipo_caso", //SOSPECHOSO, PROBABLE, CONFIRMADO, DESCARTADO
        "gravedad", // LEVE, MODERADO, GRAVE, CRITICO
        "estado", // EN SEGUIMIENTO, ACTIVO, RECUPERADO, FALLECIDO, DESCARTADO
        "fecha_falle",
        "contacto", // Nro. de contacto con otras personas
        "hospitalizacion", // requiere hospitlizacion SI/NO (1,0)
        "tipo_alta", // medica, solicitdad, fuga, defunción
        "fecha_hospitalizacion",
        "establecimiento",
        "hospitalizacion_uti",
        "fecha_hospitalizacion_uti",
        "establecimiento_uti",
        "laboratorio",
        "nexo",
        "muestra",
        "fecha_muestra",
        "tipo_muestra",
        "rt_pcr",
        "igm",
        "igm_nc",
        "igg",
        "igg_nc",
        "observacion_lab",
        "fecha_registro",
        "observaciones",
    ];

    protected $appends = ["fi_sintomas_t", "fecha_diagnostico_t"];

    public function getFiSintomasTAttribute()
    {
        return Carbon::parse($this->fi_sintomas)
            ->format("d/m/Y");
    }

    public function getFechaDiagnosticoTAttribute()
    {
        return Carbon::parse($this->fecha_diagnostico)
            ->format("d/m/Y");
    }

    protected $casts = [
        'fecha_diagnostico' => 'date:Y-m-d',
        'fi_sintomas' => 'date:Y-m-d',
        'fecha_registro' => 'date:Y-m-d',
    ];

    public function paciente()
    {
        return $this->belongsTo(Paciente::class, 'paciente_id');
    }
    public function enfermedad()
    {
        return $this->belongsTo(Enfermedad::class, 'enfermedad_id');
    }
    public function centro()
    {
        return $this->belongsTo(Centro::class, 'centro_id');
    }
    public function comunidad()
    {
        return $this->belongsTo(Comunidad::class, 'comunidad_id');
    }
    public function comunidad_lpi()
    {
        return $this->belongsTo(Comunidad::class, 'comunidad_id_lpi');
    }
    public function comunidad_lis()
    {
        return $this->belongsTo(Comunidad::class, 'comunidad_id_lis');
    }
    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }
    public function seguimientos()
    {
        return $this->hasMany(Seguimiento::class, 'caso_epidemiologico_id');
    }
    public function caso_sintomas()
    {
        return $this->hasMany(CasoSintoma::class, 'caso_epidemiologico_id');
    }
}
