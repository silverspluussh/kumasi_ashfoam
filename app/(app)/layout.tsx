import { AppProviders } from "@/components/providers";
import { AppShell } from "@/components/app-shell";

/** App shell mirroring Flutter StarterApp: yellow sidebar + offline banner. */
export default function AppLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <AppProviders>
      <AppShell>{children}</AppShell>
    </AppProviders>
  );
}
