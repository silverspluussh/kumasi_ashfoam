<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Model;

class Payment extends Model
{
    use HasUuids;

    protected $fillable = [
        'id',
        'order_id',
        'payment_method',
        'amount_paid',
        'reference',
        'status',
        'payment_date',
    ];

    protected $casts = [
        'amount_paid' => 'double',
        'payment_date' => 'datetime',
    ];

    public function saleOrder()
    {
        return $this->belongsTo(SaleOrder::class, 'order_id');
    }
}
