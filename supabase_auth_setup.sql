-- ==========================================================
-- SCRIPT BAO MAT: CHI NGUOI DUNG DA DANG NHAP MOI DUOC QUAN TRI
-- Chay trong Supabase -> SQL Editor (sau khi da chay supabase_setup.sql)
-- ==========================================================

-- 1. Cap nhat policy cho bang posts: chi authenticated moi duoc ghi/xoa
drop policy if exists "Anyone can insert posts" on public.posts;
drop policy if exists "Anyone can update posts" on public.posts;
drop policy if exists "Anyone can delete posts" on public.posts;

create policy "Authenticated can insert posts"
  on public.posts for insert
  to authenticated
  with check (true);

create policy "Authenticated can update posts"
  on public.posts for update
  to authenticated
  using (true);

create policy "Authenticated can delete posts"
  on public.posts for delete
  to authenticated
  using (true);

-- Policy doc van public (giu nguyen)
-- "Public can view posts" da ton tai.

-- 2. Policy cho Storage bucket 'images': chi authenticated moi duoc upload/xoa
-- (Doc public van mo cho tat ca)
drop policy if exists "Public can view images" on storage.objects;
create policy "Public can view images"
  on storage.objects for select
  using (bucket_id = 'images');

drop policy if exists "Authenticated can upload images" on storage.objects;
create policy "Authenticated can upload images"
  on storage.objects for insert
  to authenticated
  with check (bucket_id = 'images');

drop policy if exists "Authenticated can update images" on storage.objects;
create policy "Authenticated can update images"
  on storage.objects for update
  to authenticated
  using (bucket_id = 'images');

drop policy if exists "Authenticated can delete images" on storage.objects;
create policy "Authenticated can delete images"
  on storage.objects for delete
  to authenticated
  using (bucket_id = 'images');

-- ==========================================================
-- TAO TAI KHOAN QUAN TRI (lam thu cong trong Dashboard)
-- Supabase -> Authentication -> Users -> Add user
--   Email: (email ban muon dung)
--   Password: (mat khau manh)
--   Auto Confirm User: ON (de khong can xac nhan email)
-- Sau do dung email/mat khau nay de dang nhap tai /admin
-- ==========================================================