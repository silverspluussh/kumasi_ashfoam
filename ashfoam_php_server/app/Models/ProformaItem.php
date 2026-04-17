<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Model;

class ProformaItem extends Model
{
    use HasUuids;

    protected $fillable = [
        'id',
        'proforma_id',
        'product_id',
        'product_name',
        'quantity',
        'unit_price',
        'total_price',
        'discount_amount',
        'tax_amount',
    ];

    protected $casts = [
        'quantity' => 'integer',
        'unit_price' => 'double',
        'total_price' => 'double',
        'discount_amount' => 'double',
        'tax_amount' => 'double',
    ];

    public function proforma()
    {
        return $this->belongsTo(Proforma::class);
    }

    public function product()
    {
        return $this->belongsTo(Inventory::class, 'product_id');
    }
}
