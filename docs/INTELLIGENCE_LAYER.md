# Intelligence Layer

## Messy Inputs
- Rep drops in a name, maybe a company, maybe a phone number
- Activity notes are free-text ("called, no answer", "sent deck")
- Status is manually set

## Auto-Structure Schema (v1 score event)
```json
{
  "lead_id": "uuid",
  "score": 72,
  "score_source": "rule_engine_v1",
  "score_confidence": 0.85,
  "score_review_status": "unreviewed",
  "factors": {
    "status_points": 30,
    "activity_count_points": 25,
    "recency_points": 17
  }
}
```

## Scoring Rules (v1 — rule-based)
| Factor | Points |
|---|---|
| Status: Qualified | +30 |
| Status: Proposal | +40 |
| Status: Won | +50 |
| Each activity logged | +5 (max 25) |
| Activity in last 7 days | +15 |
| Activity in last 30 days | +10 |

## Events to Track
- lead_created, lead_status_changed, activity_logged, lead_score_updated

## What Gets Ranked
- Lead list sorted by score desc by default ("hottest first")

## v1 vs Later
- **v1**: rule-based score, hottest-first sort
- **Later**: LLM-parsed activity notes → intent signals; AI-suggested next action per lead
