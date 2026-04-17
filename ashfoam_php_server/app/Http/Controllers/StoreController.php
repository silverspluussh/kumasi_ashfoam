<?php

namespace App\Http\Controllers;

use App\Models\Store;
use Illuminate\Http\Request;

class StoreController extends Controller
{
    public function index()
    {
        return response()->json(Store::paginate(15));
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'id' => 'required|uuid|unique:stores,id',
            'store_name' => 'required|string|max:255',
            'is_active' => 'boolean',
        ]);

        $store = Store::create($validated);
        return response()->json($store, 201);
    }

    public function show(Store $store)
    {
        return response()->json($store->load('branches'));
    }

    public function update(Request $request, Store $store)
    {
        $validated = $request->validate([
            'store_name' => 'sometimes|string|max:255',
            'is_active' => 'sometimes|boolean',
        ]);

        $store->update($validated);
        return response()->json($store);
    }

    public function destroy(Store $store)
    {
        $store->delete();
        return response()->json(null, 204);
    }
}
