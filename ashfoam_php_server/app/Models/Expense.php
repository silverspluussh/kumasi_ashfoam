<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Model;

class Expense extends Model
{
    use HasUuids;

    protected $fillable = [
        'id',
        'category_id',
        'amount',
        'description',
        'expense_date',
        'branch_id',
        'created_by',
    ];

    protected $casts = [
        'amount' => 'double',
        'expense_date' => 'datetime',
    ];

    public function category()
    {
        return $this->belongsTo(ExpenseCategory::class, 'category_id');
    }

    public function branch()
    {
        return $this->belongsTo(Branch::class);
    }
}
