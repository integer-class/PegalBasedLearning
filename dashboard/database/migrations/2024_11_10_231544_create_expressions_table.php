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
        Schema::create('expressions', function (Blueprint $table) {
            $table->id();
            $table->foreignId('interviewee_id')->nullable()->constrained('interviewees')->cascadeOnDelete();
            $table->integer('sad');
            $table->integer('disgust');
            $table->integer('surprise');
            $table->integer('angry');
            $table->integer('fear');
            $table->integer('happy');
            $table->integer('neutral');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('expressions');
    }
};
