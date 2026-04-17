<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Model;

class StockTransferItem extends Model
{
    use HasUuids;

    protected $fillable = [
        'id',
        'stock_transfer_id',
        'product_id',
        'product_name',
        'quantity',
    ];

    protected $casts = [
        'quantity' => 'integer',
    ];

    public function stockTransfer()
    {
        return $this->belongsTo(StockTransfer::class);
    }

    public function product()
    {
        return $this->belongsTo(Inventory::class, 'product_id');
    }
}
