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
        Schema::create('comunidad_enfermedads', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("comunidad_id");
            $table->unsignedBigInteger("enfermedad_id");
            $table->integer("cantidad_casos");
            $table->string("nivel_riesgo"); //BAJO, MEDIO, ALTO, CRITICO
            $table->double("indice_riesgo", 8, 2); // calculado por ALGORITMO 0 a 1
            $table->date("fecha_evaluacion"); // se actualiza diariamente
            $table->string("estado");
            $table->timestamps();

            $table->foreign("comunidad_id")->on("comunidads")->references("id");
            $table->foreign("enfermedad_id")->on("enfermedads")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('comunidad_enfermedads');
    }
};
