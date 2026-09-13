import { Document, Page, StyleSheet, Text, View } from "@react-pdf/renderer";
import { CompanyInfo } from "@/lib/company";
import { A4ItemsTable, type A4DocItem, type A4TaxRow } from "./a4-table";
import { printDate } from "./format";
import { CompanyHeaderA4 } from "./header";
import { numberToWords } from "./words";

export interface WaybillDocData {
  id: string;
  orderNumber: string;
  dispatchDocNumber: string;
  deliveryNote: string;
  senderName: string;
  destination: string;
  dispatchDate: string;
  partyName: string;
  taxes: A4TaxRow[];
  totalQuantity: number;
  totalAmount: number;
}

const s = StyleSheet.create({
  page: { padding: 32, fontFamily: "Helvetica" },
  topRow: { flexDirection: "row", justifyContent: "space-between" },
  topText: { fontSize: 10 },
  center: { alignItems: "center" },
  title: { fontSize: 11, fontWeight: "bold" },
  partyRow: { flexDirection: "row", justifyContent: "center" },
  partyLabel: { fontSize: 10 },
  partyName: { fontSize: 10, fontWeight: "bold" },
  boxes: { flexDirection: "row" },
  box: {
    flex: 1,
    height: 50,
    borderWidth: 0.5,
    borderColor: "#000",
    padding: 5,
  },
  boxTitle: { fontSize: 8, fontWeight: "bold" },
  boxLine: { fontSize: 8 },
  footerLabel: { fontSize: 9, fontStyle: "italic" },
  words: { fontSize: 10, fontWeight: "bold" },
  tinRow: { flexDirection: "row" },
  tin: { fontSize: 10 },
  tinBold: { fontSize: 10, fontWeight: "bold" },
  declTitle: { fontSize: 10, textDecoration: "underline" },
  declBody: { fontSize: 8, width: 300 },
  signRow: { flexDirection: "row", justifyContent: "flex-end" },
  signCol: { alignItems: "flex-end" },
  signFor: { fontSize: 10, fontWeight: "bold" },
  signBy: { fontSize: 10 },
  generated: { fontSize: 9, textDecoration: "underline", textAlign: "center" },
});

/**
 * Dispatch Waybill — exact port of WaybillPrintService (quirk-fixed,
 * 'propety' → 'property'): top row with filled Ref. No., V.A.T INVOICE
 * title, party (no address), three dispatch boxes, shared table
 * (20pt spacer, 'Total' label), declaration, signatures.
 */
export function WaybillDoc({
  doc,
  items,
}: {
  doc: WaybillDocData;
  items: A4DocItem[];
}) {
  const invoiceNo = doc.id.substring(0, 8).toUpperCase();
  return (
    <Document>
      <Page size="A4" style={s.page}>
        <View style={s.topRow}>
          <View>
            <Text style={s.topText}>Invoice No. {invoiceNo}</Text>
            <Text style={s.topText}>Ref. No. {doc.orderNumber}</Text>
          </View>
          <Text style={s.topText}>Dated {printDate(doc.dispatchDate)}</Text>
        </View>

        <View style={{ height: 10 }} />
        <View style={s.center}>
          <CompanyHeaderA4 />
          <View style={{ height: 10 }} />
          <Text style={s.title}>V.A.T INVOICE</Text>
          <View style={{ height: 5 }} />
          <View style={s.partyRow}>
            <Text style={s.partyLabel}>Party : </Text>
            <Text style={s.partyName}>{doc.partyName}</Text>
          </View>
        </View>

        <View style={{ height: 15 }} />
        <View style={s.boxes}>
          <View style={s.box}>
            <Text style={s.boxTitle}>Order No.</Text>
            <Text style={s.boxLine}>{doc.orderNumber}</Text>
            <Text style={s.boxLine}>{printDate(doc.dispatchDate)}</Text>
          </View>
          <View style={s.box}>
            <Text style={s.boxTitle}>Dispatch Doc No.</Text>
            <Text style={s.boxLine}>{doc.dispatchDocNumber}</Text>
            <Text style={s.boxLine}>Through : {doc.senderName}</Text>
          </View>
          <View style={s.box}>
            <Text style={s.boxTitle}>Delivery Note</Text>
            <Text style={s.boxLine}>{doc.deliveryNote}</Text>
            <Text style={s.boxLine}>To : {doc.destination}</Text>
          </View>
        </View>

        <A4ItemsTable
          items={items}
          taxes={doc.taxes}
          spacerHeight={20}
          totalQty={doc.totalQuantity}
          totalAmount={doc.totalAmount}
          totalLabel="Total"
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
        <Text style={s.declBody}>
          We declare that this invoice shows the actual price of the goods
          described and that all particulars are true and correct. Good or
          Items remain the property of {CompanyInfo.name} until final
          payment.
        </Text>

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
