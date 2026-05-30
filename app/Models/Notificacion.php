<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;

class Notificacion extends Model
{
    protected $fillable = [
        "descripcion",
        "modulo",
        "registro_id",
        "tipo",
        "fecha",
        "hora",
    ];

    protected $appends = ["hace", "fecha_t", "fecha_c", "icon", "url"];

    public function getUrlAttribute()
    {
        if ($this->tipo == 'ALERTA') {
            return route('alerta_epidemiologicas.show', $this->registro_id);
        }

        return route('notificacion_users.show', $this->id);
    }

    public function getIconAttribute()
    {
        if ($this->tipo == 'ALERTA') {
            return 'fa fa-exclamation-triangle text-danger';
        }

        return 'fa fa-envelope';
    }

    public function getFechaCAttribute()
    {
        return date("d/m/Y H:i", strtotime($this->fecha . ' ' . $this->hora));
    }

    public function getFechaTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha));
    }
    public function getHaceAttribute()
    {
        Carbon::setLocale('es');
        return $this->created_at->diffForHumans();
    }

    public function notificacion_users()
    {
        return $this->hasMany(NotificacionUser::class, 'notificacion_id');
    }
}
