"use client";

import Image from "next/image";
import { useRouter } from "next/navigation";
import { useEffect, useState } from "react";
import { Button } from "@/components/ui/button";
import { useAuth } from "@/lib/auth/auth-context";

/**
 * Login mirroring ashfoam_sadiq login_page.dart:
 * #E6C13D bg, logo width 220, email regex + password >= 6, sign-in
 * requires internet (canSubmit = isOnline && !isLoading).
 */
const EMAIL_RE = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

export default function LoginPage() {
  const { session, offline, loading, signIn } = useAuth();
  const router = useRouter();
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [touched, setTouched] = useState(false);
  const [submitting, setSubmitting] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [online, setOnline] = useState(true);

  useEffect(() => {
    setOnline(navigator.onLine);
    const goOnline = () => setOnline(true);
    const goOffline = () => setOnline(false);
    window.addEventListener("online", goOnline);
    window.addEventListener("offline", goOffline);
    return () => {
      window.removeEventListener("online", goOnline);
      window.removeEventListener("offline", goOffline);
    };
  }, []);

  // Already authenticated (live or offline cache) → home, like appEntryProvider.
  useEffect(() => {
    if (!loading && (session || offline)) router.replace("/pos");
  }, [loading, session, offline, router]);

  const emailOk = EMAIL_RE.test(email.trim());
  const passwordOk = password.length >= 6;
  const canSubmit = online && !submitting && emailOk && passwordOk;

  const onSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setTouched(true);
    if (!canSubmit) return;
    setSubmitting(true);
    setError(null);
    const { error: msg } = await signIn(email, password);
    setSubmitting(false);
    if (msg) setError(msg);
    else router.replace("/pos");
  };

  return (
    <div className="flex min-h-screen items-center justify-center bg-ashfoam-login p-4">
      <div className="w-full max-w-sm bg-white p-6 shadow-lg">
        <div className="flex justify-center pb-4">
          <Image
            src="/ashfoam_logo.png"
            alt="Ashfoam"
            width={220}
            height={80}
            style={{ width: 220, height: "auto" }}
            priority
          />
        </div>
        <h1 className="pb-1 text-center text-lg font-bold">Sign in</h1>
        <p className="pb-4 text-center text-[13px] text-black/60">
          Ashanti Foam Factory Ltd · Kumasi POS
        </p>

        <form className="space-y-3" onSubmit={onSubmit} noValidate>
          <div>
            <label htmlFor="email" className="pb-1 block text-[13px] font-medium">
              Email
            </label>
            <input
              id="email"
              type="email"
              autoComplete="email"
              placeholder="you@company.com"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              onBlur={() => setTouched(true)}
              className="w-full border border-black/20 px-3 py-2 text-sm outline-none focus:border-black"
            />
            {touched && !emailOk && (
              <p className="pt-1 text-xs text-red-600">
                Enter a valid email address.
              </p>
            )}
          </div>

          <div>
            <label
              htmlFor="password"
              className="pb-1 block text-[13px] font-medium"
            >
              Password
            </label>
            <input
              id="password"
              type="password"
              autoComplete="current-password"
              placeholder="Your password (min 6 characters)"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              onBlur={() => setTouched(true)}
              className="w-full border border-black/20 px-3 py-2 text-sm outline-none focus:border-black"
            />
            {touched && !passwordOk && (
              <p className="pt-1 text-xs text-red-600">
                Password must be at least 6 characters.
              </p>
            )}
          </div>

          <Button
            type="submit"
            disabled={!canSubmit}
            className="w-full bg-ashfoam-ink text-white hover:bg-ashfoam-ink/90 disabled:opacity-50"
          >
            {submitting ? "Signing in…" : "Sign in"}
          </Button>
          {!online && (
            <p className="text-center text-xs font-medium text-amber-700">
              Sign-in requires internet. You are offline.
            </p>
          )}
          {error && (
            <p className="text-center text-xs font-medium text-red-600">
              {error}
            </p>
          )}
        </form>

        <p className="pt-3 text-center text-xs text-black/60">
          Sign-in requires internet. Forgot password? Contact admin:
          info@ashfoamghana.com · 0556579214 / 0544352785
        </p>
      </div>
    </div>
  );
}
