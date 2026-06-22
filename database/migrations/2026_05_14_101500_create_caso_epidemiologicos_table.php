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
            $table->string("departamento")->nullable();
            $table->string("municipio")->nullable();
            $table->unsignedBigInteger("centro_id");
            $table->unsignedBigInteger("comunidad_id");
            $table->string("red_salud")->nullable();
            $table->string("tipo")->nullable(); // PUBLICO,SEGURO,PRIVADO,OTRO
            $table->string("captado")->nullable(); // CASO CAPTADO EN BUSQUEDA ACTUAL, ATENCIÓN EN SERVICIO DE SALUD, OTRO
            $table->string("captado_desc")->nullable(); // DESC OTRO
            $table->unsignedBigInteger("user_id");
            $table->string("pais_lpi");
            $table->string("departamento_lpi");
            $table->string("municipio_lpi");
            $table->unsignedBigInteger("comunidad_id_lpi");
            $table->string("zona_lpi");
            $table->string("pais_lis");
            $table->string("departamento_lis");
            $table->string("municipio_lis");
            $table->unsignedBigInteger("comunidad_id_lis");
            $table->string("zona_lis");
            $table->integer("embarazada")->nullable();
            $table->string("fuma")->nullable();
            $table->date("fecha_parto")->nullable();
            $table->date("fi_sintomas");
            $table->date("fecha_diagnostico");
            $table->integer("semana")->nullable();
            $table->string("tipo_caso"); //SOSPECHOSO, PROBABLE, CONFIRMADO, DESCARTADO
            $table->string("gravedad"); // LEVE, MODERADO, GRAVE, CRITICO
            $table->string("estado"); // EN SEGUIMIENTO, ACTIVO, RECUPERADO, FALLECIDO, DESCARTADO
            $table->date("fecha_falle")->nullable();
            $table->integer("contacto"); // Nro. de contacto con otras personas
            $table->integer("hospitalizacion"); // requiere hospitlizacion SI/NO (1,0)
            $table->string("tipo_alta")->nullable(); // medica, solicitdad, fuga, defunción
            $table->date("fecha_hospitalizacion")->nullable();
            $table->string("establecimiento")->nullable();
            $table->integer("hospitalizacion_uti"); // requiere hospitlizacion SI/NO (1,0)
            $table->date("fecha_hospitalizacion_uti")->nullable();
            $table->string("establecimiento_uti")->nullable();
            $table->integer("laboratorio");
            $table->integer("nexo");
            $table->integer("muestra");
            $table->date("fecha_muestra")->nullable();
            $table->string("tipo_muestra", 255)->nullable();
            $table->integer("rt_pcr");
            $table->integer("igm");
            $table->integer("igm_nc");
            $table->integer("igg");
            $table->integer("igg_nc");
            $table->text("observacion_lab")->nullable();
            $table->date("fecha_registro");
            $table->text("observaciones")->nullable();
            $table->timestamps();

            $table->foreign("paciente_id")->on("pacientes")->references("id");
            $table->foreign("enfermedad_id")->on("enfermedads")->references("id");
            $table->foreign("centro_id")->on("centros")->references("id");
            $table->foreign("comunidad_id")->on("comunidads")->references("id");
            $table->foreign("comunidad_id_lpi")->on("comunidads")->references("id");
            $table->foreign("comunidad_id_lis")->on("comunidads")->references("id");
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
