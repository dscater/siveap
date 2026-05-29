<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ReglasAlerta extends Model
{
    protected $fillable = [
        "enfermedad_id",
        "umbral", // NUMERO DE CASOS ACTIVOS CONFIRMADOS
        // "riesgo",
        "status",
    ];

    public function enfermedad()
    {
        return $this->belongsTo(Enfermedad::class, "enfermedad_id");
    }
}
