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
        Schema::create('return_order_items', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('return_order_id')->index();
            $table->uuid('product_id')->index()->nullable();
            $table->string('product_name');
            $table->integer('quantity');
            $table->decimal('unit_price', 15, 2);
            $table->decimal('total_price', 15, 2);
            $table->timestamps();

            $table->foreign('return_order_id')->references('id')->on('return_orders')->onDelete('cascade');
            $table->foreign('product_id')->references('id')->on('inventories')->onDelete('set null');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('return_order_items');
    }
};
