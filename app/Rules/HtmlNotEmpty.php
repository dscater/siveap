<?php

namespace App\Rules;

use Closure;
use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Translation\PotentiallyTranslatedString;

class HtmlNotEmpty implements ValidationRule
{
    /**
     * Run the validation rule.
     *
     * @param  Closure(string, ?string=): PotentiallyTranslatedString  $fail
     */
    public function validate(string $attribute, mixed $value, Closure $fail): void
    {
        $textoPlano = trim(html_entity_decode(strip_tags($value)));
        if ($textoPlano === '') {
            $fail('Debes completar este campo');
        }
    }
}
