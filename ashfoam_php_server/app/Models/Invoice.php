<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Model;

class Invoice extends Model
{
    use HasUuids;

    protected $fillable = [
        'id',
        'invoice_num',
        'order_id',
        'total_amount',
        'status',
    ];

    protected $casts = [
        'total_amount' => 'double',
    ];

    public function saleOrder()
    {
        return $this->belongsTo(SaleOrder::class, 'order_id');
    }
}
