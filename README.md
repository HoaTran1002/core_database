# Core Database

Tài liệu hướng dẫn chạy **PostgreSQL bằng Docker Compose** và sử dụng **VS Code Extension** để truy vấn SQL.

---

# 1. Yêu cầu môi trường

Cài đặt các công cụ sau:

- Docker
- Docker Compose
- Visual Studio Code

Kiểm tra Docker:

```bash
docker --version
docker compose version
```

---

# 2. Cấu trúc thư mục

```
core_database/
│
├─ docker-compose.yml
├─ sql/
│   └─ init.sql
└─ README.md
```

---

# 3. Docker Compose

File `docker-compose.yml`

```yaml
version: "3.9"

services:
  postgres:
    image: postgres:16
    container_name: postgres_db
    restart: unless-stopped
    environment:
      POSTGRES_USER: admin
      POSTGRES_PASSWORD: admin123
      POSTGRES_DB: app_db
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
      - ./sql:/docker-entrypoint-initdb.d

  adminer:
    image: adminer:latest
    container_name: postgres_adminer
    restart: unless-stopped
    ports:
      - "8080:8080"
    depends_on:
      - postgres

volumes:
  postgres_data:
```

---

# 4. Khởi tạo bảng

Tạo file `sql/init.sql`

```sql
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(150) UNIQUE
);

INSERT INTO users (name, email)
VALUES ('Hoa', 'hoa@example.com')
ON CONFLICT (email) DO NOTHING;
```

---

# 5. Chạy database

Chạy container:

```bash
docker compose up -d
```

Kiểm tra container:

```bash
docker ps
```

---

# 6. Truy cập database

### PostgreSQL

```
Host: localhost
Port: 5432
Database: app_db
User: admin
Password: admin123
```

### Adminer

Mở trình duyệt:

```
http://localhost:8080
```

Login:

```
System: PostgreSQL
Server: postgres
Username: admin
Password: admin123
Database: app_db
```

---

# 7. VS Code Extension

Cài các extension sau:

- SQLTools
- SQLTools PostgreSQL Driver

Sau khi cài:

1. Mở Command Palette
2. Chọn `SQLTools: Add New Connection`
3. Chọn `PostgreSQL`

Thông tin kết nối:

```
Host: localhost
Port: 5432
Database: app_db
User: admin
Password: admin123
```

---

# 8. Chạy query SQL trong VSCode

Tạo file `query.sql`

```sql
SELECT * FROM users;
```

Highlight câu SQL và chạy **Run Query**.

---

# 9. Dừng container

```bash
docker compose down
```

Xóa cả volume database:

```bash
docker compose down -v
```
