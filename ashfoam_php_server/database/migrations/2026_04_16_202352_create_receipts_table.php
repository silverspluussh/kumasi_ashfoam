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
        Schema::create('receipts', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->string('receipt_number')->unique();
            $table->uuid('order_id')->index();
            $table->uuid('branch_id')->index();
            $table->string('branch_name')->nullable();
            $table->decimal('total_amount', 15, 2);
            $table->string('customer_name')->nullable();
            $table->string('bill_number')->nullable();
            $table->json('tax')->nullable();
            $table->json('items')->nullable();
            $table->string('created_by')->nullable();
            $table->timestamps();

            $table->foreign('order_id')->references('id')->on('sale_orders')->onDelete('cascade');
            $table->foreign('branch_id')->references('id')->on('branches')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('receipts');
    }
};
