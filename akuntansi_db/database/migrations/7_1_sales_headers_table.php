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
        Schema::create('sales_headers', function (Blueprint $table) {
            $table->id();
            $table->dateTime("sales_date");
            $table->bigInteger("c_id");
            $table->bigInteger("gross_amount");
            $table->bigInteger("net_amount");
            $table->bigInteger("note");
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('sales_headers');
    }
};
