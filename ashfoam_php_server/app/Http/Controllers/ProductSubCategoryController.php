<?php

namespace App\Http\Controllers;

use App\Models\ProductSubCategory;
use Illuminate\Http\Request;

class ProductSubCategoryController extends Controller
{
    public function index()
    {
        return response()->json(ProductSubCategory::paginate(15));
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'id' => 'required|uuid|unique:product_sub_categories,id',
            'category_id' => 'required|exists:product_categories,id',
            'name' => 'required|string|max:255',
        ]);

        $subCategory = ProductSubCategory::create($validated);
        return response()->json($subCategory, 201);
    }

    public function show(ProductSubCategory $productSubCategory)
    {
        return response()->json($productSubCategory->load('category'));
    }

    public function update(Request $request, ProductSubCategory $productSubCategory)
    {
        $validated = $request->validate([
            'category_id' => 'sometimes|exists:product_categories,id',
            'name' => 'sometimes|string|max:255',
        ]);

        $productSubCategory->update($validated);
        return response()->json($productSubCategory);
    }

    public function destroy(ProductSubCategory $productSubCategory)
    {
        $productSubCategory->delete();
        return response()->json(null, 204);
    }
}
