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
        Schema::create('return_orders', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->string('return_number')->unique();
            $table->uuid('order_id')->index()->nullable();
            $table->string('customer_name')->nullable();
            $table->uuid('branch_id')->index()->nullable();
            $table->decimal('total_amount', 15, 2);
            $table->text('reason')->nullable();
            $table->string('status');
            $table->string('created_by')->nullable();
            $table->timestamps();

            $table->foreign('order_id')->references('id')->on('sale_orders')->onDelete('set null');
            $table->foreign('branch_id')->references('id')->on('branches')->onDelete('set null');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('return_orders');
    }
};
