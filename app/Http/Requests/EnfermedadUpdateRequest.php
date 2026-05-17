<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Foundation\Http\FormRequest;

class EnfermedadUpdateRequest extends FormRequest
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
            "nombre" => "required|unique:enfermedads,nombre," . $this->enfermedad->id,
            "categoria_enfermedad_id" => "required",
            "tipo_transmision_id" => "required",
            "descripcion" => "nullable",
        ];
    }

    public function messages()
    {
        return [
            "nombre.required" => "Debes completar este campo",
            "categoria_enfermedad_id.required" => "Debes completar este campo",
            "tipo_transmision_id.required" => "Debes completar este campo",
        ];
    }
}
