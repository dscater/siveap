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
        Schema::create('reglas_alertas', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("enfermedad_id");
            $table->double("umbral", 8, 2); // NUMERO DE CASOS ACTIVOS CONFIRMADOS
            $table->string("riesgo"); // BAJO, MEDIO, ALTO, CRITICO
            $table->integer("status")->default(1); // 0,1 INACTIVO, ACTIVO
            $table->timestamps();

            $table->foreign("enfermedad_id")->on("enfermedads")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('reglas_alertas');
    }
};
