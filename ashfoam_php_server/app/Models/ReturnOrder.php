<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Model;

class ReturnOrder extends Model
{
    use HasUuids;

    protected $fillable = [
        'id',
        'return_number',
        'order_id',
        'customer_name',
        'branch_id',
        'total_amount',
        'reason',
        'status',
        'created_by',
    ];

    protected $casts = [
        'total_amount' => 'double',
    ];

    public function items()
    {
        return $this->hasMany(ReturnOrderItem::class);
    }

    public function saleOrder()
    {
        return $this->belongsTo(SaleOrder::class, 'order_id');
    }

    public function branch()
    {
        return $this->belongsTo(Branch::class);
    }
}
