<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Model;

class ProductSubCategory extends Model
{
    use HasUuids;

    protected $fillable = ['id', 'category_id', 'name'];

    public function category()
    {
        return $this->belongsTo(ProductCategory::class, 'category_id');
    }
}
