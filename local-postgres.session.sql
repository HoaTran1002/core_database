CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(150) UNIQUE
);
INSERT INTO users (name, email)
VALUES ('Hoa', 'hoa@example.com'),
    ('Nam', 'nam@example.com'),
    ('Lan', 'lan@example.com') ON CONFLICT (email) DO NOTHING;
SELECT *
FROM users;