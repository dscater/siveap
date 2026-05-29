<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Seguimiento extends Model
{
    protected $fillable = [
        "caso_epidemiologico_id",
        "fecha",
        "gravedad",
        "estado",
        "observaciones",
        "user_id",
    ];

    protected $appends = ["fecha_t"];

    public function getFechaTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha));
    }

    public function caso_epidemiologico()
    {
        return $this->belongsTo(CasoEpidemiologico::class, 'caso_epidemiologico_id');
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }
}
