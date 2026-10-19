-- ============================================================================
-- DỰ ÁN MINI SHOP DECOR - DỰNG KHO DỮ LIỆU CHUẨN SUPABASE (POSTGRESQL)
-- Hướng dẫn: Mở Supabase Dashboard -> chọn project -> SQL Editor -> dán & bấm RUN
-- ============================================================================

-- 1. TẠO BẢNG DANH MỤC SẢN PHẨM (categories)
CREATE TABLE IF NOT EXISTS public.categories (
    id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. TẠO BẢNG SẢN PHẨM (products)
CREATE TABLE IF NOT EXISTS public.products (
    id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    category_id VARCHAR(50) REFERENCES public.categories(id) ON DELETE SET NULL,
    price NUMERIC(12, 2) NOT NULL,
    price_formatted VARCHAR(50) NOT NULL,
    badge VARCHAR(50),
    image_url TEXT NOT NULL,
    description TEXT,
    specs JSONB DEFAULT '{}'::jsonb,
    in_stock BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. TẠO BẢNG ĐƠN HÀNG (orders)
CREATE TABLE IF NOT EXISTS public.orders (
    id VARCHAR(50) PRIMARY KEY,
    customer_name VARCHAR(255) NOT NULL,
    customer_phone VARCHAR(50) NOT NULL,
    customer_address TEXT NOT NULL,
    payment_method VARCHAR(50) DEFAULT 'cod',
    total_amount NUMERIC(12, 2) NOT NULL,
    status VARCHAR(50) DEFAULT 'Mới',
    note TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 4. TẠO BẢNG CHI TIẾT ĐƠN HÀNG (order_items)
CREATE TABLE IF NOT EXISTS public.order_items (
    id BIGSERIAL PRIMARY KEY,
    order_id VARCHAR(50) REFERENCES public.orders(id) ON DELETE CASCADE,
    product_id VARCHAR(50) REFERENCES public.products(id) ON DELETE SET NULL,
    product_name VARCHAR(255) NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    price NUMERIC(12, 2) NOT NULL,
    subtotal NUMERIC(12, 2) NOT NULL
);

-- 5. TẠO BẢNG NGƯỜI DÙNG & TÀI KHOẢN (profiles)
CREATE TABLE IF NOT EXISTS public.profiles (
    id VARCHAR(100) PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    fullname VARCHAR(255) NOT NULL,
    phone VARCHAR(50),
    role VARCHAR(20) DEFAULT 'user',
    status VARCHAR(20) DEFAULT 'active',
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 6. NẠP DỮ LIỆU DANH MỤC MẪU
INSERT INTO public.categories (id, name, slug, description) VALUES
('do-thu-cong', 'Đồ thủ công', 'do-thu-cong', 'Mây tre đan, khay gỗ chạm khắc, tranh macrame thủ công'),
('do-my-nghe', 'Đồ mỹ nghệ', 'do-my-nghe', 'Gốm sứ Bát Tràng hỏa biến, đèn lồng nan tre nghệ thuật'),
('noi-that-gia-dung', 'Nội thất gia dụng', 'noi-that-gia-dung', 'Bàn ăn gỗ, sofa Bắc Âu, kệ trang trí hiện đại')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, slug = EXCLUDED.slug;

-- 7. NẠP DỮ LIỆU SẢN PHẨM MẪU
INSERT INTO public.products (id, name, category_id, price, price_formatted, badge, image_url, description, specs) VALUES
('gio-may-dan', 'Giỏ Mây Đan Thủ Công', 'do-thu-cong', 290000, '290.000đ', 'Bán chạy', '/assets/images/products/do-thu-cong/gio-may-dan.webp', 'Giỏ mây đan tỉ mỉ từ mây tre tự nhiên đã qua xử lý mối mọt.', '{"brand": "Mini Shop", "material": "Mây tre tự nhiên"}'),
('tranh-treo-macrame', 'Tranh Treo Macrame BoHo', 'do-thu-cong', 350000, '350.000đ', 'Mới', '/assets/images/products/do-thu-cong/tranh-treo-macrame.webp', 'Tranh thừng đan nghệ thuật Bohemian phong cách mộc mạc.', '{"brand": "Mini Shop", "material": "Sợi cotton tự nhiên"}'),
('khay-go-hoa-van', 'Khay Gỗ Hoa Văn Chạm Khắc', 'do-thu-cong', 220000, '220.000đ', 'Yêu thích', '/assets/images/products/do-thu-cong/khay-go-hoa-van.webp', 'Khay gỗ chạm khắc hoa văn tinh xảo, sơn phủ mộc an toàn.', '{"brand": "Mini Shop", "material": "Gỗ sồi nguyên khối"}'),
('khay-go-trang-tri', 'Khay Gỗ Trang Trí Tối Giản', 'do-thu-cong', 180000, '180.000đ', '', '/assets/images/products/do-thu-cong/khay-go-trang-tri.webp', 'Thiết kế vuông vắn, đường vân gỗ tự nhiên rõ nét.', '{"brand": "Mini Shop", "material": "Gỗ tần bì"}'),
('den-tre-thu-cong', 'Đèn Tre Thủ Công Kiểu Nón', 'do-my-nghe', 390000, '390.000đ', 'Nổi bật', '/assets/images/products/do-my-nghe/den-tre-thu-cong.webp', 'Chao đèn tre hun khói thả trần tạo ánh sáng ấm áp.', '{"brand": "Mini Shop", "material": "Tre hun khói"}'),
('den-long-tre', 'Đèn Lồng Tre Thả Trần', 'do-my-nghe', 260000, '260.000đ', '', '/assets/images/products/do-my-nghe/den-long-tre.webp', 'Đèn lồng nan tre thanh mảnh, tôn vinh nét đẹp truyền thống.', '{"brand": "Mini Shop", "material": "Nan tre uốn nhiệt"}'),
('binh-gom-trang-tri', 'Bình Gốm Trang Trí Nghệ Thuật', 'do-my-nghe', 320000, '320.000đ', 'Mới', '/assets/images/products/do-my-nghe/binh-gom-trang-tri.webp', 'Bình gốm nung củi men hỏa biến độc bản Bát Tràng.', '{"brand": "Gốm Bát Tràng", "material": "Đất sét nung"}'),
('bo-binh-gom-minimal', 'Bộ Bình Gốm Minimalist', 'do-my-nghe', 480000, '480.000đ', 'Bán chạy', '/assets/images/products/do-my-nghe/bo-binh-gom-minimal.webp', 'Set 2 bình gốm trắng ngà phong cách Japandi và Bắc Âu.', '{"brand": "Gốm Bát Tràng", "material": "Gốm men mờ"}'),
('chau-cay-de-ban', 'Chậu Cây Để Bàn Men Mờ', 'noi-that-gia-dung', 150000, '150.000đ', '', '/assets/images/products/noi-that-gia-dung/chau-cay-de-ban.webp', 'Chậu gốm mini có đĩa lót gỗ, trồng cây để bàn làm việc.', '{"brand": "Mini Shop", "material": "Gốm sứ & đĩa gỗ"}'),
('ke-go-trang-tri', 'Kệ Gỗ Trang Trí Đa Năng', 'noi-that-gia-dung', 750000, '750.000đ', 'Mới', '/assets/images/products/noi-that-gia-dung/ke-go-trang-tri.webp', 'Kệ treo tường khung sắt đợt gỗ tối ưu không gian sống.', '{"brand": "Mini Shop", "material": "Gỗ thông & Khung sắt"}'),
('bo-ban-an-go', 'Bộ Bàn Ăn Gỗ Tự Nhiên', 'noi-that-gia-dung', 4500000, '4.500.000đ', 'Cao cấp', '/assets/images/products/noi-that-gia-dung/bo-ban-an-go.webp', 'Bộ bàn ăn 4 ghế gỗ sồi tự nhiên bo góc an toàn.', '{"brand": "Mini Shop", "material": "Gỗ sồi Nga 100%"}'),
('sofa-phong-khach', 'Sofa Phòng Khách Phong Cách Bắc Âu', 'noi-that-gia-dung', 6800000, '6.800.000đ', 'Sang trọng', '/assets/images/products/noi-that-gia-dung/sofa-phong-khach.webp', 'Sofa văng bọc vải nỉ cao cấp nệm D40 chống xẹp lún.', '{"brand": "Mini Shop", "material": "Vải nỉ & Nệm D40"}')
ON CONFLICT (id) DO NOTHING;

-- 8. TÀI KHOẢN ADMIN MẪU
INSERT INTO public.profiles (id, email, fullname, phone, role, status) VALUES
('admin-master', 'admin@minishop.com', 'Chủ Cửa Hàng Mini Shop', '0931144858', 'admin', 'active')
ON CONFLICT (id) DO UPDATE SET email = EXCLUDED.email, role = EXCLUDED.role;

-- ============================================================================
-- 9. CHÍNH SÁCH BẢO MẬT RLS (ROW LEVEL SECURITY) - BẬT TRƯỚC KHI LÊN MẠNG (BÀI 8)
-- ============================================================================
ALTER TABLE public.categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.products ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.order_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

-- Luật cho categories & products: Ai cũng được xem (SELECT)
CREATE POLICY "Public categories read" ON public.categories FOR SELECT USING (true);
CREATE POLICY "Public products read" ON public.products FOR SELECT USING (true);

-- Luật cho orders: Bất kỳ ai cũng có thể tạo đơn hàng mới (INSERT)
CREATE POLICY "Public create orders" ON public.orders FOR INSERT WITH CHECK (true);
CREATE POLICY "Public create order items" ON public.order_items FOR INSERT WITH CHECK (true);

-- Luật cho admin: Được toàn quyền xem, sửa, xóa
CREATE POLICY "Admin full access products" ON public.products FOR ALL USING (true);
CREATE POLICY "Admin full access orders" ON public.orders FOR ALL USING (true);
CREATE POLICY "Admin full access order_items" ON public.order_items FOR ALL USING (true);
CREATE POLICY "Admin full access profiles" ON public.profiles FOR ALL USING (true);
