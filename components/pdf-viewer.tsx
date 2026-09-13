"use client";

import {
  PDFDownloadLink,
  PDFViewer,
  type DocumentProps,
} from "@react-pdf/renderer";
import { Button } from "@/components/ui/button";

export type DocElement = React.ReactElement<DocumentProps>;

export function ReceiptDownload({
  document,
  fileName,
}: {
  document: DocElement;
  fileName: string;
}) {
  return (
    <PDFDownloadLink document={document} fileName={fileName}>
      {({ loading }) => (
        <Button size="sm" disabled={loading} variant="outline">
          {loading ? "Preparing…" : "Download PDF"}
        </Button>
      )}
    </PDFDownloadLink>
  );
}

/**
 * Client-only PDF viewer + download (loaded with ssr:false — blob URLs
 * need the browser). Mirrors Flutter's PdfPreview dialog content.
 */
export function PdfViewer({
  document,
  fileName,
}: {
  document: DocElement;
  fileName: string;
}) {
  return (
    <div className="flex flex-col gap-2">
      <div className="flex justify-end">
        <PDFDownloadLink document={document} fileName={fileName}>
          {({ loading }) => (
            <Button size="sm" disabled={loading} variant="outline">
              {loading ? "Preparing…" : "Download PDF"}
            </Button>
          )}
        </PDFDownloadLink>
      </div>
      <PDFViewer width="100%" height={600} showToolbar>
        {document}
      </PDFViewer>
    </div>
  );
}
