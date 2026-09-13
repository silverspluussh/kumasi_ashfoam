"use client";

import dynamic from "next/dynamic";
import { LoadingSpinner } from "@/components/loading-spinner";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";

const PdfViewer = dynamic(
  () => import("./pdf-viewer").then((m) => m.PdfViewer),
  { ssr: false, loading: () => <LoadingSpinner label="Loading preview…" /> },
);
import type { DocElement } from "./pdf-viewer";

/**
 * A4 print preview dialog — Flutter PdfPreview equivalent:
 * 1000px wide dialog, title row, viewer + download.
 */
export function PrintPreviewDialog({
  open,
  title,
  fileName,
  document,
  onClose,
}: {
  open: boolean;
  title: string;
  fileName: string;
  document: DocElement | null;
  onClose: () => void;
}) {
  return (
    <Dialog open={open} onOpenChange={onClose}>
      <DialogContent className="md:max-w-5xl">
        <DialogHeader>
          <DialogTitle>{title}</DialogTitle>
        </DialogHeader>
        {document && (
          <PdfViewer document={document} fileName={fileName} />
        )}
      </DialogContent>
    </Dialog>
  );
}
