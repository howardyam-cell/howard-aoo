create table if not exists leads (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  name text not null,
  company text,
  email text,
  phone text,
  status text not null default 'New',
  score numeric not null default 0,
  score_source text not null default 'rule_engine_v1',
  score_confidence numeric not null default 0.85,
  score_review_status text not null default 'unreviewed',
  notes text,
  created_at timestamptz not null default now()
);

alter table leads enable row level security;
drop policy if exists "leads_v1_read" on leads;
create policy "leads_v1_read" on leads for select using (true);
drop policy if exists "leads_v1_write" on leads;
create policy "leads_v1_write" on leads for all using (true) with check (true);

create table if not exists activities (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  lead_id uuid not null references leads(id) on delete cascade,
  type text not null,
  summary text,
  occurred_at timestamptz not null default now(),
  created_at timestamptz not null default now()
);

alter table activities enable row level security;
drop policy if exists "activities_v1_read" on activities;
create policy "activities_v1_read" on activities for select using (true);
drop policy if exists "activities_v1_write" on activities;
create policy "activities_v1_write" on activities for all using (true) with check (true);

create table if not exists subscriptions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  stripe_customer_id text,
  stripe_subscription_id text,
  plan text not null default 'free',
  status text not null default 'active',
  current_period_end timestamptz,
  created_at timestamptz not null default now()
);

alter table subscriptions enable row level security;
drop policy if exists "subscriptions_v1_read" on subscriptions;
create policy "subscriptions_v1_read" on subscriptions for select using (true);
drop policy if exists "subscriptions_v1_write" on subscriptions;
create policy "subscriptions_v1_write" on subscriptions for all using (true) with check (true);

create table if not exists audit_logs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  action text not null,
  tool_name text,
  target_table text,
  target_id uuid,
  payload_snapshot jsonb,
  risk_level text,
  approved_by text,
  created_at timestamptz not null default now()
);

alter table audit_logs enable row level security;
drop policy if exists "audit_logs_v1_read" on audit_logs;
create policy "audit_logs_v1_read" on audit_logs for select using (true);
drop policy if exists "audit_logs_v1_write" on audit_logs;
create policy "audit_logs_v1_write" on audit_logs for all using (true) with check (true);

insert into leads (name, company, email, phone, status, score, score_source, score_confidence, score_review_status, notes) values
  ('Marcus Webb', 'Brighthouse Solar', 'marcus@brighthouse.io', '555-0101', 'Proposal', 82, 'rule_engine_v1', 0.85, 'unreviewed', 'Very interested, awaiting board sign-off.'),
  ('Priya Nair', 'Cloudstep Inc', 'priya@cloudstep.com', '555-0202', 'Qualified', 67, 'rule_engine_v1', 0.85, 'unreviewed', 'Intro call done, needs demo.'),
  ('Derek Lam', 'Finvault', 'derek@finvault.com', '555-0303', 'Contacted', 41, 'rule_engine_v1', 0.85, 'unreviewed', 'Left voicemail x2.'),
  ('Amara Osei', 'NorthGrid Logistics', 'amara@northgrid.com', '555-0404', 'New', 12, 'rule_engine_v1', 0.85, 'unreviewed', 'Inbound from website form.'),
  ('Sofia Reyes', 'PeakFlow Media', 'sofia@peakflow.media', '555-0505', 'Won', 95, 'rule_engine_v1', 0.85, 'unreviewed', 'Contract signed. Closed $18k ARR.');

insert into activities (lead_id, type, summary, occurred_at)
select id, 'call', 'Discovery call — confirmed budget and timeline.', now() - interval '2 days' from leads where name = 'Marcus Webb';
insert into activities (lead_id, type, summary, occurred_at)
select id, 'email', 'Sent proposal deck.', now() - interval '1 day' from leads where name = 'Marcus Webb';
insert into activities (lead_id, type, summary, occurred_at)
select id, 'meeting', 'Zoom demo — very positive response.', now() - interval '4 days' from leads where name = 'Priya Nair';
insert into activities (lead_id, type, summary, occurred_at)
select id, 'call', 'Left voicemail, no reply.', now() - interval '8 days' from leads where name = 'Derek Lam';
insert into activities (lead_id, type, summary, occurred_at)
select id, 'email', 'Contract signed and returned.', now() - interval '1 day' from leads where name = 'Sofia Reyes';