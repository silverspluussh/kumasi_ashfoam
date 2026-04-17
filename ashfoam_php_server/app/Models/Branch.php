<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Model;

class Branch extends Model
{
    use HasUuids;

    protected $fillable = [
        'id',
        'store_id',
        'store_name',
        'branch_name',
        'branch_address',
        'contact',
        'is_active',
        'branch_manager_name',
        'branch_manager_id',
        'is_deleted',
        'company_details',
    ];

    protected $casts = [
        'is_active' => 'boolean',
        'is_deleted' => 'boolean',
        'company_details' => 'array',
    ];

    public function store()
    {
        return $this->belongsTo(Store::class);
    }
}
