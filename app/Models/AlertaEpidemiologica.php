<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;

class AlertaEpidemiologica extends Model
{
    protected $fillable = [
        "comunidad_id",
        "enfermedad_id",
        "nivel_alerta", // BAJO, MEDIO, ALTO, CRITICO
        "indice",
        "prediccion",
        "crecimiento",
        "confirmados",
        "activos",
        "graves",
        "fallecidos",
        "fecha",
        "estado", // ACTIVO, CONTROLADO
        "fecha_fin",
        "indice_fin",
    ];

    protected $appends = ["fecha_t", "fecha_fin_t"];

    public function getFechaTAttribute()
    {
        return Carbon::parse($this->fecha)->format("d/m/Y");
    }

    public function getFechaFinTAttribute()
    {
        if (!$this->fecha_fin) return "-";
        return Carbon::parse($this->fecha_fin)->format("d/m/Y");
    }

    public function comunidad()
    {
        return $this->belongsTo(Comunidad::class, 'comunidad_id');
    }

    public function enfermedad()
    {
        return $this->belongsTo(Enfermedad::class, 'enfermedad_id');
    }
}
