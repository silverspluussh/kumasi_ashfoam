<?php

namespace App\Http\Controllers;

use App\Models\Receipt;
use Illuminate\Http\Request;

class ReceiptController extends Controller
{
    public function index(Request $request)
    {
        $query = Receipt::query()->with('saleOrder');

        if ($request->has('receipt_number')) {
            $query->where('receipt_number', 'like', '%' . $request->receipt_number . '%');
        }

        return response()->json($query->paginate(15));
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'id' => 'required|uuid|unique:receipts,id',
            'sale_order_id' => 'required|exists:sale_orders,id',
            'receipt_number' => 'required|string|unique:receipts,receipt_number',
            'amount' => 'required|numeric',
            'payment_method' => 'required|string',
            'transaction_id' => 'nullable|string',
        ]);

        $receipt = Receipt::create($validated);
        return response()->json($receipt, 201);
    }

    public function show(Receipt $receipt)
    {
        return response()->json($receipt->load('saleOrder'));
    }

    public function update(Request $request, Receipt $receipt)
    {
        $validated = $request->validate([
            'amount' => 'sometimes|numeric',
            'payment_method' => 'sometimes|string',
        ]);

        $receipt->update($validated);
        return response()->json($receipt);
    }

    public function destroy(Receipt $receipt)
    {
        $receipt->delete();
        return response()->json(null, 204);
    }
}
