USE garage_mini;
SELECT 
    ro.order_id,
    ro.license_plate,
    ro.received_at,
    ro.status,
    c.customer_id,
    c.full_name AS customer_name,
    t.technician_id,
    t.full_name AS technician_name
FROM repair_orders ro
JOIN customers c ON ro.customer_id = c.customer_id
JOIN technicians t ON ro.technician_id = t.technician_id
WHERE ro.status = 'Completed'
  AND ro.received_at >= '2025-01-01 00:00:00'
  AND ro.received_at <= '2025-01-31 23:59:59'
ORDER BY ro.received_at ASC, ro.order_id ASC;

SELECT 
    tm.team_id,
    tm.name AS team_name,
    COUNT(ro.order_id) AS total_orders_q1
FROM teams tm
LEFT JOIN technicians t ON tm.team_id = t.team_id
LEFT JOIN repair_orders ro ON t.technician_id = ro.technician_id
    AND ro.received_at >= '2025-01-01 00:00:00'
    AND ro.received_at <= '2025-03-31 23:59:59'
GROUP BY tm.team_id, tm.name
ORDER BY total_orders_q1 DESC, tm.team_id ASC;

SELECT DISTINCT
    c.customer_id,
    c.full_name AS customer_name,
    c.phone,
    c.address
FROM customers c
JOIN repair_orders ro ON c.customer_id = ro.customer_id
LEFT JOIN repair_reports rr ON ro.order_id = rr.order_id
WHERE ro.status != 'Cancelled'
  AND rr.report_id IS NULL
ORDER BY c.customer_id ASC;

SELECT 
    tm.team_id,
    tm.name AS team_name,
    COUNT(ro.order_id) AS completed_orders_count,
    ROUND(AVG(rr.cost), 2) AS avg_repair_cost
FROM teams tm
JOIN technicians t ON tm.team_id = t.team_id
JOIN repair_orders ro ON t.technician_id = ro.technician_id
JOIN repair_reports rr ON ro.order_id = rr.order_id
WHERE ro.status = 'Completed'
GROUP BY tm.team_id, tm.name
HAVING COUNT(rr.report_id) > 0
ORDER BY avg_repair_cost DESC, tm.team_id ASC;

SELECT 
    t.technician_id,
    t.full_name AS technician_name,
    t.skill,
    COUNT(ro.order_id) AS completed_orders_count
FROM technicians t
JOIN repair_orders ro ON t.technician_id = ro.technician_id
WHERE ro.status = 'Completed'
  AND ro.received_at >= '2025-01-01 00:00:00'
  AND ro.received_at <= '2025-12-31 23:59:59'
GROUP BY t.technician_id, t.full_name, t.skill
ORDER BY completed_orders_count DESC, t.technician_id ASC
LIMIT 3;

SELECT 
    c.customer_id,
    c.full_name AS customer_name,
    COALESCE(SUM(p.amount), 0.00) AS total_paid_2025
FROM customers c
LEFT JOIN repair_orders ro ON c.customer_id = ro.customer_id
LEFT JOIN payments p ON ro.order_id = p.order_id
    AND p.payment_date >= '2025-01-01 00:00:00'
    AND p.payment_date <= '2025-12-31 23:59:59'
GROUP BY c.customer_id, c.full_name
ORDER BY total_paid_2025 DESC, c.customer_id ASC;

SELECT 
    c.customer_id,
    c.full_name AS customer_name,
    c.phone,
    c.address
FROM customers c
WHERE NOT EXISTS (
    SELECT 1 
    FROM repair_orders ro
    JOIN payments p ON ro.order_id = p.order_id
    WHERE ro.customer_id = c.customer_id
)
ORDER BY c.customer_id ASC;

SELECT 
    c.customer_id,
    c.full_name AS customer_name,
    COALESCE(SUM(rr.cost), 0.00) AS total_confirmed_cost
FROM customers c
LEFT JOIN repair_orders ro ON c.customer_id = ro.customer_id
LEFT JOIN repair_reports rr ON ro.order_id = rr.order_id
GROUP BY c.customer_id, c.full_name
ORDER BY total_confirmed_cost DESC, c.customer_id ASC;

SELECT 
    t.technician_id,
    t.full_name AS technician_name,
    COUNT(ro.order_id) AS total_orders_2025,
    COUNT(CASE WHEN ro.status = 'Cancelled' THEN 1 END) AS cancelled_orders_2025,
    CASE 
        WHEN COUNT(ro.order_id) = 0 THEN NULL
        ELSE ROUND(COUNT(CASE WHEN ro.status = 'Cancelled' THEN 1 END) * 100.0 / COUNT(ro.order_id), 2)
    END AS cancellation_rate_percentage
FROM technicians t
LEFT JOIN repair_orders ro ON t.technician_id = ro.technician_id
    AND ro.received_at >= '2025-01-01 00:00:00'
    AND ro.received_at <= '2025-12-31 23:59:59'
GROUP BY t.technician_id, t.full_name
ORDER BY cancellation_rate_percentage DESC, t.technician_id ASC;

SELECT 
    c.customer_id,
    c.full_name AS customer_name,
    COUNT(ro.order_id) AS completed_orders_count
FROM customers c
JOIN repair_orders ro ON c.customer_id = ro.customer_id
WHERE ro.status = 'Completed'
  AND ro.received_at >= '2025-01-01 00:00:00'
  AND ro.received_at <= '2025-12-31 23:59:59'
GROUP BY c.customer_id, c.full_name
HAVING COUNT(ro.order_id) > 3
ORDER BY completed_orders_count DESC, c.customer_id ASC;