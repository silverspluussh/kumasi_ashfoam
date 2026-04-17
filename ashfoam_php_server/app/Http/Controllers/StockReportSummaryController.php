<?php

namespace App\Http\Controllers;

use App\Models\StockReportSummary;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class StockReportSummaryController extends Controller
{
    public function index(Request $request)
    {
        $query = StockReportSummary::query()->with('branch');

        if ($request->has('branch_id')) {
            $query->where('branch_id', $request->branch_id);
        }

        if ($request->has('report_date')) {
            $query->whereDate('report_date', $request->report_date);
        }

        return response()->json($query->paginate(15));
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'id' => 'required|uuid|unique:stock_report_summaries,id',
            'branch_id' => 'required|exists:branches,id',
            'branch_name' => 'required|string',
            'total_items' => 'required|integer',
            'total_value' => 'required|numeric',
            'report_date' => 'required|date',
            'generated_by' => 'nullable|string',
        ]);

        $report = StockReportSummary::create($validated);
        return response()->json($report, 201);
    }

    public function show(StockReportSummary $stockReportSummary)
    {
        return response()->json($stockReportSummary->load('branch'));
    }

    public function update(Request $request, StockReportSummary $stockReportSummary)
    {
        // Reports are typically read-only, but providing update for metadata
        $validated = $request->validate([
            'report_date' => 'sometimes|date',
        ]);

        $stockReportSummary->update($validated);
        return response()->json($stockReportSummary);
    }

    public function destroy(StockReportSummary $stockReportSummary)
    {
        $stockReportSummary->delete();
        return response()->json(null, 204);
    }

    /**
     * Generate a new monthly stock report using the stored procedure.
     */
    public function generate(Request $request)
    {
        $validated = $request->validate([
            'branch_id' => 'required|exists:branches,id',
            'month' => 'required|integer|between:1,12',
            'year' => 'required|integer|min:2000',
        ]);

        $createdBy = $request->user()?->name ?? 'System';

        // Call the stored procedure
        $results = DB::select("CALL GenerateMonthlyStockReport(?, ?, ?, ?)", [
            $validated['branch_id'],
            $validated['month'],
            $validated['year'],
            $createdBy
        ]);

        if (empty($results)) {
            return response()->json(['message' => 'Failed to generate report'], 500);
        }

        $reportId = $results[0]->report_id;
        $report = StockReportSummary::find($reportId);

        return response()->json($report, 201);
    }
}
