# EarlyLore MCP & Product Architect Skill

[![EarlyLore MCP connector](https://glama.ai/mcp/connectors/io.github.jiangqizheng/earlylore/badges/score.svg)](https://glama.ai/mcp/connectors/io.github.jiangqizheng/earlylore)

> Official hosted Streamable HTTP MCP server (`com.earlylore/research` / `io.github.earlylore/earlylore-mcp`) and installable `earlylore-product-architect` Agent Skill for **Claude Code, Cursor, Codex, Antigravity, Windsurf, and Cline**.

Connect your coding agent to live software market intelligence from **[EarlyLore](https://earlylore.com)**: **540,000+** tracked software products, website traffic and pricing benchmarks across **249** niches, **130K+** computed first-fold **Design DNA** profiles (`:root` CSS variables and layout structure), incumbent alternatives, 1v1 battlecards, and completed idea evaluation blueprints.

- **Website**: <https://earlylore.com> ([中文](https://earlylore.com/zh))
- **Evaluate an idea**: <https://earlylore.com/evaluate> ([中文](https://earlylore.com/zh/evaluate))
- **Hosted MCP endpoint**: `https://earlylore.com/api/mcp`
- **MCP setup guide**: <https://earlylore.com/mcp>
- **Server card**: <https://earlylore.com/api/mcp/server-card>
- **Hosted SKILL.md**: <https://earlylore.com/skill.md>
- **Public documentation repo**: [earlylore/docs](https://github.com/earlylore/docs)
- **Operator & legal**: [About](https://earlylore.com/about) · [Terms](https://earlylore.com/terms) · [Privacy](https://earlylore.com/privacy) (`support@earlylore.com`)

---

## Quick Start

### 1. Create your personal access token

Sign in at <https://earlylore.com/account> and generate a personal token starting with `el_live_`. Keys are hashed at rest and share your account quotas. Keep real tokens local—never commit them to Git.

### 2. Connect the MCP server

#### Claude Code

```bash
claude mcp add --transport http earlylore https://earlylore.com/api/mcp \
  --header "Authorization: Bearer el_live_YOUR_TOKEN"
```

(Script copy: [`configs/claude-code.sh`](configs/claude-code.sh))

#### Cursor

Add to `.cursor/mcp.json` in your repository or `~/.cursor/mcp.json` globally (template: [`configs/cursor-mcp.json`](configs/cursor-mcp.json)):

```json
{
  "mcpServers": {
    "earlylore": {
      "url": "https://earlylore.com/api/mcp",
      "headers": {
        "Authorization": "Bearer el_live_YOUR_TOKEN"
      }
    }
  }
}
```

#### Codex, Antigravity, Windsurf, Cline, and other HTTP MCP clients

Use the generic Streamable HTTP configuration in [`configs/generic-mcp.json`](configs/generic-mcp.json) (`mcp_config.json` in Antigravity, or your client's `mcpServers` file):

```json
{
  "mcpServers": {
    "earlylore": {
      "url": "https://earlylore.com/api/mcp",
      "headers": {
        "Authorization": "Bearer el_live_YOUR_TOKEN"
      }
    }
  }
}
```

Protocol details: stateless Streamable HTTP supporting MCP protocol versions `2025-11-25`, `2025-06-18`, and `2025-03-26` (see [`server.json`](server.json) and <https://earlylore.com/api/mcp/server-card>).

### 3. Install the `earlylore-product-architect` Skill

```bash
npx skills add earlylore/earlylore-mcp --skill earlylore-product-architect
```

Or copy [`skills/earlylore-product-architect/SKILL.md`](skills/earlylore-product-architect/SKILL.md) (synced with <https://earlylore.com/skill.md> and <https://earlylore.com/.well-known/agent-skills/index.json>) into `.claude/skills/earlylore/SKILL.md` or `.agents/skills/earlylore/SKILL.md`.

---

## 14 Hosted MCP Tools

| Tool | Behavior | What it returns & best use |
| --- | --- | --- |
| `earlylore_list_my_workspace` | `readOnly`, `idempotent` | List your saved workspace evaluations, notes, and tracked products |
| `earlylore_get_evaluation` | `readOnly`, `idempotent` | Read a completed Standard or Deep evaluation blueprint (`coreBet`, `consensusTrap`, MVP prescription, and roundtable debate) |
| `earlylore_get_design_dna` | Credit / allowance gated, `openWorld` | Fetch first-fold Design DNA (`:root` CSS tokens, typography, color ratios, layout structure, avoid list) for a style or domain (130K+ analyzed sites) |
| `earlylore_get_niche_benchmark` | `readOnly`, `idempotent`, `openWorld` (Pro / Max) | Category pricing benchmarks, median entry/top prices, trial share, and niche velocity across 249 niches |
| `earlylore_search_products` | `openWorld` | Search 540,000+ software products by keyword, category, pricing, traffic, open-source, or revenue evidence |
| `earlylore_inspect_product` | `openWorld` | Inspect one competitor dossier (estimated monthly traffic, pricing tiers, changes, Design DNA, optional disclosed revenue) |
| `earlylore_inspect_creator` | `readOnly`, `idempotent`, `openWorld` | Inspect a public creator or indie founder profile and product portfolio |
| `earlylore_get_market_pulse` | `readOnly`, `idempotent`, `openWorld` | Inspect macro and niche growth trends, rising stars, and lean <10K-visit cashcows |
| `earlylore_compare_products` | `openWorld` (Free 2 / Pro 4 / Max 8) | Compare multiple products side by side across positioning, pricing, traffic, and Design DNA |
| `earlylore_save_note_or_evaluate` | Writes account state, `openWorld` | Save research notes back to your workspace or launch a new Standard/Deep evaluation |
| `earlylore_get_marketing_playbook` | `readOnly`, `idempotent`, `openWorld` | Read bilingual launch templates, viral examples, community anti-ban rules, and channel playbooks |
| `earlylore_get_incumbent_alternatives` | `readOnly`, `idempotent`, `openWorld` | Compare verified indie SaaS and open-source alternatives across 140+ commercial software incumbents |
| `earlylore_get_demand_opportunities` | `readOnly`, `idempotent`, `openWorld` | Retrieve validated unmet buyer demands and MVP wedge hypotheses backed by verbatim community quotes |
| `earlylore_get_product_comparison` | `readOnly`, `idempotent`, `openWorld` | Fetch empirical 1v1 product comparison battlecards (visits, verified MRR, starter pricing, buyer scenarios) |

> All MCP calls count against your daily MCP allowance. Product inspections follow your monthly profile unlock allowance with account-level deduplication; Design DNA extraction and new evaluations use their own plan allowances. Ask or authorize before calling write/credit-consuming tools (`earlylore_save_note_or_evaluate`, fresh extractions).

---

## Vibe Coding Prompts

### Workflow A — Evaluation Blueprint → MVP & Pricing Page

```text
Call earlylore_get_evaluation to load my latest completed evaluation blueprint.
Extract strategyDebate.coreBet, strategyDebate.consensusTrap, and the MVP prescription.
Call earlylore_get_niche_benchmark (if available on my plan) to anchor pricing tiers.
Call earlylore_get_design_dna for the recommended style or competitor and map the returned
:root CSS variables into this codebase. Build the hero and pricing page while keeping
brand names, copy, and assets original to this project.
```

### Workflow B — Competitor Teardown & Design DNA

```text
Call earlylore_search_products to find the top live competitors in <your niche>.
Inspect the strongest reference with earlylore_inspect_product and pull its first-fold
layout and CSS token system with earlylore_get_design_dna. Summarize their pricing hooks
and design patterns before we build our landing page.
```

### Workflow C — Audit Local Repo Against Live Competitors

```text
Inspect our local landing page and pricing configuration, then search EarlyLore for live
alternatives in our category. Compare positioning, entry price, and trial mechanics using
earlylore_compare_products and save the gaps to my EarlyLore workspace if I confirm.
```

### Workflow D — Launch Playbook & GTM Copy

```text
Read this repository's core workflow and target buyer, then call earlylore_get_marketing_playbook
for our primary niche. Draft launch positioning and channel-specific posts grounded in
verified buyer pain points rather than generic claims.
```

---

## Plans & Quotas

Synced against <https://earlylore.com/pricing> on **2026-11-23** (always confirm live terms on `/pricing`):

| Plan | Price | MCP Calls | Product Profiles | Design DNA & Evaluations | Compare |
| --- | --- | --- | --- | --- | --- |
| **Free** | `$0` | `30 / day` | `5 / month` | 5 Design DNA tries · 3 lifetime Standard evals (15 lifetime chat turns) | `2` products |
| **7-day Pro Trial** | `$0` (auto on sign-up, no card) | `30 / day` | `6` full details | 1 Deep + 3 Standard evals · 10 Deep chat turns · all 249 niches · 10% annual upgrade discount | `4` products |
| **Idea Polish Pack** | `$9.9` one-time | Follows plan | `25` full details | 3 Deep + 3 Standard evals · 30 Deep 1v1 turns · 3 custom role boosts · 6 site analyses | — |
| **Validation Sprint Pack** | `$19` one-time | Follows plan | `60` full details | 8 Deep + 8 Standard evals · 80 Deep 1v1 turns · 8 custom role boosts · 15 site analyses | — |
| **Pro** | `$144 / year` (`$12/mo`) or `$19 / mo` (+ 30d/1yr passes) | `200 / day` | `500 / month` | Unlimited Design DNA · 25 Deep + 50 Standard evals/mo (`12/day` cap) · Markdown export | `4` products |
| **Max** | `$384 / year` (`$32/mo`) or `$49 / mo` (+ 30d/1yr passes) | `1,000 / day` | `5,000 / month` | Unlimited Design DNA · 80 Deep + 160 Standard evals/mo (`25/day` cap) · 3 claimed domains + Stealth slots · Markdown export | `8` products |

- Evaluation packs never expire; **100% of pack spend within 14 days (up to `$19`)** credits toward Pro or Max Annual at checkout.
- Optional **30-Day** and **1-Year USD One-Time Passes** are available on Pro and Max with zero auto-renewal.

---

## Explore EarlyLore

- **Idea Evaluation & Benchmarks**: <https://earlylore.com/evaluate>
- **Design DNA & Hero Gallery**: <https://earlylore.com/design>
- **Software Alternatives & 1v1 Battlecards**: <https://earlylore.com/alternatives> · <https://earlylore.com/vs>
- **Open-Source & COSS Directory**: <https://earlylore.com/open-source>
- **Monthly Market Reports**: <https://earlylore.com/reports>
- **16 Research Guides**: <https://earlylore.com/blog> (including [Best MCP Servers for Cursor, Claude Code & Codex (2026)](https://earlylore.com/blog/best-mcp-servers-for-cursor-claude-code-and-product-research))
- **LLM Navigation Index (`llms.txt`)**: <https://earlylore.com/llms.txt> · **Full**: <https://earlylore.com/llms-full.txt>
- **Markdown Content Negotiation**: Any public research route—including curated Deep sample evaluations on `/evaluations/<id>`—supports `Accept: text/markdown` for clean agent ingestion.
- **Company & Legal Disclosures**: Operated by Kai Jiang through Dancheng County Qiannuo Network Technology Studio (Dancheng County, Zhoukou City, Henan Province, China) — [About](https://earlylore.com/about) · [Terms of Service](https://earlylore.com/terms) · [Privacy Policy](https://earlylore.com/privacy) · `support@earlylore.com` · `hello@earlylore.com`

---

## Repository Contents

- [`skills/earlylore-product-architect/SKILL.md`](skills/earlylore-product-architect/SKILL.md) — Installable Agent Skill definition (identical copy of <https://earlylore.com/skill.md>)
- [`server.json`](server.json) — Streamable HTTP MCP Server Card metadata
- [`configs/claude-code.sh`](configs/claude-code.sh) — Claude Code setup command
- [`configs/cursor-mcp.json`](configs/cursor-mcp.json) — Cursor `.cursor/mcp.json` configuration
- [`configs/generic-mcp.json`](configs/generic-mcp.json) — Generic `mcpServers` JSON for Codex, Antigravity, Windsurf, Cline, and Claude Desktop

*License: MIT for the configuration templates and repository files in `earlylore/earlylore-mcp`; product data and hosted MCP responses remain subject to <https://earlylore.com/terms>.*
