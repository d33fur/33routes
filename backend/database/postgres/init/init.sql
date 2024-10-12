DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_database WHERE datname = '33routes') THEN
        CREATE DATABASE "33routes";
    END IF;
END
$$;

\c "33routes";

CREATE TABLE IF NOT EXISTS users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    name VARCHAR(50) NOT NULL,
    surname VARCHAR(50),
    country VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    avatar_url VARCHAR(255),
    bio TEXT,
    phone VARCHAR(20),
    created_at BIGINT NOT NULL,
    is_deleted BOOLEAN NOT NULL,
    instagram VARCHAR(255),
    facebook VARCHAR(255),
    x VARCHAR(255),
    vkontakte VARCHAR(255),
    telegram VARCHAR(255),
    linkedin VARCHAR(255),
    youtube VARCHAR(255),
    user_site VARCHAR(255),
    email_for_communications VARCHAR(255)
);

-- CREATE TYPE theme_type AS ENUM ('light', 'dark'); -- Енам для тем

-- CREATE TABLE IF NOT EXISTS user_settings (
--     user_id INT PRIMARY KEY REFERENCES users(user_id),
--     theme theme_type DEFAULT 'light', -- Установлена тема по умолчанию
--     show_email_for_communications BOOLEAN DEFAULT TRUE,
--     show_phone BOOLEAN DEFAULT TRUE,
--     show_planned BOOLEAN DEFAULT TRUE,
--     show_visited BOOLEAN DEFAULT TRUE,
--     show_favorite BOOLEAN DEFAULT TRUE,
--     notification_settings JSONB
-- );

-- CREATE TABLE IF NOT EXISTS routes (
--     route_id SERIAL PRIMARY KEY,
--     user_id INT REFERENCES users(user_id),
--     name VARCHAR(255) NOT NULL,
--     url VARCHAR(255) NOT NULL,
--     description TEXT,
--     start_point VARCHAR(255), -- можно оставить, если предполагается некое описание точки старта
--     end_point VARCHAR(255), -- аналогично для конечной точки
--     length INT, -- длина в метрах (int), как ты предложил
--     duration INT, -- продолжительность в минутах (int)
--     -- Теги: можно хранить как массив строк
--     tags VARCHAR(255)[], -- массив строк для тегов
--     -- Категории: создадим ENUM
--     category VARCHAR(50),
--     created_at BIGINT DEFAULT EXTRACT(EPOCH FROM CURRENT_TIMESTAMP), -- юникстайм
--     status VARCHAR(10) DEFAULT 'pending' CHECK (status IN ('pending', 'approved', 'rejected')),
--     is_deleted BOOLEAN NOT NULL,
--     rating FLOAT NOT NULL
--     -- Фотографии можно добавить как массив URL-адресов или как отдельную таблицу
--     -- photos TEXT[]
-- );

-- CREATE TABLE IF NOT EXISTS route_points (
--     point_id SERIAL PRIMARY KEY,
--     route_id INT REFERENCES routes(route_id),
--     point_name VARCHAR(255),
--     latitude NUMERIC(10, 8),
--     longitude NUMERIC(11, 8),
--     -- Время прохождения точки можно хранить в минутах от старта маршрута
--     time_offset INT, -- время в минутах от начала маршрута
--     -- Высота в метрах
--     elevation NUMERIC(6, 2),
--     -- Скорость прохождения данной точки в м/с
--     speed NUMERIC(5, 2)
-- );

-- CREATE TABLE IF NOT EXISTS collections (
--     collection_id SERIAL PRIMARY KEY,
--     user_id INT REFERENCES users(user_id),
--     title VARCHAR(255) NOT NULL,
--     description TEXT,
--     tags VARCHAR(255)[],
--     created_at BIGINT DEFAULT EXTRACT(EPOCH FROM CURRENT_TIMESTAMP)
-- );

-- CREATE TABLE IF NOT EXISTS collection_routes (
--     collection_id INT REFERENCES collections(collection_id),
--     route_id INT REFERENCES routes(route_id),
--     PRIMARY KEY (collection_id, route_id)
-- );

-- CREATE TABLE IF NOT EXISTS reviews (
--     review_id SERIAL PRIMARY KEY,
--     user_id INT REFERENCES users(user_id),
--     route_id INT REFERENCES routes(route_id),
--     rating INT CHECK (rating >= 1 AND rating <= 5),
--     comment TEXT,
--     created_at BIGINT DEFAULT EXTRACT(EPOCH FROM CURRENT_TIMESTAMP)
-- );

-- CREATE TABLE IF NOT EXISTS review_comments (
--     comment_id SERIAL PRIMARY KEY,
--     review_id INT REFERENCES reviews(review_id),
--     user_id INT REFERENCES users(user_id),
--     comment TEXT,
--     created_at BIGINT DEFAULT EXTRACT(EPOCH FROM CURRENT_TIMESTAMP)
-- );

-- CREATE TABLE IF NOT EXISTS review_likes (
--     user_id INT REFERENCES users(user_id),
--     review_id INT REFERENCES reviews(review_id),
--     PRIMARY KEY (user_id, review_id)
-- );

-- CREATE TABLE IF NOT EXISTS comment_likes (
--     user_id INT REFERENCES users(user_id),
--     comment_id INT REFERENCES review_comments(comment_id),
--     PRIMARY KEY (user_id, comment_id)
-- );

-- CREATE TABLE IF NOT EXISTS saved_routes (
--     user_id INT REFERENCES users(user_id),
--     route_id INT REFERENCES routes(route_id),
--     PRIMARY KEY (user_id, route_id)
-- );

-- CREATE TABLE IF NOT EXISTS completed_routes (
--     user_id INT REFERENCES users(user_id),
--     route_id INT REFERENCES routes(route_id),
--     completed_at BIGINT DEFAULT EXTRACT(EPOCH FROM CURRENT_TIMESTAMP), -- юникстайм для отметки времени завершения
--     PRIMARY KEY (user_id, route_id)
-- );

-- CREATE TABLE IF NOT EXISTS reports (
--     report_id SERIAL PRIMARY KEY,
--     user_id INT REFERENCES users(user_id),
--     report_type VARCHAR(50) CHECK (report_type IN ('route', 'review', 'collection', 'user', 'comment')),
--     reported_id INT,
--     reason TEXT,
--     created_at BIGINT DEFAULT EXTRACT(EPOCH FROM CURRENT_TIMESTAMP)
-- );
