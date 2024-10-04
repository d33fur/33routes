DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_database WHERE datname = '33routes') THEN
        CREATE DATABASE 33routes;
    END IF;
END
$$;

\c 33routes;

CREATE TABLE IF NOT EXISTS users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    name VARCHAR(50) NOT NULL,
    surname VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    avatar_url VARCHAR(255),
    bio TEXT,
    phone VARCHAR(20),
    -- сделать юникстайм
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_deleted BOOLEAN NOT NULL,
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

CREATE TABLE IF NOT EXISTS user_settings (
    user_id INT PRIMARY KEY REFERENCES users(user_id),
    theme VARCHAR(50), 
    -- сделать енам темы
    show_email_for_communications BOOLEAN DEFAULT TRUE,
    show_phone BOOLEAN DEFAULT TRUE,
    show_planned BOOLEAN DEFAULT TRUE,
    show_visited BOOLEAN DEFAULT TRUE,
    show_favorite BOOLEAN DEFAULT TRUE,
    notification_settings JSONB
);

CREATE TABLE IF NOT EXISTS routes (
    route_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    name VARCHAR(255) NOT NULL,
    url VARCHAR(255) NOT NULL,
    description TEXT,
    -- сомнительно
    start_point VARCHAR(255),
    -- сомнительно
    end_point VARCHAR(255),
    -- длина в интах в метрах
    length NUMERIC(10, 2),
    -- подумать как лучше хранить время, наверное лучше в интах в минутах
    duration INT,
    -- сделать енамы для тэгов
    tags VARCHAR(255),
    -- сделать енамы для категорий
    category VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(10) DEFAULT 'pending' CHECK (status IN ('pending', 'approved', 'rejected')),
    is_deleted BOOLEAN NOT NULL,
    rating FLOAT NOT NULL
    -- нужно добавить фотографии
);

CREATE TABLE IF NOT EXISTS route_points (
    point_id SERIAL PRIMARY KEY,
    route_id INT REFERENCES routes(route_id),
    point_name VARCHAR(255),
    latitude NUMERIC(10, 8),
    longitude NUMERIC(11, 8)
    -- добавить время
    -- добавить высоту
    -- добавить скорость
);

CREATE TABLE IF NOT EXISTS collections (
    collection_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    title VARCHAR(255) NOT NULL,
    description TEXT,
    tags VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS collection_routes (
    collection_id INT REFERENCES collections(collection_id),
    route_id INT REFERENCES routes(route_id),
    PRIMARY KEY (collection_id, route_id)
);

CREATE TABLE IF NOT EXISTS reviews (
    review_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    route_id INT REFERENCES routes(route_id),
    rating INT CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS review_comments (
    comment_id SERIAL PRIMARY KEY,
    review_id INT REFERENCES reviews(review_id),
    user_id INT REFERENCES users(user_id),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS review_likes (
    user_id INT REFERENCES users(user_id),
    review_id INT REFERENCES reviews(review_id),
    PRIMARY KEY (user_id, review_id)
);

CREATE TABLE IF NOT EXISTS comment_likes (
    user_id INT REFERENCES users(user_id),
    comment_id INT REFERENCES review_comments(comment_id),
    PRIMARY KEY (user_id, comment_id)
);

CREATE TABLE IF NOT EXISTS saved_routes (
    user_id INT REFERENCES users(user_id),
    route_id INT REFERENCES routes(route_id),
    PRIMARY KEY (user_id, route_id)
);

CREATE TABLE IF NOT EXISTS completed_routes (
    user_id INT REFERENCES users(user_id),
    route_id INT REFERENCES routes(route_id),
    completed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, route_id)
);

CREATE TABLE IF NOT EXISTS reports (
    report_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    report_type VARCHAR(50) CHECK (report_type IN ('route', 'review', 'collection', 'user', 'comment')),
    reported_id INT,
    reason TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
