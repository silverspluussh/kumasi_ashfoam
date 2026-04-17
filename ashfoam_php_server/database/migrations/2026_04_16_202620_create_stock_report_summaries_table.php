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
        Schema::create('stock_report_summaries', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('branch_id')->index();
            $table->string('branch_name')->nullable();
            $table->string('created_by')->nullable();
            $table->json('current_stock')->nullable();
            $table->json('category_stock')->nullable();
            $table->timestamps();

            $table->foreign('branch_id')->references('id')->on('branches')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('stock_report_summaries');
    }
};
