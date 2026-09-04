-- Bulk catalog: 30 additional real, on-topic products per active category,
-- each with a category-matched labeled image, a spec, and initial inventory.


-- Electronics
INSERT INTO products (category_id, name, description, price, original_price, sku, active) VALUES
    ((SELECT id FROM categories WHERE name = 'Electronics'), 'Ultrabook Laptop 14-inch', 'Slim and lightweight laptop with all-day battery life for work and travel.', 699.99, 849.99, 'ELEC-101', TRUE),
    ((SELECT id FROM categories WHERE name = 'Electronics'), 'Smartphone 128GB', 'Full-screen smartphone with a triple-lens camera system and fast charging.', 499.99, 599.99, 'ELEC-102', TRUE),
    ((SELECT id FROM categories WHERE name = 'Electronics'), 'Android Tablet 10.5-inch', 'Lightweight tablet ideal for streaming, reading, and browsing.', 229.99, NULL, 'ELEC-103', TRUE),
    ((SELECT id FROM categories WHERE name = 'Electronics'), 'Smartwatch Fitness Edition', 'Tracks heart rate, sleep, and workouts with a week-long battery.', 149.99, 189.99, 'ELEC-104', TRUE),
    ((SELECT id FROM categories WHERE name = 'Electronics'), 'Bluetooth Portable Speaker', 'Waterproof speaker with deep bass and 12-hour playtime.', 59.99, NULL, 'ELEC-105', TRUE),
    ((SELECT id FROM categories WHERE name = 'Electronics'), 'True Wireless Earbuds', 'Compact earbuds with active noise cancellation and touch controls.', 79.99, 99.99, 'ELEC-106', TRUE),
    ((SELECT id FROM categories WHERE name = 'Electronics'), 'Home Gaming Console', 'Next-gen console for high-performance 4K gaming.', 499.99, NULL, 'ELEC-107', TRUE),
    ((SELECT id FROM categories WHERE name = 'Electronics'), 'Mirrorless Digital Camera', '24MP mirrorless camera with interchangeable lens mount.', 649.99, NULL, 'ELEC-108', TRUE),
    ((SELECT id FROM categories WHERE name = 'Electronics'), 'Mini Camera Drone', 'Foldable drone with 4K stabilized camera and GPS return-home.', 199.99, 249.99, 'ELEC-109', TRUE),
    ((SELECT id FROM categories WHERE name = 'Electronics'), 'Portable External Hard Drive 2TB', 'Rugged external drive for fast, reliable backups.', 69.99, NULL, 'ELEC-110', TRUE),
    ((SELECT id FROM categories WHERE name = 'Electronics'), '1080p HD Webcam', 'Plug-and-play webcam with built-in noise-cancelling mic.', 34.99, NULL, 'ELEC-111', TRUE),
    ((SELECT id FROM categories WHERE name = 'Electronics'), 'Dual-Band Wi-Fi Router', 'Whole-home mesh-ready router with gigabit ports.', 79.99, NULL, 'ELEC-112', TRUE),
    ((SELECT id FROM categories WHERE name = 'Electronics'), '20000mAh Power Bank', 'High-capacity power bank with dual USB-C fast charging.', 39.99, 49.99, 'ELEC-113', TRUE),
    ((SELECT id FROM categories WHERE name = 'Electronics'), 'Graphics Card 8GB', 'Mid-range GPU for smooth 1440p gaming and creative work.', 399.99, NULL, 'ELEC-114', TRUE),
    ((SELECT id FROM categories WHERE name = 'Electronics'), 'Mechanical Gaming Keyboard RGB', 'Hot-swappable switches with per-key RGB lighting.', 89.99, NULL, 'ELEC-115', TRUE),
    ((SELECT id FROM categories WHERE name = 'Electronics'), 'Wireless Gaming Mouse', 'Ultra-light wireless mouse with adjustable DPI.', 49.99, 69.99, 'ELEC-116', TRUE),
    ((SELECT id FROM categories WHERE name = 'Electronics'), 'Compact Laser Printer', 'Fast monochrome laser printer for home offices.', 129.99, NULL, 'ELEC-117', TRUE),
    ((SELECT id FROM categories WHERE name = 'Electronics'), '24-inch Full HD Monitor', 'IPS monitor with slim bezels and eye-comfort mode.', 119.99, NULL, 'ELEC-118', TRUE),
    ((SELECT id FROM categories WHERE name = 'Electronics'), 'Mini Portable Projector', 'Pocket-sized projector with built-in speaker.', 89.99, NULL, 'ELEC-119', TRUE),
    ((SELECT id FROM categories WHERE name = 'Electronics'), 'Soundbar with Subwoofer', '2.1-channel soundbar for immersive home theater audio.', 149.99, 199.99, 'ELEC-120', TRUE),
    ((SELECT id FROM categories WHERE name = 'Electronics'), 'Wireless Security Camera', 'Weatherproof outdoor camera with night vision and motion alerts.', 44.99, NULL, 'ELEC-121', TRUE),
    ((SELECT id FROM categories WHERE name = 'Electronics'), 'Smart LED Bulb (Wi-Fi)', 'Dimmable color-changing bulb controlled from your phone.', 14.99, NULL, 'ELEC-122', TRUE),
    ((SELECT id FROM categories WHERE name = 'Electronics'), 'Fitness Tracker Band', 'Slim tracker for steps, heart rate, and sleep monitoring.', 29.99, NULL, 'ELEC-123', TRUE),
    ((SELECT id FROM categories WHERE name = 'Electronics'), 'Waterproof Action Camera', '4K action camera with mounting kit for sports and travel.', 89.99, 119.99, 'ELEC-124', TRUE),
    ((SELECT id FROM categories WHERE name = 'Electronics'), 'VR Headset', 'Standalone virtual reality headset with wide field of view.', 299.99, NULL, 'ELEC-125', TRUE),
    ((SELECT id FROM categories WHERE name = 'Electronics'), 'E-Reader Paperwhite', 'Glare-free e-ink display with weeks of battery life.', 139.99, NULL, 'ELEC-126', TRUE),
    ((SELECT id FROM categories WHERE name = 'Electronics'), 'USB-C Hub 7-in-1', 'Multiport adapter with HDMI, USB-A, and SD card slots.', 29.99, NULL, 'ELEC-127', TRUE),
    ((SELECT id FROM categories WHERE name = 'Electronics'), 'USB Condenser Microphone', 'Studio-quality mic for streaming and podcasting.', 59.99, 79.99, 'ELEC-128', TRUE),
    ((SELECT id FROM categories WHERE name = 'Electronics'), 'Graphics Drawing Tablet', 'Pressure-sensitive tablet for digital art and design.', 79.99, NULL, 'ELEC-129', TRUE),
    ((SELECT id FROM categories WHERE name = 'Electronics'), 'Noise-Isolating Wired Earphones', 'In-ear earphones with a built-in microphone.', 14.99, NULL, 'ELEC-130', TRUE);

-- Electronics images
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/4f46e5/ffffff.png?text=Ultrabook%20Laptop%2014-inch', 0 FROM products WHERE sku = 'ELEC-101';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/4f46e5/ffffff.png?text=Smartphone%20128GB', 0 FROM products WHERE sku = 'ELEC-102';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/4f46e5/ffffff.png?text=Android%20Tablet%2010.5-inch', 0 FROM products WHERE sku = 'ELEC-103';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/4f46e5/ffffff.png?text=Smartwatch%20Fitness%20Edition', 0 FROM products WHERE sku = 'ELEC-104';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/4f46e5/ffffff.png?text=Bluetooth%20Portable%20Speaker', 0 FROM products WHERE sku = 'ELEC-105';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/4f46e5/ffffff.png?text=True%20Wireless%20Earbuds', 0 FROM products WHERE sku = 'ELEC-106';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/4f46e5/ffffff.png?text=Home%20Gaming%20Console', 0 FROM products WHERE sku = 'ELEC-107';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/4f46e5/ffffff.png?text=Mirrorless%20Digital%20Camera', 0 FROM products WHERE sku = 'ELEC-108';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/4f46e5/ffffff.png?text=Mini%20Camera%20Drone', 0 FROM products WHERE sku = 'ELEC-109';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/4f46e5/ffffff.png?text=Portable%20External%20Hard%20Drive%202TB', 0 FROM products WHERE sku = 'ELEC-110';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/4f46e5/ffffff.png?text=1080p%20HD%20Webcam', 0 FROM products WHERE sku = 'ELEC-111';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/4f46e5/ffffff.png?text=Dual-Band%20Wi-Fi%20Router', 0 FROM products WHERE sku = 'ELEC-112';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/4f46e5/ffffff.png?text=20000mAh%20Power%20Bank', 0 FROM products WHERE sku = 'ELEC-113';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/4f46e5/ffffff.png?text=Graphics%20Card%208GB', 0 FROM products WHERE sku = 'ELEC-114';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/4f46e5/ffffff.png?text=Mechanical%20Gaming%20Keyboard%20RGB', 0 FROM products WHERE sku = 'ELEC-115';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/4f46e5/ffffff.png?text=Wireless%20Gaming%20Mouse', 0 FROM products WHERE sku = 'ELEC-116';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/4f46e5/ffffff.png?text=Compact%20Laser%20Printer', 0 FROM products WHERE sku = 'ELEC-117';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/4f46e5/ffffff.png?text=24-inch%20Full%20HD%20Monitor', 0 FROM products WHERE sku = 'ELEC-118';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/4f46e5/ffffff.png?text=Mini%20Portable%20Projector', 0 FROM products WHERE sku = 'ELEC-119';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/4f46e5/ffffff.png?text=Soundbar%20with%20Subwoofer', 0 FROM products WHERE sku = 'ELEC-120';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/4f46e5/ffffff.png?text=Wireless%20Security%20Camera', 0 FROM products WHERE sku = 'ELEC-121';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/4f46e5/ffffff.png?text=Smart%20LED%20Bulb%20(Wi-Fi)', 0 FROM products WHERE sku = 'ELEC-122';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/4f46e5/ffffff.png?text=Fitness%20Tracker%20Band', 0 FROM products WHERE sku = 'ELEC-123';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/4f46e5/ffffff.png?text=Waterproof%20Action%20Camera', 0 FROM products WHERE sku = 'ELEC-124';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/4f46e5/ffffff.png?text=VR%20Headset', 0 FROM products WHERE sku = 'ELEC-125';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/4f46e5/ffffff.png?text=E-Reader%20Paperwhite', 0 FROM products WHERE sku = 'ELEC-126';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/4f46e5/ffffff.png?text=USB-C%20Hub%207-in-1', 0 FROM products WHERE sku = 'ELEC-127';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/4f46e5/ffffff.png?text=USB%20Condenser%20Microphone', 0 FROM products WHERE sku = 'ELEC-128';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/4f46e5/ffffff.png?text=Graphics%20Drawing%20Tablet', 0 FROM products WHERE sku = 'ELEC-129';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/4f46e5/ffffff.png?text=Noise-Isolating%20Wired%20Earphones', 0 FROM products WHERE sku = 'ELEC-130';

-- Electronics specs
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Warranty', '1 Year' FROM products WHERE sku = 'ELEC-101';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Warranty', '2 Years' FROM products WHERE sku = 'ELEC-102';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Warranty', '6 Months' FROM products WHERE sku = 'ELEC-103';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Warranty', '3 Years' FROM products WHERE sku = 'ELEC-104';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Warranty', '1 Year' FROM products WHERE sku = 'ELEC-105';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Warranty', '2 Years' FROM products WHERE sku = 'ELEC-106';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Warranty', '6 Months' FROM products WHERE sku = 'ELEC-107';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Warranty', '3 Years' FROM products WHERE sku = 'ELEC-108';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Warranty', '1 Year' FROM products WHERE sku = 'ELEC-109';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Warranty', '2 Years' FROM products WHERE sku = 'ELEC-110';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Warranty', '6 Months' FROM products WHERE sku = 'ELEC-111';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Warranty', '3 Years' FROM products WHERE sku = 'ELEC-112';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Warranty', '1 Year' FROM products WHERE sku = 'ELEC-113';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Warranty', '2 Years' FROM products WHERE sku = 'ELEC-114';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Warranty', '6 Months' FROM products WHERE sku = 'ELEC-115';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Warranty', '3 Years' FROM products WHERE sku = 'ELEC-116';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Warranty', '1 Year' FROM products WHERE sku = 'ELEC-117';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Warranty', '2 Years' FROM products WHERE sku = 'ELEC-118';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Warranty', '6 Months' FROM products WHERE sku = 'ELEC-119';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Warranty', '3 Years' FROM products WHERE sku = 'ELEC-120';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Warranty', '1 Year' FROM products WHERE sku = 'ELEC-121';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Warranty', '2 Years' FROM products WHERE sku = 'ELEC-122';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Warranty', '6 Months' FROM products WHERE sku = 'ELEC-123';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Warranty', '3 Years' FROM products WHERE sku = 'ELEC-124';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Warranty', '1 Year' FROM products WHERE sku = 'ELEC-125';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Warranty', '2 Years' FROM products WHERE sku = 'ELEC-126';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Warranty', '6 Months' FROM products WHERE sku = 'ELEC-127';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Warranty', '3 Years' FROM products WHERE sku = 'ELEC-128';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Warranty', '1 Year' FROM products WHERE sku = 'ELEC-129';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Warranty', '2 Years' FROM products WHERE sku = 'ELEC-130';

-- Electronics inventory
INSERT INTO inventory (product_id, quantity)
SELECT id, 3 FROM products WHERE sku = 'ELEC-101';
INSERT INTO inventory (product_id, quantity)
SELECT id, 16 FROM products WHERE sku = 'ELEC-102';
INSERT INTO inventory (product_id, quantity)
SELECT id, 29 FROM products WHERE sku = 'ELEC-103';
INSERT INTO inventory (product_id, quantity)
SELECT id, 42 FROM products WHERE sku = 'ELEC-104';
INSERT INTO inventory (product_id, quantity)
SELECT id, 55 FROM products WHERE sku = 'ELEC-105';
INSERT INTO inventory (product_id, quantity)
SELECT id, 68 FROM products WHERE sku = 'ELEC-106';
INSERT INTO inventory (product_id, quantity)
SELECT id, 3 FROM products WHERE sku = 'ELEC-107';
INSERT INTO inventory (product_id, quantity)
SELECT id, 0 FROM products WHERE sku = 'ELEC-108';
INSERT INTO inventory (product_id, quantity)
SELECT id, 29 FROM products WHERE sku = 'ELEC-109';
INSERT INTO inventory (product_id, quantity)
SELECT id, 42 FROM products WHERE sku = 'ELEC-110';
INSERT INTO inventory (product_id, quantity)
SELECT id, 55 FROM products WHERE sku = 'ELEC-111';
INSERT INTO inventory (product_id, quantity)
SELECT id, 68 FROM products WHERE sku = 'ELEC-112';
INSERT INTO inventory (product_id, quantity)
SELECT id, 3 FROM products WHERE sku = 'ELEC-113';
INSERT INTO inventory (product_id, quantity)
SELECT id, 16 FROM products WHERE sku = 'ELEC-114';
INSERT INTO inventory (product_id, quantity)
SELECT id, 29 FROM products WHERE sku = 'ELEC-115';
INSERT INTO inventory (product_id, quantity)
SELECT id, 42 FROM products WHERE sku = 'ELEC-116';
INSERT INTO inventory (product_id, quantity)
SELECT id, 55 FROM products WHERE sku = 'ELEC-117';
INSERT INTO inventory (product_id, quantity)
SELECT id, 0 FROM products WHERE sku = 'ELEC-118';
INSERT INTO inventory (product_id, quantity)
SELECT id, 3 FROM products WHERE sku = 'ELEC-119';
INSERT INTO inventory (product_id, quantity)
SELECT id, 16 FROM products WHERE sku = 'ELEC-120';
INSERT INTO inventory (product_id, quantity)
SELECT id, 29 FROM products WHERE sku = 'ELEC-121';
INSERT INTO inventory (product_id, quantity)
SELECT id, 42 FROM products WHERE sku = 'ELEC-122';
INSERT INTO inventory (product_id, quantity)
SELECT id, 55 FROM products WHERE sku = 'ELEC-123';
INSERT INTO inventory (product_id, quantity)
SELECT id, 68 FROM products WHERE sku = 'ELEC-124';
INSERT INTO inventory (product_id, quantity)
SELECT id, 3 FROM products WHERE sku = 'ELEC-125';
INSERT INTO inventory (product_id, quantity)
SELECT id, 16 FROM products WHERE sku = 'ELEC-126';
INSERT INTO inventory (product_id, quantity)
SELECT id, 29 FROM products WHERE sku = 'ELEC-127';
INSERT INTO inventory (product_id, quantity)
SELECT id, 0 FROM products WHERE sku = 'ELEC-128';
INSERT INTO inventory (product_id, quantity)
SELECT id, 55 FROM products WHERE sku = 'ELEC-129';
INSERT INTO inventory (product_id, quantity)
SELECT id, 68 FROM products WHERE sku = 'ELEC-130';

-- Books
INSERT INTO products (category_id, name, description, price, original_price, sku, active) VALUES
    ((SELECT id FROM categories WHERE name = 'Books'), 'The Silent Orchard', 'A gripping literary novel about family secrets in a small coastal town.', 16.99, NULL, 'BOOK-101', TRUE),
    ((SELECT id FROM categories WHERE name = 'Books'), 'Introduction to Algorithms', 'A comprehensive university-level guide to algorithm design and analysis.', 89.99, 99.99, 'BOOK-102', TRUE),
    ((SELECT id FROM categories WHERE name = 'Books'), 'The Home Chef’s Companion', 'A cookbook full of approachable weeknight recipes for home cooks.', 24.99, NULL, 'BOOK-103', TRUE),
    ((SELECT id FROM categories WHERE name = 'Books'), 'Becoming Unstoppable', 'A biography chronicling one entrepreneur’s rise against the odds.', 19.99, NULL, 'BOOK-104', TRUE),
    ((SELECT id FROM categories WHERE name = 'Books'), 'The Dragonglass Throne', 'Book one of an epic fantasy trilogy set in a fractured kingdom.', 14.99, 18.99, 'BOOK-105', TRUE),
    ((SELECT id FROM categories WHERE name = 'Books'), 'Shadows Over Rivenwood', 'A twisty mystery novel following a detective in a fog-shrouded city.', 13.99, NULL, 'BOOK-106', TRUE),
    ((SELECT id FROM categories WHERE name = 'Books'), 'Beyond the Event Horizon', 'A science fiction adventure across generations of a starship crew.', 15.99, NULL, 'BOOK-107', TRUE),
    ((SELECT id FROM categories WHERE name = 'Books'), 'Atomic Focus', 'A self-help guide to building better habits and sustained focus.', 17.99, NULL, 'BOOK-108', TRUE),
    ((SELECT id FROM categories WHERE name = 'Books'), 'Whispers in Ink', 'A collected volume of contemporary poetry on love and loss.', 12.99, NULL, 'BOOK-109', TRUE),
    ((SELECT id FROM categories WHERE name = 'Books'), 'The Brave Little Lighthouse', 'An illustrated children’s picture book about courage.', 9.99, NULL, 'BOOK-110', TRUE),
    ((SELECT id FROM categories WHERE name = 'Books'), 'Empires of the Ancient World', 'A sweeping history of civilizations from antiquity to the Renaissance.', 22.99, NULL, 'BOOK-111', TRUE),
    ((SELECT id FROM categories WHERE name = 'Books'), 'Brushstrokes: A Visual Journey', 'A coffee-table art book showcasing modern painting techniques.', 34.99, NULL, 'BOOK-112', TRUE),
    ((SELECT id FROM categories WHERE name = 'Books'), 'Backroads and Byways', 'A travel guide covering scenic road trips across the country.', 18.99, NULL, 'BOOK-113', TRUE),
    ((SELECT id FROM categories WHERE name = 'Books'), 'Nightwing Chronicles Vol. 1', 'A graphic novel following a masked vigilante’s origin story.', 16.99, NULL, 'BOOK-114', TRUE),
    ((SELECT id FROM categories WHERE name = 'Books'), 'The Examined Life', 'An accessible introduction to major philosophical questions.', 19.99, NULL, 'BOOK-115', TRUE),
    ((SELECT id FROM categories WHERE name = 'Books'), 'Scaling Lean Startups', 'A business book on growth strategy for early-stage companies.', 24.99, NULL, 'BOOK-116', TRUE),
    ((SELECT id FROM categories WHERE name = 'Books'), 'Clean Architecture', 'A guide to structuring maintainable, testable software systems.', 39.99, 44.99, 'BOOK-117', TRUE),
    ((SELECT id FROM categories WHERE name = 'Books'), 'Calculus Made Clear', 'A student-friendly textbook covering differential and integral calculus.', 79.99, NULL, 'BOOK-118', TRUE),
    ((SELECT id FROM categories WHERE name = 'Books'), 'Foundations of Chemistry', 'An undergraduate textbook covering core chemistry principles.', 84.99, NULL, 'BOOK-119', TRUE),
    ((SELECT id FROM categories WHERE name = 'Books'), 'The Concise Modern Dictionary', 'An updated dictionary with over 100,000 entries.', 19.99, NULL, 'BOOK-120', TRUE),
    ((SELECT id FROM categories WHERE name = 'Books'), 'World Atlas & Almanac', 'A detailed atlas with maps and country statistics.', 29.99, NULL, 'BOOK-121', TRUE),
    ((SELECT id FROM categories WHERE name = 'Books'), 'Midnight in Carrow Street', 'A psychological thriller about a reporter chasing a cold case.', 15.99, NULL, 'BOOK-122', TRUE),
    ((SELECT id FROM categories WHERE name = 'Books'), 'Autumn in Provence', 'A heartfelt romance novel set in the French countryside.', 13.99, NULL, 'BOOK-123', TRUE),
    ((SELECT id FROM categories WHERE name = 'Books'), 'Grandma Lucia’s Kitchen', 'A cookbook of traditional family recipes passed down for generations.', 22.99, NULL, 'BOOK-124', TRUE),
    ((SELECT id FROM categories WHERE name = 'Books'), 'The Long Way Home', 'A memoir about resilience and rebuilding after loss.', 18.99, NULL, 'BOOK-125', TRUE),
    ((SELECT id FROM categories WHERE name = 'Books'), 'Ocean Wanderer', 'An illustrated middle-grade adventure story on the high seas.', 11.99, NULL, 'BOOK-126', TRUE),
    ((SELECT id FROM categories WHERE name = 'Books'), 'Design Patterns Explained', 'A practical guide to reusable object-oriented design patterns.', 37.99, 42.99, 'BOOK-127', TRUE),
    ((SELECT id FROM categories WHERE name = 'Books'), 'The Minimalist Mindset', 'A self-help book on decluttering both space and mind.', 15.99, NULL, 'BOOK-128', TRUE),
    ((SELECT id FROM categories WHERE name = 'Books'), 'Legends of the North Wind', 'A fantasy anthology retelling classic Norse-inspired myths.', 16.99, NULL, 'BOOK-129', TRUE),
    ((SELECT id FROM categories WHERE name = 'Books'), 'Data Structures in Practice', 'A hands-on textbook covering core data structures with examples.', 69.99, NULL, 'BOOK-130', TRUE);

-- Books images
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/92400e/ffffff.png?text=The%20Silent%20Orchard', 0 FROM products WHERE sku = 'BOOK-101';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/92400e/ffffff.png?text=Introduction%20to%20Algorithms', 0 FROM products WHERE sku = 'BOOK-102';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/92400e/ffffff.png?text=The%20Home%20Chef%E2%80%99s%20Companion', 0 FROM products WHERE sku = 'BOOK-103';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/92400e/ffffff.png?text=Becoming%20Unstoppable', 0 FROM products WHERE sku = 'BOOK-104';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/92400e/ffffff.png?text=The%20Dragonglass%20Throne', 0 FROM products WHERE sku = 'BOOK-105';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/92400e/ffffff.png?text=Shadows%20Over%20Rivenwood', 0 FROM products WHERE sku = 'BOOK-106';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/92400e/ffffff.png?text=Beyond%20the%20Event%20Horizon', 0 FROM products WHERE sku = 'BOOK-107';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/92400e/ffffff.png?text=Atomic%20Focus', 0 FROM products WHERE sku = 'BOOK-108';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/92400e/ffffff.png?text=Whispers%20in%20Ink', 0 FROM products WHERE sku = 'BOOK-109';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/92400e/ffffff.png?text=The%20Brave%20Little%20Lighthouse', 0 FROM products WHERE sku = 'BOOK-110';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/92400e/ffffff.png?text=Empires%20of%20the%20Ancient%20World', 0 FROM products WHERE sku = 'BOOK-111';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/92400e/ffffff.png?text=Brushstrokes%3A%20A%20Visual%20Journey', 0 FROM products WHERE sku = 'BOOK-112';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/92400e/ffffff.png?text=Backroads%20and%20Byways', 0 FROM products WHERE sku = 'BOOK-113';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/92400e/ffffff.png?text=Nightwing%20Chronicles%20Vol.%201', 0 FROM products WHERE sku = 'BOOK-114';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/92400e/ffffff.png?text=The%20Examined%20Life', 0 FROM products WHERE sku = 'BOOK-115';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/92400e/ffffff.png?text=Scaling%20Lean%20Startups', 0 FROM products WHERE sku = 'BOOK-116';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/92400e/ffffff.png?text=Clean%20Architecture', 0 FROM products WHERE sku = 'BOOK-117';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/92400e/ffffff.png?text=Calculus%20Made%20Clear', 0 FROM products WHERE sku = 'BOOK-118';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/92400e/ffffff.png?text=Foundations%20of%20Chemistry', 0 FROM products WHERE sku = 'BOOK-119';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/92400e/ffffff.png?text=The%20Concise%20Modern%20Dictionary', 0 FROM products WHERE sku = 'BOOK-120';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/92400e/ffffff.png?text=World%20Atlas%20%26%20Almanac', 0 FROM products WHERE sku = 'BOOK-121';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/92400e/ffffff.png?text=Midnight%20in%20Carrow%20Street', 0 FROM products WHERE sku = 'BOOK-122';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/92400e/ffffff.png?text=Autumn%20in%20Provence', 0 FROM products WHERE sku = 'BOOK-123';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/92400e/ffffff.png?text=Grandma%20Lucia%E2%80%99s%20Kitchen', 0 FROM products WHERE sku = 'BOOK-124';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/92400e/ffffff.png?text=The%20Long%20Way%20Home', 0 FROM products WHERE sku = 'BOOK-125';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/92400e/ffffff.png?text=Ocean%20Wanderer', 0 FROM products WHERE sku = 'BOOK-126';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/92400e/ffffff.png?text=Design%20Patterns%20Explained', 0 FROM products WHERE sku = 'BOOK-127';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/92400e/ffffff.png?text=The%20Minimalist%20Mindset', 0 FROM products WHERE sku = 'BOOK-128';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/92400e/ffffff.png?text=Legends%20of%20the%20North%20Wind', 0 FROM products WHERE sku = 'BOOK-129';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/92400e/ffffff.png?text=Data%20Structures%20in%20Practice', 0 FROM products WHERE sku = 'BOOK-130';

-- Books specs
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Pages', '150' FROM products WHERE sku = 'BOOK-101';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Pages', '187' FROM products WHERE sku = 'BOOK-102';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Pages', '224' FROM products WHERE sku = 'BOOK-103';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Pages', '261' FROM products WHERE sku = 'BOOK-104';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Pages', '298' FROM products WHERE sku = 'BOOK-105';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Pages', '335' FROM products WHERE sku = 'BOOK-106';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Pages', '372' FROM products WHERE sku = 'BOOK-107';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Pages', '409' FROM products WHERE sku = 'BOOK-108';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Pages', '446' FROM products WHERE sku = 'BOOK-109';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Pages', '483' FROM products WHERE sku = 'BOOK-110';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Pages', '170' FROM products WHERE sku = 'BOOK-111';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Pages', '207' FROM products WHERE sku = 'BOOK-112';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Pages', '244' FROM products WHERE sku = 'BOOK-113';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Pages', '281' FROM products WHERE sku = 'BOOK-114';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Pages', '318' FROM products WHERE sku = 'BOOK-115';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Pages', '355' FROM products WHERE sku = 'BOOK-116';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Pages', '392' FROM products WHERE sku = 'BOOK-117';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Pages', '429' FROM products WHERE sku = 'BOOK-118';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Pages', '466' FROM products WHERE sku = 'BOOK-119';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Pages', '153' FROM products WHERE sku = 'BOOK-120';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Pages', '190' FROM products WHERE sku = 'BOOK-121';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Pages', '227' FROM products WHERE sku = 'BOOK-122';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Pages', '264' FROM products WHERE sku = 'BOOK-123';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Pages', '301' FROM products WHERE sku = 'BOOK-124';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Pages', '338' FROM products WHERE sku = 'BOOK-125';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Pages', '375' FROM products WHERE sku = 'BOOK-126';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Pages', '412' FROM products WHERE sku = 'BOOK-127';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Pages', '449' FROM products WHERE sku = 'BOOK-128';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Pages', '486' FROM products WHERE sku = 'BOOK-129';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Pages', '173' FROM products WHERE sku = 'BOOK-130';

-- Books inventory
INSERT INTO inventory (product_id, quantity)
SELECT id, 3 FROM products WHERE sku = 'BOOK-101';
INSERT INTO inventory (product_id, quantity)
SELECT id, 16 FROM products WHERE sku = 'BOOK-102';
INSERT INTO inventory (product_id, quantity)
SELECT id, 29 FROM products WHERE sku = 'BOOK-103';
INSERT INTO inventory (product_id, quantity)
SELECT id, 42 FROM products WHERE sku = 'BOOK-104';
INSERT INTO inventory (product_id, quantity)
SELECT id, 55 FROM products WHERE sku = 'BOOK-105';
INSERT INTO inventory (product_id, quantity)
SELECT id, 68 FROM products WHERE sku = 'BOOK-106';
INSERT INTO inventory (product_id, quantity)
SELECT id, 3 FROM products WHERE sku = 'BOOK-107';
INSERT INTO inventory (product_id, quantity)
SELECT id, 0 FROM products WHERE sku = 'BOOK-108';
INSERT INTO inventory (product_id, quantity)
SELECT id, 29 FROM products WHERE sku = 'BOOK-109';
INSERT INTO inventory (product_id, quantity)
SELECT id, 42 FROM products WHERE sku = 'BOOK-110';
INSERT INTO inventory (product_id, quantity)
SELECT id, 55 FROM products WHERE sku = 'BOOK-111';
INSERT INTO inventory (product_id, quantity)
SELECT id, 68 FROM products WHERE sku = 'BOOK-112';
INSERT INTO inventory (product_id, quantity)
SELECT id, 3 FROM products WHERE sku = 'BOOK-113';
INSERT INTO inventory (product_id, quantity)
SELECT id, 16 FROM products WHERE sku = 'BOOK-114';
INSERT INTO inventory (product_id, quantity)
SELECT id, 29 FROM products WHERE sku = 'BOOK-115';
INSERT INTO inventory (product_id, quantity)
SELECT id, 42 FROM products WHERE sku = 'BOOK-116';
INSERT INTO inventory (product_id, quantity)
SELECT id, 55 FROM products WHERE sku = 'BOOK-117';
INSERT INTO inventory (product_id, quantity)
SELECT id, 0 FROM products WHERE sku = 'BOOK-118';
INSERT INTO inventory (product_id, quantity)
SELECT id, 3 FROM products WHERE sku = 'BOOK-119';
INSERT INTO inventory (product_id, quantity)
SELECT id, 16 FROM products WHERE sku = 'BOOK-120';
INSERT INTO inventory (product_id, quantity)
SELECT id, 29 FROM products WHERE sku = 'BOOK-121';
INSERT INTO inventory (product_id, quantity)
SELECT id, 42 FROM products WHERE sku = 'BOOK-122';
INSERT INTO inventory (product_id, quantity)
SELECT id, 55 FROM products WHERE sku = 'BOOK-123';
INSERT INTO inventory (product_id, quantity)
SELECT id, 68 FROM products WHERE sku = 'BOOK-124';
INSERT INTO inventory (product_id, quantity)
SELECT id, 3 FROM products WHERE sku = 'BOOK-125';
INSERT INTO inventory (product_id, quantity)
SELECT id, 16 FROM products WHERE sku = 'BOOK-126';
INSERT INTO inventory (product_id, quantity)
SELECT id, 29 FROM products WHERE sku = 'BOOK-127';
INSERT INTO inventory (product_id, quantity)
SELECT id, 0 FROM products WHERE sku = 'BOOK-128';
INSERT INTO inventory (product_id, quantity)
SELECT id, 55 FROM products WHERE sku = 'BOOK-129';
INSERT INTO inventory (product_id, quantity)
SELECT id, 68 FROM products WHERE sku = 'BOOK-130';

-- Fashion
INSERT INTO products (category_id, name, description, price, original_price, sku, active) VALUES
    ((SELECT id FROM categories WHERE name = 'Fashion'), 'Classic Crew Neck T-Shirt', 'Soft everyday cotton t-shirt available in multiple colors.', 14.99, NULL, 'FASH-101', TRUE),
    ((SELECT id FROM categories WHERE name = 'Fashion'), 'Slim Fit Jeans', 'Stretch-denim jeans with a modern slim fit.', 49.99, 64.99, 'FASH-102', TRUE),
    ((SELECT id FROM categories WHERE name = 'Fashion'), 'Floral Summer Dress', 'Lightweight A-line dress perfect for warm weather.', 39.99, NULL, 'FASH-103', TRUE),
    ((SELECT id FROM categories WHERE name = 'Fashion'), 'Quilted Puffer Jacket', 'Insulated jacket built for cold-weather warmth.', 89.99, 119.99, 'FASH-104', TRUE),
    ((SELECT id FROM categories WHERE name = 'Fashion'), 'Cable Knit Sweater', 'Chunky knit sweater with a classic cable pattern.', 44.99, NULL, 'FASH-105', TRUE),
    ((SELECT id FROM categories WHERE name = 'Fashion'), 'Pullover Hoodie', 'Fleece-lined hoodie with a kangaroo pocket.', 34.99, NULL, 'FASH-106', TRUE),
    ((SELECT id FROM categories WHERE name = 'Fashion'), 'Pleated Midi Skirt', 'Flowy pleated skirt that pairs with any top.', 29.99, NULL, 'FASH-107', TRUE),
    ((SELECT id FROM categories WHERE name = 'Fashion'), 'Silk Button-Up Blouse', 'Elegant blouse with a smooth silk-like finish.', 42.99, NULL, 'FASH-108', TRUE),
    ((SELECT id FROM categories WHERE name = 'Fashion'), 'Cotton Chino Shorts', 'Casual shorts with a comfortable stretch waistband.', 24.99, NULL, 'FASH-109', TRUE),
    ((SELECT id FROM categories WHERE name = 'Fashion'), 'High-Waist Leggings', 'Breathable leggings built for workouts or everyday wear.', 27.99, 34.99, 'FASH-110', TRUE),
    ((SELECT id FROM categories WHERE name = 'Fashion'), 'Wool Blend Overcoat', 'Tailored long coat for a polished cold-weather look.', 129.99, NULL, 'FASH-111', TRUE),
    ((SELECT id FROM categories WHERE name = 'Fashion'), 'Cashmere Blend Scarf', 'Soft, lightweight scarf for extra warmth and style.', 22.99, NULL, 'FASH-112', TRUE),
    ((SELECT id FROM categories WHERE name = 'Fashion'), 'Wide-Brim Sun Hat', 'Packable hat offering UV protection at the beach.', 18.99, NULL, 'FASH-113', TRUE),
    ((SELECT id FROM categories WHERE name = 'Fashion'), 'Polarized Aviator Sunglasses', 'UV400-protected sunglasses with a classic frame.', 24.99, 34.99, 'FASH-114', TRUE),
    ((SELECT id FROM categories WHERE name = 'Fashion'), 'Reversible Leather Belt', 'Two-in-one belt with a rotating buckle.', 19.99, NULL, 'FASH-115', TRUE),
    ((SELECT id FROM categories WHERE name = 'Fashion'), 'Structured Tote Handbag', 'Spacious handbag with an interior organizer pocket.', 59.99, NULL, 'FASH-116', TRUE),
    ((SELECT id FROM categories WHERE name = 'Fashion'), 'Bifold Leather Wallet', 'Slim wallet with RFID-blocking card slots.', 24.99, NULL, 'FASH-117', TRUE),
    ((SELECT id FROM categories WHERE name = 'Fashion'), 'Canvas Low-Top Sneakers', 'Everyday sneakers with a durable rubber sole.', 39.99, NULL, 'FASH-118', TRUE),
    ((SELECT id FROM categories WHERE name = 'Fashion'), 'Chelsea Ankle Boots', 'Pull-on boots with an elastic side panel.', 79.99, 99.99, 'FASH-119', TRUE),
    ((SELECT id FROM categories WHERE name = 'Fashion'), 'Strappy Flat Sandals', 'Lightweight sandals ideal for summer outings.', 22.99, NULL, 'FASH-120', TRUE),
    ((SELECT id FROM categories WHERE name = 'Fashion'), 'Formal Oxford Shoes', 'Polished leather shoes for business and formal occasions.', 69.99, NULL, 'FASH-121', TRUE),
    ((SELECT id FROM categories WHERE name = 'Fashion'), 'Cotton Crew Socks (5-pack)', 'Breathable everyday socks in assorted colors.', 12.99, NULL, 'FASH-122', TRUE),
    ((SELECT id FROM categories WHERE name = 'Fashion'), 'Touchscreen Knit Gloves', 'Warm gloves compatible with touchscreen devices.', 14.99, NULL, 'FASH-123', TRUE),
    ((SELECT id FROM categories WHERE name = 'Fashion'), 'Silk Necktie', 'Classic patterned tie for formal and business wear.', 19.99, NULL, 'FASH-124', TRUE),
    ((SELECT id FROM categories WHERE name = 'Fashion'), 'Two-Piece Slim Suit', 'Tailored suit set for weddings and formal events.', 119.99, 149.99, 'FASH-125', TRUE),
    ((SELECT id FROM categories WHERE name = 'Fashion'), 'Embroidered Cotton Kurta', 'Traditional embroidered kurta for festive occasions.', 34.99, NULL, 'FASH-126', TRUE),
    ((SELECT id FROM categories WHERE name = 'Fashion'), 'Classic Analog Wristwatch', 'Minimalist watch with a stainless steel band.', 49.99, NULL, 'FASH-127', TRUE),
    ((SELECT id FROM categories WHERE name = 'Fashion'), 'Crystal Drop Earrings', 'Elegant earrings with a sparkling crystal accent.', 17.99, NULL, 'FASH-128', TRUE),
    ((SELECT id FROM categories WHERE name = 'Fashion'), 'Layered Chain Necklace', 'Trendy layered necklace in gold-tone finish.', 21.99, NULL, 'FASH-129', TRUE),
    ((SELECT id FROM categories WHERE name = 'Fashion'), 'Woven Straw Beach Bag', 'Handwoven bag perfect for beach and vacation days.', 26.99, NULL, 'FASH-130', TRUE);

-- Fashion images
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/db2777/ffffff.png?text=Classic%20Crew%20Neck%20T-Shirt', 0 FROM products WHERE sku = 'FASH-101';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/db2777/ffffff.png?text=Slim%20Fit%20Jeans', 0 FROM products WHERE sku = 'FASH-102';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/db2777/ffffff.png?text=Floral%20Summer%20Dress', 0 FROM products WHERE sku = 'FASH-103';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/db2777/ffffff.png?text=Quilted%20Puffer%20Jacket', 0 FROM products WHERE sku = 'FASH-104';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/db2777/ffffff.png?text=Cable%20Knit%20Sweater', 0 FROM products WHERE sku = 'FASH-105';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/db2777/ffffff.png?text=Pullover%20Hoodie', 0 FROM products WHERE sku = 'FASH-106';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/db2777/ffffff.png?text=Pleated%20Midi%20Skirt', 0 FROM products WHERE sku = 'FASH-107';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/db2777/ffffff.png?text=Silk%20Button-Up%20Blouse', 0 FROM products WHERE sku = 'FASH-108';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/db2777/ffffff.png?text=Cotton%20Chino%20Shorts', 0 FROM products WHERE sku = 'FASH-109';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/db2777/ffffff.png?text=High-Waist%20Leggings', 0 FROM products WHERE sku = 'FASH-110';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/db2777/ffffff.png?text=Wool%20Blend%20Overcoat', 0 FROM products WHERE sku = 'FASH-111';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/db2777/ffffff.png?text=Cashmere%20Blend%20Scarf', 0 FROM products WHERE sku = 'FASH-112';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/db2777/ffffff.png?text=Wide-Brim%20Sun%20Hat', 0 FROM products WHERE sku = 'FASH-113';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/db2777/ffffff.png?text=Polarized%20Aviator%20Sunglasses', 0 FROM products WHERE sku = 'FASH-114';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/db2777/ffffff.png?text=Reversible%20Leather%20Belt', 0 FROM products WHERE sku = 'FASH-115';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/db2777/ffffff.png?text=Structured%20Tote%20Handbag', 0 FROM products WHERE sku = 'FASH-116';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/db2777/ffffff.png?text=Bifold%20Leather%20Wallet', 0 FROM products WHERE sku = 'FASH-117';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/db2777/ffffff.png?text=Canvas%20Low-Top%20Sneakers', 0 FROM products WHERE sku = 'FASH-118';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/db2777/ffffff.png?text=Chelsea%20Ankle%20Boots', 0 FROM products WHERE sku = 'FASH-119';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/db2777/ffffff.png?text=Strappy%20Flat%20Sandals', 0 FROM products WHERE sku = 'FASH-120';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/db2777/ffffff.png?text=Formal%20Oxford%20Shoes', 0 FROM products WHERE sku = 'FASH-121';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/db2777/ffffff.png?text=Cotton%20Crew%20Socks%20(5-pack)', 0 FROM products WHERE sku = 'FASH-122';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/db2777/ffffff.png?text=Touchscreen%20Knit%20Gloves', 0 FROM products WHERE sku = 'FASH-123';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/db2777/ffffff.png?text=Silk%20Necktie', 0 FROM products WHERE sku = 'FASH-124';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/db2777/ffffff.png?text=Two-Piece%20Slim%20Suit', 0 FROM products WHERE sku = 'FASH-125';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/db2777/ffffff.png?text=Embroidered%20Cotton%20Kurta', 0 FROM products WHERE sku = 'FASH-126';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/db2777/ffffff.png?text=Classic%20Analog%20Wristwatch', 0 FROM products WHERE sku = 'FASH-127';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/db2777/ffffff.png?text=Crystal%20Drop%20Earrings', 0 FROM products WHERE sku = 'FASH-128';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/db2777/ffffff.png?text=Layered%20Chain%20Necklace', 0 FROM products WHERE sku = 'FASH-129';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/db2777/ffffff.png?text=Woven%20Straw%20Beach%20Bag', 0 FROM products WHERE sku = 'FASH-130';

-- Fashion specs
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', '100% Cotton' FROM products WHERE sku = 'FASH-101';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Polyester Blend' FROM products WHERE sku = 'FASH-102';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Genuine Leather' FROM products WHERE sku = 'FASH-103';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Denim' FROM products WHERE sku = 'FASH-104';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Wool Blend' FROM products WHERE sku = 'FASH-105';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Linen' FROM products WHERE sku = 'FASH-106';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', '100% Cotton' FROM products WHERE sku = 'FASH-107';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Polyester Blend' FROM products WHERE sku = 'FASH-108';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Genuine Leather' FROM products WHERE sku = 'FASH-109';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Denim' FROM products WHERE sku = 'FASH-110';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Wool Blend' FROM products WHERE sku = 'FASH-111';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Linen' FROM products WHERE sku = 'FASH-112';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', '100% Cotton' FROM products WHERE sku = 'FASH-113';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Polyester Blend' FROM products WHERE sku = 'FASH-114';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Genuine Leather' FROM products WHERE sku = 'FASH-115';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Denim' FROM products WHERE sku = 'FASH-116';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Wool Blend' FROM products WHERE sku = 'FASH-117';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Linen' FROM products WHERE sku = 'FASH-118';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', '100% Cotton' FROM products WHERE sku = 'FASH-119';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Polyester Blend' FROM products WHERE sku = 'FASH-120';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Genuine Leather' FROM products WHERE sku = 'FASH-121';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Denim' FROM products WHERE sku = 'FASH-122';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Wool Blend' FROM products WHERE sku = 'FASH-123';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Linen' FROM products WHERE sku = 'FASH-124';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', '100% Cotton' FROM products WHERE sku = 'FASH-125';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Polyester Blend' FROM products WHERE sku = 'FASH-126';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Genuine Leather' FROM products WHERE sku = 'FASH-127';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Denim' FROM products WHERE sku = 'FASH-128';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Wool Blend' FROM products WHERE sku = 'FASH-129';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Linen' FROM products WHERE sku = 'FASH-130';

-- Fashion inventory
INSERT INTO inventory (product_id, quantity)
SELECT id, 3 FROM products WHERE sku = 'FASH-101';
INSERT INTO inventory (product_id, quantity)
SELECT id, 16 FROM products WHERE sku = 'FASH-102';
INSERT INTO inventory (product_id, quantity)
SELECT id, 29 FROM products WHERE sku = 'FASH-103';
INSERT INTO inventory (product_id, quantity)
SELECT id, 42 FROM products WHERE sku = 'FASH-104';
INSERT INTO inventory (product_id, quantity)
SELECT id, 55 FROM products WHERE sku = 'FASH-105';
INSERT INTO inventory (product_id, quantity)
SELECT id, 68 FROM products WHERE sku = 'FASH-106';
INSERT INTO inventory (product_id, quantity)
SELECT id, 3 FROM products WHERE sku = 'FASH-107';
INSERT INTO inventory (product_id, quantity)
SELECT id, 0 FROM products WHERE sku = 'FASH-108';
INSERT INTO inventory (product_id, quantity)
SELECT id, 29 FROM products WHERE sku = 'FASH-109';
INSERT INTO inventory (product_id, quantity)
SELECT id, 42 FROM products WHERE sku = 'FASH-110';
INSERT INTO inventory (product_id, quantity)
SELECT id, 55 FROM products WHERE sku = 'FASH-111';
INSERT INTO inventory (product_id, quantity)
SELECT id, 68 FROM products WHERE sku = 'FASH-112';
INSERT INTO inventory (product_id, quantity)
SELECT id, 3 FROM products WHERE sku = 'FASH-113';
INSERT INTO inventory (product_id, quantity)
SELECT id, 16 FROM products WHERE sku = 'FASH-114';
INSERT INTO inventory (product_id, quantity)
SELECT id, 29 FROM products WHERE sku = 'FASH-115';
INSERT INTO inventory (product_id, quantity)
SELECT id, 42 FROM products WHERE sku = 'FASH-116';
INSERT INTO inventory (product_id, quantity)
SELECT id, 55 FROM products WHERE sku = 'FASH-117';
INSERT INTO inventory (product_id, quantity)
SELECT id, 0 FROM products WHERE sku = 'FASH-118';
INSERT INTO inventory (product_id, quantity)
SELECT id, 3 FROM products WHERE sku = 'FASH-119';
INSERT INTO inventory (product_id, quantity)
SELECT id, 16 FROM products WHERE sku = 'FASH-120';
INSERT INTO inventory (product_id, quantity)
SELECT id, 29 FROM products WHERE sku = 'FASH-121';
INSERT INTO inventory (product_id, quantity)
SELECT id, 42 FROM products WHERE sku = 'FASH-122';
INSERT INTO inventory (product_id, quantity)
SELECT id, 55 FROM products WHERE sku = 'FASH-123';
INSERT INTO inventory (product_id, quantity)
SELECT id, 68 FROM products WHERE sku = 'FASH-124';
INSERT INTO inventory (product_id, quantity)
SELECT id, 3 FROM products WHERE sku = 'FASH-125';
INSERT INTO inventory (product_id, quantity)
SELECT id, 16 FROM products WHERE sku = 'FASH-126';
INSERT INTO inventory (product_id, quantity)
SELECT id, 29 FROM products WHERE sku = 'FASH-127';
INSERT INTO inventory (product_id, quantity)
SELECT id, 0 FROM products WHERE sku = 'FASH-128';
INSERT INTO inventory (product_id, quantity)
SELECT id, 55 FROM products WHERE sku = 'FASH-129';
INSERT INTO inventory (product_id, quantity)
SELECT id, 68 FROM products WHERE sku = 'FASH-130';

-- Home & Kitchen
INSERT INTO products (category_id, name, description, price, original_price, sku, active) VALUES
    ((SELECT id FROM categories WHERE name = 'Home & Kitchen'), 'High-Speed Countertop Blender', 'Powerful blender for smoothies, soups, and shakes.', 59.99, 79.99, 'HOME-101', TRUE),
    ((SELECT id FROM categories WHERE name = 'Home & Kitchen'), '2-Slice Pop-Up Toaster', 'Compact toaster with adjustable browning control.', 24.99, NULL, 'HOME-102', TRUE),
    ((SELECT id FROM categories WHERE name = 'Home & Kitchen'), 'Convection Microwave Oven', '900W microwave with grill and convection modes.', 119.99, NULL, 'HOME-103', TRUE),
    ((SELECT id FROM categories WHERE name = 'Home & Kitchen'), 'Digital Air Fryer 5L', 'Oil-free frying for crispy meals in less time.', 69.99, 89.99, 'HOME-104', TRUE),
    ((SELECT id FROM categories WHERE name = 'Home & Kitchen'), '12-Cup Drip Coffee Maker', 'Programmable coffee maker with a keep-warm plate.', 39.99, NULL, 'HOME-105', TRUE),
    ((SELECT id FROM categories WHERE name = 'Home & Kitchen'), 'Electric Cordless Kettle', 'Rapid-boil kettle with auto shut-off.', 22.99, NULL, 'HOME-106', TRUE),
    ((SELECT id FROM categories WHERE name = 'Home & Kitchen'), '24-Piece Cutlery Set', 'Everyday flatware set in a brushed stainless finish.', 34.99, NULL, 'HOME-107', TRUE),
    ((SELECT id FROM categories WHERE name = 'Home & Kitchen'), '16-Piece Dinnerware Set', 'Stoneware plates and bowls for everyday dining.', 54.99, NULL, 'HOME-108', TRUE),
    ((SELECT id FROM categories WHERE name = 'Home & Kitchen'), 'Non-Stick Frying Pan 10-inch', 'Even-heating pan with a durable non-stick coating.', 19.99, NULL, 'HOME-109', TRUE),
    ((SELECT id FROM categories WHERE name = 'Home & Kitchen'), 'Bamboo Cutting Board Set', 'Eco-friendly cutting boards in three sizes.', 17.99, NULL, 'HOME-110', TRUE),
    ((SELECT id FROM categories WHERE name = 'Home & Kitchen'), 'Airtight Food Storage Containers (Set of 10)', 'Stackable containers that keep food fresh longer.', 24.99, 32.99, 'HOME-111', TRUE),
    ((SELECT id FROM categories WHERE name = 'Home & Kitchen'), 'Cotton Bed Sheet Set (Queen)', 'Soft breathable sheets with deep-pocket fitted sheet.', 34.99, NULL, 'HOME-112', TRUE),
    ((SELECT id FROM categories WHERE name = 'Home & Kitchen'), 'Memory Foam Pillow (2-Pack)', 'Contoured pillows for neck and shoulder support.', 29.99, NULL, 'HOME-113', TRUE),
    ((SELECT id FROM categories WHERE name = 'Home & Kitchen'), 'Blackout Window Curtains (Pair)', 'Light-blocking curtains that reduce outside noise.', 27.99, NULL, 'HOME-114', TRUE),
    ((SELECT id FROM categories WHERE name = 'Home & Kitchen'), 'Cordless Stick Vacuum Cleaner', 'Lightweight vacuum with a detachable handheld unit.', 129.99, 169.99, 'HOME-115', TRUE),
    ((SELECT id FROM categories WHERE name = 'Home & Kitchen'), 'Steam Iron with Ceramic Soleplate', 'Fast-heating iron for smooth, wrinkle-free clothes.', 24.99, NULL, 'HOME-116', TRUE),
    ((SELECT id FROM categories WHERE name = 'Home & Kitchen'), 'Adjustable LED Desk Lamp', 'Dimmable lamp with multiple color temperature modes.', 19.99, NULL, 'HOME-117', TRUE),
    ((SELECT id FROM categories WHERE name = 'Home & Kitchen'), 'Modern Wall Clock', 'Silent-sweep wall clock with a minimalist face.', 16.99, NULL, 'HOME-118', TRUE),
    ((SELECT id FROM categories WHERE name = 'Home & Kitchen'), 'Soft Shag Area Rug', 'Plush rug that adds warmth to any room.', 49.99, NULL, 'HOME-119', TRUE),
    ((SELECT id FROM categories WHERE name = 'Home & Kitchen'), 'Waterproof Shower Curtain', 'Mildew-resistant curtain with reinforced grommets.', 14.99, NULL, 'HOME-120', TRUE),
    ((SELECT id FROM categories WHERE name = 'Home & Kitchen'), 'Step-Open Kitchen Trash Can', 'Odor-sealing trash can with a foot pedal.', 29.99, NULL, 'HOME-121', TRUE),
    ((SELECT id FROM categories WHERE name = 'Home & Kitchen'), 'Stainless Steel Dish Rack', 'Space-saving rack with a built-in drainboard.', 22.99, NULL, 'HOME-122', TRUE),
    ((SELECT id FROM categories WHERE name = 'Home & Kitchen'), 'Rotating Spice Rack Organizer', 'Countertop organizer that holds up to 20 spice jars.', 18.99, 24.99, 'HOME-123', TRUE),
    ((SELECT id FROM categories WHERE name = 'Home & Kitchen'), '6-Piece Kitchen Knife Set', 'Sharp forged knives with an acacia wood block.', 39.99, NULL, 'HOME-124', TRUE),
    ((SELECT id FROM categories WHERE name = 'Home & Kitchen'), 'Stainless Steel Mixing Bowls (Set of 5)', 'Nesting bowls for prep, mixing, and serving.', 26.99, NULL, 'HOME-125', TRUE),
    ((SELECT id FROM categories WHERE name = 'Home & Kitchen'), 'Multi-Function Food Processor', 'Chops, slices, and purees with interchangeable blades.', 79.99, NULL, 'HOME-126', TRUE),
    ((SELECT id FROM categories WHERE name = 'Home & Kitchen'), 'Glass Electric Kettle', 'Kettle with an LED-lit water level indicator.', 27.99, NULL, 'HOME-127', TRUE),
    ((SELECT id FROM categories WHERE name = 'Home & Kitchen'), 'Minimalist Table Lamp', 'Fabric-shade lamp that suits any bedroom or living room.', 23.99, NULL, 'HOME-128', TRUE),
    ((SELECT id FROM categories WHERE name = 'Home & Kitchen'), 'Wooden Picture Frame Set', 'Set of 5 frames in assorted sizes for wall galleries.', 19.99, NULL, 'HOME-129', TRUE),
    ((SELECT id FROM categories WHERE name = 'Home & Kitchen'), 'Scented Soy Candle (3-Pack)', 'Long-burning candles in relaxing seasonal scents.', 16.99, NULL, 'HOME-130', TRUE);

-- Home & Kitchen images
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/059669/ffffff.png?text=High-Speed%20Countertop%20Blender', 0 FROM products WHERE sku = 'HOME-101';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/059669/ffffff.png?text=2-Slice%20Pop-Up%20Toaster', 0 FROM products WHERE sku = 'HOME-102';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/059669/ffffff.png?text=Convection%20Microwave%20Oven', 0 FROM products WHERE sku = 'HOME-103';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/059669/ffffff.png?text=Digital%20Air%20Fryer%205L', 0 FROM products WHERE sku = 'HOME-104';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/059669/ffffff.png?text=12-Cup%20Drip%20Coffee%20Maker', 0 FROM products WHERE sku = 'HOME-105';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/059669/ffffff.png?text=Electric%20Cordless%20Kettle', 0 FROM products WHERE sku = 'HOME-106';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/059669/ffffff.png?text=24-Piece%20Cutlery%20Set', 0 FROM products WHERE sku = 'HOME-107';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/059669/ffffff.png?text=16-Piece%20Dinnerware%20Set', 0 FROM products WHERE sku = 'HOME-108';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/059669/ffffff.png?text=Non-Stick%20Frying%20Pan%2010-inch', 0 FROM products WHERE sku = 'HOME-109';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/059669/ffffff.png?text=Bamboo%20Cutting%20Board%20Set', 0 FROM products WHERE sku = 'HOME-110';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/059669/ffffff.png?text=Airtight%20Food%20Storage%20Containers%20(Set%20of%2010)', 0 FROM products WHERE sku = 'HOME-111';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/059669/ffffff.png?text=Cotton%20Bed%20Sheet%20Set%20(Queen)', 0 FROM products WHERE sku = 'HOME-112';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/059669/ffffff.png?text=Memory%20Foam%20Pillow%20(2-Pack)', 0 FROM products WHERE sku = 'HOME-113';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/059669/ffffff.png?text=Blackout%20Window%20Curtains%20(Pair)', 0 FROM products WHERE sku = 'HOME-114';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/059669/ffffff.png?text=Cordless%20Stick%20Vacuum%20Cleaner', 0 FROM products WHERE sku = 'HOME-115';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/059669/ffffff.png?text=Steam%20Iron%20with%20Ceramic%20Soleplate', 0 FROM products WHERE sku = 'HOME-116';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/059669/ffffff.png?text=Adjustable%20LED%20Desk%20Lamp', 0 FROM products WHERE sku = 'HOME-117';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/059669/ffffff.png?text=Modern%20Wall%20Clock', 0 FROM products WHERE sku = 'HOME-118';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/059669/ffffff.png?text=Soft%20Shag%20Area%20Rug', 0 FROM products WHERE sku = 'HOME-119';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/059669/ffffff.png?text=Waterproof%20Shower%20Curtain', 0 FROM products WHERE sku = 'HOME-120';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/059669/ffffff.png?text=Step-Open%20Kitchen%20Trash%20Can', 0 FROM products WHERE sku = 'HOME-121';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/059669/ffffff.png?text=Stainless%20Steel%20Dish%20Rack', 0 FROM products WHERE sku = 'HOME-122';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/059669/ffffff.png?text=Rotating%20Spice%20Rack%20Organizer', 0 FROM products WHERE sku = 'HOME-123';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/059669/ffffff.png?text=6-Piece%20Kitchen%20Knife%20Set', 0 FROM products WHERE sku = 'HOME-124';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/059669/ffffff.png?text=Stainless%20Steel%20Mixing%20Bowls%20(Set%20of%205)', 0 FROM products WHERE sku = 'HOME-125';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/059669/ffffff.png?text=Multi-Function%20Food%20Processor', 0 FROM products WHERE sku = 'HOME-126';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/059669/ffffff.png?text=Glass%20Electric%20Kettle', 0 FROM products WHERE sku = 'HOME-127';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/059669/ffffff.png?text=Minimalist%20Table%20Lamp', 0 FROM products WHERE sku = 'HOME-128';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/059669/ffffff.png?text=Wooden%20Picture%20Frame%20Set', 0 FROM products WHERE sku = 'HOME-129';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/059669/ffffff.png?text=Scented%20Soy%20Candle%20(3-Pack)', 0 FROM products WHERE sku = 'HOME-130';

-- Home & Kitchen specs
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Stainless Steel' FROM products WHERE sku = 'HOME-101';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'BPA-Free Plastic' FROM products WHERE sku = 'HOME-102';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Tempered Glass' FROM products WHERE sku = 'HOME-103';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Bamboo' FROM products WHERE sku = 'HOME-104';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Ceramic' FROM products WHERE sku = 'HOME-105';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Cast Iron' FROM products WHERE sku = 'HOME-106';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Stainless Steel' FROM products WHERE sku = 'HOME-107';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'BPA-Free Plastic' FROM products WHERE sku = 'HOME-108';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Tempered Glass' FROM products WHERE sku = 'HOME-109';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Bamboo' FROM products WHERE sku = 'HOME-110';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Ceramic' FROM products WHERE sku = 'HOME-111';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Cast Iron' FROM products WHERE sku = 'HOME-112';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Stainless Steel' FROM products WHERE sku = 'HOME-113';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'BPA-Free Plastic' FROM products WHERE sku = 'HOME-114';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Tempered Glass' FROM products WHERE sku = 'HOME-115';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Bamboo' FROM products WHERE sku = 'HOME-116';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Ceramic' FROM products WHERE sku = 'HOME-117';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Cast Iron' FROM products WHERE sku = 'HOME-118';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Stainless Steel' FROM products WHERE sku = 'HOME-119';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'BPA-Free Plastic' FROM products WHERE sku = 'HOME-120';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Tempered Glass' FROM products WHERE sku = 'HOME-121';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Bamboo' FROM products WHERE sku = 'HOME-122';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Ceramic' FROM products WHERE sku = 'HOME-123';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Cast Iron' FROM products WHERE sku = 'HOME-124';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Stainless Steel' FROM products WHERE sku = 'HOME-125';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'BPA-Free Plastic' FROM products WHERE sku = 'HOME-126';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Tempered Glass' FROM products WHERE sku = 'HOME-127';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Bamboo' FROM products WHERE sku = 'HOME-128';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Ceramic' FROM products WHERE sku = 'HOME-129';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Cast Iron' FROM products WHERE sku = 'HOME-130';

-- Home & Kitchen inventory
INSERT INTO inventory (product_id, quantity)
SELECT id, 3 FROM products WHERE sku = 'HOME-101';
INSERT INTO inventory (product_id, quantity)
SELECT id, 16 FROM products WHERE sku = 'HOME-102';
INSERT INTO inventory (product_id, quantity)
SELECT id, 29 FROM products WHERE sku = 'HOME-103';
INSERT INTO inventory (product_id, quantity)
SELECT id, 42 FROM products WHERE sku = 'HOME-104';
INSERT INTO inventory (product_id, quantity)
SELECT id, 55 FROM products WHERE sku = 'HOME-105';
INSERT INTO inventory (product_id, quantity)
SELECT id, 68 FROM products WHERE sku = 'HOME-106';
INSERT INTO inventory (product_id, quantity)
SELECT id, 3 FROM products WHERE sku = 'HOME-107';
INSERT INTO inventory (product_id, quantity)
SELECT id, 0 FROM products WHERE sku = 'HOME-108';
INSERT INTO inventory (product_id, quantity)
SELECT id, 29 FROM products WHERE sku = 'HOME-109';
INSERT INTO inventory (product_id, quantity)
SELECT id, 42 FROM products WHERE sku = 'HOME-110';
INSERT INTO inventory (product_id, quantity)
SELECT id, 55 FROM products WHERE sku = 'HOME-111';
INSERT INTO inventory (product_id, quantity)
SELECT id, 68 FROM products WHERE sku = 'HOME-112';
INSERT INTO inventory (product_id, quantity)
SELECT id, 3 FROM products WHERE sku = 'HOME-113';
INSERT INTO inventory (product_id, quantity)
SELECT id, 16 FROM products WHERE sku = 'HOME-114';
INSERT INTO inventory (product_id, quantity)
SELECT id, 29 FROM products WHERE sku = 'HOME-115';
INSERT INTO inventory (product_id, quantity)
SELECT id, 42 FROM products WHERE sku = 'HOME-116';
INSERT INTO inventory (product_id, quantity)
SELECT id, 55 FROM products WHERE sku = 'HOME-117';
INSERT INTO inventory (product_id, quantity)
SELECT id, 0 FROM products WHERE sku = 'HOME-118';
INSERT INTO inventory (product_id, quantity)
SELECT id, 3 FROM products WHERE sku = 'HOME-119';
INSERT INTO inventory (product_id, quantity)
SELECT id, 16 FROM products WHERE sku = 'HOME-120';
INSERT INTO inventory (product_id, quantity)
SELECT id, 29 FROM products WHERE sku = 'HOME-121';
INSERT INTO inventory (product_id, quantity)
SELECT id, 42 FROM products WHERE sku = 'HOME-122';
INSERT INTO inventory (product_id, quantity)
SELECT id, 55 FROM products WHERE sku = 'HOME-123';
INSERT INTO inventory (product_id, quantity)
SELECT id, 68 FROM products WHERE sku = 'HOME-124';
INSERT INTO inventory (product_id, quantity)
SELECT id, 3 FROM products WHERE sku = 'HOME-125';
INSERT INTO inventory (product_id, quantity)
SELECT id, 16 FROM products WHERE sku = 'HOME-126';
INSERT INTO inventory (product_id, quantity)
SELECT id, 29 FROM products WHERE sku = 'HOME-127';
INSERT INTO inventory (product_id, quantity)
SELECT id, 0 FROM products WHERE sku = 'HOME-128';
INSERT INTO inventory (product_id, quantity)
SELECT id, 55 FROM products WHERE sku = 'HOME-129';
INSERT INTO inventory (product_id, quantity)
SELECT id, 68 FROM products WHERE sku = 'HOME-130';

-- Sports & Outdoors
INSERT INTO products (category_id, name, description, price, original_price, sku, active) VALUES
    ((SELECT id FROM categories WHERE name = 'Sports & Outdoors'), 'Graphite Tennis Racket', 'Lightweight racket with a large sweet spot for control.', 49.99, NULL, 'SPORT-101', TRUE),
    ((SELECT id FROM categories WHERE name = 'Sports & Outdoors'), 'Official Size Basketball', 'Indoor/outdoor basketball with a durable rubber cover.', 24.99, NULL, 'SPORT-102', TRUE),
    ((SELECT id FROM categories WHERE name = 'Sports & Outdoors'), 'Match-Grade Soccer Ball', 'FIFA-quality ball for training and matches.', 22.99, NULL, 'SPORT-103', TRUE),
    ((SELECT id FROM categories WHERE name = 'Sports & Outdoors'), 'Adjustable Dumbbell Set', 'Space-saving dumbbells that adjust from 5 to 25 lbs.', 99.99, 129.99, 'SPORT-104', TRUE),
    ((SELECT id FROM categories WHERE name = 'Sports & Outdoors'), 'Resistance Bands Set (5-Level)', 'Full-body resistance bands for home workouts.', 19.99, NULL, 'SPORT-105', TRUE),
    ((SELECT id FROM categories WHERE name = 'Sports & Outdoors'), 'Folding Treadmill', 'Compact treadmill with incline settings and Bluetooth speakers.', 249.99, 299.99, 'SPORT-106', TRUE),
    ((SELECT id FROM categories WHERE name = 'Sports & Outdoors'), 'Road Cycling Helmet', 'Ventilated helmet with an adjustable fit dial.', 44.99, NULL, 'SPORT-107', TRUE),
    ((SELECT id FROM categories WHERE name = 'Sports & Outdoors'), 'Hybrid Commuter Bicycle', '21-speed bike built for city rides and light trails.', 259.99, NULL, 'SPORT-108', TRUE),
    ((SELECT id FROM categories WHERE name = 'Sports & Outdoors'), '4-Person Camping Tent', 'Weatherproof tent with quick-pitch setup.', 89.99, 119.99, 'SPORT-109', TRUE),
    ((SELECT id FROM categories WHERE name = 'Sports & Outdoors'), 'Cold-Weather Sleeping Bag', 'Mummy-style bag rated for 3-season camping.', 59.99, NULL, 'SPORT-110', TRUE),
    ((SELECT id FROM categories WHERE name = 'Sports & Outdoors'), '55L Hiking Backpack', 'Multi-compartment backpack with a padded hip belt.', 79.99, NULL, 'SPORT-111', TRUE),
    ((SELECT id FROM categories WHERE name = 'Sports & Outdoors'), 'Trail Running Shoes', 'Grippy outsole shoes built for uneven terrain.', 69.99, NULL, 'SPORT-112', TRUE),
    ((SELECT id FROM categories WHERE name = 'Sports & Outdoors'), 'Weightlifting Gym Gloves', 'Padded gloves with wrist wrap support.', 16.99, NULL, 'SPORT-113', TRUE),
    ((SELECT id FROM categories WHERE name = 'Sports & Outdoors'), 'Speed Jump Rope', 'Adjustable-length rope with ball-bearing handles.', 12.99, NULL, 'SPORT-114', TRUE),
    ((SELECT id FROM categories WHERE name = 'Sports & Outdoors'), 'High-Density Yoga Block (2-Pack)', 'Supportive foam blocks for yoga and stretching.', 14.99, NULL, 'SPORT-115', TRUE),
    ((SELECT id FROM categories WHERE name = 'Sports & Outdoors'), 'Telescopic Fishing Rod Combo', 'Portable rod and reel combo for casual anglers.', 34.99, 44.99, 'SPORT-116', TRUE),
    ((SELECT id FROM categories WHERE name = 'Sports & Outdoors'), 'Complete Beginner Skateboard', 'Ready-to-ride skateboard with grippy deck tape.', 44.99, NULL, 'SPORT-117', TRUE),
    ((SELECT id FROM categories WHERE name = 'Sports & Outdoors'), 'Carbon Shaft Badminton Racket', 'Lightweight racket for fast net play.', 29.99, NULL, 'SPORT-118', TRUE),
    ((SELECT id FROM categories WHERE name = 'Sports & Outdoors'), 'English Willow Cricket Bat', 'Balanced bat for middle-order batting.', 59.99, NULL, 'SPORT-119', TRUE),
    ((SELECT id FROM categories WHERE name = 'Sports & Outdoors'), '3-Wood Golf Club', 'Forgiving fairway wood for confident long shots.', 89.99, NULL, 'SPORT-120', TRUE),
    ((SELECT id FROM categories WHERE name = 'Sports & Outdoors'), 'Anti-Fog Swim Goggles', 'Comfortable goggles with UV-protected lenses.', 14.99, NULL, 'SPORT-121', TRUE),
    ((SELECT id FROM categories WHERE name = 'Sports & Outdoors'), 'Full-Face Snorkel Set', 'Panoramic-view snorkel mask for easy breathing.', 24.99, 32.99, 'SPORT-122', TRUE),
    ((SELECT id FROM categories WHERE name = 'Sports & Outdoors'), 'Adjustable Kayak Paddle', 'Lightweight two-piece paddle for touring kayaks.', 39.99, NULL, 'SPORT-123', TRUE),
    ((SELECT id FROM categories WHERE name = 'Sports & Outdoors'), 'Dynamic Climbing Rope 60m', 'UIAA-certified rope for sport climbing.', 119.99, NULL, 'SPORT-124', TRUE),
    ((SELECT id FROM categories WHERE name = 'Sports & Outdoors'), 'Youth Size Football', 'Composite-leather football sized for youth leagues.', 19.99, NULL, 'SPORT-125', TRUE),
    ((SELECT id FROM categories WHERE name = 'Sports & Outdoors'), 'Leather Baseball Glove', 'Break-in-ready glove for infield or outfield play.', 34.99, NULL, 'SPORT-126', TRUE),
    ((SELECT id FROM categories WHERE name = 'Sports & Outdoors'), 'Training Boxing Gloves', 'Padded gloves for bag work and sparring.', 22.99, NULL, 'SPORT-127', TRUE),
    ((SELECT id FROM categories WHERE name = 'Sports & Outdoors'), 'Anti-Fog Ski Goggles', 'Wide-lens goggles built for bright snow conditions.', 29.99, 39.99, 'SPORT-128', TRUE),
    ((SELECT id FROM categories WHERE name = 'Sports & Outdoors'), 'Beginner Foam Surfboard', 'Soft-top surfboard ideal for learning to surf.', 99.99, NULL, 'SPORT-129', TRUE),
    ((SELECT id FROM categories WHERE name = 'Sports & Outdoors'), 'Hydration Backpack 2L', 'Lightweight pack with an insulated water bladder.', 19.99, NULL, 'SPORT-130', TRUE);

-- Sports & Outdoors images
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/0891b2/ffffff.png?text=Graphite%20Tennis%20Racket', 0 FROM products WHERE sku = 'SPORT-101';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/0891b2/ffffff.png?text=Official%20Size%20Basketball', 0 FROM products WHERE sku = 'SPORT-102';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/0891b2/ffffff.png?text=Match-Grade%20Soccer%20Ball', 0 FROM products WHERE sku = 'SPORT-103';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/0891b2/ffffff.png?text=Adjustable%20Dumbbell%20Set', 0 FROM products WHERE sku = 'SPORT-104';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/0891b2/ffffff.png?text=Resistance%20Bands%20Set%20(5-Level)', 0 FROM products WHERE sku = 'SPORT-105';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/0891b2/ffffff.png?text=Folding%20Treadmill', 0 FROM products WHERE sku = 'SPORT-106';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/0891b2/ffffff.png?text=Road%20Cycling%20Helmet', 0 FROM products WHERE sku = 'SPORT-107';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/0891b2/ffffff.png?text=Hybrid%20Commuter%20Bicycle', 0 FROM products WHERE sku = 'SPORT-108';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/0891b2/ffffff.png?text=4-Person%20Camping%20Tent', 0 FROM products WHERE sku = 'SPORT-109';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/0891b2/ffffff.png?text=Cold-Weather%20Sleeping%20Bag', 0 FROM products WHERE sku = 'SPORT-110';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/0891b2/ffffff.png?text=55L%20Hiking%20Backpack', 0 FROM products WHERE sku = 'SPORT-111';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/0891b2/ffffff.png?text=Trail%20Running%20Shoes', 0 FROM products WHERE sku = 'SPORT-112';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/0891b2/ffffff.png?text=Weightlifting%20Gym%20Gloves', 0 FROM products WHERE sku = 'SPORT-113';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/0891b2/ffffff.png?text=Speed%20Jump%20Rope', 0 FROM products WHERE sku = 'SPORT-114';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/0891b2/ffffff.png?text=High-Density%20Yoga%20Block%20(2-Pack)', 0 FROM products WHERE sku = 'SPORT-115';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/0891b2/ffffff.png?text=Telescopic%20Fishing%20Rod%20Combo', 0 FROM products WHERE sku = 'SPORT-116';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/0891b2/ffffff.png?text=Complete%20Beginner%20Skateboard', 0 FROM products WHERE sku = 'SPORT-117';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/0891b2/ffffff.png?text=Carbon%20Shaft%20Badminton%20Racket', 0 FROM products WHERE sku = 'SPORT-118';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/0891b2/ffffff.png?text=English%20Willow%20Cricket%20Bat', 0 FROM products WHERE sku = 'SPORT-119';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/0891b2/ffffff.png?text=3-Wood%20Golf%20Club', 0 FROM products WHERE sku = 'SPORT-120';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/0891b2/ffffff.png?text=Anti-Fog%20Swim%20Goggles', 0 FROM products WHERE sku = 'SPORT-121';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/0891b2/ffffff.png?text=Full-Face%20Snorkel%20Set', 0 FROM products WHERE sku = 'SPORT-122';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/0891b2/ffffff.png?text=Adjustable%20Kayak%20Paddle', 0 FROM products WHERE sku = 'SPORT-123';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/0891b2/ffffff.png?text=Dynamic%20Climbing%20Rope%2060m', 0 FROM products WHERE sku = 'SPORT-124';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/0891b2/ffffff.png?text=Youth%20Size%20Football', 0 FROM products WHERE sku = 'SPORT-125';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/0891b2/ffffff.png?text=Leather%20Baseball%20Glove', 0 FROM products WHERE sku = 'SPORT-126';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/0891b2/ffffff.png?text=Training%20Boxing%20Gloves', 0 FROM products WHERE sku = 'SPORT-127';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/0891b2/ffffff.png?text=Anti-Fog%20Ski%20Goggles', 0 FROM products WHERE sku = 'SPORT-128';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/0891b2/ffffff.png?text=Beginner%20Foam%20Surfboard', 0 FROM products WHERE sku = 'SPORT-129';
INSERT INTO product_images (product_id, image_url, display_order)
SELECT id, 'https://placehold.co/800x800/0891b2/ffffff.png?text=Hydration%20Backpack%202L', 0 FROM products WHERE sku = 'SPORT-130';

-- Sports & Outdoors specs
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Aluminum' FROM products WHERE sku = 'SPORT-101';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Carbon Fiber' FROM products WHERE sku = 'SPORT-102';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Rubber' FROM products WHERE sku = 'SPORT-103';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Nylon' FROM products WHERE sku = 'SPORT-104';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Neoprene' FROM products WHERE sku = 'SPORT-105';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Polyester' FROM products WHERE sku = 'SPORT-106';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Aluminum' FROM products WHERE sku = 'SPORT-107';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Carbon Fiber' FROM products WHERE sku = 'SPORT-108';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Rubber' FROM products WHERE sku = 'SPORT-109';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Nylon' FROM products WHERE sku = 'SPORT-110';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Neoprene' FROM products WHERE sku = 'SPORT-111';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Polyester' FROM products WHERE sku = 'SPORT-112';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Aluminum' FROM products WHERE sku = 'SPORT-113';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Carbon Fiber' FROM products WHERE sku = 'SPORT-114';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Rubber' FROM products WHERE sku = 'SPORT-115';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Nylon' FROM products WHERE sku = 'SPORT-116';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Neoprene' FROM products WHERE sku = 'SPORT-117';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Polyester' FROM products WHERE sku = 'SPORT-118';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Aluminum' FROM products WHERE sku = 'SPORT-119';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Carbon Fiber' FROM products WHERE sku = 'SPORT-120';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Rubber' FROM products WHERE sku = 'SPORT-121';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Nylon' FROM products WHERE sku = 'SPORT-122';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Neoprene' FROM products WHERE sku = 'SPORT-123';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Polyester' FROM products WHERE sku = 'SPORT-124';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Aluminum' FROM products WHERE sku = 'SPORT-125';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Carbon Fiber' FROM products WHERE sku = 'SPORT-126';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Rubber' FROM products WHERE sku = 'SPORT-127';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Nylon' FROM products WHERE sku = 'SPORT-128';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Neoprene' FROM products WHERE sku = 'SPORT-129';
INSERT INTO product_specifications (product_id, spec_key, spec_value)
SELECT id, 'Material', 'Polyester' FROM products WHERE sku = 'SPORT-130';

-- Sports & Outdoors inventory
INSERT INTO inventory (product_id, quantity)
SELECT id, 3 FROM products WHERE sku = 'SPORT-101';
INSERT INTO inventory (product_id, quantity)
SELECT id, 16 FROM products WHERE sku = 'SPORT-102';
INSERT INTO inventory (product_id, quantity)
SELECT id, 29 FROM products WHERE sku = 'SPORT-103';
INSERT INTO inventory (product_id, quantity)
SELECT id, 42 FROM products WHERE sku = 'SPORT-104';
INSERT INTO inventory (product_id, quantity)
SELECT id, 55 FROM products WHERE sku = 'SPORT-105';
INSERT INTO inventory (product_id, quantity)
SELECT id, 68 FROM products WHERE sku = 'SPORT-106';
INSERT INTO inventory (product_id, quantity)
SELECT id, 3 FROM products WHERE sku = 'SPORT-107';
INSERT INTO inventory (product_id, quantity)
SELECT id, 0 FROM products WHERE sku = 'SPORT-108';
INSERT INTO inventory (product_id, quantity)
SELECT id, 29 FROM products WHERE sku = 'SPORT-109';
INSERT INTO inventory (product_id, quantity)
SELECT id, 42 FROM products WHERE sku = 'SPORT-110';
INSERT INTO inventory (product_id, quantity)
SELECT id, 55 FROM products WHERE sku = 'SPORT-111';
INSERT INTO inventory (product_id, quantity)
SELECT id, 68 FROM products WHERE sku = 'SPORT-112';
INSERT INTO inventory (product_id, quantity)
SELECT id, 3 FROM products WHERE sku = 'SPORT-113';
INSERT INTO inventory (product_id, quantity)
SELECT id, 16 FROM products WHERE sku = 'SPORT-114';
INSERT INTO inventory (product_id, quantity)
SELECT id, 29 FROM products WHERE sku = 'SPORT-115';
INSERT INTO inventory (product_id, quantity)
SELECT id, 42 FROM products WHERE sku = 'SPORT-116';
INSERT INTO inventory (product_id, quantity)
SELECT id, 55 FROM products WHERE sku = 'SPORT-117';
INSERT INTO inventory (product_id, quantity)
SELECT id, 0 FROM products WHERE sku = 'SPORT-118';
INSERT INTO inventory (product_id, quantity)
SELECT id, 3 FROM products WHERE sku = 'SPORT-119';
INSERT INTO inventory (product_id, quantity)
SELECT id, 16 FROM products WHERE sku = 'SPORT-120';
INSERT INTO inventory (product_id, quantity)
SELECT id, 29 FROM products WHERE sku = 'SPORT-121';
INSERT INTO inventory (product_id, quantity)
SELECT id, 42 FROM products WHERE sku = 'SPORT-122';
INSERT INTO inventory (product_id, quantity)
SELECT id, 55 FROM products WHERE sku = 'SPORT-123';
INSERT INTO inventory (product_id, quantity)
SELECT id, 68 FROM products WHERE sku = 'SPORT-124';
INSERT INTO inventory (product_id, quantity)
SELECT id, 3 FROM products WHERE sku = 'SPORT-125';
INSERT INTO inventory (product_id, quantity)
SELECT id, 16 FROM products WHERE sku = 'SPORT-126';
INSERT INTO inventory (product_id, quantity)
SELECT id, 29 FROM products WHERE sku = 'SPORT-127';
INSERT INTO inventory (product_id, quantity)
SELECT id, 0 FROM products WHERE sku = 'SPORT-128';
INSERT INTO inventory (product_id, quantity)
SELECT id, 55 FROM products WHERE sku = 'SPORT-129';
INSERT INTO inventory (product_id, quantity)
SELECT id, 68 FROM products WHERE sku = 'SPORT-130';

-- Inventory transaction audit trail (mirrors what InventoryService would record)
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 3, 3, 'INITIAL' FROM products WHERE sku = 'ELEC-101';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 16, 16, 'INITIAL' FROM products WHERE sku = 'ELEC-102';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 29, 29, 'INITIAL' FROM products WHERE sku = 'ELEC-103';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 42, 42, 'INITIAL' FROM products WHERE sku = 'ELEC-104';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 55, 55, 'INITIAL' FROM products WHERE sku = 'ELEC-105';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 68, 68, 'INITIAL' FROM products WHERE sku = 'ELEC-106';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 3, 3, 'INITIAL' FROM products WHERE sku = 'ELEC-107';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 0, 0, 'INITIAL' FROM products WHERE sku = 'ELEC-108';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 29, 29, 'INITIAL' FROM products WHERE sku = 'ELEC-109';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 42, 42, 'INITIAL' FROM products WHERE sku = 'ELEC-110';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 55, 55, 'INITIAL' FROM products WHERE sku = 'ELEC-111';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 68, 68, 'INITIAL' FROM products WHERE sku = 'ELEC-112';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 3, 3, 'INITIAL' FROM products WHERE sku = 'ELEC-113';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 16, 16, 'INITIAL' FROM products WHERE sku = 'ELEC-114';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 29, 29, 'INITIAL' FROM products WHERE sku = 'ELEC-115';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 42, 42, 'INITIAL' FROM products WHERE sku = 'ELEC-116';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 55, 55, 'INITIAL' FROM products WHERE sku = 'ELEC-117';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 0, 0, 'INITIAL' FROM products WHERE sku = 'ELEC-118';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 3, 3, 'INITIAL' FROM products WHERE sku = 'ELEC-119';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 16, 16, 'INITIAL' FROM products WHERE sku = 'ELEC-120';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 29, 29, 'INITIAL' FROM products WHERE sku = 'ELEC-121';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 42, 42, 'INITIAL' FROM products WHERE sku = 'ELEC-122';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 55, 55, 'INITIAL' FROM products WHERE sku = 'ELEC-123';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 68, 68, 'INITIAL' FROM products WHERE sku = 'ELEC-124';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 3, 3, 'INITIAL' FROM products WHERE sku = 'ELEC-125';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 16, 16, 'INITIAL' FROM products WHERE sku = 'ELEC-126';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 29, 29, 'INITIAL' FROM products WHERE sku = 'ELEC-127';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 0, 0, 'INITIAL' FROM products WHERE sku = 'ELEC-128';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 55, 55, 'INITIAL' FROM products WHERE sku = 'ELEC-129';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 68, 68, 'INITIAL' FROM products WHERE sku = 'ELEC-130';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 3, 3, 'INITIAL' FROM products WHERE sku = 'BOOK-101';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 16, 16, 'INITIAL' FROM products WHERE sku = 'BOOK-102';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 29, 29, 'INITIAL' FROM products WHERE sku = 'BOOK-103';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 42, 42, 'INITIAL' FROM products WHERE sku = 'BOOK-104';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 55, 55, 'INITIAL' FROM products WHERE sku = 'BOOK-105';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 68, 68, 'INITIAL' FROM products WHERE sku = 'BOOK-106';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 3, 3, 'INITIAL' FROM products WHERE sku = 'BOOK-107';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 0, 0, 'INITIAL' FROM products WHERE sku = 'BOOK-108';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 29, 29, 'INITIAL' FROM products WHERE sku = 'BOOK-109';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 42, 42, 'INITIAL' FROM products WHERE sku = 'BOOK-110';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 55, 55, 'INITIAL' FROM products WHERE sku = 'BOOK-111';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 68, 68, 'INITIAL' FROM products WHERE sku = 'BOOK-112';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 3, 3, 'INITIAL' FROM products WHERE sku = 'BOOK-113';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 16, 16, 'INITIAL' FROM products WHERE sku = 'BOOK-114';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 29, 29, 'INITIAL' FROM products WHERE sku = 'BOOK-115';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 42, 42, 'INITIAL' FROM products WHERE sku = 'BOOK-116';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 55, 55, 'INITIAL' FROM products WHERE sku = 'BOOK-117';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 0, 0, 'INITIAL' FROM products WHERE sku = 'BOOK-118';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 3, 3, 'INITIAL' FROM products WHERE sku = 'BOOK-119';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 16, 16, 'INITIAL' FROM products WHERE sku = 'BOOK-120';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 29, 29, 'INITIAL' FROM products WHERE sku = 'BOOK-121';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 42, 42, 'INITIAL' FROM products WHERE sku = 'BOOK-122';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 55, 55, 'INITIAL' FROM products WHERE sku = 'BOOK-123';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 68, 68, 'INITIAL' FROM products WHERE sku = 'BOOK-124';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 3, 3, 'INITIAL' FROM products WHERE sku = 'BOOK-125';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 16, 16, 'INITIAL' FROM products WHERE sku = 'BOOK-126';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 29, 29, 'INITIAL' FROM products WHERE sku = 'BOOK-127';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 0, 0, 'INITIAL' FROM products WHERE sku = 'BOOK-128';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 55, 55, 'INITIAL' FROM products WHERE sku = 'BOOK-129';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 68, 68, 'INITIAL' FROM products WHERE sku = 'BOOK-130';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 3, 3, 'INITIAL' FROM products WHERE sku = 'FASH-101';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 16, 16, 'INITIAL' FROM products WHERE sku = 'FASH-102';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 29, 29, 'INITIAL' FROM products WHERE sku = 'FASH-103';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 42, 42, 'INITIAL' FROM products WHERE sku = 'FASH-104';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 55, 55, 'INITIAL' FROM products WHERE sku = 'FASH-105';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 68, 68, 'INITIAL' FROM products WHERE sku = 'FASH-106';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 3, 3, 'INITIAL' FROM products WHERE sku = 'FASH-107';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 0, 0, 'INITIAL' FROM products WHERE sku = 'FASH-108';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 29, 29, 'INITIAL' FROM products WHERE sku = 'FASH-109';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 42, 42, 'INITIAL' FROM products WHERE sku = 'FASH-110';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 55, 55, 'INITIAL' FROM products WHERE sku = 'FASH-111';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 68, 68, 'INITIAL' FROM products WHERE sku = 'FASH-112';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 3, 3, 'INITIAL' FROM products WHERE sku = 'FASH-113';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 16, 16, 'INITIAL' FROM products WHERE sku = 'FASH-114';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 29, 29, 'INITIAL' FROM products WHERE sku = 'FASH-115';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 42, 42, 'INITIAL' FROM products WHERE sku = 'FASH-116';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 55, 55, 'INITIAL' FROM products WHERE sku = 'FASH-117';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 0, 0, 'INITIAL' FROM products WHERE sku = 'FASH-118';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 3, 3, 'INITIAL' FROM products WHERE sku = 'FASH-119';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 16, 16, 'INITIAL' FROM products WHERE sku = 'FASH-120';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 29, 29, 'INITIAL' FROM products WHERE sku = 'FASH-121';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 42, 42, 'INITIAL' FROM products WHERE sku = 'FASH-122';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 55, 55, 'INITIAL' FROM products WHERE sku = 'FASH-123';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 68, 68, 'INITIAL' FROM products WHERE sku = 'FASH-124';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 3, 3, 'INITIAL' FROM products WHERE sku = 'FASH-125';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 16, 16, 'INITIAL' FROM products WHERE sku = 'FASH-126';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 29, 29, 'INITIAL' FROM products WHERE sku = 'FASH-127';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 0, 0, 'INITIAL' FROM products WHERE sku = 'FASH-128';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 55, 55, 'INITIAL' FROM products WHERE sku = 'FASH-129';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 68, 68, 'INITIAL' FROM products WHERE sku = 'FASH-130';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 3, 3, 'INITIAL' FROM products WHERE sku = 'HOME-101';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 16, 16, 'INITIAL' FROM products WHERE sku = 'HOME-102';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 29, 29, 'INITIAL' FROM products WHERE sku = 'HOME-103';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 42, 42, 'INITIAL' FROM products WHERE sku = 'HOME-104';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 55, 55, 'INITIAL' FROM products WHERE sku = 'HOME-105';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 68, 68, 'INITIAL' FROM products WHERE sku = 'HOME-106';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 3, 3, 'INITIAL' FROM products WHERE sku = 'HOME-107';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 0, 0, 'INITIAL' FROM products WHERE sku = 'HOME-108';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 29, 29, 'INITIAL' FROM products WHERE sku = 'HOME-109';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 42, 42, 'INITIAL' FROM products WHERE sku = 'HOME-110';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 55, 55, 'INITIAL' FROM products WHERE sku = 'HOME-111';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 68, 68, 'INITIAL' FROM products WHERE sku = 'HOME-112';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 3, 3, 'INITIAL' FROM products WHERE sku = 'HOME-113';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 16, 16, 'INITIAL' FROM products WHERE sku = 'HOME-114';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 29, 29, 'INITIAL' FROM products WHERE sku = 'HOME-115';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 42, 42, 'INITIAL' FROM products WHERE sku = 'HOME-116';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 55, 55, 'INITIAL' FROM products WHERE sku = 'HOME-117';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 0, 0, 'INITIAL' FROM products WHERE sku = 'HOME-118';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 3, 3, 'INITIAL' FROM products WHERE sku = 'HOME-119';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 16, 16, 'INITIAL' FROM products WHERE sku = 'HOME-120';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 29, 29, 'INITIAL' FROM products WHERE sku = 'HOME-121';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 42, 42, 'INITIAL' FROM products WHERE sku = 'HOME-122';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 55, 55, 'INITIAL' FROM products WHERE sku = 'HOME-123';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 68, 68, 'INITIAL' FROM products WHERE sku = 'HOME-124';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 3, 3, 'INITIAL' FROM products WHERE sku = 'HOME-125';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 16, 16, 'INITIAL' FROM products WHERE sku = 'HOME-126';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 29, 29, 'INITIAL' FROM products WHERE sku = 'HOME-127';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 0, 0, 'INITIAL' FROM products WHERE sku = 'HOME-128';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 55, 55, 'INITIAL' FROM products WHERE sku = 'HOME-129';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 68, 68, 'INITIAL' FROM products WHERE sku = 'HOME-130';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 3, 3, 'INITIAL' FROM products WHERE sku = 'SPORT-101';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 16, 16, 'INITIAL' FROM products WHERE sku = 'SPORT-102';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 29, 29, 'INITIAL' FROM products WHERE sku = 'SPORT-103';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 42, 42, 'INITIAL' FROM products WHERE sku = 'SPORT-104';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 55, 55, 'INITIAL' FROM products WHERE sku = 'SPORT-105';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 68, 68, 'INITIAL' FROM products WHERE sku = 'SPORT-106';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 3, 3, 'INITIAL' FROM products WHERE sku = 'SPORT-107';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 0, 0, 'INITIAL' FROM products WHERE sku = 'SPORT-108';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 29, 29, 'INITIAL' FROM products WHERE sku = 'SPORT-109';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 42, 42, 'INITIAL' FROM products WHERE sku = 'SPORT-110';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 55, 55, 'INITIAL' FROM products WHERE sku = 'SPORT-111';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 68, 68, 'INITIAL' FROM products WHERE sku = 'SPORT-112';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 3, 3, 'INITIAL' FROM products WHERE sku = 'SPORT-113';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 16, 16, 'INITIAL' FROM products WHERE sku = 'SPORT-114';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 29, 29, 'INITIAL' FROM products WHERE sku = 'SPORT-115';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 42, 42, 'INITIAL' FROM products WHERE sku = 'SPORT-116';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 55, 55, 'INITIAL' FROM products WHERE sku = 'SPORT-117';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 0, 0, 'INITIAL' FROM products WHERE sku = 'SPORT-118';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 3, 3, 'INITIAL' FROM products WHERE sku = 'SPORT-119';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 16, 16, 'INITIAL' FROM products WHERE sku = 'SPORT-120';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 29, 29, 'INITIAL' FROM products WHERE sku = 'SPORT-121';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 42, 42, 'INITIAL' FROM products WHERE sku = 'SPORT-122';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 55, 55, 'INITIAL' FROM products WHERE sku = 'SPORT-123';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 68, 68, 'INITIAL' FROM products WHERE sku = 'SPORT-124';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 3, 3, 'INITIAL' FROM products WHERE sku = 'SPORT-125';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 16, 16, 'INITIAL' FROM products WHERE sku = 'SPORT-126';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 29, 29, 'INITIAL' FROM products WHERE sku = 'SPORT-127';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 0, 0, 'INITIAL' FROM products WHERE sku = 'SPORT-128';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 55, 55, 'INITIAL' FROM products WHERE sku = 'SPORT-129';
INSERT INTO inventory_transactions (product_id, change_quantity, resulting_quantity, reason)
SELECT id, 68, 68, 'INITIAL' FROM products WHERE sku = 'SPORT-130';
