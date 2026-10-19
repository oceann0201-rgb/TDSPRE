# 🌿 Mini Shop Decor — Dự Án Mẫu Vibe Coding (Chương 1 - 8)

Dự án thương mại điện tử chuyên đồ thủ công mỹ nghệ, gốm sứ độc bản và nội thất trang trí nhà cửa mộc mạc, được xây dựng hoàn chỉnh theo giáo trình **"Vibe Coding với Antigravity" (Khóa AI-03)** của **Trung tâm Đào tạo AI Sao Việt**.

---

## 🚀 Công Nghệ Sử Dụng (Tech Stack)

- **Framework**: [Next.js 16 (App Router)](https://nextjs.org/) với trình biên dịch siêu tốc **Turbopack**.
- **Thư viện UI**: React 19, TypeScript strictly-typed, Tailwind CSS v4.
- **Cơ sở dữ liệu**: [Supabase](https://supabase.com/) (PostgreSQL đám mây) với bảo mật **Row Level Security (RLS)**.
- **Xác thực & Phân quyền**: Supabase Auth + Dual-layer Fallback (Session + Local Storage).
- **Hạ tầng triển khai**: [Vercel](https://vercel.com/) (CI/CD tự động nối với GitHub).
- **Thiết kế & Trải nghiệm**: Phong cách Japandi / Mộc mạc ấm áp, chuẩn hóa 100% không ảnh vỡ, hỗ trợ toàn diện trên thiết bị di động.

---

## 📖 Hành Trình 8 Chương Theo Giáo Trình

| Chương | Nội dung | Trạng thái |
| :--- | :--- | :---: |
| **Chương 1** | Làm quen Vibe Coding, dựng Game mini 30 giây (`game-30s/`) | ✅ Hoàn thành |
| **Chương 2** | Dựng cửa hàng Mini Shop bằng HTML/CSS/JS (11 màn hình tĩnh) | ✅ Hoàn thành |
| **Chương 3** | Chuyển dịch toàn bộ sang Next.js App Router (Turbopack) | ✅ Hoàn thành |
| **Chương 4** | Quản lý mã nguồn với Git, cài đặt Skill Antigravity chuyên sâu | ✅ Hoàn thành |
| **Chương 5** | Dựng kho dữ liệu Supabase PostgreSQL (`schema.sql`), CRUD sản phẩm | ✅ Hoàn thành |
| **Chương 6** | Vận hành thực tế: Giỏ hàng, Đặt hàng, Auth & Phân quyền Admin | ✅ Hoàn thành |
| **Chương 7** | Khám tổng quát (10 bước Người mua, 6 bước Người bán, Thử người lạ) | ✅ Đạt 4 chữ "RỒI" |
| **Chương 8** | Bật khóa an toàn RLS, sẵn sàng phát hành toàn cầu lên Vercel | ✅ Sẵn sàng 100% |

---

## 🛠️ Hướng Dẫn Cài Đặt & Chạy Cục Bộ (Local)

### 1. Cài đặt thư viện
```bash
cd mini-shop-next
npm install
```

### 2. Cấu hình biến môi trường
Sao chép `.env.example` thành `.env.local`:
```bash
cp .env.example .env.local
```
Điền URL và Anon Key lấy từ Supabase Dashboard (`Project Settings` -> `API`):
```env
NEXT_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key-here
```
*(Nếu chưa có tài khoản Supabase, ứng dụng tự động kích hoạt chế độ Dual-Layer Fallback lưu trữ cục bộ mượt mà 100% không lo gián đoạn).*

### 3. Dựng Database Supabase
1. Đăng nhập Supabase Dashboard -> Tạo New Project.
2. Mở mục **SQL Editor**.
3. Mở file `schema.sql`, sao chép toàn bộ nội dung, dán vào và nhấn **Run**.
4. Toàn bộ bảng (`categories`, `products`, `orders`, `order_items`, `profiles`) và chính sách bảo mật **RLS** sẽ được thiết lập tự động.

### 4. Khởi chạy máy chủ phát triển
```bash
npm run dev
```
Mở trình duyệt truy cập: [http://localhost:3000](http://localhost:3000)

---

## 🔐 Tài Khoản Kiểm Thử Nghiệm Thu

| Vai trò | Email / Username | Mật khẩu | Quyền hạn |
| :--- | :--- | :--- | :--- |
| **Quản trị viên (Admin)** | `admin@minishop.com` hoặc `admin` | `admin` | Toàn quyền quản lý kho, thêm/sửa/xóa sản phẩm, duyệt đơn hàng |
| **Khách mua hàng (Customer)** | Đăng ký trực tiếp tại `/login` | Tùy chọn (>= 6 ký tự) | Mua hàng, thả tim, giỏ hàng, xem đơn hàng cá nhân |
| **Người lạ (Stranger)** | Chưa đăng nhập | Không có | Bị chặn truy cập trang `/admin` ngay lập tức |

---

## 🌐 Triển Khai Lên Mạng Qua Vercel (Chương 8)

1. **Đẩy mã nguồn lên GitHub**:
   ```bash
   git add .
   git commit -m "feat: Chuan bi phat hanh Vercel"
   git remote add origin https://github.com/<tai-khoan>/mini-shop.git
   git push -u origin main
   ```
2. **Import vào Vercel**:
   - Truy cập [vercel.com](https://vercel.com) -> Đăng nhập bằng tài khoản GitHub.
   - Chọn **Add New...** -> **Project** -> Chọn kho lưu trữ `mini-shop`.
   - Nếu kho có thư mục con, chọn **Root Directory** là `mini-shop-next`.
3. **Cài đặt Biến Môi Trường (Environment Variables)**:
   - Thêm `NEXT_PUBLIC_SUPABASE_URL`
   - Thêm `NEXT_PUBLIC_SUPABASE_ANON_KEY`
4. **Bấm Deploy**:
   - Vercel sẽ tự động build và cấp phát đường dẫn tên miền công khai dạng `https://mini-shop-xxx.vercel.app`.

---

## 🎯 4 Thói Quen Vàng Của Vibe Coding

1. **Yêu cầu 4 phần rõ ràng**: Nêu rõ Việc - Nguồn - Kết quả - Lưu ý.
2. **Lên kế hoạch trước khi làm lớn**: Tạo file kế hoạch, chốt giải pháp mới bắt tay vào code.
3. **Git là trí nhớ của dự án**: Làm xong tính năng nào lưu mốc ngay tính năng đó, không gộp bừa bãi.
4. **Tự tay nghiệm thu trước khi chốt**: Đóng vai người mua, người bán, người lạ trước khi bàn giao cho người khác.
