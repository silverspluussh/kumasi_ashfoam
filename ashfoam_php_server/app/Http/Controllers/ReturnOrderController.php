<?php

namespace App\Http\Controllers;

use App\Models\ReturnOrder;
use App\Models\ReturnOrderItem;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ReturnOrderController extends Controller
{
    public function index(Request $request)
    {
        $query = ReturnOrder::query()->with('items');

        if ($request->has('branch_id')) {
            $query->where('branch_id', $request->branch_id);
        }

        return response()->json($query->paginate(15));
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'id' => 'required|uuid|unique:return_orders,id',
            'order_number' => 'required|string|unique:return_orders,order_number',
            'sale_order_id' => 'nullable|exists:sale_orders,id',
            'reason' => 'required|string',
            'total_refund_amount' => 'required|numeric',
            'branch_id' => 'required|exists:branches,id',
            'status' => 'required|string',
            'items' => 'required|array|min:1',
            'items.*.product_id' => 'required|exists:inventories,id',
            'items.*.quantity' => 'required|integer|min:1',
            'items.*.refund_amount' => 'required|numeric',
        ]);

        return DB::transaction(function () use ($validated) {
            $returnOrder = ReturnOrder::create(array_diff_key($validated, ['items' => []]));

            foreach ($validated['items'] as $itemData) {
                $returnOrder->items()->create($itemData);
            }

            return response()->json($returnOrder->load('items'), 201);
        });
    }

    public function show(ReturnOrder $returnOrder)
    {
        return response()->json($returnOrder->load('items'));
    }

    public function update(Request $request, ReturnOrder $returnOrder)
    {
        $validated = $request->validate([
            'status' => 'sometimes|string',
        ]);

        $returnOrder->update($validated);
        return response()->json($returnOrder);
    }

    public function destroy(ReturnOrder $returnOrder)
    {
        $returnOrder->delete();
        return response()->json(null, 204);
    }
}
