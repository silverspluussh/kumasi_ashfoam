<?php

namespace App\Http\Controllers;

use App\Models\CreditNote;
use App\Models\CreditNoteItem;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class CreditNoteController extends Controller
{
    public function index(Request $request)
    {
        $query = CreditNote::query()->with('items');

        if ($request->has('customer_name')) {
            $query->where('customer_name', 'like', '%' . $request->customer_name . '%');
        }

        return response()->json($query->paginate(15));
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'id' => 'required|uuid|unique:credit_notes,id',
            'credit_note_number' => 'required|string|unique:credit_notes,credit_note_number',
            'customer_name' => 'required|string',
            'sale_order_id' => 'nullable|exists:sale_orders,id',
            'reason' => 'required|string',
            'total_amount' => 'required|numeric',
            'status' => 'required|string',
            'items' => 'required|array|min:1',
            'items.*.product_id' => 'required|exists:inventories,id',
            'items.*.product_name' => 'required|string',
            'items.*.quantity' => 'required|integer|min:1',
            'items.*.unit_price' => 'required|numeric',
            'items.*.total_price' => 'required|numeric',
        ]);

        return DB::transaction(function () use ($validated) {
            $creditNote = CreditNote::create(array_diff_key($validated, ['items' => []]));

            foreach ($validated['items'] as $itemData) {
                $creditNote->items()->create($itemData);
            }

            return response()->json($creditNote->load('items'), 201);
        });
    }

    public function show(CreditNote $creditNote)
    {
        return response()->json($creditNote->load(['items', 'saleOrder']));
    }

    public function update(Request $request, CreditNote $creditNote)
    {
        $validated = $request->validate([
            'status' => 'sometimes|string',
        ]);

        $creditNote->update($validated);
        return response()->json($creditNote);
    }

    public function destroy(CreditNote $creditNote)
    {
        $creditNote->delete();
        return response()->json(null, 204);
    }
}
