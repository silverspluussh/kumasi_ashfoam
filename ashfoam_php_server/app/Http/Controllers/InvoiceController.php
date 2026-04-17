<?php

namespace App\Http\Controllers;

use App\Models\Invoice;
use Illuminate\Http\Request;

class InvoiceController extends Controller
{
    public function index(Request $request)
    {
        $query = Invoice::query()->with('saleOrder');

        if ($request->has('invoice_number')) {
            $query->where('invoice_number', 'like', '%' . $request->invoice_number . '%');
        }

        return response()->json($query->paginate(15));
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'id' => 'required|uuid|unique:invoices,id',
            'sale_order_id' => 'required|exists:sale_orders,id',
            'invoice_number' => 'required|string|unique:invoices,invoice_number',
            'status' => 'required|string',
            'due_date' => 'nullable|date',
        ]);

        $invoice = Invoice::create($validated);
        return response()->json($invoice, 201);
    }

    public function show(Invoice $invoice)
    {
        return response()->json($invoice->load('saleOrder'));
    }

    public function update(Request $request, Invoice $invoice)
    {
        $validated = $request->validate([
            'status' => 'sometimes|string',
            'due_date' => 'nullable|date',
        ]);

        $invoice->update($validated);
        return response()->json($invoice);
    }

    public function destroy(Invoice $invoice)
    {
        $invoice->delete();
        return response()->json(null, 204);
    }
}
