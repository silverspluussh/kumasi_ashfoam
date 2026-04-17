<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Model;

class Receipt extends Model
{
    use HasUuids;

    protected $fillable = [
        'id',
        'receipt_number',
        'order_id',
        'branch_id',
        'branch_name',
        'total_amount',
        'customer_name',
        'bill_number',
        'tax',
        'items',
        'created_by',
    ];

    protected $casts = [
        'total_amount' => 'double',
        'tax' => 'array',
        'items' => 'array',
    ];

    public function saleOrder()
    {
        return $this->belongsTo(SaleOrder::class, 'order_id');
    }

    public function branch()
    {
        return $this->belongsTo(Branch::class);
    }
}
