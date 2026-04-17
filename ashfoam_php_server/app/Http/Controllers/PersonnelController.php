<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rules\Password;

class PersonnelController extends Controller
{
    public function registerEmployee(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'phone' => 'required|string|unique:users,phone',
            'location' => 'required|string',
            'role' => 'required|string|in:IT admin,manager,general_employee',
            'username' => 'nullable|string|unique:users,username',
            'branch_id' => 'nullable|exists:branches,id',
            'password' => 'required|string|min:6',
        ]);

        $user = User::create([
            'name' => $request->name,
            'phone' => $request->phone,
            'location' => $request->location,
            'role' => $request->role,
            'username' => $request->username,
            'branch_id' => $request->branch_id,
            'password' => Hash::make($request->password),
            'is_active' => true,
        ]);

        return response()->json([
            'message' => 'Employee registered successfully',
            'user' => $user,
        ], 201);
    }

    public function resetEmployeePassword(Request $request, $id)
    {
        $request->validate([
            'password' => ['required', 'string', 'min:6'],
        ]);

        $user = User::findOrFail($id);
        $user->password = Hash::make($request->password);
        $user->save();

        return response()->json([
            'message' => 'Password reset successfully',
        ]);
    }

    public function deactivateEmployee(Request $request, $id)
    {
        $user = User::findOrFail($id);
        $user->is_active = false;
        $user->save();

        return response()->json([
            'message' => 'Employee deactivated successfully',
        ]);
    }

    public function listEmployees(Request $request)
    {
        $employees = User::where('role', 'general_employee')
            ->orWhere('role', 'manager')
            ->get();
            
        return response()->json($employees);
    }
}
