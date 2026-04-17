<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Model;

class StockTransfer extends Model
{
    use HasUuids;

    protected $fillable = [
        'id',
        'from_id',
        'from_name',
        'to_id',
        'to_name',
        'status',
        'note',
        'created_by',
    ];

    protected $casts = [
        'status' => 'integer',
    ];

    public function items()
    {
        return $this->hasMany(StockTransferItem::class);
    }

    public function fromBranch()
    {
        return $this->belongsTo(Branch::class, 'from_id');
    }

    public function toBranch()
    {
        return $this->belongsTo(Branch::class, 'to_id');
    }
}
