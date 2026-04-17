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
        Schema::create('stock_transfers', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('from_id')->index();
            $table->string('from_name');
            $table->uuid('to_id')->index();
            $table->string('to_name');
            $table->integer('status');
            $table->text('note')->nullable();
            $table->string('created_by')->nullable();
            $table->timestamps();

            $table->foreign('from_id')->references('id')->on('branches')->onDelete('cascade');
            $table->foreign('to_id')->references('id')->on('branches')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('stock_transfers');
    }
};
