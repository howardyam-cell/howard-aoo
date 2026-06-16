# Security

## Secret Handling
- Stripe secret key, Supabase service-role key: server-only env vars, never in client bundle
- Only `NEXT_PUBLIC_SUPABASE_URL` and `NEXT_PUBLIC_SUPABASE_ANON_KEY` exposed to frontend
- Stripe webhook secret validated on every inbound event

## Permission Model (progression)
- **v1 demo**: open RLS policies — app works for any visitor, no login required
- **Lock-down sprint**: RLS policies scoped to `auth.uid() = user_id`; paywall enforced server-side
- **Post-lock-down**: row-level checks on every mutation route via Supabase server client

## Approved-Tools Rule
- Agentic actions use only the named tools in `AGENTIC_LAYER.md`
- No raw SQL execution, no `send_any`, no `run_any` tools
- Every tool call writes a row to `audit_logs` before and after execution

## Audit Principle
- Every state-changing action (create/update/delete lead, log activity, change subscription) → `audit_logs` row
- Audit log is append-only; no delete route exposed
