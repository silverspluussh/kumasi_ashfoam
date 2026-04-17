<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\PersonnelController;
use App\Http\Controllers\StoreController;
use App\Http\Controllers\BranchController;
use App\Http\Controllers\SupplierController;
use App\Http\Controllers\TaxController;
use App\Http\Controllers\BrandController;
use App\Http\Controllers\ProductCategoryController;
use App\Http\Controllers\ProductSubCategoryController;
use App\Http\Controllers\CustomerController;
use App\Http\Controllers\InventoryController;
use App\Http\Controllers\StockTransferController;
use App\Http\Controllers\StockReportSummaryController;
use App\Http\Controllers\SaleOrderController;
use App\Http\Controllers\ProformaController;
use App\Http\Controllers\InvoiceController;
use App\Http\Controllers\WaybillController;
use App\Http\Controllers\ReceiptController;
use App\Http\Controllers\PaymentController;
use App\Http\Controllers\ExpenseCategoryController;
use App\Http\Controllers\ExpenseController;
use App\Http\Controllers\ReturnOrderController;
use App\Http\Controllers\CreditNoteController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

// Public Auth Routes
Route::post('/login', [AuthController::class, 'login']);
Route::post('/signup', [AuthController::class, 'signup']);

// Protected Routes
Route::middleware('auth:sanctum')->group(function () {
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::get('/me', [AuthController::class, 'me']);

    // Personnel & Internal Logic
    Route::middleware('role:IT admin,manager')->group(function () {
        Route::post('/personnel/register-employee', [PersonnelController::class, 'registerEmployee']);
        Route::post('/personnel/reset-password/{id}', [PersonnelController::class, 'resetEmployeePassword']);
        Route::post('/personnel/deactivate/{id}', [PersonnelController::class, 'deactivateEmployee']);
        Route::get('/personnel', [PersonnelController::class, 'listEmployees']);
        
        // Administrative Resources
        Route::apiResource('stores', StoreController::class);
        Route::apiResource('branches', BranchController::class);
        Route::apiResource('taxes', TaxController::class);
        Route::apiResource('expense-categories', ExpenseCategoryController::class);
    });

    // General Employee & Manager Resources
    Route::apiResource('suppliers', SupplierController::class);
    Route::apiResource('brands', BrandController::class);
    Route::apiResource('product-categories', ProductCategoryController::class);
    Route::apiResource('product-sub-categories', ProductSubCategoryController::class);
    Route::apiResource('customers', CustomerController::class);
    Route::apiResource('inventory', InventoryController::class);
    Route::apiResource('stock-transfers', StockTransferController::class);
    Route::post('stock-reports/generate', [StockReportSummaryController::class, 'generate']);
    Route::apiResource('stock-reports', StockReportSummaryController::class);
    
    // Sales & Transactions
    Route::post('sale-orders/bulk', [SaleOrderController::class, 'bulkStore']);
    Route::apiResource('sale-orders', SaleOrderController::class);
    Route::apiResource('proformas', ProformaController::class);
    Route::apiResource('invoices', InvoiceController::class);
    Route::apiResource('waybills', WaybillController::class);
    Route::apiResource('receipts', ReceiptController::class);
    Route::apiResource('payments', PaymentController::class);
    
    // Expenses
    Route::apiResource('expenses', ExpenseController::class);
    
    // Returns
    Route::apiResource('return-orders', ReturnOrderController::class);
    Route::apiResource('credit-notes', CreditNoteController::class);
});
