-- Добавляем пользователей
INSERT INTO users (username, name, surname, country, city, email, password_hash, avatar_url, bio, phone, created_at)
VALUES 
('user1', 'John', 'Doe', 'USA', 'New York', 'user1@example.com', 'hash1', 'https://example.com/avatar1.jpg', 'Traveler and explorer.', '+1234567890', EXTRACT(EPOCH FROM NOW())::BIGINT),
('user2', 'Jane', 'Smith', 'Canada', 'Toronto', 'user2@example.com', 'hash2', 'https://example.com/avatar2.jpg', 'Nature lover.', '+9876543210', EXTRACT(EPOCH FROM NOW())::BIGINT);

-- Настройки пользователей
INSERT INTO user_settings (user_id, theme, show_phone, show_planned, show_visited, show_favorite, notification_settings)
VALUES
(1, 'dark', TRUE, TRUE, TRUE, TRUE, '{"email": true, "push": false}'::jsonb),
(2, 'light', FALSE, TRUE, FALSE, TRUE, '{"email": false, "push": true}'::jsonb);

-- Добавляем маршруты
INSERT INTO routes (user_id, name, url, description, length, duration, tags, category, created_at, rating, photos)
VALUES 
(1, 'Beautiful Mountain Route', 'https://example.com/route1', 'A scenic mountain route.', 10, 120, '{forest}', 'walking', EXTRACT(EPOCH FROM NOW())::BIGINT, 4.5, '{"https://example.com/photo1.jpg", "https://example.com/photo2.jpg"}'),
(2, 'Park Walk Route', 'https://example.com/route2', 'A peaceful park walk.', 5, 60, '{park}', 'walking', EXTRACT(EPOCH FROM NOW())::BIGINT, 4.0, '{"https://example.com/photo3.jpg", "https://example.com/photo4.jpg"}');

-- Точки маршрута
INSERT INTO route_points (route_id, point_name, latitude, longitude, time_offset, elevation, speed)
VALUES 
(1, 'Start Point', 40.712776, -74.005974, 0, 10.5, 4.5),
(1, 'End Point', 40.732776, -74.025974, 120, 20.0, 4.0),
(2, 'Park Entrance', 43.651070, -79.347015, 0, 5.0, 3.5),
(2, 'Park Exit', 43.651570, -79.347515, 60, 10.0, 3.0);

-- Добавляем коллекции
INSERT INTO collections (user_id, title, description, tags, created_at)
VALUES 
(1, 'Mountain Adventures', 'A collection of mountain routes.', '{forest}', EXTRACT(EPOCH FROM NOW())::BIGINT),
(2, 'City Walks', 'A collection of city routes.', '{park}', EXTRACT(EPOCH FROM NOW())::BIGINT);

-- Добавляем маршруты в коллекции
INSERT INTO collection_routes (collection_id, route_id)
VALUES
(1, 1),
(2, 2);

-- Добавляем отзывы
INSERT INTO reviews (user_id, route_id, rating, comment, created_at)
VALUES 
(1, 1, 4.5, 'Amazing route, loved the view!', EXTRACT(EPOCH FROM NOW())::BIGINT),
(2, 2, 4.0, 'Nice and peaceful walk.', EXTRACT(EPOCH FROM NOW())::BIGINT);

-- Добавляем комментарии к отзывам
INSERT INTO review_comments (review_id, user_id, comment, created_at)
VALUES 
(1, 2, 'I totally agree with you!', EXTRACT(EPOCH FROM NOW())::BIGINT),
(2, 1, 'Thanks for the review!', EXTRACT(EPOCH FROM NOW())::BIGINT);

-- Добавляем лайки к отзывам
INSERT INTO review_likes (user_id, review_id)
VALUES 
(1, 1),
(2, 2);

-- Добавляем лайки к комментариям
INSERT INTO comment_likes (user_id, comment_id)
VALUES 
(1, 1),
(2, 2);

-- Добавляем сохранённые маршруты
INSERT INTO saved_routes (user_id, route_id)
VALUES 
(1, 2),
(2, 1);

-- Добавляем завершённые маршруты
INSERT INTO completed_routes (user_id, route_id, completed_at)
VALUES 
(1, 1, EXTRACT(EPOCH FROM NOW())::BIGINT),
(2, 2, EXTRACT(EPOCH FROM NOW())::BIGINT);

-- Добавляем жалобы
INSERT INTO reports (user_id, report_type, reported_id, reason, created_at)
VALUES 
(1, 'route', 2, 'Inappropriate content', EXTRACT(EPOCH FROM NOW())::BIGINT),
(2, 'review', 1, 'Offensive comment', EXTRACT(EPOCH FROM NOW())::BIGINT);
