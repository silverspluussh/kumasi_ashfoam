"use client";

import dynamic from "next/dynamic";
import { useEffect } from "react";
import { createPortal } from "react-dom";
import { Button } from "@/components/ui/button";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import {
  ReceiptHtml,
  ReceiptPdf,
  type ReceiptDocData,
} from "@/lib/print/receipt";

const ReceiptDownload = dynamic(
  () => import("./pdf-viewer").then((m) => m.ReceiptDownload),
  { ssr: false },
);

/**
 * Thermal receipt dialog — Flutter ReceiptService.showPreview equivalent:
 * 80mm HTML preview + Print (thermal via window.print) + Download PDF.
 * Title: 'Receipt Preview (80mm)'.
 */
export function ReceiptDialog({
  open,
  doc,
  onClose,
}: {
  open: boolean;
  doc: ReceiptDocData | null;
  onClose: () => void;
}) {
  // 80mm @page only while this dialog is open (A4 flows untouched).
  useEffect(() => {
    if (!open) return;
    const st = document.createElement("style");
    st.textContent = "@page{size:80mm auto;margin:0}";
    document.head.appendChild(st);
    return () => {
      st.remove();
    };
  }, [open ]);

  const print = () => {
    document.body.classList.add("receipt-printing");
    const done = () => {
      document.body.classList.remove("receipt-printing");
      window.removeEventListener("afterprint", done);
    };
    window.addEventListener("afterprint", done);
    window.print();
  };

  return (
    <Dialog open={open} onOpenChange={onClose}>
      <DialogContent className="md:max-w-md">
        <DialogHeader>
          <DialogTitle>Receipt Preview (80mm)</DialogTitle>
        </DialogHeader>
        {doc && (
          <div className="space-y-2">
            <div className="flex justify-center overflow-x-auto border border-black/10 bg-black/5 p-2">
              <ReceiptHtml doc={doc} />
            </div>
            <p className="text-xs text-black/50">
              Select the 80mm thermal printer with header/footer off.
            </p>
            <div className="flex justify-end gap-2">
              <ReceiptDownload
                document={<ReceiptPdf doc={doc} />}
                fileName={`Receipt_${doc.orderNumber}.pdf`}
              />
              <Button onClick={print}>Print Receipt</Button>
              <Button variant="outline" onClick={onClose}>
                Close
              </Button>
            </div>
          </div>
        )}
        {/* print-only node at body level (escapes dialog transforms) */}
        {open &&
          doc &&
          typeof document !== "undefined" &&
          createPortal(
            <div id="print-thermal" aria-hidden>
              <ReceiptHtml doc={doc} />
            </div>,
            document.body,
          )}
      </DialogContent>
    </Dialog>
  );
}
