<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;

class Paciente extends Model
{
    protected $fillable = [
        "nombre",
        "paterno",
        "materno",
        "ci",
        "ci_exp",
        "sexo",
        "fecha_nac",
        "dir",
        "latitud",
        "longitud",
        "fono",
        "comunidad_id",
        "fecha_registro",
    ];

    protected $appends = ["full_name", "full_ci", "edad", "fecha_nac_t", "fecha_registro_t"];

    public function getFechaRegistroTAttribute()
    {
        return Carbon::parse($this->fecha_nac)
            ->format("d/m/Y");
    }

    public function getFechaNacTAttribute()
    {
        return Carbon::parse($this->fecha_nac)
            ->locale("es")
            ->translatedFormat('d \d\e F \d\e Y');
    }

    public function getFullCiAttribute()
    {
        return $this->ci . ' ' . $this->ci_exp;
    }

    public function getEdadAttribute()
    {
        return Carbon::parse($this->fecha_nac)->age;
    }

    public function getFullNameAttribute()
    {
        return $this->nombre . ' ' . $this->paterno . ($this->materno ? ' ' . $this->materno : '');
    }

    public function comunidad()
    {
        return $this->belongsTo(Comunidad::class, 'comunidad_id');
    }
}
