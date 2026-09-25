"use client";

import { useCallback, useEffect, useMemo, useState } from "react";
import {
  Calendar,
  CheckCircle2,
  Clock,
  Download,
  Pencil,
  Plus,
  RefreshCw,
  Search,
  Tag,
  Trash2,
  TrendingDown,
} from "lucide-react";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { ConfirmDialog } from "@/components/confirm-dialog";
import { DataTable } from "@/components/data-table";
import { Input } from "@/components/ui/input";
import { formatPaymentDate } from "@/lib/dates";
import { db } from "@/lib/db/dexie";
import { useDataVersion } from "@/lib/db/data-bus";
import type { ExpenseRow, Synced } from "@/lib/db/types";
import { downloadExpensesExport } from "@/lib/excel/excel";
import { createClient } from "@/lib/supabase/browser";
import { useOnline } from "@/lib/sync/connectivity";
import { remoteFirst } from "@/lib/sync/remote-first";
import { ghs } from "@/lib/taxes";
import { cn } from "@/lib/utils";
import {
  addExpense,
  DEFAULT_EXPENSE_CATEGORIES,
  deleteExpenseItem,
  getCategoryBadgeClass,
  updateExpense,
  type ExpenseInput,
} from "@/features/expenses/mutations";
import { ExpenseDialog } from "@/features/expenses/expense-dialog";

type DateFilter = "all" | "today" | "week" | "month" | "last_month";

export default function ExpensesPage() {
  const online = useOnline();
  const dataVersion = useDataVersion();

  const [rows, setRows] = useState<Synced<ExpenseRow>[]>([]);
  const [loading, setLoading] = useState(true);
  const [query, setQuery] = useState("");
  const [categoryFilter, setCategoryFilter] = useState("all");
  const [periodFilter, setPeriodFilter] = useState<DateFilter>("all");

  const [dialogOpen, setDialogOpen] = useState(false);
  const [editingExpense, setEditingExpense] = useState<ExpenseRow | null>(null);
  const [deletingExpense, setDeletingExpense] = useState<ExpenseRow | null>(null);

  const [busy, setBusy] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [notice, setNotice] = useState<string | null>(null);

  // Load expenses: warm from remote if online, then query local Dexie
  const load = useCallback(async () => {
    try {
      if (online) {
        try {
          await remoteFirst.warmExpenses(createClient());
        } catch {
          /* local stands */
        }
      }
      const local = await db.expenses.toArray();
      // Sort newest date first (fallback to created_at)
      local.sort((a, b) => {
        const timeA = new Date(a.date || a.created_at || 0).getTime();
        const timeB = new Date(b.date || b.created_at || 0).getTime();
        return timeB - timeA;
      });
      setRows(local);
    } finally {
      setLoading(false);
    }
  }, [online]);

  useEffect(() => {
    void load();
  }, [load, dataVersion]);

  // Extract all unique categories for the filter dropdown
  const availableCategories = useMemo(() => {
    const set = new Set<string>(DEFAULT_EXPENSE_CATEGORIES);
    for (const r of rows) {
      if (r.category) set.add(r.category);
    }
    return Array.from(set).sort();
  }, [rows]);

  // Date filtering logic
  const isDateInPeriod = (dateStr: string, period: DateFilter) => {
    if (period === "all") return true;
    const d = new Date(dateStr);
    if (Number.isNaN(d.getTime())) return false;

    const now = new Date();
    const today = new Date(now.getFullYear(), now.getMonth(), now.getDate());

    if (period === "today") {
      const target = new Date(d.getFullYear(), d.getMonth(), d.getDate());
      return target.getTime() === today.getTime();
    }

    if (period === "week") {
      const oneWeekAgo = new Date(today);
      oneWeekAgo.setDate(today.getDate() - 7);
      return d >= oneWeekAgo && d <= now;
    }

    if (period === "month") {
      return (
        d.getMonth() === now.getMonth() && d.getFullYear() === now.getFullYear()
      );
    }

    if (period === "last_month") {
      const prevMonth = now.getMonth() === 0 ? 11 : now.getMonth() - 1;
      const prevYear = now.getMonth() === 0 ? now.getFullYear() - 1 : now.getFullYear();
      return d.getMonth() === prevMonth && d.getFullYear() === prevYear;
    }

    return true;
  };

  // Filtered rows
  const filtered = useMemo(() => {
    const q = query.trim().toLowerCase();
    return rows.filter((r) => {
      // Search match
      const matchSearch =
        !q ||
        (r.title ?? "").toLowerCase().includes(q) ||
        (r.category ?? "").toLowerCase().includes(q) ||
        (r.description ?? "").toLowerCase().includes(q);

      // Category match
      const matchCat =
        categoryFilter === "all" ||
        (r.category ?? "").toLowerCase() === categoryFilter.toLowerCase();

      // Period match
      const matchDate = isDateInPeriod(r.date || r.created_at || "", periodFilter);

      return matchSearch && matchCat && matchDate;
    });
  }, [rows, query, categoryFilter, periodFilter]);

  // KPI Metrics Calculation
  const stats = useMemo(() => {
    const now = new Date();
    const currentMonth = now.getMonth();
    const currentYear = now.getFullYear();
    const todayMidnight = new Date(now.getFullYear(), now.getMonth(), now.getDate()).getTime();

    let totalFiltered = 0;
    let thisMonthTotal = 0;
    let todayTotal = 0;
    const categoryTotals: Record<string, number> = {};

    for (const r of rows) {
      const amt = Number(r.amount) || 0;
      const d = new Date(r.date || r.created_at || 0);

      // Month check
      if (d.getMonth() === currentMonth && d.getFullYear() === currentYear) {
        thisMonthTotal += amt;
      }

      // Today check
      const dMidnight = new Date(d.getFullYear(), d.getMonth(), d.getDate()).getTime();
      if (dMidnight === todayMidnight) {
        todayTotal += amt;
      }

      // Category aggregation
      const cat = r.category || "Uncategorized";
      categoryTotals[cat] = (categoryTotals[cat] || 0) + amt;
    }

    for (const r of filtered) {
      totalFiltered += Number(r.amount) || 0;
    }

    // Determine top category by spend
    let topCat = "None";
    let topCatAmount = 0;
    for (const [cat, amt] of Object.entries(categoryTotals)) {
      if (amt > topCatAmount) {
        topCatAmount = amt;
        topCat = cat;
      }
    }

    return {
      totalFiltered,
      thisMonthTotal,
      todayTotal,
      topCat,
      topCatAmount,
    };
  }, [rows, filtered]);

  // Create / Update submission handler
  const handleSave = async (input: ExpenseInput) => {
    setBusy(true);
    setError(null);
    setNotice(null);
    try {
      if (editingExpense) {
        const { synced } = await updateExpense(
          online,
          editingExpense.id,
          input,
          editingExpense,
        );
        setNotice(
          synced
            ? "Expense updated & synced with server"
            : "Expense updated locally — will sync when online",
        );
      } else {
        const { synced } = await addExpense(online, input);
        setNotice(
          synced
            ? "Expense recorded & synced with server"
            : "Expense saved locally — will sync when online",
        );
      }
      setDialogOpen(false);
      setEditingExpense(null);
      void load();
    } catch (e) {
      setError(e instanceof Error ? e.message : String(e));
    } finally {
      setBusy(false);
    }
  };

  // Delete submission handler
  const handleDelete = async () => {
    if (!deletingExpense) return;
    setBusy(true);
    setError(null);
    setNotice(null);
    try {
      await deleteExpenseItem(online, deletingExpense.id);
      setNotice("Expense deleted successfully");
      setDeletingExpense(null);
      void load();
    } catch (e) {
      setError(e instanceof Error ? e.message : String(e));
    } finally {
      setBusy(false);
    }
  };

  // Export filtered rows
  const handleExport = () => {
    downloadExpensesExport(
      filtered.map((r) => ({
        title: r.title,
        category: r.category,
        amount: r.amount ?? 0,
        date: r.date ? formatPaymentDate(r.date) : "-",
        description: r.description ?? "",
      })),
    );
  };

  return (
    <div className="space-y-5">
      {/* Top Header */}
      <div className="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
        <div>
          <div className="flex items-center gap-2">
            <h1 className="text-xl font-bold tracking-tight text-ashfoam-ink">
              Expenses
            </h1>
            <span className="rounded-full bg-ashfoam/30 px-2.5 py-0.5 text-xs font-semibold text-ashfoam-ink">
              {rows.length} total
            </span>
          </div>
          <p className="text-sm text-black/60">
            Track and manage branch operating costs and expenses
          </p>
        </div>

        <div className="flex flex-wrap items-center gap-2">
          <Button
            variant="outline"
            size="sm"
            onClick={() => void load()}
            disabled={loading}
            className="border-black/20 text-xs font-medium hover:bg-black/5"
          >
            <RefreshCw className={cn("mr-1.5 h-3.5 w-3.5", loading && "animate-spin")} />
            Refresh
          </Button>

          <Button
            variant="outline"
            size="sm"
            onClick={handleExport}
            disabled={filtered.length === 0}
            className="border-black/20 text-xs font-medium hover:bg-black/5"
          >
            <Download className="mr-1.5 h-3.5 w-3.5" />
            Export Excel
          </Button>

          <Button
            onClick={() => {
              setError(null);
              setEditingExpense(null);
              setDialogOpen(true);
            }}
            className="bg-ashfoam-ink text-white hover:bg-ashfoam-ink/90 font-medium text-xs shadow-sm"
          >
            <Plus className="mr-1 h-4 w-4" />
            Record Expense
          </Button>
        </div>
      </div>

      {/* KPI Cards */}
      <div className="grid grid-cols-1 gap-3 sm:grid-cols-2 lg:grid-cols-4">
        {/* Total Filtered */}
        <Card className="border border-black/10 bg-white p-4 shadow-sm">
          <div className="flex items-center justify-between">
            <span className="text-xs font-medium text-black/60 uppercase tracking-wider">
              {periodFilter === "all" ? "Total Expenses" : "Filtered Total"}
            </span>
            <div className="rounded-md bg-amber-50 p-2 text-amber-700">
              <TrendingDown className="h-4 w-4" />
            </div>
          </div>
          <div className="mt-2 flex items-baseline justify-between">
            <p className="text-xl font-bold tracking-tight text-ashfoam-ink">
              {ghs.format(stats.totalFiltered)}
            </p>
            <span className="text-xs text-black/50">{filtered.length} entries</span>
          </div>
        </Card>

        {/* This Month */}
        <Card className="border border-black/10 bg-white p-4 shadow-sm">
          <div className="flex items-center justify-between">
            <span className="text-xs font-medium text-black/60 uppercase tracking-wider">
              This Month
            </span>
            <div className="rounded-md bg-blue-50 p-2 text-blue-700">
              <Calendar className="h-4 w-4" />
            </div>
          </div>
          <div className="mt-2 flex items-baseline justify-between">
            <p className="text-xl font-bold tracking-tight text-blue-900">
              {ghs.format(stats.thisMonthTotal)}
            </p>
            <span className="text-xs text-black/50">Current month</span>
          </div>
        </Card>

        {/* Today */}
        <Card className="border border-black/10 bg-white p-4 shadow-sm">
          <div className="flex items-center justify-between">
            <span className="text-xs font-medium text-black/60 uppercase tracking-wider">
              Today&apos;s Expenses
            </span>
            <div className="rounded-md bg-emerald-50 p-2 text-emerald-700">
              <Clock className="h-4 w-4" />
            </div>
          </div>
          <div className="mt-2 flex items-baseline justify-between">
            <p className="text-xl font-bold tracking-tight text-emerald-900">
              {ghs.format(stats.todayTotal)}
            </p>
            <span className="text-xs text-black/50">Recorded today</span>
          </div>
        </Card>

        {/* Top Category */}
        <Card className="border border-black/10 bg-white p-4 shadow-sm">
          <div className="flex items-center justify-between">
            <span className="text-xs font-medium text-black/60 uppercase tracking-wider">
              Top Category
            </span>
            <div className="rounded-md bg-purple-50 p-2 text-purple-700">
              <Tag className="h-4 w-4" />
            </div>
          </div>
          <div className="mt-2 flex items-baseline justify-between">
            <p className="truncate text-base font-bold text-ashfoam-ink" title={stats.topCat}>
              {stats.topCat}
            </p>
            <span className="text-xs font-semibold text-purple-700">
              {ghs.format(stats.topCatAmount)}
            </span>
          </div>
        </Card>
      </div>

      {/* Alerts and Notices */}
      {notice && (
        <div className="flex items-center justify-between rounded-md border border-green-200 bg-green-50 px-4 py-2.5 text-xs font-medium text-green-800 animate-in fade-in">
          <span>{notice}</span>
          <button
            onClick={() => setNotice(null)}
            className="text-green-600 hover:text-green-900 ml-2 font-bold"
          >
            ×
          </button>
        </div>
      )}

      {error && (
        <div className="flex items-center justify-between rounded-md border border-red-200 bg-red-50 px-4 py-2.5 text-xs font-medium text-red-800 animate-in fade-in">
          <span>{error}</span>
          <button
            onClick={() => setError(null)}
            className="text-red-600 hover:text-red-900 ml-2 font-bold"
          >
            ×
          </button>
        </div>
      )}

      {/* Search and Filters Bar */}
      <div className="flex flex-col gap-2.5 rounded-lg border border-black/10 bg-white p-3 shadow-sm md:flex-row md:items-center md:justify-between">
        <div className="relative flex-1">
          <Search className="pointer-events-none absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-black/40" />
          <Input
            placeholder="Search expenses by title, category, description..."
            value={query}
            onChange={(e) => setQuery(e.target.value)}
            className="pl-9 text-xs border-black/15 focus-visible:ring-ashfoam-ink"
          />
        </div>

        <div className="flex flex-wrap items-center gap-2">
          {/* Category Filter */}
          <div className="flex items-center gap-1.5">
            <span className="text-xs font-medium text-black/60 hidden sm:inline">Category:</span>
            <select
              value={categoryFilter}
              onChange={(e) => setCategoryFilter(e.target.value)}
              className="rounded-md border border-black/15 bg-white px-2.5 py-1.5 text-xs font-medium text-black/80 focus:border-black focus:outline-none"
            >
              <option value="all">All Categories</option>
              {availableCategories.map((c) => (
                <option key={c} value={c}>
                  {c}
                </option>
              ))}
            </select>
          </div>

          {/* Period Filter */}
          <div className="flex items-center gap-1.5">
            <span className="text-xs font-medium text-black/60 hidden sm:inline">Date:</span>
            <select
              value={periodFilter}
              onChange={(e) => setPeriodFilter(e.target.value as DateFilter)}
              className="rounded-md border border-black/15 bg-white px-2.5 py-1.5 text-xs font-medium text-black/80 focus:border-black focus:outline-none"
            >
              <option value="all">All Time</option>
              <option value="today">Today</option>
              <option value="week">Past 7 Days</option>
              <option value="month">This Month</option>
              <option value="last_month">Last Month</option>
            </select>
          </div>

          {(query || categoryFilter !== "all" || periodFilter !== "all") && (
            <Button
              variant="ghost"
              size="sm"
              onClick={() => {
                setQuery("");
                setCategoryFilter("all");
                setPeriodFilter("all");
              }}
              className="text-xs text-black/60 hover:text-black h-8 px-2"
            >
              Reset
            </Button>
          )}
        </div>
      </div>

      {/* Expenses Data Table */}
      <div className="rounded-lg bg-white shadow-sm overflow-hidden">
        <DataTable
          loading={loading}
          columns={[
            {
              header: "Date",
              accessorKey: "date",
              cell: ({ row }) => {
                const date = row.original.date || row.original.created_at;
                return (
                  <div className="text-[12px] font-medium text-black/80 whitespace-nowrap">
                    {formatPaymentDate(date)}
                  </div>
                );
              },
            },
            {
              header: "Title & Details",
              accessorKey: "title",
              cell: ({ row }) => (
                <div className="py-1">
                  <p className="text-[13px] font-semibold text-black leading-snug">
                    {row.original.title}
                  </p>
                  {row.original.description && (
                    <p className="text-[11px] text-black/60 line-clamp-1 mt-0.5">
                      {row.original.description}
                    </p>
                  )}
                </div>
              ),
            },
            {
              header: "Category",
              accessorKey: "category",
              cell: ({ row }) => {
                const cat = row.original.category || "General";
                return (
                  <span
                    className={cn(
                      "inline-flex items-center rounded-full border px-2.5 py-0.5 text-[11px] font-medium whitespace-nowrap",
                      getCategoryBadgeClass(cat),
                    )}
                  >
                    {cat}
                  </span>
                );
              },
            },
            {
              header: "Amount",
              accessorKey: "amount",
              cell: ({ row }) => (
                <div className="text-right sm:text-left">
                  <span className="text-[13px] font-bold text-ashfoam-ink">
                    {ghs.format(row.original.amount ?? 0)}
                  </span>
                </div>
              ),
            },
            {
              header: "Status",
              accessorKey: "_isSynced",
              cell: ({ row }) => {
                const isSynced = row.original._isSynced !== 0;
                return isSynced ? (
                  <span
                    className="inline-flex items-center gap-1 text-[11px] font-medium text-emerald-700"
                    title="Synced with server"
                  >
                    <CheckCircle2 className="h-3 w-3 text-emerald-600" />
                    Synced
                  </span>
                ) : (
                  <span
                    className="inline-flex items-center gap-1 rounded bg-amber-50 px-1.5 py-0.5 text-[10px] font-medium text-amber-700 border border-amber-200"
                    title="Queued locally — waiting for internet to sync"
                  >
                    Pending Sync
                  </span>
                );
              },
            },
            {
              header: "Actions",
              id: "actions",
              cell: ({ row }) => (
                <div className="flex items-center gap-1">
                  <button
                    type="button"
                    title="Edit expense"
                    onClick={() => {
                      setError(null);
                      setEditingExpense(row.original);
                      setDialogOpen(true);
                    }}
                    className="rounded p-1 text-black/60 hover:bg-black/10 hover:text-black transition-colors"
                  >
                    <Pencil className="h-3.5 w-3.5" />
                  </button>
                  <button
                    type="button"
                    title="Delete expense"
                    onClick={() => {
                      setError(null);
                      setDeletingExpense(row.original);
                    }}
                    className="rounded p-1 text-red-500 hover:bg-red-50 hover:text-red-700 transition-colors"
                  >
                    <Trash2 className="h-3.5 w-3.5" />
                  </button>
                </div>
              ),
            },
          ]}
          rows={filtered}
          emptyHint="No expenses found. Click 'Record Expense' to log one."
        />
      </div>

      {/* Add / Edit Expense Dialog */}
      {dialogOpen && (
        <ExpenseDialog
          open
          busy={busy}
          error={error}
          initial={editingExpense}
          existingCategories={availableCategories}
          onClose={() => {
            setDialogOpen(false);
            setEditingExpense(null);
          }}
          onSubmit={(vals) => void handleSave(vals)}
        />
      )}

      {/* Delete Confirmation Dialog */}
      {deletingExpense && (
        <ConfirmDialog
          open
          title="Delete Expense?"
          message={`Are you sure you want to delete "${deletingExpense.title}" (${ghs.format(
            deletingExpense.amount ?? 0,
          )})? This action cannot be undone.`}
          confirmLabel="Delete Expense"
          tone="danger"
          busy={busy}
          onCancel={() => setDeletingExpense(null)}
          onConfirm={() => void handleDelete()}
        />
      )}
    </div>
  );
}
