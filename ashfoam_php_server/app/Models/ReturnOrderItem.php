<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Model;

class ReturnOrderItem extends Model
{
    use HasUuids;

    protected $fillable = [
        'id',
        'return_order_id',
        'product_id',
        'product_name',
        'quantity',
        'unit_price',
        'total_price',
    ];

    protected $casts = [
        'quantity' => 'integer',
        'unit_price' => 'double',
        'total_price' => 'double',
    ];

    public function returnOrder()
    {
        return $this->belongsTo(ReturnOrder::class);
    }

    public function product()
    {
        return $this->belongsTo(Inventory::class, 'product_id');
    }
}
