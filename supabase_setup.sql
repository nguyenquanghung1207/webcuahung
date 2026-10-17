-- ==========================================================
-- SCRIPT TAO BANG BAI VIET (posts) TREN SUPABASE
-- Chay trong Supabase -> SQL Editor -> New query -> Run
-- ==========================================================

-- 1. Tao bang posts (neu chua co)
create table if not exists public.posts (
  id uuid default gen_random_uuid() primary key,
  title text not null,
  content text not null,
  image_url text,
  category text not null default 'Tin tức',
  is_featured boolean default false,
  created_at timestamptz default now()
);

-- 2. Bat Row Level Security
alter table public.posts enable row level security;

-- 3. Policies (phu hop demo ca nhan dung anon key tu frontend)
drop policy if exists "Public can view posts" on public.posts;
create policy "Public can view posts"
  on public.posts for select
  using (true);

drop policy if exists "Anyone can insert posts" on public.posts;
create policy "Anyone can insert posts"
  on public.posts for insert
  with check (true);

drop policy if exists "Anyone can update posts" on public.posts;
create policy "Anyone can update posts"
  on public.posts for update
  using (true);

drop policy if exists "Anyone can delete posts" on public.posts;
create policy "Anyone can delete posts"
  on public.posts for delete
  using (true);

-- 4. Index de sap xep va loc nhanh
create index if not exists posts_created_at_idx on public.posts (created_at desc);
create index if not exists posts_category_idx on public.posts (category);

-- ==========================================================
-- STORAGE: Tao bucket 'images' (lam thu cong trong Dashboard)
-- Supabase -> Storage -> New bucket
--   Name: images
--   Public bucket: ON
-- (Neu da tao roi thi bo qua)
-- ==========================================================