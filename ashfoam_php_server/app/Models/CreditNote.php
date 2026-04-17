<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Model;

class CreditNote extends Model
{
    use HasUuids;

    protected $fillable = [
        'id',
        'credit_note_number',
        'invoice_id',
        'return_order_id',
        'customer_name',
        'branch_id',
        'branch_name',
        'total_items',
        'total_amount',
        'applied_amount',
        'status',
        'note',
        'created_by',
        'issued_at',
        'due_date',
        'is_synced',
        'last_synced_at',
    ];

    protected $casts = [
        'total_items' => 'integer',
        'total_amount' => 'double',
        'applied_amount' => 'double',
        'issued_at' => 'datetime',
        'due_date' => 'datetime',
        'is_synced' => 'boolean',
        'last_synced_at' => 'datetime',
    ];

    public function items()
    {
        return $this->hasMany(CreditNoteItem::class);
    }

    public function invoice()
    {
        return $this->belongsTo(Invoice::class);
    }

    public function returnOrder()
    {
        return $this->belongsTo(ReturnOrder::class);
    }

    public function branch()
    {
        return $this->belongsTo(Branch::class);
    }
}
