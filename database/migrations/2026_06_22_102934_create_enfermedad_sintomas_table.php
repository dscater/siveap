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
        Schema::create('enfermedad_sintomas', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("enfermedad_id");
            $table->string("nombre");
            $table->string("tipo");
            $table->integer("input"); // 0:checkbox, 1:texto
            $table->timestamps();

            $table->foreign("enfermedad_id")->on("enfermedads")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('enfermedad_sintomas');
    }
};
