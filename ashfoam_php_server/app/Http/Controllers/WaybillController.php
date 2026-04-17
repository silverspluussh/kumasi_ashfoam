<?php

namespace App\Http\Controllers;

use App\Models\Waybill;
use Illuminate\Http\Request;

class WaybillController extends Controller
{
    public function index(Request $request)
    {
        $query = Waybill::query()->with('saleOrder');

        if ($request->has('waybill_number')) {
            $query->where('waybill_number', 'like', '%' . $request->waybill_number . '%');
        }

        return response()->json($query->paginate(15));
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'id' => 'required|uuid|unique:waybills,id',
            'sale_order_id' => 'required|exists:sale_orders,id',
            'waybill_number' => 'required|string|unique:waybills,waybill_number',
            'status' => 'required|string',
            'delivery_address' => 'nullable|string',
            'delivery_contact' => 'nullable|string',
        ]);

        $waybill = Waybill::create($validated);
        return response()->json($waybill, 201);
    }

    public function show(Waybill $waybill)
    {
        return response()->json($waybill->load('saleOrder'));
    }

    public function update(Request $request, Waybill $waybill)
    {
        $validated = $request->validate([
            'status' => 'sometimes|string',
            'delivery_address' => 'nullable|string',
        ]);

        $waybill->update($validated);
        return response()->json($waybill);
    }

    public function destroy(Waybill $waybill)
    {
        $waybill->delete();
        return response()->json(null, 204);
    }
}
