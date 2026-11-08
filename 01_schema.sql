DROP DATABASE IF exists garage_mini;
CREATE DATABASE garage_mini CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE garage_mini;
CREATE TABLE teams (
    team_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);
CREATE TABLE technicians (
    technician_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    skill VARCHAR(100),
    team_id INT NOT NULL,
    FOREIGN KEY (team_id) REFERENCES teams(team_id) ON DELETE RESTRICT ON UPDATE CASCADE
);
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    address VARCHAR(255)
);
CREATE TABLE repair_orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    technician_id INT NOT NULL,
    received_at DATETIME NOT NULL,
    status ENUM('Pending', 'Completed', 'Cancelled') NOT NULL DEFAULT 'Pending',
    license_plate VARCHAR(20) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (technician_id) REFERENCES technicians(technician_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT chk_license_plate_not_empty CHECK (CHAR_LENGTH(TRIM(license_plate)) > 0)
);
CREATE TABLE repair_reports (
    report_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL UNIQUE,
    fault_description TEXT NOT NULL,
    work_summary TEXT NOT NULL,
    cost DECIMAL(15, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES repair_orders(order_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT chk_cost_non_negative CHECK (cost >= 0)
);
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    amount DECIMAL(15, 2) NOT NULL,
    payment_date DATETIME NOT NULL,
    method ENUM('Cash', 'BankTransfer', 'Card') NOT NULL,
    FOREIGN KEY (order_id) REFERENCES repair_orders(order_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT chk_payment_amount_positive CHECK (amount > 0)
);