import type { Metadata, Viewport } from "next";
import { Inter } from "next/font/google";
import { ServiceWorkerRegistrar } from "@/components/service-worker-registrar";
import "./globals.css";

const inter = Inter({
  variable: "--font-sans",
  subsets: ["latin"],
  display: "swap",
});

export const metadata: Metadata = {
  title: "Ashfoam Kumasi POS",
  description: "Ashanti Foam Factory Ltd — offline-first point of sale",
  applicationName: "Ashfoam Kumasi POS",
  manifest: "/manifest.webmanifest",
  appleWebApp: {
    capable: true,
    title: "Ashfoam",
    statusBarStyle: "black-translucent",
  },
  icons: {
    icon: [
      { url: "/AppIcon64.png", sizes: "64x64", type: "image/png" },
      { url: "/AppIcon256.png", sizes: "256x256", type: "image/png" },
    ],
    apple: "/AppIcon256.png",
  },
};

export const viewport: Viewport = {
  themeColor: "#0F0F0F",
};


export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en" className={`${inter.variable} h-full antialiased`}>
      <body className="min-h-full flex flex-col">
      <ServiceWorkerRegistrar />
      {children}
    </body>
    </html>
  );
}
