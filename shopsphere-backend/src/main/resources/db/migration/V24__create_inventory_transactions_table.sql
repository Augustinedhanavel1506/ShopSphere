CREATE TABLE inventory_transactions (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    product_id BIGINT NOT NULL,
    change_quantity INT NOT NULL,
    resulting_quantity INT NOT NULL,
    reason VARCHAR(30) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_inventory_transactions_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);
