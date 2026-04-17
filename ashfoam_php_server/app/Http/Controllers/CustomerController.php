<?php

namespace App\Http\Controllers;

use App\Models\Customer;
use Illuminate\Http\Request;

class CustomerController extends Controller
{
    public function index(Request $request)
    {
        $query = Customer::query();

        if ($request->has('search')) {
            $search = $request->search;
            $query->where('name', 'like', "%$search%")
                  ->orWhere('phone', 'like', "%$search%")
                  ->orWhere('customer_code', 'like', "%$search%");
        }

        return response()->json($query->paginate(15));
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'id' => 'required|uuid|unique:customers,id',
            'name' => 'required|string|max:255',
            'customer_code' => 'required|string|unique:customers,customer_code',
            'phone' => 'nullable|string',
            'email' => 'nullable|email',
            'address' => 'nullable|string',
            'location' => 'nullable|string',
            'customer_type' => 'nullable|string',
        ]);

        $customer = Customer::create($validated);
        return response()->json($customer, 201);
    }

    public function show(Customer $customer)
    {
        return response()->json($customer);
    }

    public function update(Request $request, Customer $customer)
    {
        $validated = $request->validate([
            'name' => 'sometimes|string|max:255',
            'phone' => 'nullable|string',
            'email' => 'nullable|email',
            'address' => 'nullable|string',
        ]);

        $customer->update($validated);
        return response()->json($customer);
    }

    public function destroy(Customer $customer)
    {
        $customer->delete();
        return response()->json(null, 204);
    }
}
