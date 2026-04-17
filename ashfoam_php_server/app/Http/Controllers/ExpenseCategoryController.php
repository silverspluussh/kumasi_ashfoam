<?php

namespace App\Http\Controllers;

use App\Models\ExpenseCategory;
use Illuminate\Http\Request;

class ExpenseCategoryController extends Controller
{
    public function index()
    {
        return response()->json(ExpenseCategory::paginate(15));
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'id' => 'required|uuid|unique:expense_categories,id',
            'name' => 'required|string|max:255',
            'description' => 'nullable|string',
        ]);

        $category = ExpenseCategory::create($validated);
        return response()->json($category, 201);
    }

    public function show(ExpenseCategory $expenseCategory)
    {
        return response()->json($expenseCategory->load('expenses'));
    }

    public function update(Request $request, ExpenseCategory $expenseCategory)
    {
        $validated = $request->validate([
            'name' => 'sometimes|string|max:255',
            'description' => 'nullable|string',
        ]);

        $expenseCategory->update($validated);
        return response()->json($expenseCategory);
    }

    public function destroy(ExpenseCategory $expenseCategory)
    {
        $expenseCategory->delete();
        return response()->json(null, 204);
    }
}
