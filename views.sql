USE garage_mini;
CREATE OR REPLACE VIEW v_detail AS
SELECT 
    ro.order_id,
    ro.received_at,
    ro.status,
    ro.license_plate,
    c.customer_id,
    c.full_name AS customer_name,
    t.technician_id,
    t.full_name AS technician_name,
    tm.team_id,
    tm.name AS team_name,
    rr.cost AS repair_cost
FROM repair_orders ro
JOIN customers c ON ro.customer_id = c.customer_id
JOIN technicians t ON ro.technician_id = t.technician_id
JOIN teams tm ON t.team_id = tm.team_id
LEFT JOIN repair_reports rr ON ro.order_id = rr.order_id;

CREATE OR REPLACE VIEW v_group_summary AS
SELECT 
    tm.team_id,
    tm.name AS team_name,
    COUNT(ro.order_id) AS total_orders,
    COUNT(CASE WHEN ro.status = 'Completed' THEN 1 END) AS completed_orders,
    COUNT(CASE WHEN ro.status = 'Cancelled' THEN 1 END) AS cancelled_orders,
    COALESCE(SUM(rr.cost), 0.00) AS total_cost
FROM teams tm
LEFT JOIN technicians t ON tm.team_id = t.team_id
LEFT JOIN repair_orders ro ON t.technician_id = ro.technician_id
LEFT JOIN repair_reports rr ON ro.order_id = rr.order_id
GROUP BY tm.team_id, tm.name;

CREATE OR REPLACE VIEW v_debt AS
SELECT 
    c.customer_id,
    c.full_name AS customer_name,
    COALESCE(costs.total_confirmed_cost, 0.00) AS total_confirmed_cost,
    COALESCE(payments_sum.total_paid, 0.00) AS total_paid,
    (COALESCE(costs.total_confirmed_cost, 0.00) - COALESCE(payments_sum.total_paid, 0.00)) AS debt
FROM customers c
LEFT JOIN (
    SELECT 
        ro.customer_id,
        SUM(rr.cost) AS total_confirmed_cost
    FROM repair_orders ro
    JOIN repair_reports rr ON ro.order_id = rr.order_id
    GROUP BY ro.customer_id
) costs ON c.customer_id = costs.customer_id
LEFT JOIN (
    SELECT 
        ro.customer_id,
        SUM(p.amount) AS total_paid
    FROM repair_orders ro
    JOIN payments p ON ro.order_id = p.order_id
    GROUP BY ro.customer_id
) payments_sum ON c.customer_id = payments_sum.customer_id;