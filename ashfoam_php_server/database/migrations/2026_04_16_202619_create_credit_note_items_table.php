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
        Schema::create('credit_note_items', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('credit_note_id')->index();
            $table->uuid('product_id')->index()->nullable();
            $table->string('description')->nullable();
            $table->integer('quantity');
            $table->decimal('unit_price', 15, 2);
            $table->decimal('total_price', 15, 2);
            $table->decimal('tax_amount', 15, 2)->default(0);
            $table->boolean('is_synced')->default(false);
            $table->timestamp('last_synced_at')->nullable();
            $table->timestamps();

            $table->foreign('credit_note_id')->references('id')->on('credit_notes')->onDelete('cascade');
            $table->foreign('product_id')->references('id')->on('inventories')->onDelete('set null');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('credit_note_items');
    }
};
