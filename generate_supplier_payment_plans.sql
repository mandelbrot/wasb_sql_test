-- Monthly payment plan for suppliers based on their invoices

-- TODO: didn't have the time to rewrite the query to Trino SQL, but I would do it with cursor, so here is the pseudocode

DO $$
DECLARE
    r RECORD;
    remaining_amount DECIMAL(8, 2);
    payment_amount DECIMAL(8, 2);
    payment_date DATE;
    months_left TINYINT;
BEGIN
    -- Calculate the payment amount and number of months for each supplier
    FOR r IN (
        SELECT 
            s.supplier_id,
            s.name AS supplier_name,
            SUM(i.invoice_amount) AS total_invoice_amount,
            MAX(i.due_date) AS max_due_date,
            DATE_DIFF('month', CURRENT_DATE, MAX(i.due_date)) AS num_payments
        FROM 
            SUPPLIER s
        JOIN 
            INVOICE i ON s.supplier_id = i.supplier_id
        WHERE 
            i.due_date > CURRENT_DATE
        GROUP BY 
            s.supplier_id, s.name
        HAVING 
            DATE_DIFF('month', CURRENT_DATE, MAX(i.due_date)) > 0
    ) LOOP
        -- Set initial values for the cursor
        remaining_amount := r.total_invoice_amount;
        payment_amount := CEIL(remaining_amount / r.num_payments);
        payment_date := last_day_of_month(CURRENT_DATE + INTERVAL '1' MONTH);
        
        -- Loop through the number of payments and output the payment details
        FOR i IN 1..r.num_payments LOOP
            -- Calculate the actual payment amount for the last payment if needed
            IF remaining_amount < payment_amount THEN
                payment_amount := remaining_amount;
            END IF;

            -- Output the payment information
            RAISE NOTICE 'Supplier ID: %, Supplier Name: %, Payment Amount: %, Balance Outstanding: %, Payment Date: %',
                r.supplier_id, r.supplier_name, payment_amount, remaining_amount, payment_date;

            -- Decrease the remaining amount
            remaining_amount := remaining_amount - payment_amount;

            -- Move to the next month
            payment_date := last_day_of_month(payment_date + INTERVAL '1' MONTH);
        END LOOP;
    END LOOP;
END $$;



