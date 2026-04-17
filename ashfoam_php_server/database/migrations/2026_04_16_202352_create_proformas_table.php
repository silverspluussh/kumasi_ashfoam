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
        Schema::create('proformas', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->string('proforma_number')->unique();
            $table->uuid('customer_id')->index()->nullable();
            $table->string('customer_name')->nullable();
            $table->string('customer_address')->nullable();
            $table->string('customer_phone')->nullable();
            $table->decimal('total_amount', 15, 2);
            $table->decimal('discount_amount', 15, 2)->default(0);
            $table->decimal('tax_amount', 15, 2)->default(0);
            $table->string('status');
            $table->timestamp('expiry_date')->nullable();
            $table->text('notes')->nullable();
            $table->string('created_by')->nullable();
            $table->boolean('is_deleted')->default(false);
            $table->timestamps();

            $table->foreign('customer_id')->references('id')->on('customers')->onDelete('set null');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('proformas');
    }
};
