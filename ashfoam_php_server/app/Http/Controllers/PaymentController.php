<?php

namespace App\Http\Controllers;

use App\Models\Payment;
use Illuminate\Http\Request;

class PaymentController extends Controller
{
    public function index(Request $request)
    {
        $query = Payment::query()->with('saleOrder');

        if ($request->has('branch_id')) {
            $query->where('branch_id', $request->branch_id);
        }

        return response()->json($query->paginate(15));
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'id' => 'required|uuid|unique:payments,id',
            'sale_order_id' => 'required|exists:sale_orders,id',
            'amount' => 'required|numeric',
            'payment_method' => 'required|string',
            'status' => 'required|string',
            'transaction_reference' => 'nullable|string',
        ]);

        $payment = Payment::create($validated);
        return response()->json($payment, 201);
    }

    public function show(Payment $payment)
    {
        return response()->json($payment->load('saleOrder'));
    }

    public function update(Request $request, Payment $payment)
    {
        $validated = $request->validate([
            'status' => 'sometimes|string',
            'transaction_reference' => 'nullable|string',
        ]);

        $payment->update($validated);
        return response()->json($payment);
    }

    public function destroy(Payment $payment)
    {
        $payment->delete();
        return response()->json(null, 204);
    }
}
