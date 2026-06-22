<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class EnfermedadSintoma extends Model
{
    protected $fillable = [
        "enfermedad_id",
        "nombre",
        "tipo",
        "input", // 0:checkbox, 1:texto
    ];

    protected $appends = ["input_txt"];

    public function getInputTxtAttribute()
    {
        return $this->input == 0 ? 'CHECKBOX' : 'TEXTO';
    }

    public function enfermedad()
    {
        return $this->belongsTo(Enfermedad::class, 'enfermedad_id');
    }
}
