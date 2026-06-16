# PRD — howard-aoo

## Problem
Sales reps lose deals because they have no lightweight place to capture leads, see which ones are hottest, and know what to do next — without opening a CRM the size of Salesforce.

## Target User
Individual sales rep or small sales team; owns their own pipeline; needs clarity fast.

## Core Objects
- **Lead** — the thing being tracked (contact, company, status, score, notes)
- **Activity** — every touch logged against a lead (call, email, meeting, note)
- **Plan** — free vs paid subscription tier

## MVP Must-Haves
- [ ] Lead list view: create, edit, delete leads
- [ ] Lead detail view: full field set + activity log
- [ ] Status pipeline: New → Contacted → Qualified → Proposal → Won / Lost
- [ ] Auto lead-score (rule-based: status weight + recency + activity count)
- [ ] Log an activity against any lead
- [ ] Stripe checkout for paid tier (one price, monthly)
- [ ] Paywall: free tier capped at 10 leads; paid = unlimited
- [ ] Seed demo data visible without login

## Non-Goals (v1)
- Salesforce / HubSpot integration
- Team sharing / multi-user workspaces
- Email sending from the app
- Mobile native app
- Custom pipeline stages

## Success Criteria
> A sales rep lands on the app, sees a live demo pipeline, creates a new lead, logs a call activity, sees the lead score update, hits the upgrade button, completes Stripe checkout, and can now add lead #11 — all in one session.
