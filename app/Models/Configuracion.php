<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Configuracion extends Model
{
    use HasFactory;

    protected $fillable = [
        "nombre_sistema",
        "alias",
        "razon_social",
        "nit",
        "dir",
        "fono",
        "actividad",
        "correo",
        "logo",
        "logo2",
    ];

    protected $casts = [];

    protected $appends = ["url_logo", "url_logo2", "logo_b64", "logo2_b64"];
    public function getUrlLogo2Attribute()
    {
        return asset("imgs/" . $this->logo2);
    }

    public function getLogo2B64Attribute()
    {
        $path = public_path("imgs/" . $this->logo2);
        if (file_exists($path)) {
            $type = pathinfo($path, PATHINFO_EXTENSION);
            $data = file_get_contents($path);
            $base64 = 'data:image/' . $type . ';base64,' . base64_encode($data);
            return $base64;
        }
        return "";
    }
    public function getUrlLogoAttribute()
    {
        return asset("imgs/" . $this->logo);
    }

    public function getLogoB64Attribute()
    {
        $path = public_path("imgs/" . $this->logo);
        if (file_exists($path)) {
            $type = pathinfo($path, PATHINFO_EXTENSION);
            $data = file_get_contents($path);
            $base64 = 'data:image/' . $type . ';base64,' . base64_encode($data);
            return $base64;
        }
        return "";
    }
}
