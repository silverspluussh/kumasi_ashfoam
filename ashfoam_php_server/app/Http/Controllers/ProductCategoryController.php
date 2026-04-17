<?php

namespace App\Http\Controllers;

use App\Models\ProductCategory;
use Illuminate\Http\Request;

class ProductCategoryController extends Controller
{
    public function index()
    {
        return response()->json(ProductCategory::paginate(15));
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'id' => 'required|uuid|unique:product_categories,id',
            'name' => 'required|string|max:255',
        ]);

        $category = ProductCategory::create($validated);
        return response()->json($category, 201);
    }

    public function show(ProductCategory $productCategory)
    {
        return response()->json($productCategory->load('subCategories'));
    }

    public function update(Request $request, ProductCategory $productCategory)
    {
        $validated = $request->validate([
            'name' => 'sometimes|string|max:255',
        ]);

        $productCategory->update($validated);
        return response()->json($productCategory);
    }

    public function destroy(ProductCategory $productCategory)
    {
        $productCategory->delete();
        return response()->json(null, 204);
    }
}
