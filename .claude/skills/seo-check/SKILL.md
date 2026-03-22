---
name: seo-check
description: "SEO analysis — meta tags, structured data, sitemap, accessibility, page speed"
tools: Read, Glob, Grep, Bash
---

# SEO Check — Search Engine Optimization Analysis

## Purpose
Audit the Web3 website for search engine optimization: meta tags, structured data, sitemap, social previews, and technical SEO factors.

## When to Use
- Before launching a production site
- After adding new pages
- When organic traffic is underperforming
- Periodic SEO health check

## Step-by-Step Workflow

### 1. Meta Tags Audit
Check every page in `src/app/`:
- [ ] `title` unique and descriptive (50-60 chars)
- [ ] `description` compelling with keywords (150-160 chars)
- [ ] `keywords` relevant (if used)
- [ ] Canonical URL set correctly
- [ ] `robots` meta appropriate (index/noindex)
- [ ] Next.js `metadata` export used (not manual `<head>`)

### 2. Open Graph & Social
- [ ] `og:title`, `og:description`, `og:image` on all pages
- [ ] `og:image` is 1200x630px, high quality
- [ ] Twitter card meta tags (`twitter:card`, `twitter:image`)
- [ ] `og:type` correct (website, article, product)
- [ ] `og:url` set to canonical URL
- [ ] Test with Facebook Sharing Debugger / Twitter Card Validator

### 3. Structured Data (JSON-LD)
Add appropriate schema for Web3 sites:
```json
{
  "@type": "WebApplication",
  "name": "Project Name",
  "applicationCategory": "FinanceApplication",
  "operatingSystem": "Web",
  "offers": { "price": "0", "priceCurrency": "USD" }
}
```
- Organization schema with logo
- FAQ schema for common questions
- BreadcrumbList for navigation
- SoftwareApplication for DApps

### 4. Technical SEO
- [ ] `sitemap.xml` generated (`src/app/sitemap.ts`)
- [ ] `robots.txt` configured (`src/app/robots.ts`)
- [ ] Clean URL structure (no query params for main content)
- [ ] 404 page returns proper status code
- [ ] Redirects use 301 (permanent) not 302
- [ ] No duplicate content issues
- [ ] Pages load under 3 seconds

### 5. Content SEO for Web3
- [ ] Token name and symbol appear naturally in content
- [ ] Chain name (BNB Chain/BSC) mentioned for discoverability
- [ ] Feature pages have descriptive headings (H1 → H2 → H3)
- [ ] Alt text on all images
- [ ] Contract address in text (indexable by search)
- [ ] Outbound links to BSCScan, CoinGecko (authority signals)

### 6. Performance as SEO Factor
- [ ] Largest Contentful Paint < 2.5s
- [ ] First Input Delay < 100ms
- [ ] Cumulative Layout Shift < 0.1
- [ ] Mobile-friendly (responsive design)
- [ ] HTTPS enabled
- [ ] No mixed content warnings

### 7. Internationalization
- [ ] `lang` attribute on `<html>`
- [ ] `hreflang` if multiple languages
- [ ] Unicode/emoji safe in meta tags
- [ ] Right-to-left support if needed

### 8. Generate SEO Report
```markdown
## SEO Audit Report — {date}

### Page-by-Page Meta Tags
| Page | Title | Description | OG Image | Status |

### Structured Data
| Page | Schema Type | Valid | Issues |

### Technical SEO
| Check | Status | Notes |

### Quick Wins
1. Fix items
2. Add items

### Score: X/100
```

## Output Format
- Page-by-page SEO status
- Missing meta tags identified
- Structured data validation
- Technical SEO checklist
- Prioritized improvements

## Related Skills
`release-checklist`, `perf-profile`, `accessibility-check`
