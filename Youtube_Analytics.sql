--  USERS TABLE
-- ==========================================
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50),
    country VARCHAR(50),
    join_date DATE
);

--  Channels TABLE
-- ==========================================
CREATE TABLE channels (
    channel_id INT PRIMARY KEY,
    user_id INT,
    channel_name VARCHAR(100),
    category VARCHAR(50),
    subscribers INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

--  Videos TABLE
-- ==========================================
CREATE TABLE videos (
    video_id INT PRIMARY KEY,
    channel_id INT,
    title VARCHAR(200),
    upload_date DATE,
    views INT,
    likes INT,
    duration_minutes INT,
    FOREIGN KEY (channel_id) REFERENCES channels(channel_id)
);

--  Comments TABLE
-- ==========================================
CREATE TABLE comments (
    comment_id INT PRIMARY KEY,
    video_id INT,
    user_id INT,
    comment_text TEXT,
    comment_date DATE,
    FOREIGN KEY (video_id) REFERENCES videos(video_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

--  Likes TABLE
-- ==========================================
CREATE TABLE likes (
    like_id INT PRIMARY KEY,
    video_id INT,
    user_id INT,
    like_date DATE,
    FOREIGN KEY (video_id) REFERENCES videos(video_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

--  Subscriptions TABLE
-- ==========================================
CREATE TABLE subscriptions (
    subscription_id INT PRIMARY KEY,
    user_id INT,
    channel_id INT,
    subscribe_date DATE,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (channel_id) REFERENCES channels(channel_id)
);

--  Watch_history TABLE
-- ==========================================
CREATE TABLE watch_history (
    watch_id INT PRIMARY KEY,
    user_id INT,
    video_id INT,
    watch_time_minutes INT,
    watch_date DATE,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (video_id) REFERENCES videos(video_id)
);

-- USERS TABLE (SAMPLE DATA)
-- ==========================================
INSERT INTO users VALUES
(1, 'john_doe', 'USA', '2023-01-10'),
(2, 'priya_tech', 'India', '2023-02-15'),
(3, 'alex_gaming', 'UK', '2023-03-20'),
(4, 'sarah_vlogs', 'Canada', '2023-04-18'),
(5, 'mike_music', 'Australia', '2023-05-25'),
(6, 'emma_fit', 'USA', '2023-06-12'),
(7, 'raj_edits', 'India', '2023-07-08'),
(8, 'lucas_live', 'Brazil', '2023-08-21'),
(9, 'nina_foodie', 'France', '2023-09-14'),
(10, 'david_creator', 'Germany', '2023-10-01'),
(11, 'oliver_tech', 'UK', '2023-10-19'),
(12, 'kavya_vlogs', 'India', '2023-11-03'),
(13, 'sam_music', 'USA', '2023-11-25'),
(14, 'leo_gamer', 'Canada', '2023-12-10'),
(15, 'mia_travel', 'Australia', '2024-01-05'),
(16, 'arjun_sql', 'India', '2024-01-22'),
(17, 'sofia_style', 'Italy', '2024-02-11'),
(18, 'ethan_reviews', 'USA', '2024-02-28'),
(19, 'zara_cooking', 'UAE', '2024-03-15'),
(20, 'noah_streams', 'Japan', '2024-04-02');

select * from users ;

-- COUNT TOTAL USERS
-- ==========================================
SELECT COUNT(*) AS total_users
FROM users;

-- CHANNELS TABLE
-- ==========================================
-- Channel Information:
-- Stores YouTube channel details including
-- channel owner, category, and subscriber count.
-- ==========================================
INSERT INTO channels VALUES
(101, 1, 'John Tech Reviews', 'Technology', 120000),
(102, 2, 'Priya Coding Hub', 'Education', 95000),
(103, 3, 'Alex Gaming Zone', 'Gaming', 210000),
(104, 4, 'Sarah Travel Vlogs', 'Travel', 150000),
(105, 5, 'Mike Music Studio', 'Music', 175000),
(106, 6, 'Emma Fitness World', 'Fitness', 88000),
(107, 7, 'Raj Editing Master', 'Editing', 67000),
(108, 8, 'Lucas Live Streams', 'Entertainment', 143000),
(109, 9, 'Nina Food Recipes', 'Food', 99000),
(110, 10, 'David Creative Studio', 'Creativity', 76000),
(111, 11, 'Oliver Tech Talks', 'Technology', 134000),
(112, 12, 'Kavya Daily Vlogs', 'Lifestyle', 112000),
(113, 13, 'Sam Music Beats', 'Music', 156000),
(114, 14, 'Leo Gamer Pro', 'Gaming', 245000),
(115, 15, 'Mia Travel Diaries', 'Travel', 98000),
(116, 16, 'Arjun SQL Academy', 'Education', 54000),
(117, 17, 'Sofia Fashion Hub', 'Fashion', 81000),
(118, 18, 'Ethan Review Central', 'Reviews', 72000),
(119, 19, 'Zara Cooking Magic', 'Cooking', 128000),
(120, 20, 'Noah Streaming Arena', 'Streaming', 165000);

select * from channels;

-- CHANNELS RANKED BY SUBSCRIBERS
-- ==========================================
SELECT channel_name, subscribers
FROM channels
ORDER BY subscribers DESC;

-- VIDEOS TABLE
-- ==========================================
-- Video Information:
-- Stores video details including title,
-- upload date, views, likes, and duration.
-- ==========================================
INSERT INTO videos VALUES
(1001, 101, 'Best Laptop 2025', '2025-01-10', 500000, 45000, 15),
(1002, 102, 'Learn SQL Basics', '2025-02-12', 750000, 62000, 25),
(1003, 103, 'Top 10 Games', '2025-03-05', 1200000, 98000, 18),
(1004, 104, 'Trip to Japan', '2025-03-15', 650000, 54000, 30),
(1005, 105, 'Relaxing Piano Music', '2025-04-01', 900000, 72000, 60);

select * from videos;

-- COMMENTS TABLE
-- ==========================================
-- Comment Details:
-- Stores comments posted by users on videos,
-- including comment text and comment date.
-- ==========================================
INSERT INTO comments VALUES
(1, 1001, 1, 'Great tutorial!', '2025-01-11'),
(2, 1003, 2, 'Loved this video', '2025-03-06'),
(3, 1004, 3, 'Awesome gameplay', '2025-03-16'),
(4, 1002, 4, 'Very helpful explanation!', '2025-02-13'),
(5, 1005, 5, 'Relaxing and peaceful music.', '2025-04-02'),
(6, 1001, 2, 'Thanks for the laptop review!', '2025-01-12'),
(7, 1003, 1, 'Top games list was amazing!', '2025-03-07'),
(8, 1004, 5, 'Japan looks beautiful!', '2025-03-17'),
(9, 1002, 3, 'Easy to understand SQL concepts.', '2025-02-14'),
(10, 1005, 4, 'Perfect music for studying.', '2025-04-03'),
(11, 1001, 5, 'This helped me choose a laptop.', '2025-01-13'),
(12, 1003, 4, 'Waiting for part 2!', '2025-03-08'),
(13, 1004, 2, 'Great travel vlog!', '2025-03-18'),
(14, 1002, 1, 'Excellent tutorial.', '2025-02-15'),
(15, 1005, 3, 'Loved the piano performance.', '2025-04-04');

SELECT * FROM comments;

-- LIKES TABLE
-- ==========================================
-- Like Information:
-- Stores information about users who liked videos,
-- including the video ID, user ID, and like date.
-- ==========================================
INSERT INTO likes VALUES
(1, 1001, 1, '2025-01-11'),
(2, 1001, 2, '2025-01-12'),
(3, 1002, 3, '2025-02-13'),
(4, 1002, 4, '2025-02-14'),
(5, 1003, 5, '2025-03-06'),
(6, 1003, 1, '2025-03-07'),
(7, 1004, 2, '2025-03-16'),
(8, 1004, 3, '2025-03-17'),
(9, 1005, 4, '2025-04-02'),
(10, 1005, 5, '2025-04-03'),
(11, 1001, 3, '2025-01-13'),
(12, 1002, 5, '2025-02-15'),
(13, 1003, 2, '2025-03-08'),
(14, 1004, 1, '2025-03-18'),
(15, 1005, 2, '2025-04-04');

select * from likes;

-- SUBSCRIPTIONS TABLE
-- ==========================================
-- Subscription Information:
-- Stores details of users subscribing to channels,
-- including subscriber ID, channel ID, and subscription date.
-- ==========================================
INSERT INTO subscriptions VALUES
(1, 1, 101, '2025-01-05'),
(2, 2, 102, '2025-01-10'),
(3, 3, 103, '2025-01-15'),
(4, 4, 104, '2025-01-20'),
(5, 5, 105, '2025-01-25'),
(6, 1, 102, '2025-02-01'),
(7, 2, 103, '2025-02-03'),
(8, 3, 104, '2025-02-05'),
(9, 4, 105, '2025-02-07'),
(10, 5, 101, '2025-02-10'),
(11, 1, 103, '2025-02-12'),
(12, 2, 104, '2025-02-15'),
(13, 3, 105, '2025-02-18'),
(14, 4, 101, '2025-02-20'),
(15, 5, 102, '2025-02-22'),
(16, 1, 104, '2025-03-01'),
(17, 2, 105, '2025-03-03'),
(18, 3, 101, '2025-03-05'),
(19, 4, 102, '2025-03-07'),
(20, 5, 103, '2025-03-10');

select * from subscriptions;

-- WATCH HISTORY TABLE
-- ==========================================
-- Watch History Information:
-- Stores user video viewing activity,
-- including watch time and watch date.
-- ==========================================
INSERT INTO watch_history VALUES
(1, 1, 1001, 12, '2025-01-11'),
(2, 2, 1002, 20, '2025-02-13'),
(3, 3, 1003, 15, '2025-03-06'),
(4, 4, 1004, 25, '2025-03-16'),
(5, 5, 1005, 45, '2025-04-02'),
(6, 1, 1002, 18, '2025-02-14'),
(7, 2, 1003, 10, '2025-03-07'),
(8, 3, 1004, 22, '2025-03-17'),
(9, 4, 1005, 50, '2025-04-03'),
(10, 5, 1001, 14, '2025-01-12'),
(11, 1, 1003, 16, '2025-03-08'),
(12, 2, 1004, 28, '2025-03-18'),
(13, 3, 1005, 55, '2025-04-04'),
(14, 4, 1001, 13, '2025-01-13'),
(15, 5, 1002, 21, '2025-02-15'),
(16, 1, 1004, 24, '2025-03-19'),
(17, 2, 1005, 48, '2025-04-05'),
(18, 3, 1001, 11, '2025-01-14'),
(19, 4, 1002, 19, '2025-02-16'),
(20, 5, 1003, 17, '2025-03-09');

select * from watch_history;

-- TOP 3 MOST VIEWED VIDEOS
-- ==========================================
-- Displays the three videos with the highest
-- number of views on the platform.
-- ==========================================
SELECT
    video_id,
    title,
    views
FROM videos
ORDER BY views DESC
LIMIT 3;

-- TOP 3 MOST LIKED VIDEOS
-- ==========================================
-- Purpose:
-- Retrieve the three videos that received
-- the highest number of likes from users.
-- ==========================================
SELECT
    v.video_id,
    v.title,
    COUNT(l.like_id) AS total_likes
FROM videos v
JOIN likes l
ON v.video_id = l.video_id
GROUP BY v.video_id, v.title
ORDER BY total_likes DESC
LIMIT 3;


SELECT
    v.video_id,
    v.title,
    COUNT(l.like_id) AS total_likes
FROM videos v
LEFT JOIN likes l
ON v.video_id = l.video_id
GROUP BY v.video_id, v.title
ORDER BY total_likes DESC;


-- TOTAL VIEWS PER CHANNEL
-- ==========================================
-- Purpose:
-- Calculate the total number of views received
-- by each channel across all its videos.
-- ==========================================
SELECT
    c.channel_id,
    c.channel_name,
    SUM(v.views) AS total_views
FROM channels c
JOIN videos v
ON c.channel_id = v.channel_id
GROUP BY c.channel_id, c.channel_name
ORDER BY total_views DESC;

-- MOST ACTIVE USERS
-- ==========================================
-- Purpose:
-- Identify the users who watch videos most
-- frequently based on their watch history.
-- ==========================================
SELECT
    u.user_id,
    u.username,
    COUNT(w.watch_id) AS total_watches
FROM users u
JOIN watch_history w
ON u.user_id = w.user_id
GROUP BY u.user_id, u.username
ORDER BY total_watches DESC;