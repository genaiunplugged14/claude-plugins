# Research Sources

> **Purpose**: The researcher's lens. WHERE to look for citeable facts, WHO the competitors are (for angle and gap analysis), and HOW to judge a source. The researcher reads this every session before searching; the reviewer reads it when verifying claims.
> **Update cadence**: Quarterly. Add new authoritative sources as you find them; retire dead ones during a monthly cleanup.

---

## Trusted Sources for Facts (cite these for anything verifiable)

These are the sources whose facts we trust enough to publish. The researcher prefers these over random blogs when extracting permit rules, road status, distances, and prices.

### Official / government
- **BRO (Border Roads Organisation)** + state PWD bulletins - pass opening/closing dates, road status. The ground truth for "is the road open".
- **Lahaul-Spiti / Ladakh district administration portals** - Inner Line Permit rules, the current permit portal URLs, restricted-area lists.
- **HP & Ladakh tourism department sites** - official advisories, registration requirements.
- **IMD (India Meteorological Department)** - weather windows, snowfall warnings for high passes.

### High-trust community / first-hand
- **Team BHP travelogues + road-status threads** - real-world, recently-driven reports with dates and photos. Excellent for "what's the road actually like right now".
- **Reddit r/india, r/motorcycles, r/IndiaTravel** - current traveler pain points and freshly-driven reports. Good for People Also Ask and objection-spotting, weaker for hard facts (verify before citing).

### Freshness rule
For permits, pass status, fuel prices, and toll/entry fees: **a source older than the current season is stale.** Always look for the most recent dated confirmation and note the date in the brief. If the only source is from a prior year, label it "needs 2026 confirmation".

---

## Competitor Watchlist (for ANGLE and GAP, not for facts)

The researcher checks what these competitors said so the writer can take a sharper, differentiated angle - and so we never publish a weaker version of something already ranking. Use Tavily `search` with `include_domains` per competitor.

### Vargis Khan
- **Site**: https://vargiskhan.com (road trips: https://vargiskhan.com/log/)
- **Strength**: Detailed route guides, very strong SEO, massive archive
- **Weakness**: Less personal, less budget-focused, occasionally sponsored without disclosure
- **Our edge**: Budget angle, motorcycle coverage, first-person voice

### Thrillophilia
- **Site**: https://www.thrillophilia.com (e.g. /destinations/spiti-valley/articles)
- **Strength**: Strong commercial SEO, booking integration, high volume
- **Weakness**: Generic commercial copy, no first-hand experience, package-tour bias
- **Our edge**: Self-drive truth, real receipts, no booking funnel

### IndiaHikes
- **Site**: https://indiahikes.com/blog
- **Strength**: Excellent trek guides, difficulty ratings, strong community
- **Weakness**: Trekking only, no road trips, no motorcycle content
- **Our edge**: Road-trip format, broader audience (adjacent - covers same regions for trekking)

---

## Our Differentiation (frame "what they missed" from this list)

When the researcher writes the coverage gap and recommended angle, pull from these defensible advantages:

- **14+ years first-hand on these exact roads** (E-E-A-T compounding)
- **562-post archive** - internal-linking firepower
- **Budget-focused** - real prices from actual trips, not sponsored stays
- **Motorcycle + car coverage** - most rivals specialize in one
- **Local knowledge** - Hindi/Punjabi vocabulary, dhaba recommendations, named contacts
- **Safety-first honesty** - direct about danger, altitude, road conditions
- **Photo-and-receipt evidence** - defeats AI-generated competitors automatically

---

## Source-Quality Scoring (the researcher applies this before citing)

Rank every source before pulling a fact or quote from it:

1. **Authority** - Official/govt > recent first-hand travelogue > established blog > UGC > AI-generated listicle. Never cite an AI-generated listicle as a fact source.
2. **Recency** - Current season for logistics; within ~2 years for evergreen background. Date everything.
3. **Specificity** - A source with km markers, real prices, and named places beats one with adjectives.
4. **Verifiability** - Can a reader (or the reviewer) confirm it? Prefer claims with a primary source behind them.

### Red flags (down-rank or drop)
- No publish/update date, or clearly stale for a seasonal topic
- Formulaic AI structure, zero specific data, no first-hand cues
- Pure commercial/booking copy with package pricing only
- Numbers that contradict 2+ trusted sources without explanation

---

## Tavily Targeting Guide (how the researcher searches)

- **Specific queries with the year**: "Manali Spiti Atal Tunnel 2026 permit fuel" - not "spiti travel".
- **`search` with `include_domains`** to read a specific competitor or trusted source; plain `search` for open discovery.
- **`extract`** the top scored hits for clean full text (strips boilerplate) before analysis.
- **`crawl`** only as a fallback when a site won't surface in search (max_depth=1, max_breadth=15). Crawls are unreliable - don't retry endlessly.
- **Always record the URL and the date** for every fact that lands in the brief.
