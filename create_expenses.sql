CREATE TABLE expense(
    employee_id TINYINT,
    unit_price DECIMAL(8, 2),
    quantity TINYINT
);

INSERT INTO EXPENSE (employee_id, unit_price, quantity) VALUES
(3, 6.50, 14),  -- Alex Jacobson - Drinks, lots of drinks
(3, 11.00, 20), -- Alex Jacobson - More Drinks
(3, 22.00, 18), -- Alex Jacobson - So Many Drinks!
(3, 13.00, 75), -- Alex Jacobson - I bought everyone in the bar a drink!
(9, 300.00, 1),  -- Andrea Ghibaudi - Flights from Mexico back to New York
(4, 40.00, 9),   -- Darren Poynton - Ubers to get us all home
(2, 17.50, 4);   -- Umberto Torrielli - I had too much fun and needed something to eat