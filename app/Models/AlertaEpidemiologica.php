<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AlertaEpidemiologica extends Model
{
    protected $fillable = [
        "comunidad_id",
        "enfermedad_id",
        "nivel_alerta",
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
    ];

    public function comunidad()
    {
        return $this->belongsTo(Comunidad::class, 'comunidad_id');
    }

    public function enfermedad()
    {
        return $this->belongsTo(Enfermedad::class, 'enfermedad_id');
    }
}
