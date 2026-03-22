---
name: ui-ux-pro-max
description: "UI/UX 设计智能库 — 67 种风格、96 配色方案、57 字体搭配、25 图表类型。建站时自动搜索匹配产品类型的配色和风格，杜绝千篇一律的蓝紫色。"
tools: Read, Bash, Glob
---

# UI/UX Pro Max — 设计智能库

67 种 UI 风格、96 配色方案（161 产品类型）、57 字体搭配、25 图表类型、99 UX 准则。
BM25 搜索引擎，根据产品类型自动推荐最佳设计系统。

**核心价值：杜绝蓝紫色默认配色，每个项目必须根据产品类型匹配专属配色。**

## 脚本路径

```
~/.claude/skills/ui-ux-pro-max/scripts/search.py
```

## 强制使用规则

以下场景 **必须** 在写代码前先调用设计系统生成：

| 场景 | 触发 | 起始步骤 |
|------|------|---------|
| 新项目/新页面 | "做个 landing page"、"Build a dashboard" | Step 1 → Step 2（设计系统） |
| 新组件 | "做个 pricing card"、"加个 modal" | Step 3（领域搜索：style, ux） |
| 选风格/配色/字体 | "推荐配色"、"什么风格适合 fintech" | Step 2（设计系统） |
| 审查 UI | "检查 UX 问题"、"Review accessibility" | Step 3（领域搜索：ux） |
| 优化改进 | "提升移动端体验"、"Make this faster" | Step 3（领域搜索：ux, react） |

## 工作流

### Step 1: 分析需求

从用户请求提取：
- **产品类型**：SaaS / 电商 / DApp / Token / NFT / 博客 / 作品集 等
- **目标受众**：C 端用户 / B 端企业 / 开发者 / 投资者
- **风格关键词**：dark mode / minimal / futuristic / brutalism 等
- **技术栈**：Next.js + Tailwind v3（本项目默认）

### Step 2: 生成设计系统（必须）

**每个新项目必须先跑 `--design-system`：**

```bash
python3 ~/.claude/skills/ui-ux-pro-max/scripts/search.py "<产品类型> <行业> <关键词>" --design-system -p "项目名"
```

输出包含：配色方案 + 字体搭配 + UI 风格 + Landing 结构 + 反面模式

**示例：**
```bash
# Web3 DApp
python3 ~/.claude/skills/ui-ux-pro-max/scripts/search.py "crypto defi dashboard dark" --design-system -p "DeFi Hub"

# 电商
python3 ~/.claude/skills/ui-ux-pro-max/scripts/search.py "ecommerce fashion luxury" --design-system -p "Fashion Store"

# SaaS
python3 ~/.claude/skills/ui-ux-pro-max/scripts/search.py "saas productivity tool minimal" --design-system -p "TaskFlow"
```

### Step 2b: 持久化设计系统

保存为可复用的设计文件：

```bash
python3 ~/.claude/skills/ui-ux-pro-max/scripts/search.py "<query>" --design-system --persist -p "项目名"
```

创建：
- `design-system/项目名/MASTER.md` — 全局设计规范
- `design-system/项目名/pages/` — 页面级覆写

带页面覆写：
```bash
python3 ~/.claude/skills/ui-ux-pro-max/scripts/search.py "<query>" --design-system --persist -p "项目名" --page "dashboard"
```

### Step 3: 补充领域搜索

设计系统生成后，按需深入查询：

```bash
python3 ~/.claude/skills/ui-ux-pro-max/scripts/search.py "<关键词>" --domain <领域> [-n <数量>]
```

| 需要 | 领域 | 示例 |
|------|------|------|
| 产品类型推荐 | `product` | `--domain product "crypto defi"` |
| 更多风格选项 | `style` | `--domain style "glassmorphism dark"` |
| 配色方案 | `color` | `--domain color "entertainment vibrant"` |
| 字体搭配 | `typography` | `--domain typography "modern tech"` |
| 图表推荐 | `chart` | `--domain chart "real-time dashboard"` |
| UX 最佳实践 | `ux` | `--domain ux "animation accessibility"` |
| Landing 页结构 | `landing` | `--domain landing "hero social-proof"` |
| React/Next.js 性能 | `react` | `--domain react "suspense memo rerender"` |
| Google Fonts | `google-fonts` | `--domain google-fonts "futuristic display"` |

## 搜索领域一览

| 领域 | 数据量 | 用途 |
|------|-------|------|
| `product` | 50+ 产品类型 | 按产品类型推荐风格+配色+布局 |
| `style` | 67 种 UI 风格 | glassmorphism / brutalism / aurora 等 |
| `color` | 96 方案（161 产品类型） | 完整语义色彩 tokens |
| `typography` | 57 字体搭配 | heading + body 配对 + Google Fonts URL |
| `chart` | 25 图表类型 | 数据可视化推荐 |
| `ux` | 99 条准则 | 动画/无障碍/导航/表单等 |
| `landing` | 15+ 模式 | Hero / CTA / 社会证明等 |
| `react` | 性能准则 | SSR / memo / bundle / suspense |
| `google-fonts` | 完整字体库 | 按风格/语言/类别搜索 |
| `icons` | 图标推荐 | 按场景推荐图标 |

## 与现有工作流集成

### /pick-style 集成
`/pick-style` 选完 25 种内置风格后，自动用 ui-ux-pro-max 搜索对应配色：
```bash
# 用户选了 "Glassmorphism" → 自动搜索
python3 ~/.claude/skills/ui-ux-pro-max/scripts/search.py "glassmorphism transparent blur" --domain color -n 3
python3 ~/.claude/skills/ui-ux-pro-max/scripts/search.py "glassmorphism" --domain style -n 1
```

### /new-site 和 /new-dapp 集成
建站流程中 Step 2（设计系统）**必须**调用本技能生成配色，禁止使用默认蓝紫色。

## 输出格式

```bash
# ASCII 表格（默认，终端友好）
python3 ~/.claude/skills/ui-ux-pro-max/scripts/search.py "fintech" --design-system

# Markdown（适合文档）
python3 ~/.claude/skills/ui-ux-pro-max/scripts/search.py "fintech" --design-system -f markdown
```

## 配色禁令

**绝对禁止：**
- 默认蓝紫色配色（#6366f1 / #8b5cf6 / #3b82f6 作为主色）
- 不经搜索直接使用 Tailwind 默认色板
- 所有项目使用相同配色

**必须做到：**
- 每个项目先 `--design-system` 搜索产品类型专属配色
- 配色来自 colors.csv 的 161 种产品类型方案
- 主色、副色、强调色必须与产品类型匹配
