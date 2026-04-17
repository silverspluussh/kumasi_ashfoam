<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Model;

class SaleOrder extends Model
{
    use HasUuids;

    protected $fillable = [
        'id',
        'order_number',
        'customer_name',
        'channel',
        'branch_id',
        'branch_name',
        'total_amount',
        'discount_amount',
        'total_quantity',
        'tax_amount',
        'status',
        'is_synced',
        'last_synced_at',
        'created_by',
    ];

    protected $casts = [
        'total_amount' => 'double',
        'discount_amount' => 'double',
        'total_quantity' => 'integer',
        'tax_amount' => 'double',
        'is_synced' => 'boolean',
        'last_synced_at' => 'datetime',
    ];

    public function items()
    {
        return $this->hasMany(SaleOrderItem::class);
    }

    public function branch()
    {
        return $this->belongsTo(Branch::class);
    }
}
