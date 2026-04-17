<?php

namespace App\Http\Controllers;

use App\Models\Inventory;
use Illuminate\Http\Request;

class InventoryController extends Controller
{
    public function index(Request $request)
    {
        $query = Inventory::query()->with(['category', 'subCategory', 'brand', 'supplier', 'branch']);

        if ($request->has('search')) {
            $search = $request->search;
            $query->where('product_name', 'like', "%$search%")
                  ->orWhere('sku', 'like', "%$search%")
                  ->orWhere('barcode', 'like', "%$search%");
        }

        if ($request->has('category_id')) {
            $query->where('category_id', $request->category_id);
        }

        if ($request->has('branch_id')) {
            $query->where('branch_id', $request->branch_id);
        }

        return response()->json($query->paginate(15));
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'id' => 'required|uuid|unique:inventories,id',
            'product_name' => 'required|string|max:255',
            'sku' => 'required|string|unique:inventories,sku',
            'category_id' => 'required|exists:product_categories,id',
            'sub_category_id' => 'nullable|exists:product_sub_categories,id',
            'brand_id' => 'nullable|exists:brands,id',
            'supplier_id' => 'nullable|exists:suppliers,id',
            'branch_id' => 'required|exists:branches,id',
            'price' => 'required|numeric',
            'quantity' => 'required|integer',
            'min_stock_level' => 'nullable|integer',
            'unit' => 'nullable|string',
        ]);

        $inventory = Inventory::create($validated);
        return response()->json($inventory, 201);
    }

    public function show(Inventory $inventory)
    {
        return response()->json($inventory->load(['category', 'subCategory', 'brand', 'supplier', 'branch', 'saleOrderItems']));
    }

    public function update(Request $request, Inventory $inventory)
    {
        $validated = $request->validate([
            'product_name' => 'sometimes|string|max:255',
            'price' => 'sometimes|numeric',
            'quantity' => 'sometimes|integer',
            'min_stock_level' => 'nullable|integer',
        ]);

        $inventory->update($validated);
        return response()->json($inventory);
    }

    public function destroy(Inventory $inventory)
    {
        $inventory->delete();
        return response()->json(null, 204);
    }
}
