# Data Model

## leads
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid nullable | owner (null = demo row) |
| name | text | contact full name |
| company | text | |
| email | text | |
| phone | text | |
| status | text | New/Contacted/Qualified/Proposal/Won/Lost |
| score | numeric | 0–100, rule-based |
| score_source | text | 'rule_engine_v1' |
| score_confidence | numeric | 0–1 |
| score_review_status | text | 'unreviewed' |
| notes | text | |
| created_at | timestamptz | |

## activities
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid nullable | |
| lead_id | uuid | FK → leads.id |
| type | text | call/email/meeting/note |
| summary | text | |
| occurred_at | timestamptz | |
| created_at | timestamptz | |

## subscriptions
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid nullable | |
| stripe_customer_id | text | |
| stripe_subscription_id | text | |
| plan | text | 'free'/'pro' |
| status | text | 'active'/'canceled'/'past_due' |
| current_period_end | timestamptz | |
| created_at | timestamptz | |

## RLS
- v1: all tables have permissive select + write policies (demo-first)
- Lock-down sprint: replace with `auth.uid() = user_id` policies
