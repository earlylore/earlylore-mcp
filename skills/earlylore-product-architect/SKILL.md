---
name: earlylore-product-architect
description: Connect your AI Coding Agent (Claude Code, Cursor, Antigravity, Windsurf) to EarlyLore's product catalog, completed Standard and Deep evaluation reports, category pricing benchmarks, and available product first-fold Design DNA evidence. Activate when turning an idea into an MVP, building a high-converting SaaS landing page, setting pricing tiers, or auditing a local codebase against live competitors.
---

# EarlyLore Product & Design Architect Skill

Use this skill alongside the **EarlyLore MCP Server** (`/api/mcp`) to ground product architecture, landing-page implementation, and pricing decisions in real market evidence from 540,000+ software products.

## 1. Prerequisites & MCP Setup

Ensure the `earlylore` MCP server is connected with your personal access token (`el_live_...` generated at `/account`):

Connection metadata is published at https://earlylore.com/api/mcp/server-card and listed in https://earlylore.com/.well-known/ai-catalog.json. The skills index at https://earlylore.com/.well-known/agent-skills/index.json includes this file's SHA-256 digest. MCP uses stateless Streamable HTTP; initialize with a supported version and send the negotiated `MCP-Protocol-Version` on subsequent requests. Automated HTTP clients requesting `Accept: text/markdown` from public EarlyLore research pages should pass an identifiable `User-Agent` header.

All tool calls count toward the account's daily MCP limit. Evaluation and design brief operations also use their respective credits. MCP product inspection uses the account's full-detail allowance and existing product-view deduplication rules. Temporary free reading of direct public web pages does not exempt authenticated MCP calls. Check each tool's annotations: product inspection, design extraction, search and comparison may start analysis or consume design allowances; saving notes and starting evaluations create account content. Ask the user before starting a new evaluation or saving a note unless their task already authorizes it.

```bash
claude mcp add --transport http earlylore https://earlylore.com/api/mcp \
  --header "Authorization: Bearer el_live_YOUR_TOKEN"
```

## 2. Core Workflows

### Workflow A: Idea Evaluation Blueprint → MVP & Landing Page (`立项蓝图转 MVP 落地`)

When the user asks to scaffold a new product or landing page from an EarlyLore evaluation:

1. **Fetch the Evaluation Blueprint**:
   - Call `earlylore_get_evaluation` (pass `evaluationId` or `query`, or leave empty to pull the user's latest completed report).
   - Extract:
     - `strategyDebate.coreBet`: The single differentiating wedge to build first.
     - `strategyDebate.consensusTrap`: The bloated feature trap to exclude from the MVP scope.
     - `mvpBlueprint.positioning`: Exact `headline`, `subheadline`, and `formAndStyle`.
     - `mvpBlueprint.pricing`: Billing `model`, `tiers`, and conversion `hook`.
     - `personas`: Buyer willingness-to-pay (`wtp`) and top adoption frictions.
2. **Fetch the First-Fold Design DNA**:
   - Call `earlylore_get_design_dna` with the target `styleSlug` or a reference `productSlugOrDomain` from `directCompetitors`.
   - Apply the returned `:root` CSS variables (`--background`, `--surface`, `--foreground`, `--muted-foreground`, `--accent`, `--radius`, `--font-heading`, `--font-body`) and 5-color area ratios directly to `src/styles.css` or Tailwind config.
   - Follow the `hero` layout structure and `avoid` rules. Keep all copy, brand names, logos, and assets original to the user's product.
3. **Align Pricing with the Niche Benchmark**:
   - Call `earlylore_get_niche_benchmark` for the product's primary `categorySlug`.
   - Anchor the entry tier and pro tier against `medianEntryUsd`, `medianTopUsd`, and `trialShare`.

### Workflow B: Search Projects & Inspect Full Project Data (`检索项目与获取完整项目档案`)

When the user wants to find competitors, browse fastest-growing or revenue-verified projects, or pull full commercial data for a specific product:

1. **Search or Filter the 540K+ Catalog (`earlylore_search_products` & `earlylore_get_market_pulse`)**:
   - **Exact Name / Domain Lookup (`mode: "fast"`)**: Pass `query` (e.g. `"postiz"`, `"linear.app"`) to get instant millisecond matches and creator profiles.
   - **Natural-Language Idea Match (`mode: "semantic"`)**: Pass a full product description in `query` to get direct and partial-job competitors plus concentrated niche market stats.
   - **Ranked Lists & Filters (`query` omitted)**: Browse `list: "growing" | "revenue" | "new"` filtered by `category`, `pricing` (`free`, `freemium`, `subscription`, `one_time`, `usage`), `form` (`app`, `extension`, `mcp_server`, `cli`, `api`, `web`), `minVisits`, `trend`, or `hasRepository`.
   - **Market Pulse & Lean Cashcows (`earlylore_get_market_pulse`)**: Pull surging niches, verified revenue risers, and `leanCashcowsUnder10kVisits` (products with verified revenue and <10K monthly visits).
   - **Serial Maker Portfolios (`earlylore_inspect_creator`)**: Inspect an indie creator's full product portfolio, total verified MRR, median launch gap days, and niche distribution.
2. **Fetch Complete Project Data (`earlylore_inspect_product`)**:
   - Pass `slugOrDomain` (and optional `includeDesignDna: true`, or `analyzeIfMissing: true` to trigger live capture for an uncatalogued domain).
   - Returns:
     - **Positioning & Product Scope**: `tagline`, `category`, `aiRole`, `audience`, `forms`, `useTags`, `useCases`, `features`, `integrations`, `repositoryUrl`.
     - **Open Source & Agent Ecosystem (`openSource` & `agentEcosystem`)**: GitHub `repoSlug`, `stars`, `forks`, `license`, `selfHosted`, commercial `alternatives`, plus `hasMcp`, `hasSkill`, `hasCliOrSdk`, compatible AI `clients`, and `capabilities`.
     - **12-Month Traffic & Acquisition (`traffic` & `siteProfile`)**: Monthly visits `history`, MoM `changePct`, traffic `channels` share, `topCountries`, organic `keywords`, and domain `authority`.
     - **Verified Revenue & Claims (`revenue`, `trustmrr`, `revenueClaims`)**: Verified MRR, monthly revenue series, active subscriptions, and public revenue disclosures.
     - **Pricing & Niche Position (`pricing`)**: `pricingMode`, `entryPriceUsd`, `pricePosition` (`categoryMedianUsd`, `cheaperShare`, `pricierShare`), and full plan tiers.
     - **Ecosystem & Evolution**: `stores` (App Store / Google Play / Chrome Web Store), `recentWebsiteChanges`, `recentMarketingEvents`, `creators`, and `similarProducts`.
3. **Compare Competitors, Alternatives & Demand Signals**:
   - **Side-by-Side Comparison (`earlylore_compare_products`)**: Pass `slugsOrDomains` (2–8 products depending on plan) to compare traffic, channel mix, verified MRR, pricing tiers, ad libraries, and hero Design DNA side by side.
   - **Incumbent Alternatives (`earlylore_get_incumbent_alternatives`)**: Pass `incumbentSlug` (e.g. `"notion"`, `"semrush"`, `"canva"`) or filter with `q` / `ossOnly` across 140+ tracked commercial incumbents to inspect verified indie and open-source challengers.
   - **1v1 Product Battlecards (`earlylore_get_product_comparison`)**: Pass `pairSlug` (e.g. `"linear-vs-jira"`) or search via `q`, `categorySlug`, and `ossOnly` for monthly visits, starter pricing, choose-A vs. choose-B scenarios, and FAQs.
   - **Unmet Buyer Demand & MVP Wedges (`earlylore_get_demand_opportunities`)**: Pass optional `categorySlug`, `groupSlug`, and `limit` (1–40) to retrieve validated community pain points, broken workarounds, WTP signals, and MVP wedges backed by verbatim quotes.

### Workflow C: Local Codebase Positioning & Pricing Audit (`本地项目竞品对标体检`)

When the user asks to review or improve an existing project's landing page, positioning, or pricing:

1. **Read Local Surfaces**:
   - Inspect the local repository's landing route, hero copy, feature list, and pricing component.
2. **Pull Live Competitor Evidence**:
   - Call `earlylore_search_products` and `earlylore_get_niche_benchmark` to identify the niche's median entry price, free-trial share, and fastest-growing products.
   - Call `earlylore_inspect_product` (with `includeDesignDna: true`) on the top 2–3 direct competitors to inspect their positioning, organic search share, top countries, verified MRR, pricing tiers, and first-fold Design DNA.
3. **Deliver Actionable Diffs**:
   - Compare the local hero copy, CTA pattern, and pricing tiers against the live niche benchmark.
   - Save key competitive findings back to the user's workspace using `earlylore_save_note_or_evaluate` (`action: "save_note"`).

### Workflow D: Multi-Project Launch & Marketing Playbook (`本地或多项目首发帖模版与社区防封指南`)

When the user asks to write launch posts, cold-start copy, or promotion plans for the current repository or any of their projects:

1. **Resolve the Target Project Context**:
   - **Local Repository (Default)**: Read `README.md`, `package.json`, or the landing page hero route in the current workspace to extract `productName`, `oneLiner`, `painPoint`, `incumbent` (what manual workflow or legacy tool it replaces), `metric`, and delivery `form` (`web`, `app`, `extension`, `mcp_server`, `cli`, `api`).
   - **Multiple Projects in EarlyLore Workspace**: If the user specifies one of their other projects by name, call `earlylore_list_my_workspace` or `earlylore_get_evaluation` (`query: "<project-name>"`) to pull its positioning and target persona first.
2. **Fetch Tailored Templates, Viral Examples & Community Rules (`earlylore_get_marketing_playbook`)**:
   - Call `earlylore_get_marketing_playbook` passing `productName`, `oneLiner`, `painPoint`, `incumbent`, `metric`, `form`, and optional `category`.
   - The tool returns:
     - **8 Pre-Rendered Bilingual Templates (`templates`)**: Ready-to-post English & Chinese drafts across 8 proven launch plays (`launch_post`, `demo_video`, `versus`, `quick_build`, `build_in_public`, `giveaway`, `hot_take`, `milestone`), each paired with top verified viral post examples (`100x+` normal views) for tone calibration.
     - **14 Community Anti-Ban & Title Formula Guides (`communities`)**: Allowed formats, ban triggers, and high-converting title formulas for `r/SideProject`, `r/SaaS`, `r/LocalLLaMA`, `r/selfhosted`, `Show HN`, `Product Hunt`, `X #buildinpublic`, `RedNote (Xiaohongshu)`, and `V2EX`.
     - **Niche Channel Mix & 8 Global Regions (`channelMix`, `topCountries`, `regions`)**: Primary acquisition channel shares, SEO dependency, and regional search engine / local payment rules.
3. **Output Ready-to-Publish Drafts**:
   - Present platform-specific drafts (X main post without external link + Reply #1 link, Reddit story post with exact title formula, Show HN title + technical first comment, and RedNote/V2EX copy) calibrated against the real viral post examples.
