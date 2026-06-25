CREATE DATABASE homely_essentials;
USE homely_essentials;
CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price INT NOT NULL,
    image VARCHAR(255),
    category VARCHAR(50)
);
INSERT INTO products (id, name, price, image, category) VALUES
(1, 'Classic Tea Cups Set', 1800, 'tea-cups.jpg', 'Tea Sets'),
(2, 'Ceramic Coffee Mugs', 2500, 'coffee-mugs.jpg', 'Mugs'),
(3, 'Luxury Dinner Set', 9500, 'luxury-dinner.jpg', 'Dinner Sets'),
(4, 'Glass Water Jug Set', 2100, 'water-jug.jpg', 'Water Sets'),
(5, 'Wooden Serving Tray', 1950, 'serving-tray.jpg', 'Serving'),
(6, 'Porcelain Soup Bowls', 3200, 'soup-bowls.jpg', 'Bowls'),
(7, 'Stanley Tumbler', 3200, 'stanley.jpg', 'Stanleys'),
(8, 'Ceramic Plates Set', 4000, 'plates-set.jpg', 'Plates'),
(9, 'Complete Dinner Set', 8500, 'dinner-set.jpg', 'Dinner Sets'),
(10,'Glass Water Set', 2200, 'water-set.jpg', 'Water Sets'),
(11,'Stanley Travel Mug', 3500, 'stanley-mug.jpg', 'Stanleys'),
(12,'Ceramic Serving Bowl', 2800, 'serving-bowl.jpg', 'Serving'),
(13,'Tea Kettle', 3000, 'tea-kettle.jpg', 'Kitchen'),
(14,'Cutlery Set', 2600, 'cutlery.jpg', 'Cutlery'),
(15,'Coffee Jar Set', 1900, 'coffee-jar.jpg', 'Storage'),
(16,'Dessert Plates', 2300, 'dessert-plates.jpg', 'Plates'),
(17,'Wooden Serving Tray', 1950, 'serving-tray.jpg', 'Serving'),
(18,'Ceramic Milk Jug', 1500, 'milk-jug.jpg', 'Kitchen'),
(19,'Glass Dessert Bowls', 2700, 'dessert-bowls.jpg', 'Bowls'),
(20,'Premium Dinner Set', 10500, 'premium-dinner.jpg', 'Dinner Sets');
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL
);
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
CREATE TABLE order_items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);
INSERT INTO customers (name, phone)
VALUES ('Ayesha Khan', '03012345678');
INSERT INTO orders (customer_id)
VALUES (1);
INSERT INTO order_items (order_id, product_id, quantity)
VALUES (1, 9, 1);
SELECT * FROM products;
SELECT * FROM products
WHERE category = 'Dinner Sets';
SELECT * FROM products
ORDER BY price ASC;
SELECT 
    orders.order_id,
    customers.name AS customer_name,
    customers.phone,
    products.name AS product_name,
    order_items.quantity,
    orders.order_date
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id
JOIN order_items ON orders.order_id = order_items.order_id
JOIN products ON order_items.product_id = products.id;
