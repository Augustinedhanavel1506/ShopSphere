CREATE TABLE product_specifications (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    product_id BIGINT NOT NULL,
    spec_key VARCHAR(100) NOT NULL,
    spec_value VARCHAR(500) NOT NULL,
    CONSTRAINT fk_product_specifications_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);
