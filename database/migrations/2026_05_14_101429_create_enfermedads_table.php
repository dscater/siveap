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
        Schema::create('enfermedads', function (Blueprint $table) {
            $table->id();
            $table->string("nombre");
            $table->unsignedBigInteger("categoria_enfermedad_id");
            $table->unsignedBigInteger("tipo_transmision_id");
            $table->text("descripcion")->nullable();
            $table->timestamps();

            $table->foreign("categoria_enfermedad_id")->on("categoria_enfermedads")->references("id");
            $table->foreign("tipo_transmision_id")->on("tipo_transmisions")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('enfermedads');
    }
};
