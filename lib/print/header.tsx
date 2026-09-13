import { StyleSheet, Text, View } from "@react-pdf/renderer";
import { CompanyInfo } from "@/lib/company";

/**
 * Shared print headers. Exact port of PdfHelper.buildCompanyHeader
 * (A4, left) + buildReceiptHeader (thermal, centered). Strict constants.
 */
const styles = StyleSheet.create({
  col: { flexDirection: "column" },
  nameA4: { fontSize: 12, fontWeight: "bold" },
  lineA4: { fontSize: 9 },
  vatA4: { fontSize: 6, textAlign: "center" },
  nameR: { fontSize: 13, fontWeight: "bold", textAlign: "center" },
  lineR: { fontSize: 8, textAlign: "center" },
  vatR: { fontSize: 7, fontWeight: "bold", textAlign: "center" },
});

export function CompanyHeaderA4() {
  return (
    <View style={styles.col}>
      <Text style={styles.nameA4}>{CompanyInfo.name}</Text>
      <Text style={styles.lineA4}>{CompanyInfo.postalAddress}</Text>
      <Text style={styles.lineA4}>{CompanyInfo.commercialAddress}</Text>
      <Text style={styles.lineA4}>Tel : {CompanyInfo.phonePrimary}/{CompanyInfo.phoneSecondary}</Text>
      <Text style={styles.lineA4}>Fax : {CompanyInfo.faxId}</Text>
      <Text style={styles.lineA4}>Email : {CompanyInfo.email}</Text>
      <View style={{ height: 2 }} />
      <Text style={styles.vatA4}>
        VAT INVOICE (VAT Reg Num: {CompanyInfo.vatReg})
      </Text>
    </View>
  );
}

export function ReceiptHeader() {
  return (
    <View style={{ ...styles.col, alignItems: "center" }}>
      <Text style={styles.nameR}>{CompanyInfo.name}</Text>
      <Text style={styles.lineR}>{CompanyInfo.postalAddress}</Text>
      <Text style={styles.lineR}>{CompanyInfo.commercialAddress}</Text>
      <Text style={styles.lineR}>Tel : {CompanyInfo.phonePrimary}/{CompanyInfo.phoneSecondary}</Text>
      <Text style={styles.lineR}>Fax : {CompanyInfo.faxId}</Text>
      <Text style={styles.lineR}>Email : {CompanyInfo.email}</Text>
      <View style={{ height: 4 }} />
      <Text style={styles.vatR}>
        VAT INVOICE (VAT Reg Num: {CompanyInfo.vatReg})
      </Text>
    </View>
  );
}
