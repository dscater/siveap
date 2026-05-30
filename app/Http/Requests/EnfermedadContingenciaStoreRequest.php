<?php

namespace App\Http\Requests;

use App\Rules\HtmlNotEmpty;
use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Foundation\Http\FormRequest;

class EnfermedadContingenciaStoreRequest extends FormRequest
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
            "enfermedad_id" => "required|unique:enfermedad_contingencias,enfermedad_id",

            "descripcion" => ["required", new HtmlNotEmpty],
        ];
    }

    public function messages()
    {
        return [
            "enfermedad_id.required" => "El campo enfermedad es obligatorio.",
            "enfermedad_id.unique" => "La enfermedad ya tiene una regla.",
            "descripcion.required" => "Debes completar este campo",
        ];
    }
}
