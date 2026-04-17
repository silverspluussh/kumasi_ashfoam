<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Model;

class CreditNoteItem extends Model
{
    use HasUuids;

    protected $fillable = [
        'id',
        'credit_note_id',
        'product_id',
        'description',
        'quantity',
        'unit_price',
        'total_price',
        'tax_amount',
        'is_synced',
        'last_synced_at',
    ];

    protected $casts = [
        'quantity' => 'integer',
        'unit_price' => 'double',
        'total_price' => 'double',
        'tax_amount' => 'double',
        'is_synced' => 'boolean',
        'last_synced_at' => 'datetime',
    ];

    public function creditNote()
    {
        return $this->belongsTo(CreditNote::class);
    }

    public function product()
    {
        return $this->belongsTo(Inventory::class, 'product_id');
    }
}
