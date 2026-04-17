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
        Schema::create('inventories', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->string('name');
            $table->string('sku')->unique();
            $table->string('category')->nullable();
            $table->uuid('category_id')->index()->nullable();
            $table->string('sub_category')->nullable();
            $table->string('size')->nullable();
            $table->string('thickness')->nullable();
            $table->string('material')->nullable();
            $table->string('density')->nullable();
            $table->string('brand')->nullable();
            $table->uuid('brand_id')->index()->nullable();
            $table->string('supplier')->nullable();
            $table->uuid('supplier_id')->index()->nullable();
            $table->decimal('retail_price', 15, 2);
            $table->decimal('discount_price', 15, 2)->nullable();
            $table->decimal('discount_percentage', 5, 2)->nullable();
            $table->integer('quantity')->default(0);
            $table->string('unit')->nullable();
            $table->uuid('branch_id')->index()->nullable();
            $table->boolean('is_available')->default(true);
            $table->boolean('is_deleted')->default(false);
            $table->timestamps();

            $table->foreign('category_id')->references('id')->on('product_categories')->onDelete('set null');
            $table->foreign('brand_id')->references('id')->on('brands')->onDelete('set null');
            $table->foreign('supplier_id')->references('id')->on('suppliers')->onDelete('set null');
            $table->foreign('branch_id')->references('id')->on('branches')->onDelete('set null');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('inventories');
    }
};
