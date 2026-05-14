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
        Schema::create('seguimientos', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("caso_epidemiologico_id");
            $table->date("fecha");
            $table->string("estado"); //EN SEGUIMIENTO, ACTIVO, RECUPERADO, FALLECIDO, DESCARTADO
            $table->text("observaciones");
            $table->unsignedBigInteger("user_id");
            $table->timestamps();

            $table->foreign("caso_epidemiologico_id")->on("caso_epidemiologicos")->references("id");
            $table->foreign("user_id")->on("users")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('seguimientos');
    }
};
