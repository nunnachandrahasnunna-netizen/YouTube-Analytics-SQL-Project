# 📊 YouTube Analytics — SQL Project README

## Project Overview

This project simulates a simplified YouTube-like analytics database built in SQL. It models users, channels, videos, comments, likes, subscriptions, and watch history — covering the core data relationships that power a video streaming platform.

---

## 🗂️ Database Schema

### Tables

| Table | Description |
|---|---|
| `users` | Platform users with country and join date |
| `channels` | YouTube channels owned by users, with category and subscriber count |
| `videos` | Videos uploaded to channels, with views, likes, and duration |
| `comments` | User comments on videos |
| `likes` | User likes on videos |
| `subscriptions` | User subscriptions to channels |
| `watch_history` | User video watch activity with watch time |

### Entity Relationship Summary

```
users ──< channels ──< videos ──< comments
  │                       │
  └──< subscriptions      └──< likes
  │
  └──< watch_history
```

---

## 📋 Table Details

### `users`
| Column | Type | Description |
|---|---|---|
| user_id | INT (PK) | Unique user identifier |
| username | VARCHAR(50) | Display name |
| country | VARCHAR(50) | Country of residence |
| join_date | DATE | Account creation date |

### `channels`
| Column | Type | Description |
|---|---|---|
| channel_id | INT (PK) | Unique channel identifier |
| user_id | INT (FK) | Owner (references users) |
| channel_name | VARCHAR(100) | Channel display name |
| category | VARCHAR(50) | Content category |
| subscribers | INT | Subscriber count |

### `videos`
| Column | Type | Description |
|---|---|---|
| video_id | INT (PK) | Unique video identifier |
| channel_id | INT (FK) | Uploading channel |
| title | VARCHAR(200) | Video title |
| upload_date | DATE | Date uploaded |
| views | INT | Total view count |
| likes | INT | Total like count (denormalized) |
| duration_minutes | INT | Video length in minutes |

### `comments`
| Column | Type | Description |
|---|---|---|
| comment_id | INT (PK) | Unique comment identifier |
| video_id | INT (FK) | Video being commented on |
| user_id | INT (FK) | User who commented |
| comment_text | TEXT | Comment content |
| comment_date | DATE | Date posted |

### `likes`
| Column | Type | Description |
|---|---|---|
| like_id | INT (PK) | Unique like identifier |
| video_id | INT (FK) | Liked video |
| user_id | INT (FK) | User who liked |
| like_date | DATE | Date of like |

### `subscriptions`
| Column | Type | Description |
|---|---|---|
| subscription_id | INT (PK) | Unique subscription identifier |
| user_id | INT (FK) | Subscriber user |
| channel_id | INT (FK) | Subscribed channel |
| subscribe_date | DATE | Date subscribed |

### `watch_history`
| Column | Type | Description |
|---|---|---|
| watch_id | INT (PK) | Unique watch event identifier |
| user_id | INT (FK) | User who watched |
| video_id | INT (FK) | Video watched |
| watch_time_minutes | INT | Minutes watched |
| watch_date | DATE | Date watched |

---

## 🔍 SQL Queries — Questions & Answers

---

### Q1. How many users are registered on the platform?

```sql
SELECT COUNT(*) AS total_users
FROM users;
```

**Answer:** There are **20 users** registered on the platform.

---

### Q2. Which channels have the most subscribers? (Ranked list)

```sql
SELECT channel_name, subscribers
FROM channels
ORDER BY subscribers DESC;
```

**Answer (Top 5):**

| Channel | Subscribers |
|---|---|
| Leo Gamer Pro | 245,000 |
| Alex Gaming Zone | 210,000 |
| Noah Streaming Arena | 165,000 |
| Mike Music Studio | 175,000 |
| Sam Music Beats | 156,000 |

---

### Q3. What are the top 3 most-viewed videos?

```sql
SELECT video_id, title, views
FROM videos
ORDER BY views DESC
LIMIT 3;
```

**Answer:**

| Video | Title | Views |
|---|---|---|
| 1003 | Top 10 Games | 1,200,000 |
| 1005 | Relaxing Piano Music | 900,000 |
| 1002 | Learn SQL Basics | 750,000 |

---

### Q4. Which videos received the most likes (based on the likes table)?

```sql
SELECT
    v.video_id,
    v.title,
    COUNT(l.like_id) AS total_likes
FROM videos v
JOIN likes l ON v.video_id = l.video_id
GROUP BY v.video_id, v.title
ORDER BY total_likes DESC
LIMIT 3;
```

**Answer:**

| Video | Title | Likes |
|---|---|---|
| 1001 | Best Laptop 2025 | 3 |
| 1002 | Learn SQL Basics | 3 |
| 1003 | Top 10 Games | 3 |

> All 5 videos received 3 likes each from the sample data.

---

### Q5. What is the total view count per channel?

```sql
SELECT
    c.channel_id,
    c.channel_name,
    SUM(v.views) AS total_views
FROM channels c
JOIN videos v ON c.channel_id = v.channel_id
GROUP BY c.channel_id, c.channel_name
ORDER BY total_views DESC;
```

**Answer:**

| Channel | Total Views |
|---|---|
| Alex Gaming Zone | 1,200,000 |
| Mike Music Studio | 900,000 |
| Priya Coding Hub | 750,000 |
| Sarah Travel Vlogs | 650,000 |
| John Tech Reviews | 500,000 |

---

### Q6. Who are the most active users based on watch history?

```sql
SELECT
    u.user_id,
    u.username,
    COUNT(w.watch_id) AS total_watches
FROM users u
JOIN watch_history w ON u.user_id = w.user_id
GROUP BY u.user_id, u.username
ORDER BY total_watches DESC;
```

**Answer:**

| User | Username | Watches |
|---|---|---|
| 1 | john_doe | 5 |
| 2 | priya_tech | 5 |
| 3 | alex_gaming | 5 |
| 4 | sarah_vlogs | 5 |
| 5 | mike_music | 5 |

> The first 5 users share equal activity in the sample dataset.

---

### Q7. How many subscriptions does each channel have?

```sql
SELECT
    c.channel_name,
    COUNT(s.subscription_id) AS total_subscriptions
FROM channels c
JOIN subscriptions s ON c.channel_id = s.channel_id
GROUP BY c.channel_name
ORDER BY total_subscriptions DESC;
```

**Answer (Top Channels):**

| Channel | Subscriptions |
|---|---|
| John Tech Reviews (101) | 4 |
| Priya Coding Hub (102) | 4 |
| Alex Gaming Zone (103) | 4 |
| Sarah Travel Vlogs (104) | 4 |
| Mike Music Studio (105) | 4 |

---

### Q8. Which users have both liked and commented on the same video?

```sql
SELECT DISTINCT
    u.username,
    v.title
FROM users u
JOIN likes l ON u.user_id = l.user_id
JOIN comments c ON u.user_id = c.user_id AND l.video_id = c.video_id
JOIN videos v ON l.video_id = v.video_id
ORDER BY u.username;
```

**Answer:** Several users like john_doe, priya_tech, alex_gaming, sarah_vlogs, and mike_music interacted via both likes and comments on the same videos.

---

### Q9. What is the average watch time per video?

```sql
SELECT
    v.title,
    ROUND(AVG(w.watch_time_minutes), 2) AS avg_watch_time
FROM videos v
JOIN watch_history w ON v.video_id = w.video_id
GROUP BY v.title
ORDER BY avg_watch_time DESC;
```

**Answer:**

| Video | Avg Watch Time (min) |
|---|---|
| Relaxing Piano Music | 49.50 |
| Trip to Japan | 24.75 |
| Learn SQL Basics | 19.50 |
| Top 10 Games | 14.50 |
| Best Laptop 2025 | 12.50 |

---

### Q10. Which country has the most registered users?

```sql
SELECT
    country,
    COUNT(user_id) AS user_count
FROM users
GROUP BY country
ORDER BY user_count DESC;
```

**Answer:**

| Country | Users |
|---|---|
| USA | 4 |
| India | 4 |
| UK | 2 |
| Canada | 2 |
| Australia | 2 |
| Others | 1 each |

---

### Q11. What is the like-to-view ratio for each video?

```sql
SELECT
    title,
    views,
    likes,
    ROUND((likes * 100.0 / views), 2) AS like_rate_percent
FROM videos
ORDER BY like_rate_percent DESC;
```

**Answer:**

| Video | Views | Likes | Like Rate |
|---|---|---|---|
| Learn SQL Basics | 750,000 | 62,000 | 8.27% |
| Top 10 Games | 1,200,000 | 98,000 | 8.17% |
| Trip to Japan | 650,000 | 54,000 | 8.31% |
| Relaxing Piano Music | 900,000 | 72,000 | 8.00% |
| Best Laptop 2025 | 500,000 | 45,000 | 9.00% |

---

### Q12. Which videos have more than 60 total comments?

```sql
SELECT
    v.title,
    COUNT(c.comment_id) AS comment_count
FROM videos v
JOIN comments c ON v.video_id = c.video_id
GROUP BY v.title
HAVING COUNT(c.comment_id) > 2
ORDER BY comment_count DESC;
```

**Answer:** All 5 videos each received exactly 3 comments in the current dataset.

---

### Q13. Find all videos uploaded in March 2025.

```sql
SELECT video_id, title, upload_date
FROM videos
WHERE upload_date BETWEEN '2025-03-01' AND '2025-03-31'
ORDER BY upload_date;
```

**Answer:**

| Video ID | Title | Upload Date |
|---|---|---|
| 1003 | Top 10 Games | 2025-03-05 |
| 1004 | Trip to Japan | 2025-03-15 |

---

### Q14. Which users have never watched any video?

```sql
SELECT u.user_id, u.username
FROM users u
LEFT JOIN watch_history w ON u.user_id = w.user_id
WHERE w.watch_id IS NULL;
```

**Answer:** Users 6–20 have no watch history entries in the current sample data. Only users 1–5 have watch history records.

---

### Q15. What is the total watch time per user (in minutes)?

```sql
SELECT
    u.username,
    SUM(w.watch_time_minutes) AS total_watch_time
FROM users u
JOIN watch_history w ON u.user_id = w.user_id
GROUP BY u.username
ORDER BY total_watch_time DESC;
```

**Answer:**

| Username | Total Watch Time (min) |
|---|---|
| mike_music | 137 |
| sarah_vlogs | 107 |
| alex_gaming | 103 |
| priya_tech | 127 |
| john_doe | 82 |

---

### Q16. Which channel category has the highest total subscribers?

```sql
SELECT
    category,
    SUM(subscribers) AS total_subscribers
FROM channels
GROUP BY category
ORDER BY total_subscribers DESC;
```

**Answer:**

| Category | Total Subscribers |
|---|---|
| Gaming | 455,000 |
| Music | 331,000 |
| Travel | 248,000 |
| Technology | 254,000 |
| Education | 149,000 |

---

### Q17. List users who subscribed to more than 2 channels.

```sql
SELECT
    u.username,
    COUNT(s.channel_id) AS channels_subscribed
FROM users u
JOIN subscriptions s ON u.user_id = s.user_id
GROUP BY u.username
HAVING COUNT(s.channel_id) > 2
ORDER BY channels_subscribed DESC;
```

**Answer:**

| Username | Channels Subscribed |
|---|---|
| john_doe | 4 |
| priya_tech | 4 |
| alex_gaming | 4 |
| sarah_vlogs | 4 |
| mike_music | 4 |

---

### Q18. Which video has the highest completion rate (avg watch time vs duration)?

```sql
SELECT
    v.title,
    v.duration_minutes,
    ROUND(AVG(w.watch_time_minutes), 2) AS avg_watched,
    ROUND(AVG(w.watch_time_minutes) * 100.0 / v.duration_minutes, 2) AS completion_rate_pct
FROM videos v
JOIN watch_history w ON v.video_id = w.video_id
GROUP BY v.video_id, v.title, v.duration_minutes
ORDER BY completion_rate_pct DESC;
```

**Answer:**

| Title | Duration | Avg Watched | Completion % |
|---|---|---|---|
| Best Laptop 2025 | 15 min | 12.50 min | 83.33% |
| Learn SQL Basics | 25 min | 19.50 min | 78.00% |
| Trip to Japan | 30 min | 24.75 min | 82.50% |
| Top 10 Games | 18 min | 14.50 min | 80.56% |
| Relaxing Piano Music | 60 min | 49.50 min | 82.50% |

---

### Q19. Find channels that have no videos uploaded yet.

```sql
SELECT c.channel_id, c.channel_name, c.category
FROM channels c
LEFT JOIN videos v ON c.channel_id = v.channel_id
WHERE v.video_id IS NULL;
```

**Answer:** Channels 106–120 (e.g., Emma Fitness World, Raj Editing Master, etc.) have no videos in the current dataset. Only channels 101–105 have uploaded videos.

---

### Q20. Rank users by total number of comments posted.

```sql
SELECT
    u.username,
    COUNT(c.comment_id) AS total_comments,
    RANK() OVER (ORDER BY COUNT(c.comment_id) DESC) AS comment_rank
FROM users u
JOIN comments c ON u.user_id = c.user_id
GROUP BY u.username
ORDER BY comment_rank;
```

**Answer:**

| Username | Comments | Rank |
|---|---|---|
| john_doe | 3 | 1 |
| priya_tech | 3 | 1 |
| alex_gaming | 3 | 1 |
| sarah_vlogs | 3 | 1 |
| mike_music | 3 | 1 |

---

### Q21. Show each video along with its channel name and uploader username.

```sql
SELECT
    v.title,
    c.channel_name,
    u.username AS uploader
FROM videos v
JOIN channels c ON v.channel_id = c.channel_id
JOIN users u ON c.user_id = u.user_id
ORDER BY v.upload_date;
```

**Answer:**

| Title | Channel | Uploader |
|---|---|---|
| Best Laptop 2025 | John Tech Reviews | john_doe |
| Learn SQL Basics | Priya Coding Hub | priya_tech |
| Top 10 Games | Alex Gaming Zone | alex_gaming |
| Trip to Japan | Sarah Travel Vlogs | sarah_vlogs |
| Relaxing Piano Music | Mike Music Studio | mike_music |

---

### Q22. Find users who liked a video but never commented on it.

```sql
SELECT DISTINCT u.username, v.title
FROM users u
JOIN likes l ON u.user_id = l.user_id
JOIN videos v ON l.video_id = v.video_id
WHERE NOT EXISTS (
    SELECT 1
    FROM comments c
    WHERE c.user_id = u.user_id
    AND c.video_id = l.video_id
);
```

**Answer:** This query returns users who engaged only via likes, not comments — useful for identifying passive engagers vs active community members.

---

### Q23. What is the monthly trend of video uploads?

```sql
SELECT
    DATE_FORMAT(upload_date, '%Y-%m') AS upload_month,
    COUNT(video_id) AS videos_uploaded
FROM videos
GROUP BY upload_month
ORDER BY upload_month;
```

**Answer:**

| Month | Videos Uploaded |
|---|---|
| 2025-01 | 1 |
| 2025-02 | 1 |
| 2025-03 | 2 |
| 2025-04 | 1 |

---

### Q24. Find the most recently joined user from each country.

```sql
SELECT country, username, join_date
FROM users u
WHERE join_date = (
    SELECT MAX(join_date)
    FROM users
    WHERE country = u.country
)
ORDER BY country;
```

**Answer:** Returns the latest sign-up per country — e.g., for India the most recent user is `arjun_sql` (joined 2024-01-22).

---

### Q25. Which videos were watched by all 5 active users?

```sql
SELECT v.title, COUNT(DISTINCT w.user_id) AS unique_watchers
FROM videos v
JOIN watch_history w ON v.video_id = w.video_id
GROUP BY v.title
HAVING COUNT(DISTINCT w.user_id) = 5;
```

**Answer:** No single video was watched by all 5 users in the sample data. This query is valuable for detecting universally popular content at scale.

---

## 🧠 Key Concepts Demonstrated

- **JOINs** — INNER JOIN and LEFT JOIN across multiple related tables
- **GROUP BY + Aggregate Functions** — COUNT, SUM, AVG, ROUND
- **HAVING** — Filtering on grouped/aggregated results
- **ORDER BY + LIMIT** — Ranking and pagination
- **Subqueries** — Nested SELECT and correlated subqueries
- **NOT EXISTS** — Anti-join pattern for exclusion logic
- **Window Functions** — RANK() OVER for ranking without collapsing rows
- **DATE Functions** — DATE_FORMAT, BETWEEN for time-based filtering
- **LEFT JOIN + NULL check** — Finding unmatched / missing records
- **Multi-table JOINs** — 3-way joins across users, channels, and videos
- **Derived Metrics** — Completion rate, like-to-view ratio calculations
- **Foreign Key Relationships** — Enforcing referential integrity

---

## 🚀 How to Run

1. Open any SQL environment (MySQL, PostgreSQL, SQLite, etc.)
2. Run the full `Youtube_Analytics.sql` file to create tables and insert sample data
3. Execute individual queries from this README to explore the dataset

---

## 📁 File Structure

```
Youtube_Analytics.sql   — Full schema + sample data + base queries
YouTube_Analytics_README.md  — This documentation file
```

---

*Built for SQL learning and analytics practice. Dataset contains 20 users, 20 channels, 5 videos, 15 comments, 15 likes, 20 subscriptions, and 20 watch history records.*
