<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Foundation\Http\FormRequest;

class PacienteUpdateRequest extends FormRequest
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
            "nombre" => "required",
            "paterno" => "required",
            "materno" => "nullable",
            "sexo" => "required",
            "ci" => "required|unique:pacientes,ci," . $this->paciente->id,
            "ci_exp" => "required",
            "fecha_nac" => "required",
            "dir" => "required",
            "latitud" => "required",
            "longitud" => "required",
            "fono" => "nullable",
            "comunidad_id" => "required",
        ];
    }

    public function messages()
    {
        return [
            "nombre.required" => "Debes completar este campo",
            "paterno.required" => "Debes completar este campo",
            "materno.required" => "Debes completar este campo",
            "ci.required" => "Debes completar este campo",
            "ci.unique" => "Este C.I. no esta disponible",
            "ci_exp.required" => "Debes completar este campo",
            "sexo.required" => "Debes completar este campo",
            "fecha_nac.required" => "Debes completar este campo",
            "dir.required" => "Debes completar este campo",
            "latitud.required" => "Debes indicar la ubicación",
            "longitud.required" => "Debes completar este campo",
            "fono.required" => "Debes completar este campo",
            "comunidad_id.required" => "Debes completar este campo",
        ];
    }
}
