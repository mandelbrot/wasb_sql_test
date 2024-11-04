WITH ExpenseAccounts AS (
	SELECT 
		e.employee_id,
		CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
		e.manager_id,
		SUM(exp.unit_price * exp.quantity) AS total_expensed_amount
	FROM EXPENSE exp
	JOIN EMPLOYEE e ON exp.employee_id = e.employee_id
	GROUP BY 1, 2, 3
	HAVING SUM(exp.unit_price * exp.quantity) > 1000
)
SELECT 
	expa.employee_id,
	expa.employee_name,
	expa.manager_id,
	CONCAT(m.first_name, ' ', m.last_name) AS manager_name,
	expa.total_expensed_amount
FROM ExpenseAccounts expa
JOIN EMPLOYEE m ON expa.manager_id = m.employee_id
ORDER BY total_expensed_amount DESC;
