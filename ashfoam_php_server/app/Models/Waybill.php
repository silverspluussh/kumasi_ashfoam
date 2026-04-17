<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Model;

class Waybill extends Model
{
    use HasUuids;

    protected $fillable = [
        'id',
        'main_content',
        'order_number',
        'dispatch_doc_number',
        'delivery_note',
        'sender_name',
        'destination',
        'dispatch_date',
        'party_name',
        'created_by',
        'is_deleted',
    ];

    protected $casts = [
        'main_content' => 'array',
        'dispatch_date' => 'datetime',
        'is_deleted' => 'boolean',
    ];
}
