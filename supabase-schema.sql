-- TH Photography Wedding Desk — Supabase schema
-- Run this script in Supabase Dashboard > SQL Editor.
create extension if not exists pgcrypto;

create table if not exists public.weddings (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  client text not null default '',
  wedding_date date,
  data jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.weddings enable row level security;

drop policy if exists "Users can read own weddings" on public.weddings;
create policy "Users can read own weddings" on public.weddings
for select to authenticated using (auth.uid() = user_id);

drop policy if exists "Users can insert own weddings" on public.weddings;
create policy "Users can insert own weddings" on public.weddings
for insert to authenticated with check (auth.uid() = user_id);

drop policy if exists "Users can update own weddings" on public.weddings;
create policy "Users can update own weddings" on public.weddings
for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);

drop policy if exists "Users can delete own weddings" on public.weddings;
create policy "Users can delete own weddings" on public.weddings
for delete to authenticated using (auth.uid() = user_id);

create or replace function public.set_updated_at()
returns trigger language plpgsql as $$
begin new.updated_at = now(); return new; end;
$$;
drop trigger if exists weddings_updated_at on public.weddings;
create trigger weddings_updated_at before update on public.weddings
for each row execute function public.set_updated_at();
