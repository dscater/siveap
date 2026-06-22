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
        Schema::create('pacientes', function (Blueprint $table) {
            $table->id();
            $table->string("nombre");
            $table->string("paterno");
            $table->string("materno");
            $table->string("sexo");
            $table->string("ci");
            $table->string("ci_exp");
            $table->date("fecha_nac");
            $table->string("dir");
            $table->string("latitud");
            $table->string("longitud");
            $table->string("fono")->nullable();
            $table->string("ocupacion")->nullable();
            $table->string("departamento")->nullable();
            $table->string("municipio")->nullable();
            $table->string("zona")->nullable();
            $table->string("apoderado")->nullable();
            $table->unsignedBigInteger("comunidad_id");
            $table->date("fecha_registro")->nullable();
            $table->timestamps();

            $table->foreign("comunidad_id")->on("comunidads")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('pacientes');
    }
};
