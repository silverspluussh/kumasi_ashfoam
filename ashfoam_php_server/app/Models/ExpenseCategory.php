<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Model;

class ExpenseCategory extends Model
{
    use HasUuids;

    protected $fillable = ['id', 'name', 'description'];

    public function expenses()
    {
        return $this->hasMany(Expense::class, 'category_id');
    }
}
