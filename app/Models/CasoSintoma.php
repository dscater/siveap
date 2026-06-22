<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CasoSintoma extends Model
{
    protected $fillable = [
        "caso_epidemiologico_id",
        "enfermedad_sintoma_id",
        "valor",
    ];

    public function caso_epidemiologico()
    {
        return $this->belongsTo(CasoEpidemiologico::class, 'caso_epidemiologico_id');
    }

    public function enfermedad_sintoma()
    {
        return $this->belongsTo(EnfermedadSintoma::class, 'enfermedad_sintoma_id');
    }
}
