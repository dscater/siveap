<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('caso_epidemiologicos', function (Blueprint $table) {
            $table->id();
            $table->string("codigo");
            $table->unsignedBigInteger("paciente_id");
            $table->unsignedBigInteger("enfermedad_id");
            $table->unsignedBigInteger("centro_id");
            $table->unsignedBigInteger("comunidad_id");
            $table->unsignedBigInteger("user_id");
            $table->date("fi_sintomas");
            $table->date("fecha_diagnostico");
            $table->string("tipo_caso"); //SOSPECHOSO, PROBABLE, CONFIRMADO, DESCARTADO
            $table->string("gravedad"); // LEVE, MODERADO, GRAVE, CRITICO
            $table->string("estado"); // EN SEGUIMIENTO, ACTIVO, RECUPERADO, FALLECIDO, DESCARTADO
            $table->integer("contacto"); // Nro. de contacto con otras personas
            $table->integer("hospitalizacion"); // requiere hospitlizacion SI/NO (1,0)
            $table->date("fecha_registro");
            $table->text("observaciones")->nullable();
            $table->timestamps();

            $table->foreign("paciente_id")->on("pacientes")->references("id");
            $table->foreign("enfermedad_id")->on("enfermedads")->references("id");
            $table->foreign("centro_id")->on("centros")->references("id");
            $table->foreign("comunidad_id")->on("comunidads")->references("id");
            $table->foreign("user_id")->on("users")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('caso_epidemiologicos');
    }
};
