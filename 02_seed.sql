USE garage_mini;
INSERT INTO teams (team_id, name) VALUES
(1, 'Tổ Động Cơ - Hộp Số'),
(2, 'Tổ Điện - Điện Lạnh'),
(3, 'Tổ Gầm - Thắng'),
(4, 'Tổ Đồng - Sơn'),
(5, 'Tổ Bảo Dưỡng Nhanh');
INSERT INTO technicians (technician_id, full_name, email, skill, team_id) VALUES
(1, 'Nguyễn Huy Bình', 'nghbinh@gmail.com', 'Động cơ tổng quát', 1),
(2, 'Đặng Đình Gia Bảo', 'bao.ddg@gmail.com', 'Hệ thống điện', 2),
(3, 'Phạm Lê Bảo Quỳnh', 'quynh.plb@gmail.com', 'Sửa chữa chung', 1),
(4, 'Trần Đức Minh', 'minh.td@gmail.com', 'Đồng sơn ô tô', 3),
(5, 'Trần Văn Khanh', 'Khanhtran@gmail.com', 'Bảo dưỡng định kỳ', 4),
(6, 'Lê Văn Linh', 'linhLV@gmail.com', 'Hệ thống điện cao áp', 5);
INSERT INTO customers (customer_id, full_name, phone, address) VALUES
(1, 'Trần Văn An', '0901234567', '123 Lê Lợi, Hai Bà Trưng, Hà Nội'),
(2, 'Lê Thị Bình', '0912345678', '456 Hai Bà Trưng, Hai Bà Trưng, Hà Nội'),
(3, 'Nguyễn Tiến Cường', '0923456789', '789 Phố Huế, Hai Bà Trưng, Hà Nội'),
(4, 'Phạm Hải Đăng', '0934567890', '101 Nguyễn Đình Chiểu, Hai Bà Trưng, Hà Nội'),
(5, 'Hoàng Thu Giang', '0945678901', '202 Kim Liên, Kim Liên, Hà Nội'),
(6, 'Bùi Minh Hiếu', '0956789012', '303 Điện Biên Phủ, Hai Bà Trưng, Hà Nội'),
(7, 'Ngô Xuân Khánh', '0967890123', '404 Lý Thường Kiệt, Hai Bà Trưng, Hà Nội'),
(8, 'Vũ Phương Linh', '0978901234', '505 Bà Triệu, Hai Bà Trưng, Hà Nội'),
(9, 'Đinh Gia Long', '0989012345', '606 Chùa Bộc, Đống Đa, Hà Nội'),
(10, 'Đỗ Văn Kiên', '0990123456', '707 Đình Thôn, Từ Liêm, Hà Nội'),
(11, 'Mai Ngọc Ánh', '0909876543', '808 Nguyễn Trãi, Thanh Xuân, Hà Nội');
INSERT INTO repair_orders (order_id, customer_id, technician_id, received_at, status, license_plate) VALUES
(1,  1, 1, '2025-01-10 08:30:00', 'Completed', '51A-123.45'),
(2,  1, 2, '2025-01-22 09:15:00', 'Completed', '51A-123.45'),
(3,  1, 1, '2025-02-15 10:00:00', 'Completed', '51A-123.45'),
(4,  3, 3, '2025-03-12 14:00:00', 'Completed', '59B-456.78'),
(5,  3, 3, '2025-02-18 11:30:00', 'Cancelled', '59B-456.78'),
(6,  1, 1, '2025-04-05 08:45:00', 'Completed', '51A-123.45'),
(7,  2, 2, '2025-05-18 13:20:00', 'Completed', '60C-789.01'),
(8,  4, 4, '2025-06-10 09:00:00', 'Completed', '72D-234.56'), 
(9,  5, 3, '2025-07-25 15:30:00', 'Completed', '49A-567.89'),
(10, 6, 1, '2025-08-14 16:00:00', 'Completed', '61E-890.12'),
(11, 8, 2, '2025-09-02 10:30:00', 'Pending',   '51G-333.44'),
(12, 9, 4, '2025-09-15 14:15:00', 'Pending',   '50E-555.66'), 
(13, 4, 1, '2025-05-20 16:45:00', 'Cancelled', '72D-234.56'),
(14, 7, 6, '2024-11-20 09:30:00', 'Completed', '29A-888.99'),
(15, 8, 2, '2026-01-12 08:00:00', 'Cancelled', '51G-333.44');

INSERT INTO repair_reports (report_id, order_id, fault_description, work_summary, cost) VALUES
(1,  1,  'Động cơ kêu gõ, hao dầu máy', 'Đại tu động cơ, thay séc-măng và phớt gít', 2500000.00),
(2,  2,  'Điều hòa không lạnh sâu', 'Vệ sinh giàn lạnh, nạp ga R134a', 1200000.00),
(3,  3,  'Bảo dưỡng định kỳ 4 vạn km', 'Thay dầu động cơ, lọc dầu, lọc gió động cơ', 800000.00),
(4,  4,  'Bàn đạp phanh bị mút sâu', 'Láng đĩa phanh, thay má phanh gốm', 1500000.00),
(5,  6,  'Lốc điều hòa phát tiếng kêu', 'Thay lốc nén điều hòa chính hãng', 2000000.00),
(6,  7,  'Gầm xe kêu lục cục khi qua ổ gà', 'Thay cao su càng A, thay rô-tuyn cân bằng', 2500000.00),
(7,  8,  'Xước móp cản trước và tai xe', 'Gò nắn phục hồi, sơn sấy công nghệ cao', 2500000.00),
(8,  9,  'Đèn pha chiếu sáng chập chờn', 'Thay cụm bóng đèn Bi-LED siêu sáng', 400000.00),
(9,  10, 'Lốp mòn vẹt, nứt chân chim', 'Thay 4 quả lốp Michelin 205/55R16', 6000000.00),
(10, 14, 'Bảo dưỡng định kỳ năm 2024', 'Vệ sinh kim phun, họng hút buồng đốt', 1000000.00);

INSERT INTO payments (payment_id, order_id, amount, payment_date, method) VALUES
(1,  1,  1500000.00, '2025-01-11 17:00:00', 'Cash'),
(2,  1,  1000000.00, '2025-01-12 09:00:00', 'BankTransfer'),
(3,  2,  1200000.00, '2025-01-23 11:00:00', 'Card'),
(4,  3,   500000.00, '2025-02-16 16:00:00', 'BankTransfer'),
(5,  4,  1500000.00, '2025-03-13 10:30:00', 'Cash'),
(6,  6,  2000000.00, '2025-04-06 14:00:00', 'BankTransfer'),
(7,  8,  2000000.00, '2025-06-12 15:00:00', 'Cash'),
(8,  9,   400000.00, '2025-07-26 17:30:00', 'Card'),
(9,  10, 5000000.00, '2025-08-15 10:00:00', 'BankTransfer'),
(10, 14, 1000000.00, '2024-11-21 08:30:00', 'Cash');

SELECT 
    ro.order_id, 
    ro.status, 
    COUNT(rr.report_id) AS report_count
FROM repair_orders ro
LEFT JOIN repair_reports rr ON ro.order_id = rr.order_id
GROUP BY ro.order_id, ro.status
HAVING (ro.status = 'Completed' AND report_count != 1)
    OR (ro.status != 'Completed' AND report_count > 0);

SELECT 
    ro.order_id, 
    rr.cost AS confirmed_cost, 
    COALESCE(SUM(p.amount), 0) AS total_paid,
    (rr.cost - COALESCE(SUM(p.amount), 0)) AS remaining_debt
FROM repair_orders ro
JOIN repair_reports rr ON ro.order_id = rr.order_id
LEFT JOIN payments p ON ro.order_id = p.order_id
GROUP BY ro.order_id, rr.cost
HAVING total_paid > confirmed_cost;

/*
-- Minh họa 1: Vi phạm ràng buộc chi phí âm (CHECK cost >= 0)
INSERT INTO repair_reports (order_id, fault_description, work_summary, cost)
VALUES (11, 'Lỗi phanh', 'Thay má phanh', -500000);
-- Lỗi mong đợi: Check constraint 'chk_report_cost_non_negative' is violated.

-- Minh họa 2: Vi phạm ràng buộc biển số rỗng (CHECK license_plate not empty)
INSERT INTO repair_orders (customer_id, technician_id, received_at, status, license_plate)
VALUES (1, 1, NOW(), 'Pending', '   ');
-- Lỗi mong đợi: Check constraint 'chk_license_plate_not_empty' is violated.

-- Minh họa 3: Vi phạm số tiền thanh toán không dương (CHECK amount > 0)
INSERT INTO payments (order_id, amount, payment_date, method)
VALUES (1, 0, NOW(), 'Cash');
-- Lỗi mong đợi: Check constraint 'chk_payment_amount_positive' is violated.
*/
