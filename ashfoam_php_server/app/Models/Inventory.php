<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Model;

class Inventory extends Model
{
    use HasUuids;

    protected $fillable = [
        'id',
        'name',
        'sku',
        'category',
        'category_id',
        'sub_category',
        'size',
        'thickness',
        'material',
        'density',
        'brand',
        'brand_id',
        'supplier',
        'supplier_id',
        'retail_price',
        'discount_price',
        'discount_percentage',
        'quantity',
        'unit',
        'branch_id',
        'is_available',
        'is_deleted',
    ];

    protected $casts = [
        'retail_price' => 'double',
        'discount_price' => 'double',
        'discount_percentage' => 'double',
        'quantity' => 'integer',
        'is_available' => 'boolean',
        'is_deleted' => 'boolean',
    ];

    public function category()
    {
        return $this->belongsTo(ProductCategory::class, 'category_id');
    }

    public function brand()
    {
        return $this->belongsTo(Brand::class, 'brand_id');
    }

    public function supplier()
    {
        return $this->belongsTo(Supplier::class, 'supplier_id');
    }

    public function branch()
    {
        return $this->belongsTo(Branch::class, 'branch_id');
    }
}
