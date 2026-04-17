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
        Schema::create('sale_order_items', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('product_id')->index()->nullable();
            $table->uuid('sale_order_id')->index();
            $table->string('product_name');
            $table->integer('quantity');
            $table->decimal('unit_price', 15, 2);
            $table->decimal('total_price', 15, 2);
            $table->decimal('discount_amount', 15, 2)->default(0);
            $table->decimal('tax_amount', 15, 2)->default(0);
            $table->boolean('is_synced')->default(false);
            $table->timestamp('last_synced_at')->nullable();
            $table->timestamps();

            $table->foreign('product_id')->references('id')->on('inventories')->onDelete('set null');
            $table->foreign('sale_order_id')->references('id')->on('sale_orders')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('sale_order_items');
    }
};
