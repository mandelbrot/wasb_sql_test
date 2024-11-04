-- Find cycles in the manager-employee relationships
WITH RECURSIVE EmployeeHierarchy(employee_id, manager_id, cycle_path) AS (
    SELECT 
        employee_id,
        manager_id,
        ARRAY[employee_id] AS cycle_path
    FROM 
        EMPLOYEE
    WHERE 
        employee_id IS NOT NULL

    UNION ALL

    SELECT 
        e.employee_id,
        e.manager_id,
        eh.cycle_path || e.employee_id  -- Append the current employee_id to the cycle path
    FROM 
        EMPLOYEE e
    JOIN 
        EmployeeHierarchy eh ON e.manager_id = eh.employee_id
    WHERE 
        array_position(eh.cycle_path, e.employee_id) = 0   -- Avoid cycles
)
SELECT 
    employee_id,
    cycle_path
FROM 
    EmployeeHierarchy
WHERE 
    array_position(cycle_path, employee_id) > 0 AND cardinality(cycle_path) > 1 -- Only include entries where the employee is in the cycle, excluding single arrays
ORDER BY 
    employee_id;