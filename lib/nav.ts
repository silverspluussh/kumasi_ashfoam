import {
  BarChart3,
  ClipboardList,
  FileText,
  LayoutDashboard,
  Package,
  Settings2,
  ShoppingCart,
  SlidersHorizontal,
  Truck,
  Users,
  Wallet,
  type LucideIcon,
} from "lucide-react";
import type { AppRole } from "./roles";

export interface NavItem {
  label: string;
  href: string;
  /** Original Flutter selectedIndex in main_app.dart (-1 = new in Next.js) */
  flutterIndex: number;
  icon: LucideIcon;
  onlineOnly: boolean;
  blockedFor?: AppRole[];
}

export interface NavSection {
  title: string;
  items: NavItem[];
}

const managerBlocked: AppRole[] = ["manager"];

export const NAV_SECTIONS: NavSection[] = [
  {
    title: "Main",
    items: [
      { label: "Summary", href: "/", flutterIndex: 0, icon: LayoutDashboard, onlineOnly: false },
      { label: "Point of Sale", href: "/pos", flutterIndex: 1, icon: ShoppingCart, onlineOnly: false },
      { label: "Sale Orders", href: "/sales", flutterIndex: 2, icon: ClipboardList, onlineOnly: false },
    ],
  },
  {
    title: "Inventory",
    items: [
      { label: "Products", href: "/inventory", flutterIndex: 4, icon: Package, onlineOnly: false },
      { label: "Stock Reports", href: "/inventory/reports", flutterIndex: 5, icon: BarChart3, onlineOnly: true },
      { label: "Proformas", href: "/inventory/proformas", flutterIndex: 6, icon: FileText, onlineOnly: false },
      { label: "Waybills", href: "/inventory/waybills", flutterIndex: 11, icon: Truck, onlineOnly: false },
      { label: "Adjustments", href: "/inventory/adjustments", flutterIndex: 13, icon: SlidersHorizontal, onlineOnly: true },
    ],
  },
  {
    title: "Money",
    items: [
      { label: "Payments", href: "/payments", flutterIndex: 7, icon: Wallet, onlineOnly: true },
    ],
  },
  {
    title: "Partners",
    items: [
      { label: "Suppliers", href: "/suppliers", flutterIndex: 16, icon: Users, onlineOnly: true, blockedFor: managerBlocked },
      { label: "Supplier Payments", href: "/suppliers/payments", flutterIndex: 15, icon: Wallet, onlineOnly: true, blockedFor: managerBlocked },
    ],
  },
  {
    title: "Admin",
    items: [
      { label: "Brands & Categories", href: "/settings/catalog", flutterIndex: 12, icon: Settings2, onlineOnly: true },
    ],
  },
];

export const ALL_NAV_ITEMS: NavItem[] = NAV_SECTIONS.flatMap((s) => s.items);

export function findNavItem(pathname: string): NavItem | undefined {
  return ALL_NAV_ITEMS.find((item) => item.href === pathname);
}
