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
        "centro_id",
        "comunidad_id",
        "user_id",
        "fi_sintomas", // FECHA INICIO SINTOMAS
        "fecha_diagnostico", // FECHA DIAGNOSTICO POR DEFECTO
        "tipo_caso", //SOSPECHOSO, PROBABLE, CONFIRMADO, DESCARTADO
        "gravedad", // LEVE, MODERADO, GRAVE, CRITICO
        "estado", // EN SEGUIMIENTO, ACTIVO, RECUPERADO, FALLECIDO, DESCARTADO
        "contacto", // Nro. de contacto con otras personas
        "hospitalizacion", // requiere hospitlizacion SI/NO (1,0)
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
    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }
}
