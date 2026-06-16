# Agentic Layer

## Risk Levels & Actions

### Low — auto-execute
- Score lead on save (`tool: score_lead`) — recalculates and writes score fields
- Tag lead from activity note (`tool: tag_lead_intent`) — sets inferred intent tag

### Medium — light approval (user confirms in UI)
- Suggest next follow-up action (`tool: draft_followup_task`) — shown as dismissible prompt
- Auto-move lead status after N days of inactivity (`tool: update_lead_status`) — user approves the nudge

### High — always approval before execution
- Send follow-up email draft (`tool: draft_email`) — user reviews, edits, sends manually
- Initiate Stripe charge / upgrade flow (`tool: create_checkout_session`) — user clicks Upgrade

### Critical — human-only, never automated
- Delete lead or bulk wipe
- Issue refund
- Export all customer data

## Named Tools (approved set)
`score_lead`, `tag_lead_intent`, `draft_followup_task`, `update_lead_status`, `draft_email`, `create_checkout_session`

## Audit Log Fields
`id, user_id, action, tool_name, target_table, target_id, payload_snapshot, risk_level, approved_by, created_at`

## v1 vs Later
- **v1**: `score_lead` + `create_checkout_session` only
- **Later**: `draft_followup_task`, `draft_email`, `tag_lead_intent`
