<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Model;

class SaleOrderItem extends Model
{
    use HasUuids;

    protected $fillable = [
        'id',
        'product_id',
        'sale_order_id',
        'product_name',
        'quantity',
        'unit_price',
        'total_price',
        'discount_amount',
        'tax_amount',
        'is_synced',
        'last_synced_at',
    ];

    protected $casts = [
        'quantity' => 'integer',
        'unit_price' => 'double',
        'total_price' => 'double',
        'discount_amount' => 'double',
        'tax_amount' => 'double',
        'is_synced' => 'boolean',
        'last_synced_at' => 'datetime',
    ];

    public function saleOrder()
    {
        return $this->belongsTo(SaleOrder::class);
    }

    public function product()
    {
        return $this->belongsTo(Inventory::class, 'product_id');
    }
}
