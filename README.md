# YouTube-Analytics-SQL-Project
A SQL-based database project that analyzes YouTube data, including users, channels, videos, comments, likes, subscriptions, and watch history. It demonstrates database design, relationships, and analytical queries to generate insights such as top viewed videos, most liked content, and user engagement metrics.

A relational database schema simulating a YouTube-like platform for analytics, user behavior tracking, and content performance reporting.

---

## Overview

| Property | Details |
|---|---|
| Database Type | Relational (SQL) |
| Tables | 7 |
| Sample Users | 20 |
| Sample Channels | 20 |
| Sample Videos | 5 |
| Date Range | 2023–2025 |

---

## Schema

### `users`
Stores registered platform users.

| Column | Type | Notes |
|---|---|---|
| `user_id` | INT | Primary Key |
| `username` | VARCHAR(50) | Unique display name |
| `country` | VARCHAR(50) | Country of origin |
| `join_date` | DATE | Account creation date |

---

### `channels`
Each user can own one channel.

| Column | Type | Notes |
|---|---|---|
| `channel_id` | INT | Primary Key |
| `user_id` | INT | FK → users |
| `channel_name` | VARCHAR(100) | Display name |
| `category` | VARCHAR(50) | e.g. Technology, Gaming, Music |
| `subscribers` | INT | Current subscriber count |

---

### `videos`
Videos uploaded to channels.

| Column | Type | Notes |
|---|---|---|
| `video_id` | INT | Primary Key |
| `channel_id` | INT | FK → channels |
| `title` | VARCHAR(200) | Video title |
| `upload_date` | DATE | Date published |
| `views` | INT | Total view count |
| `likes` | INT | Total like count (denormalized) |
| `duration_minutes` | INT | Video length in minutes |

---

### `comments`
User comments on videos.

| Column | Type | Notes |
|---|---|---|
| `comment_id` | INT | Primary Key |
| `video_id` | INT | FK → videos |
| `user_id` | INT | FK → users |
| `comment_text` | TEXT | Comment content |
| `comment_date` | DATE | Date posted |

---

### `likes`
Tracks which users liked which videos (normalized).

| Column | Type | Notes |
|---|---|---|
| `like_id` | INT | Primary Key |
| `video_id` | INT | FK → videos |
| `user_id` | INT | FK → users |
| `like_date` | DATE | Date of like |

---

### `subscriptions`
Tracks user subscriptions to channels.

| Column | Type | Notes |
|---|---|---|
| `subscription_id` | INT | Primary Key |
| `user_id` | INT | FK → users |
| `channel_id` | INT | FK → channels |
| `subscribe_date` | DATE | Date subscribed |

---

### `watch_history`
Logs user watch sessions with duration.

| Column | Type | Notes |
|---|---|---|
| `watch_id` | INT | Primary Key |
| `user_id` | INT | FK → users |
| `video_id` | INT | FK → videos |
| `watch_time_minutes` | INT | Minutes watched |
| `watch_date` | DATE | Date of watch |

---

## Relationships

```
users ──< channels      (one user owns one channel)
channels ──< videos     (one channel has many videos)
users ──< comments      (users comment on videos)
videos ──< comments
users ──< likes         (users like videos)
videos ──< likes
users ──< subscriptions (users subscribe to channels)
channels ──< subscriptions
users ──< watch_history
videos ──< watch_history
```

---

## Sample Data Summary

| Table | Rows |
|---|---|
| users | 20 |
| channels | 20 (one per user) |
| videos | 5 |
| comments | 15 |
| likes | 15 |
| subscriptions | 20 |
| watch_history | 20 |

**Countries represented:** USA, India, UK, Canada, Australia, Brazil, France, Germany, Italy, UAE, Japan

**Channel categories:** Technology, Education, Gaming, Travel, Music, Fitness, Editing, Entertainment, Food, Creativity, Lifestyle, Fashion, Reviews, Cooking, Streaming

---

## Sample Queries Included

### 1. Top 3 most-viewed videos
```sql
SELECT video_id, title, views
FROM videos
ORDER BY views DESC
LIMIT 3;
```

### 2. Top 3 most-liked videos (from likes table)
```sql
SELECT v.video_id, v.title, COUNT(l.like_id) AS total_likes
FROM videos v
JOIN likes l ON v.video_id = l.video_id
GROUP BY v.video_id, v.title
ORDER BY total_likes DESC
LIMIT 3;
```

### 3. Total views per channel
```sql
SELECT c.channel_id, c.channel_name, SUM(v.views) AS total_views
FROM channels c
JOIN videos v ON c.channel_id = v.channel_id
GROUP BY c.channel_id, c.channel_name
ORDER BY total_views DESC;
```

### 4. Most active watchers
```sql
SELECT u.user_id, u.username, COUNT(w.watch_id) AS total_watches
FROM users u
JOIN watch_history w ON u.user_id = w.user_id
GROUP BY u.user_id, u.username
ORDER BY total_watches DESC;
```

### 5. All likes per video (including videos with zero likes)
```sql
SELECT v.video_id, v.title, COUNT(l.like_id) AS total_likes
FROM videos v
LEFT JOIN likes l ON v.video_id = l.video_id
GROUP BY v.video_id, v.title
ORDER BY total_likes DESC;
```

---

## Use Cases

- **Engagement analysis** — track likes, comments, and watch time per video
- **Creator performance** — rank channels by total views or subscriber count
- **User behavior** — identify power users by watch history or subscription count
- **Content trends** — analyze which categories attract the most engagement
- **Retention metrics** — compare video duration vs. actual watch time

---

## Animated Dashboard — Data Highlights

An interactive animated dashboard built from the sample data, featuring:

- Stat cards with count-up animations (total users, channels, views, comments)
- Rows that fade and slide up on load
- Animated bar indicators showing relative views, subscriber reach, and watch activity
- Category badges color-coded by content type

### Videos — performance

| Title | Channel | Views | Likes | Like Rate | Duration |
|---|---|---|---|---|---|
| Top 10 games | Alex Gaming Zone | 1,200,000 | 98,000 | 8.2% | 18 min |
| Relaxing piano music | Mike Music Studio | 900,000 | 72,000 | 8.0% | 60 min |
| Learn SQL basics | Priya Coding Hub | 750,000 | 62,000 | 8.3% | 25 min |
| Trip to Japan | Sarah Travel Vlogs | 650,000 | 54,000 | 8.3% | 30 min |
| Best laptop 2025 | John Tech Reviews | 500,000 | 45,000 | 9.0% | 15 min |

### Top channels — by subscribers

| Channel | Category | Subscribers |
|---|---|---|
| Leo Gamer Pro | Gaming | 245,000 |
| Alex Gaming Zone | Gaming | 210,000 |
| Mike Music Studio | Music | 175,000 |
| Sam Music Beats | Music | 156,000 |
| Noah Streaming Arena | Streaming | 165,000 |
| Sarah Travel Vlogs | Travel | 150,000 |
| Mia Travel Diaries | Travel | 98,000 |
| Lucas Live Streams | Entertainment | 143,000 |

### Users — watch activity

| User | Country | Watch sessions |
|---|---|---|
| user_1 | USA | 4 |
| user_2 | India | 4 |
| user_3 | UK | 4 |
| user_4 | Canada | 4 |
| user_5 | Australia | 4 |

### Recent comments

| User | Comment | Date |
|---|---|---|
| mike_music | Perfect music for studying. | Apr 3 |
| sarah_vlogs | Japan looks beautiful! | Mar 17 |
| alex_gaming | Loved the piano performance. | Apr 4 |
| john_doe | Great tutorial! | Jan 11 |
| priya_tech | Loved this video | Mar 6 |

---

## Notes

- The `likes` column in the `videos` table is **denormalized** — the actual source of truth for likes is the `likes` table. Use the `likes` table for accurate counts in analytics queries.
- Sample data uses only 5 videos, so some analytical queries will return limited results. Extend the dataset for richer analysis.
- All dates fall between January 2023 and April 2025.
