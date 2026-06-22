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
        Schema::create('caso_sintomas', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("caso_epidemiologico_id");
            $table->unsignedBigInteger("enfermedad_sintoma_id");
            $table->string("valor");
            $table->timestamps();

            $table->foreign("caso_epidemiologico_id")->on("caso_epidemiologicos")->references("id");
            $table->foreign("enfermedad_sintoma_id")->on("enfermedad_sintomas")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('caso_sintomas');
    }
};
