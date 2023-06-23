-- Tasarımını yaptığınız tabloları oluşturan sql ifadeleri buraya yazınız.
-- veri tiplerine, nullable olma durumuna, default değerine ve tablolar arası foreign key kullanımına dikkat.

-- Veritabanı oluşturma
CREATE DATABASE hepsiorada;

-- "hepsiorada" veritabanını kullanma
\c hepsiorada;

-- Kategoriler tablosunu oluşturma
CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL,
    CONSTRAINT unique_category_name UNIQUE (category_name)
);

-- Ürünler tablosunu oluşturma
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category_id INT NOT NULL,
    price NUMERIC(10, 2) NOT NULL,
    description TEXT,
    CONSTRAINT fk_products_category_id FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Kullanıcılar tablosunu oluşturma
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    CONSTRAINT check_username_length CHECK (LENGTH(username) > 3)
);

-- Siparişler tablosunu oluşturma
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT NOW(),
    total_amount NUMERIC(10, 2) NOT NULL DEFAULT 0.00,
    CONSTRAINT fk_orders_user_id FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Sipariş Detayları tablosunu oluşturma
CREATE TABLE order_details (
    order_detail_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price NUMERIC(10, 2) NOT NULL,
    CONSTRAINT fk_order_details_order_id FOREIGN KEY (order_id) REFERENCES orders(order_id),
    CONSTRAINT fk_order_details_product_id FOREIGN KEY (product_id) REFERENCES products(product_id)
);