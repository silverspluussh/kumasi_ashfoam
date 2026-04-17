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
        Schema::create('branches', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('store_id')->index();
            $table->string('store_name');
            $table->string('branch_name');
            $table->string('branch_address')->nullable();
            $table->string('contact')->nullable();
            $table->boolean('is_active')->default(true);
            $table->string('branch_manager_name')->nullable();
            $table->string('branch_manager_id')->nullable();
            $table->boolean('is_deleted')->default(false);
            $table->json('company_details')->nullable();
            $table->timestamps();

            $table->foreign('store_id')->references('id')->on('stores')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('branches');
    }
};
