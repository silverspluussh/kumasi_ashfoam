<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Model;

class Customer extends Model
{
    use HasUuids;

    protected $fillable = [
        'id',
        'name',
        'customer_code',
        'address',
        'phone',
        'email',
        'customer_type',
        'is_active',
        'is_deleted',
    ];

    protected $casts = [
        'is_active' => 'boolean',
        'is_deleted' => 'boolean',
    ];
}
