<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Model;

class ProductCategory extends Model
{
    use HasUuids;

    protected $fillable = ['id', 'name'];

    public function subCategories()
    {
        return $this->hasMany(ProductSubCategory::class, 'category_id');
    }
}
