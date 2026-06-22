<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Foundation\Http\FormRequest;

class CasoEpidemiologicoStoreRequest extends FormRequest
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
            "fecha_diagnostico" => "required|date",
            "departamento" => "required",
            "municipio" => "required",
            "red_salud" => "required",
            "paciente_id" => "required",
            "enfermedad_id" => "required",
            "centro_id" => "required",
            "comunidad_id" => "required",
            "tipo" => "required",
            "captado" => "required",
            "captado_desc" => "nullable",
            "pais_lpi" => "required",
            "departamento_lpi" => "required",
            "municipio_lpi" => "required",
            "comunidad_id_lpi" => "required",
            "zona_lpi" => "required",
            "pais_lis" => "required",
            "departamento_lis" => "required",
            "municipio_lis" => "required",
            "comunidad_id_lis" => "required",
            "zona_lis" => "required",
            "embarazada" => "nullable",
            "fuma" => "nullable",
            "fecha_parto" => "nullable",
            "fi_sintomas" => "required|date",
            "tipo_caso" => "required",
            "semana" => "required",
            "fecha_falle" => "nullable",
            "gravedad" => "required",
            "estado" => "required",
            "contacto" => "required",
            "hospitalizacion" => "required",
            "tipo_alta" => "nullable",
            "fecha_hospitalizacion" => "nullable",
            "establecimiento" => "nullable",
            "hospitalizacion_uti" => "nullable",
            "fecha_hospitalizacion_uti" => "nullable",
            "establecimiento_uti" => "nullable",
            "laboratorio" => "nullable",
            "nexo" => "nullable",
            "muestra" => "nullable",
            "fecha_muestra" => "nullable",
            "tipo_muestra" => "nullable",
            "rt_pcr" => "nullable",
            "igm" => "nullable",
            "igm_nc" => "nullable",
            "igg" => "nullable",
            "igg_nc" => "nullable",
            "observacion_lab" => "nullable",
            "observaciones" => "nullable",
            "caso_sintomas" => "array",
        ];
    }

    public function messages()
    {
        return [
            "paciente_id.required" => "Debes completar este campo",
            "enfermedad_id.required" => "Debes completar este campo",
            "departamento.required" => "Debes completar este campo",
            "municipio.required" => "Debes completar este campo",
            "red_salud.required" => "Debes completar este campo",
            "centro_id.required" => "Debes completar este campo",
            "comunidad_id.required" => "Debes completar este campo",
            "zona.required" => "Debes completar este campo",
            "tipo.required" => "Debes completar este campo",
            "captado.required" => "Debes completar este campo",
            "pais_lpi.required" => "Debes completar este campo",
            "departamento_lpi.required" => "Debes completar este campo",
            "comunidad_id_lpi.required" => "Debes completar este campo",
            "zona_lpi.required" => "Debes completar este campo",
            "pais_lis.required" => "Debes completar este campo",
            "departamento_lis.required" => "Debes completar este campo",
            "municipio_lis.required" => "Debes completar este campo",
            "comunidad_id_lis.required" => "Debes completar este campo",
            "zona_lis.required" => "Debes completar este campo",
            "semana.required" => "Debes completar este campo",
            "tipo_alta.required" => "Debes completar este campo",
            "fi_sintomas.required" => "Debes completar este campo",
            "fi_sintomas.date" => "Debes ingresar una fecha valida",
            "fecha_diagnostico.required" => "Debes completar este campo",
            "fecha_diagnostico.date" => "Debes ingresar una fecha valida",
            "tipo_caso.required" => "Debes completar este campo",
            "gravedad.required" => "Debes completar este campo",
            "estado.required" => "Debes completar este campo",
            "contacto.required" => "Debes completar este campo",
            "hospitalizacion.required" => "Debes completar este campo",
            "observaciones.required" => "Debes completar este campo",
        ];
    }
}
