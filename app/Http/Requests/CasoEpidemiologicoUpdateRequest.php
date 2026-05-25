<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Foundation\Http\FormRequest;

class CasoEpidemiologicoUpdateRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            "paciente_id" => "required",
            "enfermedad_id" => "required",
            "centro_id" => "required",
            "comunidad_id" => "required",
            "fi_sintomas" => "required|date",
            "fecha_diagnostico" => "required|date",
            "tipo_caso" => "required",
            "gravedad" => "required",
            "estado" => "required",
            "contacto" => "required",
            "hospitalizacion" => "required",
            "observaciones" => "nullable",
        ];
    }

    public function messages()
    {
        return [
            "paciente_id.requried" => "Debes completar este campo",
            "enfermedad_id.requried" => "Debes completar este campo",
            "centro_id.requried" => "Debes completar este campo",
            "comunidad_id.requried" => "Debes completar este campo",
            "fi_sintomas.requried" => "Debes completar este campo",
            "fi_sintomas.date" => "Debes ingresar una fecha valida",
            "fecha_diagnostico.requried" => "Debes completar este campo",
            "fecha_diagnostico.date" => "Debes ingresar una fecha valida",
            "tipo_caso.requried" => "Debes completar este campo",
            "gravedad.requried" => "Debes completar este campo",
            "estado.requried" => "Debes completar este campo",
            "contacto.requried" => "Debes completar este campo",
            "hospitalizacion.requried" => "Debes completar este campo",
            "observaciones.requried" => "Debes completar este campo",
        ];
    }
}
