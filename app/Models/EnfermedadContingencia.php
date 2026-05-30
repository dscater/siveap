<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class EnfermedadContingencia extends Model
{
    protected $fillable = [
        "enfermedad_id",
        "descripcion",
    ];

    public function enfermedad()
    {
        return $this->belongsTo(Enfermedad::class, 'enfermedad_id');
    }
}
