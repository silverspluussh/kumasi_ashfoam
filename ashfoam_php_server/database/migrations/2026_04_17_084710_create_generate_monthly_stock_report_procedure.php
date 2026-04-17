<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        if (DB::getDriverName() === 'sqlite') {
            return;
        }

        $procedure = "
            CREATE PROCEDURE IF NOT EXISTS GenerateMonthlyStockReport(
                IN p_month INT,
                IN p_year INT,
                IN p_created_by VARCHAR(255)
            )
            BEGIN
                DECLARE v_report_id CHAR(36);
                DECLARE v_branch_name VARCHAR(255);
                DECLARE v_branch_id CHAR(36);
                
                -- Generate UUID for the report
                SET v_report_id = UUID();
                
                -- Get the first branch (since all data belongs to one branch)
                SELECT id, branch_name INTO v_branch_id, v_branch_name FROM branches LIMIT 1;
                
                INSERT INTO stock_report_summaries (id, branch_id, branch_name, created_by, current_stock, category_stock, created_at, updated_at)
                SELECT 
                    v_report_id,
                    COALESCE(v_branch_id, UUID()),
                    COALESCE(v_branch_name, 'Main Branch'),
                    p_created_by,
                    (
                        SELECT JSON_ARRAYAGG(
                            JSON_OBJECT(
                                'id', i.id,
                                'name', i.name,
                                'sku', i.sku,
                                'quantity', i.quantity,
                                'retail_price', CAST(i.retail_price AS DOUBLE),
                                'quantity_sold', CAST(COALESCE(sales.qty_sold, 0) AS SIGNED),
                                'total_sales', CAST(COALESCE(sales.total_amt, 0.0) AS DOUBLE)
                            )
                        )
                        FROM inventories i
                        LEFT JOIN (
                            SELECT 
                                soi.product_id, 
                                SUM(soi.quantity) as qty_sold, 
                                SUM(soi.total_price) as total_amt
                            FROM sale_order_items soi
                            JOIN sale_orders so ON soi.sale_order_id = so.id
                            WHERE MONTH(so.created_at) = p_month 
                              AND YEAR(so.created_at) = p_year
                            GROUP BY soi.product_id
                        ) sales ON i.id = sales.product_id
                        WHERE i.is_deleted = 0
                    ) AS current_stock,
                    (
                        SELECT JSON_ARRAYAGG(
                            JSON_OBJECT(
                                'category_id', c.id,
                                'category_name', c.name,
                                'total_quantity', CAST(SUM(ci.quantity) AS SIGNED),
                                'total_value', CAST(SUM(ci.quantity * ci.retail_price) AS DOUBLE)
                            )
                        )
                        FROM inventories ci
                        JOIN product_categories c ON ci.category_id = c.id
                        WHERE ci.is_deleted = 0
                        GROUP BY c.id, c.name
                    ) AS category_stock,
                    NOW(),
                    NOW();
                    
                -- Return the report ID
                SELECT v_report_id AS report_id;
            END;
        ";

        DB::unprepared("DROP PROCEDURE IF EXISTS GenerateMonthlyStockReport");
        DB::unprepared($procedure);
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        DB::unprepared("DROP PROCEDURE IF EXISTS GenerateMonthlyStockReport");
    }
};
