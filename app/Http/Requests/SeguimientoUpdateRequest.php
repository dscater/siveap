<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Foundation\Http\FormRequest;

class SeguimientoUpdateRequest extends FormRequest
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
            "caso_epidemiologico_id" => "required",
            "fecha" => "required|date",
            "estado" => "required",
            "observaciones" => "nullable",
        ];
    }

    public function messages()
    {
        return [
            "caso_epidemiologico_id.required" => "Debes completar este campo",
            "fecha.required" => "Debes completar este campo",
            "fecha.date" => "Debes ingresar una fecha valida",
            "estado.required" => "Debes completar este campo",
            "observaciones.required" => "Debes completar este campo",
        ];
    }
}
