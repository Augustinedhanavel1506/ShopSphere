-- Demo data: fuller catalog with real photos for local UI testing.

-- Images for the 3 pre-existing products (previously had none)
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://picsum.photos/seed/mechanical-keyboard-1/800/800', 0 FROM products WHERE sku = 'KB-001';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://picsum.photos/seed/mechanical-keyboard-2/800/800', 1 FROM products WHERE sku = 'KB-001';

INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://picsum.photos/seed/test-widget-1/800/800', 0 FROM products WHERE sku = 'WIDGET-TEST-1';

INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://picsum.photos/seed/gaming-mouse-1/800/800', 0 FROM products WHERE sku = 'MOUSE-PREM-1';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://picsum.photos/seed/gaming-mouse-2/800/800', 1 FROM products WHERE sku = 'MOUSE-PREM-1';

-- New categories
INSERT INTO categories (name, description, image_url, active) VALUES
    ('Fashion', 'Clothing and footwear', 'https://picsum.photos/seed/fashion-cat/600/400', TRUE),
    ('Home & Kitchen', 'Cookware, dining and home essentials', 'https://picsum.photos/seed/home-kitchen-cat/600/400', TRUE),
    ('Sports & Outdoors', 'Fitness and outdoor gear', 'https://picsum.photos/seed/sports-cat/600/400', TRUE);

-- New products
INSERT INTO products (category_id, name, description, price, original_price, sku, active) VALUES
    ((SELECT id FROM categories WHERE name = 'Books'), 'The Pragmatic Programmer', 'Classic guide to software craftsmanship, covering practical techniques every developer should know.', 34.99, 44.99, 'BOOK-PRAG-1', TRUE),
    ((SELECT id FROM categories WHERE name = 'Books'), 'Clean Code', 'A handbook of agile software craftsmanship focused on writing readable, maintainable code.', 29.99, NULL, 'BOOK-CLEAN-1', TRUE),
    ((SELECT id FROM categories WHERE name = 'Electronics'), 'Wireless Noise-Cancelling Headphones', 'Over-ear headphones with active noise cancellation and 30-hour battery life.', 149.99, 199.99, 'ELEC-HEAD-1', TRUE),
    ((SELECT id FROM categories WHERE name = 'Electronics'), '4K Ultra HD Monitor 27-inch', '27-inch 4K IPS monitor with 144Hz refresh rate, ideal for work and gaming.', 329.99, NULL, 'ELEC-MON-1', TRUE),
    ((SELECT id FROM categories WHERE name = 'Fashion'), 'Classic Denim Jacket', 'Timeless regular-fit denim jacket made from 100% cotton.', 59.99, 79.99, 'FASH-JACKET-1', TRUE),
    ((SELECT id FROM categories WHERE name = 'Fashion'), 'Running Sneakers', 'Lightweight breathable sneakers built for everyday running.', 89.99, NULL, 'FASH-SNEAKER-1', TRUE),
    ((SELECT id FROM categories WHERE name = 'Home & Kitchen'), 'Stainless Steel Cookware Set (10-piece)', 'Durable 10-piece stainless steel cookware set with tempered glass lids.', 129.99, 179.99, 'HOME-COOKSET-1', TRUE),
    ((SELECT id FROM categories WHERE name = 'Home & Kitchen'), 'Ceramic Coffee Mug Set (4-piece)', 'Set of 4 handcrafted 350ml ceramic mugs.', 24.99, NULL, 'HOME-MUGSET-1', TRUE),
    ((SELECT id FROM categories WHERE name = 'Sports & Outdoors'), 'Yoga Mat Premium', 'Non-slip 6mm TPE yoga mat with carry strap.', 34.99, NULL, 'SPORT-YOGA-1', TRUE),
    ((SELECT id FROM categories WHERE name = 'Sports & Outdoors'), 'Insulated Water Bottle 1L', 'Vacuum-insulated stainless steel bottle, keeps drinks cold for 24 hours.', 19.99, NULL, 'SPORT-BOTTLE-1', TRUE);

-- Images (2 per new product)
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://picsum.photos/seed/pragmatic-programmer-1/800/800', 0 FROM products WHERE sku = 'BOOK-PRAG-1';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://picsum.photos/seed/clean-code-1/800/800', 0 FROM products WHERE sku = 'BOOK-CLEAN-1';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://picsum.photos/seed/headphones-1/800/800', 0 FROM products WHERE sku = 'ELEC-HEAD-1';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://picsum.photos/seed/headphones-2/800/800', 1 FROM products WHERE sku = 'ELEC-HEAD-1';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://picsum.photos/seed/monitor-1/800/800', 0 FROM products WHERE sku = 'ELEC-MON-1';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://picsum.photos/seed/denim-jacket-1/800/800', 0 FROM products WHERE sku = 'FASH-JACKET-1';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://picsum.photos/seed/denim-jacket-2/800/800', 1 FROM products WHERE sku = 'FASH-JACKET-1';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://picsum.photos/seed/sneakers-1/800/800', 0 FROM products WHERE sku = 'FASH-SNEAKER-1';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://picsum.photos/seed/cookware-1/800/800', 0 FROM products WHERE sku = 'HOME-COOKSET-1';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://picsum.photos/seed/cookware-2/800/800', 1 FROM products WHERE sku = 'HOME-COOKSET-1';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://picsum.photos/seed/mugs-1/800/800', 0 FROM products WHERE sku = 'HOME-MUGSET-1';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://picsum.photos/seed/yoga-mat-1/800/800', 0 FROM products WHERE sku = 'SPORT-YOGA-1';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://picsum.photos/seed/water-bottle-1/800/800', 0 FROM products WHERE sku = 'SPORT-BOTTLE-1';

-- Specifications
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Author', 'David Thomas & Andrew Hunt' FROM products WHERE sku = 'BOOK-PRAG-1';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Pages', '352' FROM products WHERE sku = 'BOOK-PRAG-1';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Author', 'Robert C. Martin' FROM products WHERE sku = 'BOOK-CLEAN-1';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Pages', '464' FROM products WHERE sku = 'BOOK-CLEAN-1';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Battery Life', '30 hours' FROM products WHERE sku = 'ELEC-HEAD-1';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Bluetooth', '5.3' FROM products WHERE sku = 'ELEC-HEAD-1';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Resolution', '3840 x 2160' FROM products WHERE sku = 'ELEC-MON-1';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Refresh Rate', '144Hz' FROM products WHERE sku = 'ELEC-MON-1';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', '100% Cotton Denim' FROM products WHERE sku = 'FASH-JACKET-1';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Fit', 'Regular' FROM products WHERE sku = 'FASH-JACKET-1';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Weight', '280g' FROM products WHERE sku = 'FASH-SNEAKER-1';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Stainless Steel' FROM products WHERE sku = 'HOME-COOKSET-1';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Pieces', '10' FROM products WHERE sku = 'HOME-COOKSET-1';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Capacity', '350ml' FROM products WHERE sku = 'HOME-MUGSET-1';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Pieces', '4' FROM products WHERE sku = 'HOME-MUGSET-1';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Thickness', '6mm' FROM products WHERE sku = 'SPORT-YOGA-1';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'TPE' FROM products WHERE sku = 'SPORT-YOGA-1';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Capacity', '1L' FROM products WHERE sku = 'SPORT-BOTTLE-1';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Stainless Steel' FROM products WHERE sku = 'SPORT-BOTTLE-1';

-- Inventory (mirrors InventoryService.initializeForProduct + a MANUAL_ADJUSTMENT stock-in, matching what the app would record via the admin API)
INSERT INTO inventory (product_id, quantity)
SELECT id, 0 FROM products WHERE sku IN ('BOOK-PRAG-1','BOOK-CLEAN-1','ELEC-HEAD-1','ELEC-MON-1','FASH-JACKET-1','FASH-SNEAKER-1','HOME-COOKSET-1','HOME-MUGSET-1','SPORT-YOGA-1','SPORT-BOTTLE-1');

INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 0, 0, 'INITIAL' FROM products WHERE sku IN ('BOOK-PRAG-1','BOOK-CLEAN-1','ELEC-HEAD-1','ELEC-MON-1','FASH-JACKET-1','FASH-SNEAKER-1','HOME-COOKSET-1','HOME-MUGSET-1','SPORT-YOGA-1','SPORT-BOTTLE-1');

-- Stock most items; leave the monitor and water bottle at 0 to show the "Out of Stock" badge
UPDATE inventory SET quantity = 40 WHERE product_id = (SELECT id FROM products WHERE sku = 'BOOK-PRAG-1');
UPDATE inventory SET quantity = 35 WHERE product_id = (SELECT id FROM products WHERE sku = 'BOOK-CLEAN-1');
UPDATE inventory SET quantity = 25 WHERE product_id = (SELECT id FROM products WHERE sku = 'ELEC-HEAD-1');
UPDATE inventory SET quantity = 15 WHERE product_id = (SELECT id FROM products WHERE sku = 'FASH-JACKET-1');
UPDATE inventory SET quantity = 30 WHERE product_id = (SELECT id FROM products WHERE sku = 'FASH-SNEAKER-1');
UPDATE inventory SET quantity = 12 WHERE product_id = (SELECT id FROM products WHERE sku = 'HOME-COOKSET-1');
UPDATE inventory SET quantity = 50 WHERE product_id = (SELECT id FROM products WHERE sku = 'HOME-MUGSET-1');
UPDATE inventory SET quantity = 45 WHERE product_id = (SELECT id FROM products WHERE sku = 'SPORT-YOGA-1');

INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT product_id, quantity, quantity, 'MANUAL_ADJUSTMENT' FROM inventory
WHERE product_id IN (SELECT id FROM products WHERE sku IN ('BOOK-PRAG-1','BOOK-CLEAN-1','ELEC-HEAD-1','FASH-JACKET-1','FASH-SNEAKER-1','HOME-COOKSET-1','HOME-MUGSET-1','SPORT-YOGA-1'))
AND quantity > 0;
