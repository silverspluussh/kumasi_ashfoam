-- Supabase SQL Schema for Ashfoam App

-- Extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 1. Base Tables (Independent)
CREATE TABLE ashfoam_stores (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    name TEXT NOT NULL,
    address TEXT NOT NULL,
    is_active SMALLINT NOT NULL DEFAULT 1
);

CREATE TABLE ashfoam_product_brands (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE ashfoam_product_categories (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE ashfoam_taxes (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL,
    value_percentage FLOAT8 NOT NULL
);

CREATE TABLE ashfoam_suppliers (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL,
    supplier_code TEXT,
    contact_name TEXT,
    email TEXT,
    phone TEXT,
    address TEXT,
    is_active SMALLINT NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 2. Dependent Base Tables
CREATE TABLE ashfoam_branches (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    store_id UUID REFERENCES ashfoam_stores(id),
    store_name TEXT NOT NULL,
    branch_name TEXT NOT NULL,
    branch_address TEXT,
    contact TEXT,
    is_active SMALLINT NOT NULL DEFAULT 1,
    is_deleted SMALLINT NOT NULL DEFAULT 0,
    branch_manager_name TEXT,
    branch_manager_id TEXT, -- Might be a link to employees later
    company_details JSONB, -- Stored as JSONB per user request
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE ashfoam_product_subcategories (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    category_id UUID REFERENCES ashfoam_product_categories(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE ashfoam_customers (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL,
    email TEXT,
    phone TEXT,
    address TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 3. Employees (Linked to Supabase Auth)
CREATE TABLE ashfoam_employees (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    first_name TEXT,
    last_name TEXT,
    middle_name TEXT,
    email TEXT UNIQUE NOT NULL,
    phone TEXT,
    role TEXT NOT NULL,
    department TEXT,
    branch_id UUID REFERENCES ashfoam_branches(id),
    branch_name TEXT,
    manager_id UUID REFERENCES ashfoam_employees(id),
    manager_name TEXT,
    designation TEXT,
    status TEXT NOT NULL DEFAULT 'active',
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    hire_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    end_date TIMESTAMPTZ,
    address TEXT,
    notes TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 4. Inventory
CREATE TABLE ashfoam_inventory (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL,
    sku TEXT UNIQUE NOT NULL,
    category TEXT,
    catergory_id UUID REFERENCES ashfoam_product_categories(id),
    "subCategory" TEXT,
    size TEXT,
    thickness TEXT,
    material TEXT,
    density TEXT,
    brand TEXT,
    "brandId" UUID REFERENCES ashfoam_product_brands(id),
    "retailPrice" FLOAT8 NOT NULL,
    "discountPrice" FLOAT8,
    "discountPercentage" FLOAT8,
    quantity INTEGER NOT NULL DEFAULT 0,
    unit TEXT,
    "branchId" UUID,
    "isAvailable" SMALLINT NOT NULL DEFAULT 1,
    "isDeleted" SMALLINT NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    "updatedAt" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    "isSynced" BOOLEAN DEFAULT FALSE,
    "lastSyncedAt" TIMESTAMPTZ
);

-- 5. Sales and Transactions
CREATE TABLE ashfoam_sale_orders (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    "orderNumber" TEXT UNIQUE NOT NULL,
    "customerName" TEXT,
    channel TEXT,
    "branchId" UUID,
    "branchName" TEXT,
    "totalAmount" FLOAT8 NOT NULL,
    "discountAmount" FLOAT8 DEFAULT 0.0,
    "totalQuantity" INTEGER NOT NULL,
    "taxAmount" FLOAT8 DEFAULT 0.0,
    status TEXT NOT NULL,
    "isSynced" SMALLINT DEFAULT 0,
    "createdBy" TEXT NOT NULL,
    "lastSyncedAt" TIMESTAMPTZ DEFAULT NOW(),
    "createdAt" TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE ashfoam_sale_order_items (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    "saleOrderId" UUID REFERENCES ashfoam_sale_orders(id) ON DELETE CASCADE,
    "productId" UUID REFERENCES ashfoam_inventory(id),
    "productName" TEXT NOT NULL,
    quantity INTEGER NOT NULL,
    "unitPrice" FLOAT8 NOT NULL,
    "totalPrice" FLOAT8 NOT NULL,
    "discountAmount" FLOAT8 DEFAULT 0.0,
    "taxAmount" FLOAT8 DEFAULT 0.0,
    "isSynced" SMALLINT DEFAULT 0,
    "lastSyncedAt" TIMESTAMPTZ
);

CREATE TABLE ashfoam_invoices (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    invoice_number TEXT UNIQUE NOT NULL,
    customer_id UUID REFERENCES ashfoam_customers(id),
    customer_name TEXT,
    total_amount FLOAT8 NOT NULL,
    status TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE ashfoam_invoice_items (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    invoice_id UUID REFERENCES ashfoam_invoices(id) ON DELETE CASCADE,
    product_id UUID REFERENCES ashfoam_inventory(id),
    description TEXT NOT NULL,
    quantity INTEGER NOT NULL,
    unit_price FLOAT8 NOT NULL,
    total_price FLOAT8 NOT NULL
);

-- 6. Proformas and Waybills
CREATE TABLE ashfoam_proformas (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    party_name TEXT,
    party_address TEXT,
    declaration TEXT,
    tax JSONB, -- Stored as JSONB per user request
    total_quantity INTEGER NOT NULL,
    total_amount FLOAT8 NOT NULL,
    is_deleted SMALLINT DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE ashfoam_proforma_items (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    proforma_id UUID REFERENCES ashfoam_proformas(id) ON DELETE CASCADE,
    product_id UUID REFERENCES ashfoam_inventory(id),
    product_name TEXT NOT NULL,
    quantity INTEGER NOT NULL,
    unit_price FLOAT8 NOT NULL,
    discount_percentage FLOAT8 DEFAULT 0.0,
    total_amount FLOAT8 NOT NULL
);

CREATE TABLE ashfoam_waybills (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    "mainContent" JSONB,
    "orderNumber" TEXT NOT NULL,
    "dispatchDocNumber" TEXT NOT NULL,
    "deliveryNote" TEXT NOT NULL,
    "senderName" TEXT NOT NULL,
    destination TEXT NOT NULL,
    "dispatchDate" TIMESTAMPTZ NOT NULL,
    "partyName" TEXT NOT NULL,
    "createdBy" TEXT NOT NULL,
    "isDeleted" SMALLINT DEFAULT 0,
    "createdAt" TIMESTAMPTZ DEFAULT NOW(),
    "updatedAt" TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE ashfoam_waybill_items (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    waybill_id UUID REFERENCES ashfoam_waybills(id) ON DELETE CASCADE,
    product_id UUID REFERENCES ashfoam_inventory(id),
    product_name TEXT NOT NULL,
    quantity INTEGER NOT NULL,
    unit_price FLOAT8 NOT NULL,
    discount_percentage FLOAT8 DEFAULT 0.0,
    total_amount FLOAT8 NOT NULL
);

-- 7. Other Transactional Tables
CREATE TABLE ashfoam_receipts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    receipt_number TEXT UNIQUE NOT NULL,
    invoice_id UUID REFERENCES ashfoam_invoices(id),
    amount_paid FLOAT8 NOT NULL,
    payment_method TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE ashfoam_payments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    amount FLOAT8 NOT NULL,
    payment_method TEXT NOT NULL,
    reference TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE ashfoam_branch_payments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    branch_id UUID,
    branch_name TEXT,
    amount FLOAT8 NOT NULL,
    note TEXT,
    title TEXT NOT NULL,
    created_by TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE ashfoam_expenses (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title TEXT NOT NULL,
    description TEXT,
    amount FLOAT8 NOT NULL,
    category TEXT NOT NULL,
    date TIMESTAMPTZ NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 8. Returns and Credit Notes
CREATE TABLE ashfoam_return_orders (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    return_number TEXT UNIQUE NOT NULL,
    invoice_id UUID REFERENCES ashfoam_invoices(id),
    customer_name TEXT,
    total_amount FLOAT8 NOT NULL,
    status TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE ashfoam_return_order_items (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    return_order_id UUID REFERENCES ashfoam_return_orders(id) ON DELETE CASCADE,
    product_id UUID REFERENCES ashfoam_inventory(id),
    quantity INTEGER NOT NULL,
    reason TEXT
);

CREATE TABLE ashfoam_credit_notes (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    credit_note_number TEXT UNIQUE NOT NULL,
    invoice_id UUID REFERENCES ashfoam_invoices(id),
    return_order_id UUID REFERENCES ashfoam_return_orders(id),
    customer_name TEXT,
    total_amount FLOAT8 NOT NULL,
    applied_amount FLOAT8 DEFAULT 0.0,
    status TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE ashfoam_credit_note_items (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    credit_note_id UUID REFERENCES ashfoam_credit_notes(id) ON DELETE CASCADE,
    description TEXT NOT NULL,
    quantity INTEGER NOT NULL,
    total_price FLOAT8 NOT NULL
);

-- 9. Logistics and Reports
CREATE TABLE ashfoam_stock_transfers (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    transfer_number TEXT UNIQUE NOT NULL,
    from_branch_id UUID REFERENCES ashfoam_branches(id),
    to_branch_id UUID REFERENCES ashfoam_branches(id),
    status TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE ashfoam_stock_transfer_items (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    stock_transfer_id UUID REFERENCES ashfoam_stock_transfers(id) ON DELETE CASCADE,
    product_id UUID REFERENCES ashfoam_inventory(id),
    quantity INTEGER NOT NULL
);

CREATE TABLE ashfoam_stock_reports (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    branch_id UUID REFERENCES ashfoam_branches(id),
    report_date TIMESTAMPTZ NOT NULL,
    data JSONB -- Stored as JSONB
);

-- Row Level Security (RLS) - Enable for all ashfoam tables
DO $$
DECLARE
    t text;
BEGIN
    FOR t IN (SELECT table_name FROM information_schema.tables WHERE table_name LIKE 'ashfoam_%' AND table_schema = 'public') LOOP
        EXECUTE format('ALTER TABLE public.%I ENABLE ROW LEVEL SECURITY', t);
        EXECUTE format('DROP POLICY IF EXISTS "Authenticated users can perform all actions" ON public.%I', t);
        EXECUTE format('CREATE POLICY "Authenticated users can perform all actions" ON public.%I FOR ALL TO authenticated USING (true) WITH CHECK (true)', t);
    END LOOP;
END $$;

-- 10. Triggers for Real-time Inventory Adjustments
CREATE OR REPLACE FUNCTION update_stock_after_sale()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE ashfoam_inventory
    SET quantity = quantity - NEW.quantity
    WHERE id = NEW."productId";
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trigger_update_stock_after_sale ON ashfoam_sale_order_items;
CREATE TRIGGER trigger_update_stock_after_sale
AFTER INSERT ON ashfoam_sale_order_items
FOR EACH ROW
EXECUTE FUNCTION update_stock_after_sale();

CREATE OR REPLACE FUNCTION update_stock_after_return()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE ashfoam_inventory
    SET quantity = quantity + NEW.quantity
    WHERE id = NEW.product_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trigger_update_stock_after_return ON ashfoam_return_order_items;
CREATE TRIGGER trigger_update_stock_after_return
AFTER INSERT ON ashfoam_return_order_items
FOR EACH ROW
EXECUTE FUNCTION update_stock_after_return();
