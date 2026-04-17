<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Model;

class StockReportSummary extends Model
{
    use HasUuids;

    protected $fillable = [
        'id',
        'branch_id',
        'branch_name',
        'created_by',
        'current_stock',
        'category_stock',
    ];

    protected $casts = [
        'current_stock' => 'array',
        'category_stock' => 'array',
    ];

    public function branch()
    {
        return $this->belongsTo(Branch::class);
    }
}
