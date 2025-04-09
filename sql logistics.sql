
CREATE DATABASE supplychain_db;
USE supplychain_db;

-- Create tables

-- 1. Products table
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    unit_price DECIMAL(10, 2)
);

-- 2. Warehouses table
CREATE TABLE warehouses (
    warehouse_id INT AUTO_INCREMENT PRIMARY KEY,
    warehouse_name VARCHAR(100),
    location VARCHAR(100)
);

-- 3. Suppliers table
CREATE TABLE suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(100),
    contact_email VARCHAR(100)
);

-- 4. Inventory table (stock per warehouse)
CREATE TABLE inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    warehouse_id INT,
    quantity INT,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouse_id)
);

-- 5. Orders table
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE,
    warehouse_id INT,
    supplier_id INT,
    status VARCHAR(50), -- e.g., 'Pending', 'Delivered', 'Cancelled'
    FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouse_id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

-- 6. Order Items table
CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert sample data

-- Products
INSERT INTO products (product_name, category, unit_price) VALUES
('Surgical Gloves', 'Medical Supplies', 5.50),
('Face Masks', 'Medical Supplies', 2.00),
('Hand Sanitizer', 'Disinfectant', 3.75),
('Thermometer', 'Equipment', 12.90),
('IV Drip Set', 'Medical Supplies', 9.25);

-- Warehouses
INSERT INTO warehouses (warehouse_name, location) VALUES
('Central Hub', 'Delhi'),
('West Wing Depot', 'Mumbai'),
('South Care Storage', 'Chennai');

-- Suppliers
INSERT INTO suppliers (supplier_name, contact_email) VALUES
('MediSupply Co.', 'contact@medisupply.com'),
('HealthPro Ltd.', 'info@healthpro.com'),
('BioEssence Traders', 'sales@bioessence.in');

-- Inventory
INSERT INTO inventory (product_id, warehouse_id, quantity) VALUES
(1, 1, 500),
(2, 1, 800),
(3, 2, 600),
(4, 3, 300),
(5, 2, 250);

-- Orders
INSERT INTO orders (order_date, warehouse_id, supplier_id, status) VALUES
('2025-04-01', 1, 1, 'Delivered'),
('2025-04-03', 2, 2, 'Pending'),
('2025-04-05', 3, 3, 'Delivered');

-- Order Items
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 200),
(1, 2, 300),
(2, 3, 150),
(3, 4, 50),
(3, 5, 70);

SELECT 
    w.warehouse_name,
    p.product_name,
    i.quantity
FROM inventory i
JOIN products p ON i.product_id = p.product_id
JOIN warehouses w ON i.warehouse_id = w.warehouse_id;
SELECT 
    p.product_name,
    SUM(oi.quantity) AS total_ordered
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_ordered DESC;
SELECT status, COUNT(*) AS order_count
FROM orders
GROUP BY status;
SELECT 
    s.supplier_name,
    COUNT(o.order_id) AS total_orders
FROM orders o
JOIN suppliers s ON o.supplier_id = s.supplier_id
GROUP BY s.supplier_name;




