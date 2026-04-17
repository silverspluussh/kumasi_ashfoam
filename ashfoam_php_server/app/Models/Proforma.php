<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Model;

class Proforma extends Model
{
    use HasUuids;

    protected $fillable = [
        'id',
        'proforma_number',
        'customer_id',
        'customer_name',
        'customer_address',
        'customer_phone',
        'total_amount',
        'discount_amount',
        'tax_amount',
        'status',
        'expiry_date',
        'notes',
        'created_by',
        'is_deleted',
    ];

    protected $casts = [
        'total_amount' => 'double',
        'discount_amount' => 'double',
        'tax_amount' => 'double',
        'expiry_date' => 'datetime',
        'is_deleted' => 'boolean',
    ];

    public function items()
    {
        return $this->hasMany(ProformaItem::class);
    }

    public function customer()
    {
        return $this->belongsTo(Customer::class);
    }
}
