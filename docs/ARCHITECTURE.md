# Architecture

## Stack
- **Frontend**: Next.js 14 (App Router) on Vercel
- **Database**: Supabase Postgres + RLS
- **Auth**: Supabase Auth (added at lock-down sprint)
- **Payments**: Stripe Checkout + webhooks
- **Styling**: Tailwind CSS

## Now vs Later
**Now**: Lead CRUD, activity log, rule-based score, Stripe checkout, paywall enforcement
**Later**: Auth + per-user isolation, AI scoring, email sequences, team workspaces

## Key User Action — "Log a lead and get scored"
1. Rep types lead name, company, status into the New Lead form
2. Form POSTs to `/api/leads` → validates → inserts row in `leads`
3. Scoring function runs server-side: status points + activity count + recency = `score` (0–100)
4. Score written back to `leads.score`; `activities` row inserted for creation event
5. Lead list re-fetches; lead card shows updated score badge
6. Rep hits Upgrade → Stripe Checkout session created → webhook confirms payment → `subscriptions` row updated → paywall lifts

## Layer Plan
1. **Data first** — tables, seed rows, open RLS policies
2. **App logic** — CRUD routes, scoring function, paywall middleware
3. **Smart features** — AI-assisted next-action suggestions, priority ranking (post-v1)

## Core Without AI
Scoring and status pipeline are pure rule-based logic. AI layer is additive only.
