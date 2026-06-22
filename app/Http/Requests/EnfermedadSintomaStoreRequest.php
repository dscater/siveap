<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Foundation\Http\FormRequest;

class EnfermedadSintomaStoreRequest extends FormRequest
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
            "enfermedad_id" => "required",
            "nombre" => "required",
            "tipo" => "required",
            "input" => "required",
        ];
    }

    public function messages()
    {
        return [
            "enfermedad_id.required" => "Debes completar este campo",
            "nombre.required" => "Debes completar este campo",
            "tipo.required" => "Debes completar este campo",
            "input.required" => "Debes completar este campo",
        ];
    }
}
