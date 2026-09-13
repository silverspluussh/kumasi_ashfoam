import { StyleSheet, Text, View, type Styles } from "@react-pdf/renderer";
import { printAmount } from "./format";

export interface A4DocItem {
  productName: string;
  quantity: number;
  unitPrice: number;
  discountPct: number;
  total: number;
}

export interface A4TaxRow {
  name: string;
  valuePercentage: number;
  taxAmount?: number;
}

const s = StyleSheet.create({
  table: { borderWidth: 0.5, borderColor: "#000" },
  row: { flexDirection: "row" },
  headerRow: { flexDirection: "row", borderWidth: 0.5, borderColor: "#000" },
  c0: { width: 30, padding: 5, borderRightWidth: 0.5, borderColor: "#000" },
  c1: { flex: 5, padding: 5, borderRightWidth: 0.5, borderColor: "#000" },
  c2: { width: 60, padding: 5, borderRightWidth: 0.5, borderColor: "#000" },
  c3: { width: 70, padding: 5, borderRightWidth: 0.5, borderColor: "#000" },
  c4: { width: 40, padding: 5, borderRightWidth: 0.5, borderColor: "#000" },
  c5: { width: 50, padding: 5, borderRightWidth: 0.5, borderColor: "#000" },
  c6: { width: 90, padding: 5 },
  th: { fontSize: 8, fontWeight: "bold" },
  td: { fontSize: 8 },
  tdBold: { fontSize: 8, fontWeight: "bold" },
  taxName: {
    fontSize: 8,
    fontWeight: "bold",
    fontStyle: "italic",
    textAlign: "right",
  },
  taxPct: { fontSize: 8, fontWeight: "bold", textAlign: "center" },
  center: { textAlign: "center" },
  right: { textAlign: "right" },
  totalRow: { flexDirection: "row", borderWidth: 0.5, borderColor: "#000" },
});

/**
 * Shared A4 items table (proforma + waybill are identical after the
 * quirk fixes): fixed column widths, 0.5pt borders, ceiled amounts,
 * tax rows with pct in Disc.% + amount in Amount, spacer rows.
 */
export function A4ItemsTable({
  items,
  taxes,
  spacerHeight,
  totalQty,
  totalAmount,
  totalLabel,
}: {
  items: A4DocItem[];
  taxes: A4TaxRow[];
  spacerHeight: number;
  totalQty: number;
  totalAmount: number;
  totalLabel: string;
}) {
  const headers: [string, Styles[string], Styles[string]][] = [
    ["Sl\nNo.", s.c0, s.center],
    ["Description of Goods", s.c1, {}],
    ["Quantity", s.c2, s.center],
    ["Price", s.c3, s.center],
    ["per", s.c4, s.center],
    ["Disc. %", s.c5, s.center],
    ["Amount", s.c6, s.center],
  ];
  return (
    <View style={s.table}>
      <View style={s.headerRow}>
        {headers.map(([t, cell, align], i) => (
          <View key={i} style={cell}>
            <Text style={[s.th, align]}>{t}</Text>
          </View>
        ))}
      </View>
      {items.map((it, i) => (
        <View key={i} style={s.row}>
          <View style={s.c0}>
            <Text style={[s.td, s.center]}>{i + 1}</Text>
          </View>
          <View style={s.c1}>
            <Text style={s.tdBold}>{it.productName}</Text>
          </View>
          <View style={s.c2}>
            <Text style={[s.tdBold, s.right]}>{it.quantity} pcs</Text>
          </View>
          <View style={s.c3}>
            <Text style={[s.tdBold, s.right]}>
              {printAmount(it.unitPrice)}
            </Text>
          </View>
          <View style={s.c4}>
            <Text style={[s.td, s.center]}>pcs</Text>
          </View>
          <View style={s.c5}>
            <Text style={[s.td, s.center]}>
              {Math.trunc(it.discountPct)} %
            </Text>
          </View>
          <View style={s.c6}>
            <Text style={[s.tdBold, s.right]}>{printAmount(it.total)}</Text>
          </View>
        </View>
      ))}
      <View style={{ height: spacerHeight }} />
      {taxes.map((t, i) => (
        <View key={i} style={s.row}>
          <View style={s.c0}>
            <Text> </Text>
          </View>
          <View style={s.c1}>
            <Text style={s.taxName}>{t.name}</Text>
          </View>
          <View style={s.c2}>
            <Text> </Text>
          </View>
          <View style={s.c3}>
            <Text> </Text>
          </View>
          <View style={s.c4}>
            <Text> </Text>
          </View>
          <View style={s.c5}>
            <Text style={s.taxPct}>{t.valuePercentage.toFixed(2)} %</Text>
          </View>
          <View style={s.c6}>
            <Text style={[s.tdBold, s.right]}>
              {(t.taxAmount ?? 0).toFixed(2)}
            </Text>
          </View>
        </View>
      ))}
      <View style={{ height: 100 }} />
      <View style={s.totalRow}>
        <View style={s.c0}>
          <Text> </Text>
        </View>
        <View style={s.c1}>
          <Text style={[s.tdBold, s.right]}>{totalLabel}</Text>
        </View>
        <View style={s.c2}>
          <Text style={[s.tdBold, s.right]}>{totalQty} pcs</Text>
        </View>
        <View style={s.c3}>
          <Text> </Text>
        </View>
        <View style={s.c4}>
          <Text> </Text>
        </View>
        <View style={s.c5}>
          <Text> </Text>
        </View>
        <View style={s.c6}>
          <Text style={[s.tdBold, s.right]}>
            GHC {printAmount(totalAmount)}
          </Text>
        </View>
      </View>
    </View>
  );
}
