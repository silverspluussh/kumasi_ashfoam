<?php

namespace App\Http\Controllers;

use App\Models\Tax;
use Illuminate\Http\Request;

class TaxController extends Controller
{
    public function index()
    {
        return response()->json(Tax::paginate(15));
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'id' => 'required|uuid|unique:taxes,id',
            'name' => 'required|string|max:255',
            'percentage' => 'required|numeric',
        ]);

        $tax = Tax::create($validated);
        return response()->json($tax, 201);
    }

    public function show(Tax $tax)
    {
        return response()->json($tax);
    }

    public function update(Request $request, Tax $tax)
    {
        $validated = $request->validate([
            'name' => 'sometimes|string|max:255',
            'percentage' => 'sometimes|numeric',
        ]);

        $tax->update($validated);
        return response()->json($tax);
    }

    public function destroy(Tax $tax)
    {
        $tax->delete();
        return response()->json(null, 204);
    }
}
