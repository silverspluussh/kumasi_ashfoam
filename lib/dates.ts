/**
 * Date formats matching the Flutter screens (intl DateFormat literals).
 */
const MONTHS = [
  "Jan", "Feb", "Mar", "Apr", "May", "Jun",
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec",
];
const pad = (n: number) => String(n).padStart(2, "0");

function d(iso: string | null | undefined): Date | null {
  if (!iso) return null;
  const t = new Date(iso);
  return Number.isNaN(t.getTime()) ? null : t;
}

/** 'dd MMM yyyy' (sales grid fullDate, waybill dispatch date). */
export function formatFullDate(iso?: string | null): string {
  const t = d(iso);
  if (!t) return "-";
  return `${pad(t.getDate())} ${MONTHS[t.getMonth()]} ${t.getFullYear()}`;
}

/** 'dd MMM yyyy, HH:mm' (order details). */
export function formatDateTime(iso?: string | null): string {
  const t = d(iso);
  if (!t) return "-";
  return `${formatFullDate(iso)}, ${pad(t.getHours())}:${pad(t.getMinutes())}`;
}

/** 'MMM dd, yyyy' (proforma grid). */
export function formatShortDate(iso?: string | null): string {
  const t = d(iso);
  if (!t) return "-";
  return `${MONTHS[t.getMonth()]} ${pad(t.getDate())}, ${t.getFullYear()}`;
}

/** 'MMM dd, HH:mm' (adjustment audit logs). */
export function formatAuditDate(iso?: string | null): string {
  const t = d(iso);
  if (!t) return "-";
  return `${MONTHS[t.getMonth()]} ${pad(t.getDate())}, ${pad(t.getHours())}:${pad(t.getMinutes())}`;
}

/** 'EEEE, d MMMM yyyy' (summary header) — uses Intl. */
export function formatLongDate(date: Date = new Date()): string {
  return new Intl.DateTimeFormat("en-GB", {
    weekday: "long",
    day: "numeric",
    month: "long",
    year: "numeric",
  }).format(date);
}

/** 'MMM dd, yyyy HH:mm' (payments grid, e.g. Sep 13, 2026 14:30). */
export function formatPaymentDate(iso?: string | null): string {
  const t = d(iso);
  if (!t) return "-";
  return `${MONTHS[t.getMonth()]} ${pad(t.getDate())}, ${t.getFullYear()} ${pad(t.getHours())}:${pad(t.getMinutes())}`;
}

/** 'dd MMMM yyyy h:mm a' (stock report grid, e.g. 13 September 2026 2:30 PM). */
const MONTHS_FULL = [
  "January", "February", "March", "April", "May", "June",
  "July", "August", "September", "October", "November", "December",
];
export function formatReportDate(iso?: string | null): string {
  const t = d(iso);
  if (!t) return "-";
  const h24 = t.getHours();
  const h12 = h24 % 12 === 0 ? 12 : h24 % 12;
  const ampm = h24 < 12 ? "AM" : "PM";
  return `${pad(t.getDate())} ${MONTHS_FULL[t.getMonth()]} ${t.getFullYear()} ${h12}:${pad(t.getMinutes())} ${ampm}`;
}

/** 'MM/DD/YYYY' (POS order date, recent transactions). */
export function formatCompact(iso?: string | null): string {
  const t = d(iso);
  if (!t) return "—";
  return `${pad(t.getMonth() + 1)}/${pad(t.getDate())}/${t.getFullYear()}`;
}

/** 'yyyy-MM-dd' for date inputs / dispatchDocNumber. */
export function toIsoDate(date: Date = new Date()): string {
  return `${date.getFullYear()}-${pad(date.getMonth() + 1)}-${pad(date.getDate())}`;
}
