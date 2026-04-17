<?php

namespace App\Http\Controllers;

use App\Models\Branch;
use Illuminate\Http\Request;

class BranchController extends Controller
{
    public function index()
    {
        return response()->json(Branch::paginate(15));
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'id' => 'required|uuid|unique:branches,id',
            'store_id' => 'required|exists:stores,id',
            'store_name' => 'required|string',
            'branch_name' => 'required|string|max:255',
            'branch_address' => 'nullable|string',
            'contact' => 'nullable|string',
            'is_active' => 'boolean',
        ]);

        $branch = Branch::create($validated);
        return response()->json($branch, 201);
    }

    public function show(Branch $branch)
    {
        return response()->json($branch->load('store'));
    }

    public function update(Request $request, Branch $branch)
    {
        $validated = $request->validate([
            'branch_name' => 'sometimes|string|max:255',
            'branch_address' => 'nullable|string',
            'contact' => 'nullable|string',
            'is_active' => 'sometimes|boolean',
        ]);

        $branch->update($validated);
        return response()->json($branch);
    }

    public function destroy(Branch $branch)
    {
        $branch->delete();
        return response()->json(null, 204);
    }
}
