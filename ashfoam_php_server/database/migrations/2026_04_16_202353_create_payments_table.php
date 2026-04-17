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
        Schema::create('payments', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('order_id')->index();
            $table->string('payment_method');
            $table->decimal('amount_paid', 15, 2);
            $table->string('reference')->nullable();
            $table->string('status');
            $table->timestamp('payment_date')->nullable();
            $table->timestamps();

            $table->foreign('order_id')->references('id')->on('sale_orders')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('payments');
    }
};
