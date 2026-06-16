# Test Plan

## v1 Success Scenario (manual)
1. Open `/` — confirm 5 demo lead cards render with scores, no login prompt
2. Click "New Lead" — fill name="Jane Doe", company="Acme", status="Qualified" → submit
3. Confirm Jane appears in list with score >0 and green/amber badge
4. Open Jane's detail → click "Log Activity" → type=call, summary="Intro call, positive" → submit
5. Confirm activity appears in log; score badge updates (recency bonus applied)
6. Add 10 more leads → confirm upgrade banner appears at limit
7. Click "Upgrade to Pro" → Stripe test checkout opens (use card 4242 4242 4242 4242)
8. Complete checkout → redirected to `/upgrade/success`
9. Return to `/` → add lead #11 → confirm it saves without paywall block

## Empty State Cases
- Fresh DB (no seed): list shows "No leads yet — add your first one" CTA
- Lead with no activities: activity section shows "No touches yet — log your first activity"
- Checkout cancelled: return to list, upgrade banner still visible, no subscription created

## Error Cases
- Submit New Lead with empty name → inline validation error, no insert
- Stripe webhook with invalid signature → 400 returned, no DB write
- Edit lead with stale session → server returns 401 (post-auth sprint), UI shows "Session expired"
- Network offline during lead save → form shows "Save failed — check connection"

## Regression Checks (each sprint)
- Score recalculates correctly after status change and after activity log
- Paywall blocks insert at lead #11 on free tier; unblocks after confirmed payment
- Audit log row created for every create/update/delete action
