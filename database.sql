CREATE TABLE IF NOT EXISTS consumables (
    id INT AUTO_INCREMENT PRIMARY KEY,
    item_name VARCHAR(50) NOT NULL,
    durability INT NOT NULL,
    effect VARCHAR(50) NOT NULL
);

INSERT INTO consumables (item_name, durability, effect) VALUES
('water_bottle', 100, 'refresh'),
('burger', 100, 'energy'),
('beer', 100, 'drunk');