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
        Schema::create('waybills', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->json('main_content')->nullable();
            $table->string('order_number');
            $table->string('dispatch_doc_number');
            $table->string('delivery_note')->nullable();
            $table->string('sender_name')->nullable();
            $table->string('destination')->nullable();
            $table->timestamp('dispatch_date')->nullable();
            $table->string('party_name')->nullable();
            $table->string('created_by')->nullable();
            $table->boolean('is_deleted')->default(false);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('waybills');
    }
};
