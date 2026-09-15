import { Document, Page, StyleSheet, Text, View } from "@react-pdf/renderer";
import { CompanyInfo } from "@/lib/company";
import { formatCompact } from "@/lib/dates";
import { ReceiptHeader } from "./header";
import { printTime24, receiptAmount } from "./format";

export interface ReceiptDocItem {
  productName: string;
  quantity: number;
  unitPrice: number;
  totalPrice: number;
  discountAmount: number;
}

export interface ReceiptDocData {
  orderNumber: string;
  createdAt: string | null;
  createdBy: string;
  customerName: string | null;
  items: ReceiptDocItem[];
  totalQuantity: number;
  totalAmount: number;
  /** Cash actually tendered (POS captures it; history prints default to total). */
  cashTendered: number;
}

/** kTaxModels receipt rows: name + 'x.xx%'. */
export const RECEIPT_TAXES = [
  { name: "GetFund(GFL)", valuePercentage: 2.5 },
  { name: "NHIL", valuePercentage: 2.5 },
  { name: "VAT", valuePercentage: 15.0 },
];

const PT = 226.77; // 80mm in points

const s = StyleSheet.create({
  page: {
    paddingTop: 12,
    paddingBottom: 12,
    paddingLeft: 12,
    paddingRight: 12,
    fontFamily: "Helvetica",
    alignItems: "center",
  },
  meta: { width: "100%" },
  metaRow: { flexDirection: "row" },
  metaCell: { flex: 1 },
  kv: {
    flexDirection: "row",
    justifyContent: "space-between",
    paddingVertical: 2,
  },
  kvLabel: { fontSize: 9 },
  kvValue: { fontSize: 9, textAlign: "right" },
  kvValueBold: { fontSize: 10, fontWeight: "bold", textAlign: "right" },
  divider: { borderBottomWidth: 0.8, borderColor: "#000", marginVertical: 6 },
  dividerHeavy: { borderBottomWidth: 1.2, borderColor: "#000", marginVertical: 6 },
  head: { flexDirection: "row" },
  h0: { flex: 3, fontSize: 9, fontWeight: "bold" },
  h1: { flex: 1, fontSize: 9, fontWeight: "bold", textAlign: "center" },
  h2: { flex: 2, fontSize: 9, fontWeight: "bold", textAlign: "right" },
  h3: { flex: 2, fontSize: 9, fontWeight: "bold", textAlign: "right" },
  itemName: { fontSize: 10 },
  itemCell: { fontSize: 9 },
  totalLabel: { fontSize: 9, fontWeight: "bold" },
  totalQty: { fontSize: 9, textAlign: "center" },
  totalAmt: { fontSize: 11, fontWeight: "bold", textAlign: "right" },
  foot1: { fontSize: 10, fontWeight: "bold", textAlign: "center" },
  foot2: { fontSize: 9, textAlign: "center" },
});

/** Deterministic height estimate so the roll page fits content. */
export function receiptPageHeight(items: ReceiptDocItem[]): number {
  const base = 372;
  const lines = items.reduce(
    (a, it) => a + 20 + (it.discountAmount > 0 ? 12 : 0),
    0,
  );
  return Math.ceil(base + lines);
}

function ReceiptBody({ doc }: { doc: ReceiptDocData }) {
  const balance = doc.cashTendered - doc.totalAmount;
  return (
    <View style={{ width: "100%", alignItems: "center" }}>
      <ReceiptHeader />
      <View style={{ height: 6 }} />

      <View style={s.meta}>
        <View style={s.metaRow}>
          <View style={s.metaCell}>
            <View style={s.kv}>
              <Text style={s.kvLabel}>Bill No:</Text>
              <Text style={s.kvValue}>{doc.orderNumber}</Text>
            </View>
          </View>
          <View style={{ width: 10 }} />
          <View style={s.metaCell}>
            <View style={s.kv}>
              <Text style={s.kvLabel}>Time:</Text>
              <Text style={s.kvValue}>{printTime24(doc.createdAt)} hrs</Text>
            </View>
          </View>
        </View>
        <View style={s.metaRow}>
          <View style={s.metaCell}>
            <View style={s.kv}>
              <Text style={s.kvLabel}>Date:</Text>
              <Text style={s.kvValue}>
                {doc.createdAt ? formatCompact(doc.createdAt) : "—"}
              </Text>
            </View>
          </View>
          <View style={{ width: 10 }} />
          <View style={s.metaCell}>
            <View style={s.kv}>
              <Text style={s.kvLabel}>User:</Text>
              <Text style={s.kvValue}>{doc.createdBy}</Text>
            </View>
          </View>
        </View>
        <View style={s.kv}>
          <Text style={s.kvLabel}>Buyer (Bill to):</Text>
          <Text style={s.kvValue}>{doc.customerName ?? "Customer"}</Text>
        </View>
        <View style={s.kv}>
          <Text style={s.kvLabel}>Address:</Text>
          <Text style={s.kvValue}>Ahodwo Kumasi</Text>
        </View>
      </View>

      <View style={[{ width: "100%" }, s.divider]} />
      <View style={s.head}>
        <Text style={s.h0}>Description</Text>
        <Text style={s.h1}>Qty</Text>
        <Text style={s.h2}>Price</Text>
        <Text style={s.h3}>Total</Text>
      </View>
      <View style={[{ width: "100%" }, s.divider]} />

      {doc.items.map((it, i) => (
        <View key={i} style={{ width: "100%", paddingVertical: 3 }}>
          <View style={s.head}>
            <Text style={[s.h0, s.itemName]}>{it.productName}</Text>
            <Text style={[s.h1, s.itemCell]}>{it.quantity}</Text>
            <Text style={[s.h2, s.itemCell]}>{it.unitPrice.toFixed(2)}</Text>
            <Text style={[s.h3, s.itemCell]}>
              {(it.totalPrice + it.discountAmount).toFixed(2)}
            </Text>
          </View>
          {it.discountAmount > 0 && (
            <View style={[s.head, { paddingBottom: 2 }]}>
              <Text style={[s.h0, s.itemCell]}>Discount</Text>
              <Text style={s.h1}> </Text>
              <Text style={s.h2}> </Text>
              <Text style={[s.h3, s.itemCell]}>
                (-){it.discountAmount.toFixed(2)}
              </Text>
            </View>
          )}
        </View>
      ))}

      <View style={{ height: 10 }} />
      {RECEIPT_TAXES.map((t) => (
        <View key={t.name} style={[s.meta, s.kv]}>
          <Text style={s.kvLabel}>{t.name}</Text>
          <Text style={s.kvValue}>{t.valuePercentage.toFixed(2)}%</Text>
        </View>
      ))}
      <View style={[{ width: "100%" }, s.divider]} />
      <View style={s.head}>
        <Text style={[s.h0, s.totalLabel]}>Total</Text>
        <Text style={[s.h1, s.totalQty]}>{doc.totalQuantity}</Text>
        <Text style={[s.h2, s.totalAmt, { flex: 4 }]}>
          {receiptAmount(doc.totalAmount)}
        </Text>
      </View>
      <View style={[{ width: "100%" }, s.dividerHeavy]} />

      <View style={s.meta}>
        <View style={s.kv}>
          <Text style={s.kvLabel}>Cash:</Text>
          <Text style={s.kvValue}>{doc.totalAmount.toFixed(2)}</Text>
        </View>
        <View style={s.kv}>
          <Text style={s.kvLabel}>Cash Tendered:</Text>
          <Text style={s.kvValue}>{doc.cashTendered.toFixed(2)}</Text>
        </View>
        <View style={s.kv}>
          <Text style={s.kvLabel}>Balance:</Text>
          <Text style={s.kvValue}>{balance.toFixed(2)}</Text>
        </View>
        <View style={[{ width: "100%" }, s.divider]} />
        <View style={s.kv}>
          <Text style={[s.kvLabel, s.totalLabel]}>Total Paid:</Text>
          <Text style={s.kvValueBold}>{doc.totalAmount.toFixed(2)}</Text>
        </View>
        <View style={[{ width: "100%" }, s.dividerHeavy]} />
      </View>

      <View style={{ height: 5 }} />
      <Text style={s.foot1}>GOODS ONCE SOLD ARE NOT RETURNABLE</Text>
      <Text style={s.foot2}>Please verify before leaving</Text>
    </View>
  );
}

/** 80mm thermal PDF (roll height computed from content). */
export function ReceiptPdf({ doc }: { doc: ReceiptDocData }) {
  return (
    <Document>
      <Page size={[PT, receiptPageHeight(doc.items)]} style={s.page}>
        <ReceiptBody doc={doc} />
      </Page>
    </Document>
  );
}

/**
 * Screen/print HTML twin of the PDF (same order, literals, sizes in pt).
 * Printed via window.print with 80mm @page rules (see globals.css).
 */
export function ReceiptHtml({ doc, id }: { doc: ReceiptDocData; id?: string }) {
  const balance = doc.cashTendered - doc.totalAmount;
  const row: React.CSSProperties = {
    display: "flex",
    justifyContent: "space-between",
    padding: "2pt 0",
    fontSize: "9pt",
  };
  return (
    <div
      id={id}
      style={{
        width: "80mm",
        padding: "12pt",
        background: "#fff",
        color: "#000",
        fontFamily: "Helvetica, Arial, sans-serif",
      }}
    >
      <div style={{ textAlign: "center" }}>
        <div style={{ fontSize: "14pt", fontWeight: "bold" }}>{CompanyInfo.name}</div>
        {[CompanyInfo.postalAddress, CompanyInfo.commercialAddress,
          `Tel : ${CompanyInfo.phonePrimary}/${CompanyInfo.phoneSecondary}`,
          `Fax : ${CompanyInfo.faxId}`, `Email : ${CompanyInfo.email}`].map((l) => (
          <div key={l} style={{ fontSize: "9pt" }}>{l}</div>
        ))}
        <div style={{ height: "4pt" }} />
        <div style={{ fontSize: "8pt", fontWeight: "bold" }}>
          VAT INVOICE (VAT Reg Num: {CompanyInfo.vatReg})
        </div>
      </div>
      <div style={{ height: "6pt" }} />
      <div style={{ display: "flex", gap: "10pt" }}>
        <div style={{ flex: 1, ...row }}>
          <span>Bill No:</span>
          <span style={{ textAlign: "right" }}>{doc.orderNumber}</span>
        </div>
        <div style={{ flex: 1, ...row }}>
          <span>Time:</span>
          <span style={{ textAlign: "right" }}>{printTime24(doc.createdAt)} hrs</span>
        </div>
      </div>
      <div style={{ display: "flex", gap: "10pt" }}>
        <div style={{ flex: 1, ...row }}>
          <span>Date:</span>
          <span style={{ textAlign: "right" }}>
            {doc.createdAt ? formatCompact(doc.createdAt) : "—"}
          </span>
        </div>
        <div style={{ flex: 1, ...row }}>
          <span>User:</span>
          <span style={{ textAlign: "right" }}>{doc.createdBy}</span>
        </div>
      </div>
      <div style={row}>
        <span>Buyer (Bill to):</span>
        <span style={{ textAlign: "right" }}>{doc.customerName ?? "Customer"}</span>
      </div>
      <div style={row}>
        <span>Address:</span>
        <span style={{ textAlign: "right" }}>Ahodwo Kumasi</span>
      </div>
      <hr style={{ border: "none", borderTop: "0.8pt solid #000", margin: "6pt 0" }} />
      <div style={{ display: "flex", fontSize: "9pt", fontWeight: "bold" }}>
        <span style={{ flex: 3 }}>Description</span>
        <span style={{ flex: 1, textAlign: "center" }}>Qty</span>
        <span style={{ flex: 2, textAlign: "right" }}>Price</span>
        <span style={{ flex: 2, textAlign: "right" }}>Total</span>
      </div>
      <hr style={{ border: "none", borderTop: "0.8pt solid #000", margin: "6pt 0" }} />
      {doc.items.map((it, i) => (
        <div key={i} style={{ padding: "3pt 0", breakInside: "avoid" }}>
          <div style={{ display: "flex", alignItems: "flex-start" }}>
            <span style={{ flex: 3, fontSize: "10pt" }}>{it.productName}</span>
            <span style={{ flex: 1, fontSize: "9pt", textAlign: "center" }}>{it.quantity}</span>
            <span style={{ flex: 2, fontSize: "9pt", textAlign: "right" }}>{it.unitPrice.toFixed(2)}</span>
            <span style={{ flex: 2, fontSize: "9pt", textAlign: "right" }}>
              {(it.totalPrice + it.discountAmount).toFixed(2)}
            </span>
          </div>
          {it.discountAmount > 0 && (
            <div style={{ display: "flex", fontSize: "9pt", paddingBottom: "2pt" }}>
              <span style={{ flex: 6 }}>Discount</span>
              <span style={{ flex: 2, textAlign: "right" }}>
                (-){it.discountAmount.toFixed(2)}
              </span>
            </div>
          )}
        </div>
      ))}
      <div style={{ height: "10pt" }} />
      {RECEIPT_TAXES.map((t) => (
        <div key={t.name} style={row}>
          <span>{t.name}</span>
          <span style={{ textAlign: "right" }}>{t.valuePercentage.toFixed(2)}%</span>
        </div>
      ))}
      <hr style={{ border: "none", borderTop: "0.8pt solid #000", margin: "6pt 0" }} />
      <div style={{ display: "flex", alignItems: "center" }}>
        <span style={{ flex: 3, fontSize: "9pt", fontWeight: "bold" }}>Total</span>
        <span style={{ flex: 1, fontSize: "9pt", textAlign: "center" }}>{doc.totalQuantity}</span>
        <span style={{ flex: 4, fontSize: "11pt", fontWeight: "bold", textAlign: "right" }}>
          {receiptAmount(doc.totalAmount)}
        </span>
      </div>
      <hr style={{ border: "none", borderTop: "1.2pt solid #000", margin: "6pt 0" }} />
      <div style={row}><span>Cash:</span><span>{doc.totalAmount.toFixed(2)}</span></div>
      <div style={row}><span>Cash Tendered:</span><span>{doc.cashTendered.toFixed(2)}</span></div>
      <div style={row}><span>Balance:</span><span>{balance.toFixed(2)}</span></div>
      <hr style={{ border: "none", borderTop: "0.8pt solid #000", margin: "4pt 0" }} />
      <div style={{ ...row, fontWeight: "bold" }}>
        <span>Total Paid:</span><span style={{ fontSize: "10pt" }}>{doc.totalAmount.toFixed(2)}</span>
      </div>
      <hr style={{ border: "none", borderTop: "1.2pt solid #000", margin: "4pt 0" }} />
      <div style={{ height: "5pt" }} />
      <div style={{ textAlign: "center", fontSize: "10pt", fontWeight: "bold" }}>
        GOODS ONCE SOLD ARE NOT RETURNABLE
      </div>
      <div style={{ textAlign: "center", fontSize: "9pt" }}>Please verify before leaving</div>
    </div>
  );
}
