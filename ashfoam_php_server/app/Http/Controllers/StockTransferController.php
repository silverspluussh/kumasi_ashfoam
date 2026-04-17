<?php

namespace App\Http\Controllers;

use App\Models\StockTransfer;
use App\Models\StockTransferItem;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class StockTransferController extends Controller
{
    public function index(Request $request)
    {
        $query = StockTransfer::query()->with(['fromBranch', 'toBranch', 'items']);

        if ($request->has('branch_id')) {
            $query->where('from_id', $request->branch_id)
                  ->orWhere('to_id', $request->branch_id);
        }

        if ($request->has('status')) {
            $query->where('status', $request->status);
        }

        return response()->json($query->paginate(15));
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'id' => 'required|uuid|unique:stock_transfers,id',
            'from_id' => 'required|exists:branches,id',
            'from_name' => 'required|string',
            'to_id' => 'required|exists:branches,id',
            'to_name' => 'required|string',
            'status' => 'required|integer',
            'note' => 'nullable|string',
            'created_by' => 'nullable|string',
            'items' => 'required|array|min:1',
            'items.*.product_id' => 'required|exists:inventories,id',
            'items.*.product_name' => 'required|string',
            'items.*.quantity' => 'required|integer|min:1',
        ]);

        return DB::transaction(function () use ($validated) {
            $transfer = StockTransfer::create(array_diff_key($validated, ['items' => []]));

            foreach ($validated['items'] as $itemData) {
                $transfer->items()->create($itemData);
            }

            return response()->json($transfer->load('items'), 201);
        });
    }

    public function show(StockTransfer $stockTransfer)
    {
        return response()->json($stockTransfer->load(['fromBranch', 'toBranch', 'items']));
    }

    public function update(Request $request, StockTransfer $stockTransfer)
    {
        $validated = $request->validate([
            'status' => 'sometimes|integer',
            'note' => 'nullable|string',
        ]);

        $stockTransfer->update($validated);
        return response()->json($stockTransfer);
    }

    public function destroy(StockTransfer $stockTransfer)
    {
        $stockTransfer->delete();
        return response()->json(null, 204);
    }
}
