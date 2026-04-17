<?php

namespace App\Http\Controllers;

use App\Models\SaleOrder;
use App\Models\SaleOrderItem;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class SaleOrderController extends Controller
{
    public function index(Request $request)
    {
        $query = SaleOrder::query()->with('items');

        if ($request->has('branch_id')) {
            $query->where('branch_id', $request->branch_id);
        }

        if ($request->has('status')) {
            $query->where('status', $request->status);
        }

        if ($request->has('start_date') && $request->has('end_date')) {
            $query->whereBetween('created_at', [$request->start_date, $request->end_date]);
        }

        return response()->json($query->paginate(15));
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'id' => 'required|uuid|unique:sale_orders,id',
            'order_number' => 'required|string|unique:sale_orders,order_number',
            'customer_name' => 'required|string',
            'channel' => 'required|string',
            'branch_id' => 'required|exists:branches,id',
            'branch_name' => 'required|string',
            'total_amount' => 'required|numeric',
            'discount_amount' => 'nullable|numeric',
            'total_quantity' => 'required|integer',
            'tax_amount' => 'nullable|numeric',
            'status' => 'required|string',
            'created_by' => 'nullable|string',
            'items' => 'required|array|min:1',
            'items.*.product_id' => 'required|exists:inventories,id',
            'items.*.product_name' => 'required|string',
            'items.*.quantity' => 'required|integer|min:1',
            'items.*.unit_price' => 'required|numeric',
            'items.*.total_price' => 'required|numeric',
        ]);

        return DB::transaction(function () use ($validated) {
            $order = SaleOrder::create(array_diff_key($validated, ['items' => []]));

            foreach ($validated['items'] as $itemData) {
                $order->items()->create($itemData);
            }

            return response()->json($order->load('items'), 201);
        });
    }

    /**
     * Bulk upload SaleOrders and their items.
     * Expects an array of orders.
     */
    public function bulkStore(Request $request)
    {
        $request->validate([
            'orders' => 'required|array|min:1',
            'orders.*.id' => 'required|uuid|unique:sale_orders,id',
            'orders.*.order_number' => 'required|string|unique:sale_orders,order_number',
            'orders.*.branch_id' => 'required|exists:branches,id',
            'orders.*.items' => 'required|array|min:1',
        ]);

        $ordersData = $request->orders;
        $results = [];

        DB::transaction(function () use ($ordersData, &$results) {
            foreach ($ordersData as $orderData) {
                $items = $orderData['items'];
                unset($orderData['items']);
                
                $order = SaleOrder::create($orderData);
                
                foreach ($items as $itemData) {
                    $order->items()->create($itemData);
                }
                
                $results[] = $order->id;
            }
        });

        return response()->json([
            'message' => count($results) . ' orders uploaded successfully',
            'order_ids' => $results
        ], 201);
    }

    public function show(SaleOrder $saleOrder)
    {
        return response()->json($saleOrder->load('items'));
    }

    public function update(Request $request, SaleOrder $saleOrder)
    {
        $validated = $request->validate([
            'status' => 'sometimes|string',
            'total_amount' => 'sometimes|numeric',
        ]);

        $saleOrder->update($validated);
        return response()->json($saleOrder);
    }

    public function destroy(SaleOrder $saleOrder)
    {
        $saleOrder->delete();
        return response()->json(null, 204);
    }
}
