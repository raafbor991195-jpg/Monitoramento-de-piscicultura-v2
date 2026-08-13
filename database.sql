create extension if not exists "pgcrypto";

create table if not exists public.tanks(
 id uuid primary key default gen_random_uuid(), name text not null, volume numeric, density numeric,
 animals integer, weight numeric, fcr numeric, feed numeric, feedings integer, temp numeric, ph numeric,
 ammonia numeric, nitrite numeric, oxygen numeric, updated_at timestamptz not null default now(),
 updated_by uuid references auth.users(id) on delete set null, created_at timestamptz not null default now()
);

create table if not exists public.tank_history(
 id uuid primary key default gen_random_uuid(), tank_id uuid not null references public.tanks(id) on delete cascade,
 user_id uuid references auth.users(id) on delete set null, field text not null, old_value text, new_value text,
 created_at timestamptz not null default now()
);

alter table public.tanks enable row level security;
alter table public.tank_history enable row level security;

drop policy if exists "auth read tanks" on public.tanks;
drop policy if exists "auth insert tanks" on public.tanks;
drop policy if exists "auth update tanks" on public.tanks;
drop policy if exists "auth delete tanks" on public.tanks;
create policy "auth read tanks" on public.tanks for select to authenticated using(true);
create policy "auth insert tanks" on public.tanks for insert to authenticated with check(true);
create policy "auth update tanks" on public.tanks for update to authenticated using(true) with check(true);
create policy "auth delete tanks" on public.tanks for delete to authenticated using(true);

drop policy if exists "auth read history" on public.tank_history;
drop policy if exists "auth insert history" on public.tank_history;
create policy "auth read history" on public.tank_history for select to authenticated using(true);
create policy "auth insert history" on public.tank_history for insert to authenticated with check(true);

alter table public.tanks replica identity full;
do $$ begin alter publication supabase_realtime add table public.tanks; exception when duplicate_object then null; end $$;

-- Permite mostrar o e-mail do usuário no histórico sem expor a tabela auth.users.
create or replace view public.profiles as
select id, email from auth.users;

grant select on public.profiles to authenticated;
