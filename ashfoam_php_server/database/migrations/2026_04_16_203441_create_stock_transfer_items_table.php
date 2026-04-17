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
        Schema::create('stock_transfer_items', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('stock_transfer_id')->index();
            $table->uuid('product_id')->index();
            $table->string('product_name');
            $table->integer('quantity');
            $table->timestamps();

            $table->foreign('stock_transfer_id')->references('id')->on('stock_transfers')->onDelete('cascade');
            $table->foreign('product_id')->references('id')->on('inventories')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('stock_transfer_items');
    }
};
