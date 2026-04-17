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
        Schema::create('sale_orders', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->string('order_number')->unique();
            $table->string('customer_name')->nullable();
            $table->string('channel')->nullable();
            $table->uuid('branch_id')->index()->nullable();
            $table->string('branch_name')->nullable();
            $table->decimal('total_amount', 15, 2);
            $table->decimal('discount_amount', 15, 2)->default(0);
            $table->integer('total_quantity')->default(0);
            $table->decimal('tax_amount', 15, 2)->default(0);
            $table->string('status');
            $table->boolean('is_synced')->default(false);
            $table->timestamp('last_synced_at')->nullable();
            $table->string('created_by')->nullable();
            $table->timestamps();

            $table->foreign('branch_id')->references('id')->on('branches')->onDelete('set null');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('sale_orders');
    }
};
