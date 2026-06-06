CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- ============================================================
-- Identity tables
-- ============================================================
CREATE TABLE IF NOT EXISTS identity_users (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    username   VARCHAR(100) NOT NULL UNIQUE,
    email      VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- Catalog tables
-- ============================================================
CREATE TABLE IF NOT EXISTS catalog_categories (
    id   INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS catalog_products (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(200) NOT NULL,
    description TEXT,
    price       DECIMAL(10,2) NOT NULL,
    stock       INT NOT NULL DEFAULT 0,
    category_id INT NOT NULL,
    image_url   VARCHAR(500),
    created_at  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_product_category FOREIGN KEY (category_id) REFERENCES catalog_categories(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- Order tables
-- ============================================================
CREATE TABLE IF NOT EXISTS order_orders (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    user_id     INT NOT NULL,
    status      VARCHAR(50) NOT NULL DEFAULT 'Pending',
    total       DECIMAL(10,2) NOT NULL DEFAULT 0,
    created_at  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS order_items (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    order_id    INT NOT NULL,
    product_id  INT NOT NULL,
    product_name VARCHAR(200) NOT NULL,
    unit_price  DECIMAL(10,2) NOT NULL,
    quantity    INT NOT NULL DEFAULT 1,
    CONSTRAINT fk_item_order FOREIGN KEY (order_id) REFERENCES order_orders(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- Seed data — categories
-- ============================================================
INSERT IGNORE INTO catalog_categories (name) VALUES
    ('Electronics'),
    ('Books'),
    ('Clothing'),
    ('Home & Kitchen');

-- ============================================================
-- Seed data — 10 sample products
-- ============================================================
INSERT IGNORE INTO catalog_products (name, description, price, stock, category_id, image_url) VALUES
    ('Wireless Mouse',       'Ergonomic wireless mouse with USB receiver',   29.99,  150, 1, NULL),
    ('Mechanical Keyboard',  'RGB mechanical keyboard, blue switches',       89.99,  80,  1, NULL),
    ('USB-C Hub',            '7-in-1 USB-C hub with HDMI and ethernet',     45.00,  200, 1, NULL),
    ('Clean Code',           'Robert C. Martin — software craftsmanship',   39.99,  60,  2, NULL),
    ('Design Patterns',      'Gang of Four classic',                         49.99,  40,  2, NULL),
    ('Domain-Driven Design', 'Eric Evans — tackling complexity in software', 54.99,  35,  2, NULL),
    ('Cotton T-Shirt',       'Unisex cotton t-shirt, multiple colors',      19.99,  300, 3, NULL),
    ('Denim Jacket',         'Classic denim jacket, all sizes',             69.99,  100, 3, NULL),
    ('Coffee Maker',         '12-cup programmable coffee maker',            59.99,  75,  4, NULL),
    ('Cast Iron Skillet',    '10-inch pre-seasoned cast iron skillet',      34.99,  120, 4, NULL);
