<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Log;

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
        "ocupacion",
        "departamento",
        "municipio",
        "zona",
        "apoderado",
        "comunidad_id",
        "capturaMapa",
        "fecha_registro",
    ];

    protected $appends = ["full_name", "full_ci", "edad", "fecha_nac_t", "fecha_registro_t", "mapa64"];

    public function getMapa64Attribute()
    {
        $path = public_path("imgs/pacientes/mapas/" . $this->capturaMapa);
        if (!$this->capturaMapa || !file_exists($path)) {
            $path = public_path("imgs/croquis.png");
        }
        $type = pathinfo($path, PATHINFO_EXTENSION);
        $data = file_get_contents($path);
        $base64 = 'data:image/' . $type . ';base64,' . base64_encode($data);
        return $base64;
    }

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

    public function scopeBuscarNombre($query, $texto)
    {
        if (!$texto) return $query;

        $palabras = explode(' ', $texto);

        foreach ($palabras as $palabra) {
            $query->where(function ($q) use ($palabra) {
                $q->where('nombre', 'like', "%$palabra%")
                    ->orWhere('paterno', 'like', "%$palabra%")
                    ->orWhere('materno', 'like', "%$palabra%")
                    ->orWhere('ci', 'like', "%$palabra%");
            });
        }

        return $query;
    }
}
