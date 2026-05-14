<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Foundation\Http\FormRequest;

class TipoTransmisionUpdateRequest extends FormRequest
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
            "nombre" => "required|unique:tipo_transmisions,nombre," . $this->tipo_transmision->id
        ];
    }

    public function messages()
    {
        return [
            "nombre.required" => "Debes completar este campo",
            "nombre.unique" => "Este nombre no esta disponible",
        ];
    }
}
