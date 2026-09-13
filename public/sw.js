/**
 * P5 service worker — app-shell cache ONLY.
 * Dexie (IndexedDB) is the offline data layer; this SW never caches API
 * responses or Supabase traffic. Static assets get cache-first, navigations
 * get network-first with cache fallback so installed PWAs stay usable offline.
 */
const CACHE = "ashfoam-shell-v1";

self.addEventListener("install", (event) => {
  event.waitUntil(
    caches
      .open(CACHE)
      .then((cache) =>
        // Shell pages — ok to fail individually (e.g. auth redirect on /)
        Promise.allSettled(
          ["/", "/pos", "/login"].map((u) =>
            cache.add(new Request(u, { cache: "reload" })),
          ),
        ),
      )
      .then(() => self.skipWaiting()),
  );
});

self.addEventListener("activate", (event) => {
  event.waitUntil(
    caches
      .keys()
      .then((keys) =>
        Promise.all(keys.filter((k) => k !== CACHE).map((k) => caches.delete(k))),
      )
      .then(() => self.clients.claim()),
  );
});

self.addEventListener("fetch", (event) => {
  const req = event.request;
  if (req.method !== "GET") return;

  const url = new URL(req.url);

  // Never touch cross-origin (Supabase, fonts CDN) — pass through.
  if (url.origin !== self.location.origin) return;

  // Never cache the Supabase auth/session endpoints or any /api route.
  if (url.pathname.startsWith("/api/")) return;

  // Static build assets + icons + manifest: cache-first (immutable/hashed).
  if (
    url.pathname.startsWith("/_next/static/") ||
    url.pathname === "/manifest.webmanifest" ||
    /\.(png|ico|svg|webp|woff2?)$/.test(url.pathname)
  ) {
    event.respondWith(
      caches.match(req).then(
        (hit) =>
          hit ??
          fetch(req).then((res) => {
            if (res.ok) {
              const copy = res.clone();
              caches.open(CACHE).then((c) => c.put(req, copy));
            }
            return res;
          }),
      ),
    );
    return;
  }

  // Navigations: network-first, cache fallback (offline page shell).
  if (req.mode === "navigate") {
    event.respondWith(
      fetch(req)
        .then((res) => {
          if (res.ok) {
            const copy = res.clone();
            caches.open(CACHE).then((c) => c.put(req, copy));
          }
          return res;
        })
        .catch(() =>
          caches.match(req).then(
            (hit) =>
              hit ??
              caches.match("/pos").then(
                (shell) =>
                  shell ??
                  new Response("Offline", {
                    status: 503,
                    headers: { "Content-Type": "text/plain" },
                  }),
              ),
          ),
        ),
    );
  }
});
