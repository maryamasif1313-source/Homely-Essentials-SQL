CREATE DATABASE homely_essentials;
USE homely_essentials;
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    password VARCHAR(255),
    role ENUM('customer','admin') DEFAULT 'customer',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO users (full_name, email, phone, role) VALUES
('Admin Homely', 'admin@homelyessentials.pk', '03000000000', 'admin'),
('Ayesha Khan', 'ayesha@gmail.com', '03123456789', 'customer'),
('Sara Ali', 'sara@gmail.com', '03219876543', 'customer');
CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO categories (name, description) VALUES
('Dinner Sets', 'Complete dinnerware sets for family meals'),
('Stanleys', 'Insulated tumblers and bottles'),
('Water Sets', 'Glass and plastic water serving sets'),
('Serving', 'Serving trays, bowls and platters'),
('Crockery', 'Plates, cups and bowls'),
('Kitchen Accessories', 'Daily use kitchen items');
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT,
    name VARCHAR(150) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    image VARCHAR(255),
    description TEXT,
    stock INT DEFAULT 10,
    is_featured BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);
INSERT INTO products (category_id, name, price, image, description, is_featured) VALUES
(1, 'Complete Dinner Set', 8500, 'dinner-set.jpg', 'Premium ceramic dinner set for 6 persons', TRUE),
(1, 'Royal White Dinner Set', 9200, 'royal-white.jpg', 'Elegant white dinnerware set', FALSE),
(1, 'Floral Dinner Set', 7800, 'floral-set.jpg', 'Printed floral design dinner set', FALSE),
(2, 'Stanley Tumbler', 3200, 'stanley.jpg', 'Original insulated tumbler for hot & cold drinks', TRUE),
(2, 'Stanley Travel Mug', 3500, 'travel-mug.jpg', 'Leak proof travel mug', FALSE),
(2, 'Stanley Water Bottle', 4000, 'water-bottle.jpg', 'Stainless steel water bottle', FALSE),
(3, 'Glass Water Set', 2200, 'water-set.jpg', '6 glasses with water jug', TRUE),
(3, 'Crystal Water Set', 2800, 'crystal-set.jpg', 'Premium crystal water set', FALSE),
(3, 'Plastic Water Set', 1500, 'plastic-set.jpg', 'Durable plastic water set', FALSE),
(4, 'Wooden Serving Tray', 1950, 'serving-tray.jpg', 'Handcrafted wooden serving tray', TRUE),
(4, 'Marble Serving Tray', 3500, 'marble-tray.jpg', 'Luxury marble tray', FALSE),
(4, 'Snack Serving Platter', 1800, 'snack-platter.jpg', 'Perfect for tea time snacks', FALSE),
(5, 'Tea Cup Set', 2600, 'tea-cups.jpg', '6 ceramic tea cups with saucers', FALSE),
(5, 'Soup Bowl Set', 2100, 'soup-bowls.jpg', 'Soup bowls for everyday use', FALSE),
(6, 'Spice Jar Set', 2400, 'spice-jars.jpg', 'Glass spice jars with stand', FALSE),
(6, 'Cutlery Holder', 1700, 'cutlery-holder.jpg', 'Stylish kitchen cutlery holder', FALSE);
CREATE TABLE cart (
    cart_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
INSERT INTO cart (user_id) VALUES
(2),
(3);
CREATE TABLE cart_items (
    cart_item_id INT AUTO_INCREMENT PRIMARY KEY,
    cart_id INT,
    product_id INT,
    quantity INT DEFAULT 1,
    FOREIGN KEY (cart_id) REFERENCES cart(cart_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
INSERT INTO cart_items (cart_id, product_id, quantity) VALUES
(1, 1, 1),
(1, 4, 2),
(2, 7, 1);
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    address TEXT NOT NULL,
    total_amount DECIMAL(10,2),
    order_status ENUM('pending','confirmed','shipped','delivered','cancelled') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO orders (customer_name, phone, address, total_amount, order_status) VALUES
('Ayesha Khan', '03123456789', 'Johar Town, Lahore', 11700, 'confirmed'),
('Sara Ali', '03219876543', 'Gulshan, Karachi', 2200, 'pending');
CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 8500),
(1, 4, 1, 3200),
(2, 7, 1, 2200);
CREATE TABLE inquiries (
    inquiry_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    phone VARCHAR(20),
    message TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO inquiries (name, phone, message) VALUES
('Hina', '03011223344', 'Is Stanley tumbler available in pink color?'),
('Ali', '03455667788', 'Do you deliver to Islamabad?');
CREATE TABLE reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    customer_name VARCHAR(100),
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
INSERT INTO reviews (product_id, customer_name, rating, comment) VALUES
(1, 'Ayesha Khan', 5, 'Beautiful quality! Loved it.'),
(4, 'Sara Ali', 4, 'Keeps drinks cold for long hours'),
(10, 'Hina', 5, 'Very elegant tray');

