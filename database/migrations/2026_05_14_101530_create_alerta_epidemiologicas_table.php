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
        Schema::create('alerta_epidemiologicas', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("comunidad_id");
            $table->unsignedBigInteger("enfermedad_id");
            $table->string("nivel_alerta");
            $table->integer("cantidad_casos");
            $table->date("fecha");
            $table->string("estado"); // ACTIVO, CONTROLADO
            $table->date("fecha_fin")->nullable();
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
        Schema::dropIfExists('alerta_epidemiologicas');
    }
};
