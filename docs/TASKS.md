# Tasks & Sprints

## Sprint 1 — DB + Lead CRUD (core engine) ✦ v1 functional starts here
**Goal**: Leads table live, full CRUD working, demo data visible without login.
- [ ] Run migration SQL (leads, activities, subscriptions, audit_logs tables)
- [ ] Seed 5 demo leads with varied statuses and scores
- [ ] Lead list page (`/`) — renders seed data, no login required
- [ ] New Lead form — POST `/api/leads` → insert → redirect to lead detail
- [ ] Lead detail page — shows all fields + edit form
- [ ] Delete lead with confirm dialog
- [ ] Empty state copy: "No leads yet — add your first one"
- **DoD**: create/edit/delete a lead; changes persist; list reflects them; works for anonymous visitor

## Sprint 2 — Activity Log + Scoring
**Goal**: Log activities against leads; score recalculates on every save.
- [ ] Activity log section on lead detail page
- [ ] Log Activity form (type, summary, occurred_at) → POST `/api/activities`
- [ ] `score_lead` function: status + activity count + recency → writes score fields
- [ ] Score badge on lead card (color: green ≥70, amber 40–69, red <40)
- [ ] Lead list sorted by score desc by default
- [ ] Empty activity state: "No touches yet — log your first activity"
- **DoD**: log an activity → score updates → list re-sorts; no login needed

## Sprint 3 — Stripe Checkout + Paywall ✦ v1 functional milestone
**Goal**: Paid tier live; real payment possible; paywall enforced.
- [ ] Stripe products + price created in Stripe dashboard
- [ ] `POST /api/checkout` → create Stripe Checkout session → redirect
- [ ] Stripe webhook `POST /api/webhooks/stripe` → upsert subscriptions row
- [ ] Paywall middleware: free tier capped at 10 leads; shows upgrade prompt at limit
- [ ] Upgrade CTA banner on lead list when at/near limit
- [ ] Success page after checkout (`/upgrade/success`)
- [ ] Stripe secret + webhook secret in Vercel env vars only
- **DoD**: complete real Stripe test checkout → subscription row updated → can add lead #11

## Sprint 4 — Lock It Down (Auth + per-user RLS)
**Goal**: Each rep sees only their own leads; demo rows preserved.
- [ ] Supabase Auth — email/password signup + login pages
- [ ] On signup: create subscriptions row (plan='free')
- [ ] Replace v1 RLS policies with `auth.uid() = user_id` owner policies
- [ ] Assign `user_id` on all creates via server client
- [ ] Demo seed rows kept with `user_id = null` (read by all pre-login; hidden post-login)
- [ ] Redirect unauthenticated users to `/login` only for write actions
- **DoD**: two test users each see only their own leads; Stripe subscription tied to user

## Sprint 5 — Polish + Deploy
**Goal**: Production-ready, error-handled, documented.
- [ ] Loading skeletons on lead list + detail
- [ ] Error boundary + friendly error pages
- [ ] Lead search / filter by status
- [ ] Audit log viewer (admin debug only)
- [ ] README with local setup + env vars list
- [ ] Deploy to Vercel prod with all env vars set
- **DoD**: live URL works end-to-end; test plan passes in prod

## Gantt (sprint → week)
| Sprint | Week |
|---|---|
| 1 — DB + Lead CRUD | 1 |
| 2 — Activities + Scoring | 1–2 |
| 3 — Stripe + Paywall | 2 |
| 4 — Auth + RLS | 3 |
| 5 — Polish + Deploy | 3–4 |
