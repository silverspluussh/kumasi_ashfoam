<?php

namespace App\Http\Controllers;

use App\Models\Proforma;
use App\Models\ProformaItem;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ProformaController extends Controller
{
    public function index(Request $request)
    {
        $query = Proforma::query()->with('items');

        if ($request->has('customer_name')) {
            $query->where('customer_name', 'like', '%' . $request->customer_name . '%');
        }

        return response()->json($query->paginate(15));
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'id' => 'required|uuid|unique:proformas,id',
            'proforma_number' => 'required|string|unique:proformas,proforma_number',
            'customer_name' => 'required|string',
            'branch_id' => 'required|exists:branches,id',
            'total_amount' => 'required|numeric',
            'status' => 'required|string',
            'valid_until' => 'nullable|date',
            'items' => 'required|array|min:1',
            'items.*.product_id' => 'required|exists:inventories,id',
            'items.*.product_name' => 'required|string',
            'items.*.quantity' => 'required|integer|min:1',
            'items.*.unit_price' => 'required|numeric',
            'items.*.total_price' => 'required|numeric',
        ]);

        return DB::transaction(function () use ($validated) {
            $proforma = Proforma::create(array_diff_key($validated, ['items' => []]));

            foreach ($validated['items'] as $itemData) {
                $proforma->items()->create($itemData);
            }

            return response()->json($proforma->load('items'), 201);
        });
    }

    public function show(Proforma $proforma)
    {
        return response()->json($proforma->load('items'));
    }

    public function update(Request $request, Proforma $proforma)
    {
        $validated = $request->validate([
            'status' => 'sometimes|string',
            'valid_until' => 'nullable|date',
        ]);

        $proforma->update($validated);
        return response()->json($proforma);
    }

    public function destroy(Proforma $proforma)
    {
        $proforma->delete();
        return response()->json(null, 204);
    }
}
