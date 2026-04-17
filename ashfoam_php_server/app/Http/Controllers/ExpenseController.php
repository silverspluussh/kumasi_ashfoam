<?php

namespace App\Http\Controllers;

use App\Models\Expense;
use Illuminate\Http\Request;

class ExpenseController extends Controller
{
    public function index(Request $request)
    {
        $query = Expense::query()->with(['category', 'branch']);

        if ($request->has('branch_id')) {
            $query->where('branch_id', $request->branch_id);
        }

        if ($request->has('category_id')) {
            $query->where('category_id', $request->category_id);
        }

        return response()->json($query->paginate(15));
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'id' => 'required|uuid|unique:expenses,id',
            'expense_category_id' => 'required|exists:expense_categories,id',
            'amount' => 'required|numeric',
            'expense_date' => 'required|date',
            'description' => 'required|string',
            'branch_id' => 'required|exists:branches,id',
            'recorded_by' => 'nullable|string',
        ]);

        $expense = Expense::create($validated);
        return response()->json($expense, 201);
    }

    public function show(Expense $expense)
    {
        return response()->json($expense->load(['category', 'branch']));
    }

    public function update(Request $request, Expense $expense)
    {
        $validated = $request->validate([
            'amount' => 'sometimes|numeric',
            'description' => 'sometimes|string',
            'expense_date' => 'sometimes|date',
        ]);

        $expense->update($validated);
        return response()->json($expense);
    }

    public function destroy(Expense $expense)
    {
        $expense->delete();
        return response()->json(null, 204);
    }
}
