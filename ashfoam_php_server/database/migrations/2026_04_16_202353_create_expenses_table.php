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
        Schema::create('expenses', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('category_id')->index()->nullable();
            $table->decimal('amount', 15, 2);
            $table->text('description')->nullable();
            $table->timestamp('expense_date')->nullable();
            $table->uuid('branch_id')->index()->nullable();
            $table->string('created_by')->nullable();
            $table->timestamps();

            $table->foreign('category_id')->references('id')->on('expense_categories')->onDelete('set null');
            $table->foreign('branch_id')->references('id')->on('branches')->onDelete('set null');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('expenses');
    }
};
