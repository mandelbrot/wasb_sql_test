-- Create the SUPPLIER table
CREATE TABLE SUPPLIER (
    supplier_id TINYINT,
    name VARCHAR
);

-- Create the INVOICE table
CREATE TABLE INVOICE (
    supplier_id TINYINT,
    invoice_amount DECIMAL(8, 2),
    due_date DATE
);

-- Insert suppliers sorted alphabetically
INSERT INTO SUPPLIER (supplier_id, name) VALUES
(1, 'Catering Plus'),
(2, 'Dave''s Discos'),
(3, 'Entertainment tonight'),
(4, 'Ice Ice Baby'),
(5, 'Party Animals');

-- Insert invoices with the corresponding supplier IDs
INSERT INTO INVOICE (supplier_id, invoice_amount, due_date) VALUES
(5, 6000.00, last_day_of_month(CURRENT_DATE + INTERVAL '3' MONTH)),  -- Party Animals
(1, 2000.00, last_day_of_month(CURRENT_DATE + INTERVAL '2' MONTH)),  -- Catering Plus
(1, 1500.00, last_day_of_month(CURRENT_DATE + INTERVAL '3' MONTH)),  -- Catering Plus
(2, 500.00, last_day_of_month(CURRENT_DATE + INTERVAL '1' MONTH)),    -- Dave's Discos
(3, 6000.00, last_day_of_month(CURRENT_DATE + INTERVAL '3' MONTH)),   -- Entertainment tonight
(4, 4000.00, last_day_of_month(CURRENT_DATE + INTERVAL '6' MONTH));    -- Ice Ice Baby