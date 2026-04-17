<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Model;

class Tax extends Model
{
    use HasUuids;

    protected $fillable = ['id', 'name', 'value_percentage'];

    protected $casts = [
        'value_percentage' => 'double',
    ];
}
