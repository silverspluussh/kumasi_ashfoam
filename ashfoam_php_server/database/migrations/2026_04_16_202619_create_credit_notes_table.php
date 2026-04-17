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
        Schema::create('credit_notes', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->string('credit_note_number')->unique();
            $table->uuid('invoice_id')->index()->nullable();
            $table->uuid('return_order_id')->index()->nullable();
            $table->string('customer_name')->nullable();
            $table->uuid('branch_id')->index()->nullable();
            $table->string('branch_name')->nullable();
            $table->integer('total_items')->default(0);
            $table->decimal('total_amount', 15, 2);
            $table->decimal('applied_amount', 15, 2)->default(0);
            $table->string('status');
            $table->text('note')->nullable();
            $table->string('created_by')->nullable();
            $table->timestamp('issued_at')->nullable();
            $table->timestamp('due_date')->nullable();
            $table->boolean('is_synced')->default(false);
            $table->timestamp('last_synced_at')->nullable();
            $table->timestamps();

            $table->foreign('invoice_id')->references('id')->on('invoices')->onDelete('set null');
            $table->foreign('return_order_id')->references('id')->on('return_orders')->onDelete('set null');
            $table->foreign('branch_id')->references('id')->on('branches')->onDelete('set null');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('credit_notes');
    }
};
