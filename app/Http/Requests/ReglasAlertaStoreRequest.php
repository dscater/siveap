<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Foundation\Http\FormRequest;

class ReglasAlertaStoreRequest extends FormRequest
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
            "enfermedad_id" => "required|unique:reglas_alertas,enfermedad_id",
            "umbral" => "required",
            // "riesgo" => "required",
        ];
    }

    public function messages()
    {
        return [
            "enfermedad_id.required" => "El campo enfermedad es obligatorio.",
            "enfermedad_id.unique" => "La enfermedad ya tiene una regla.",
            "umbral.required" => "El campo umbral es obligatorio.",
            "riesgo.required" => "El campo riesgo es obligatorio.",
        ];
    }
}
