import { CompanyInfo } from "@/lib/company";
import { Taxes } from "@/lib/taxes";
import { db } from "./dexie";

/**
 * Local-only seeds: 3 Ghana taxes (Flutter hardcodes them instead of
 * pulling ashfoam_taxes) + company-settings singleton from
 * kCompanyHeaderMap. Idempotent — safe to run on every bootstrap.
 */
export async function seedLocalConstants() {
  await db.taxes.bulkPut(
    Taxes.map((t, i) => ({
      id: `seed-tax-${i}`,
      name: t.name,
      value_percentage: t.valuePercentage,
    })),
  );
  await db.companySettings.put({
    id: "main",
    name: CompanyInfo.name,
    postalAddress: CompanyInfo.postalAddress,
    commercialAddress: CompanyInfo.commercialAddress,
    phonePrimary: CompanyInfo.phonePrimary,
    phoneSecondary: CompanyInfo.phoneSecondary,
    faxId: CompanyInfo.faxId,
    email: CompanyInfo.email,
    updatedAt: new Date().toISOString(),
  });
}
