import { Document, Page, StyleSheet, Text, View } from "@react-pdf/renderer";
import { CompanyInfo } from "@/lib/company";
import { A4ItemsTable, type A4DocItem, type A4TaxRow } from "./a4-table";
import { printDate } from "./format";
import { CompanyHeaderA4 } from "./header";
import { numberToWords } from "./words";

export interface ProformaDocData {
  id: string;
  partyName: string | null;
  partyAddress: string | null;
  createdAt: string;
  taxes: A4TaxRow[];
  totalQuantity: number;
  totalAmount: number;
}

const s = StyleSheet.create({
  page: { padding: 32, fontFamily: "Helvetica" },
  topRow: {
    flexDirection: "row",
    justifyContent: "space-between",
  },
  topText: { fontSize: 10 },
  center: { alignItems: "center" },
  title: { fontSize: 11, fontWeight: "bold" },
  partyRow: { flexDirection: "row", justifyContent: "center" },
  partyLabel: { fontSize: 10 },
  partyName: { fontSize: 10, fontWeight: "bold" },
  partyAddr: { fontSize: 10, textDecoration: "underline" },
  footerLabel: { fontSize: 9, fontStyle: "italic" },
  words: { fontSize: 10, fontWeight: "bold" },
  tinRow: { flexDirection: "row" },
  tin: { fontSize: 10 },
  tinBold: { fontSize: 10, fontWeight: "bold" },
  declTitle: { fontSize: 10, textDecoration: "underline" },
  declBody: { fontSize: 9 },
  signRow: { flexDirection: "row", justifyContent: "flex-end" },
  signCol: { alignItems: "flex-end" },
  signFor: { fontSize: 10, fontWeight: "bold" },
  signBy: { fontSize: 10 },
  generated: {
    fontSize: 9,
    textDecoration: "underline",
    textAlign: "center",
  },
});

/**
 * Proforma Invoice — exact port of ProformaPrintService (quirk-fixed):
 * top row (Ref. No. line removed), centered company + title + party,
 * shared table (30pt spacer), footer, signatures, generated stamp.
 */
export function ProformaDoc({
  doc,
  items,
}: {
  doc: ProformaDocData;
  items: A4DocItem[];
}) {
  const invoiceNo = doc.id.substring(0, 8).toUpperCase();
  return (
    <Document>
      <Page size="A4" style={s.page}>
        <View style={s.topRow}>
          <View>
            <Text style={s.topText}>Invoice No. {invoiceNo}</Text>
          </View>
          <Text style={s.topText}>Dated {printDate(doc.createdAt)}</Text>
        </View>

        <View style={{ height: 10 }} />
        <View style={s.center}>
          <CompanyHeaderA4 />
          <View style={{ height: 10 }} />
          <Text style={s.title}>Proforma Invoice</Text>
          <View style={{ height: 5 }} />
          <View style={s.partyRow}>
            <Text style={s.partyLabel}>Party : </Text>
            <View>
              <Text style={s.partyName}>
                {doc.partyName ?? "Cash Customers"}
              </Text>
              {doc.partyAddress && (
                <Text style={s.partyAddr}>{doc.partyAddress}</Text>
              )}
            </View>
          </View>
        </View>

        <View style={{ height: 15 }} />
        <A4ItemsTable
          items={items}
          taxes={doc.taxes}
          spacerHeight={30}
          totalQty={doc.totalQuantity}
          totalAmount={doc.totalAmount}
          totalLabel="Grand Total"
        />

        <View style={{ height: 5 }} />
        <Text style={s.footerLabel}>Amount Chargeable (in words)</Text>
        <Text style={s.words}>{numberToWords(doc.totalAmount)}</Text>
        <View style={{ height: 10 }} />
        <View style={s.tinRow}>
          <Text style={s.tin}>Company&apos;s VAT TIN   : </Text>
          <Text style={s.tinBold}>{CompanyInfo.vatReg}</Text>
        </View>
        <View style={{ height: 10 }} />
        <Text style={s.declTitle}>Declaration</Text>
        <Text style={s.declBody}>One week validity from date of issue</Text>

        <View style={{ height: 20 }} />
        <View style={s.signRow}>
          <View style={s.signCol}>
            <Text style={s.signFor}>for {CompanyInfo.name}</Text>
            <View style={{ height: 30 }} />
            <Text style={s.signBy}>Authorised Signatory</Text>
          </View>
        </View>

        <View style={{ flexGrow: 1 }} />
        <Text style={s.generated}>This is a Computer Generated Invoice</Text>
      </Page>
    </Document>
  );
}
