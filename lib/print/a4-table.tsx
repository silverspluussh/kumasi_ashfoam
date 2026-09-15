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
  headerRow: {
    flexDirection: "row",
    borderBottomWidth: 0.5,
    borderColor: "#000",
  },
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
  totalRow: {
    flexDirection: "row",
    borderTopWidth: 0.5,
    borderColor: "#000",
  },
  /* Spacer row: preserves vertical column dividers across empty space */
  spacerRow: { flexDirection: "row" },
});

/**
 * Spacer cell: renders an empty cell with the given height and optional
 * right border so that vertical column lines stay continuous.
 */
function SpacerCell({
  style,
  height,
}: {
  style: Styles[string];
  height: number;
}) {
  return <View style={[style, { height, padding: 0 }]} />;
}

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
    ["Price", s.c3, s.right],
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
      {/* Spacer: structured row with column dividers to keep vertical lines continuous */}
      <View style={s.spacerRow}>
        <SpacerCell style={s.c0} height={spacerHeight} />
        <SpacerCell style={s.c1} height={spacerHeight} />
        <SpacerCell style={s.c2} height={spacerHeight} />
        <SpacerCell style={s.c3} height={spacerHeight} />
        <SpacerCell style={s.c4} height={spacerHeight} />
        <SpacerCell style={s.c5} height={spacerHeight} />
        <SpacerCell style={s.c6} height={spacerHeight} />
      </View>
      {taxes.map((t, i) => (
        <View key={i} style={s.row}>
          <View style={[s.c0, { paddingVertical: 1 }]}>
            <Text> </Text>
          </View>
          <View style={[s.c1, { paddingVertical: 1 }]}>
            <Text style={s.taxName}>{t.name}</Text>
          </View>
          <View style={[s.c2, { paddingVertical: 1 }]}>
            <Text> </Text>
          </View>
          <View style={[s.c3, { paddingVertical: 1 }]}>
            <Text style={[s.tdBold, s.right]}>
              {t.valuePercentage.toFixed(2)}
            </Text>
          </View>
          <View style={[s.c4, { paddingVertical: 1 }]}>
            <Text style={s.td}>%</Text>
          </View>
          <View style={[s.c5, { paddingVertical: 1 }]}>
            <Text> </Text>
          </View>
          <View style={[s.c6, { paddingVertical: 1 }]}>
            <Text style={[s.tdBold, s.right]}>
              {(t.taxAmount ?? 0).toFixed(2)}
            </Text>
          </View>
        </View>
      ))}
      {/* Bottom spacer: structured row with column dividers */}
      <View style={s.spacerRow}>
        <SpacerCell style={s.c0} height={100} />
        <SpacerCell style={s.c1} height={100} />
        <SpacerCell style={s.c2} height={100} />
        <SpacerCell style={s.c3} height={100} />
        <SpacerCell style={s.c4} height={100} />
        <SpacerCell style={s.c5} height={100} />
        <SpacerCell style={s.c6} height={100} />
      </View>
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
