-- Fix product categorization and replace unreliable random stock photos
-- (picsum.photos "seed" images are random and unrelated to the product; a keyword-based
-- real-photo service was tried and rejected -- it returned an inappropriate image for one
-- keyword, which is unacceptable) with deterministic, always-accurate labeled placeholders.

-- "Premium Mouse" was miscategorized under Books; move it to Electronics.
UPDATE products SET category_id = (SELECT id FROM categories WHERE name = 'Electronics')
WHERE sku = 'MOUSE-PREM-1';

-- "Test Widget" is leftover dev test data with no real category fit; deactivate rather
-- than delete (it may be referenced by existing orders/reviews via FK).
UPDATE products SET active = FALSE WHERE sku = 'WIDGET-TEST-1';

-- Replace existing images with labeled placeholders matching each product's category color.
DELETE FROM product_images WHERE product_id IN (SELECT id FROM products WHERE sku IN (
    'KB-001',
    'MOUSE-PREM-1',
    'BOOK-PRAG-1',
    'BOOK-CLEAN-1',
    'ELEC-HEAD-1',
    'ELEC-MON-1',
    'FASH-JACKET-1',
    'FASH-SNEAKER-1',
    'HOME-COOKSET-1',
    'HOME-MUGSET-1',
    'SPORT-YOGA-1',
    'SPORT-BOTTLE-1'
));

INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/4f46e5/ffffff.png?text=Mechanical%20Keyboard', 0 FROM products WHERE sku = 'KB-001';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/4f46e5/ffffff.png?text=Premium%20Mouse', 0 FROM products WHERE sku = 'MOUSE-PREM-1';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/92400e/ffffff.png?text=The%20Pragmatic%20Programmer', 0 FROM products WHERE sku = 'BOOK-PRAG-1';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/92400e/ffffff.png?text=Clean%20Code', 0 FROM products WHERE sku = 'BOOK-CLEAN-1';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/4f46e5/ffffff.png?text=Wireless%20Noise-Cancelling%20Headphones', 0 FROM products WHERE sku = 'ELEC-HEAD-1';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/4f46e5/ffffff.png?text=4K%20Ultra%20HD%20Monitor%2027-inch', 0 FROM products WHERE sku = 'ELEC-MON-1';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/db2777/ffffff.png?text=Classic%20Denim%20Jacket', 0 FROM products WHERE sku = 'FASH-JACKET-1';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/db2777/ffffff.png?text=Running%20Sneakers', 0 FROM products WHERE sku = 'FASH-SNEAKER-1';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/059669/ffffff.png?text=Stainless%20Steel%20Cookware%20Set%20(10-piece)', 0 FROM products WHERE sku = 'HOME-COOKSET-1';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/059669/ffffff.png?text=Ceramic%20Coffee%20Mug%20Set%20(4-piece)', 0 FROM products WHERE sku = 'HOME-MUGSET-1';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/0891b2/ffffff.png?text=Yoga%20Mat%20Premium', 0 FROM products WHERE sku = 'SPORT-YOGA-1';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/0891b2/ffffff.png?text=Insulated%20Water%20Bottle%201L', 0 FROM products WHERE sku = 'SPORT-BOTTLE-1';
