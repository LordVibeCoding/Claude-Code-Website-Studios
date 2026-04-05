---
name: new-site
description: "一键建站/建DApp — 问项目类型+风格，Agent Teams 全自动并行出全套（网站/DApp 通吃，钱包连接+合约交互+克制高级视觉）"
tools: Read, Glob, Grep, Write, Edit, Bash, AskUserQuestion, Agent
---

# New Site — 一键建站/建 DApp

## 核心原则

**只问关键决策，问完后全自动。Agent Teams 并行构建，零等待。**
**同时支持普通网站和 DApp，根据用户选择自动切换页面结构和技术栈。**

## PUA 强制注入协议（铁律 — 不可跳过）

**本技能产出的每一个网站/DApp 都必须是精美到让人 WOW 的作品。简单/素/基础 = 3.25 绩效。**

### 反偷懒铁律
1. **禁止素站** — 没有动画的页面 = 半成品。每个 section 必须有 Framer Motion 入场动画
2. **禁止默认配色** — 蓝色(#3b82f6)、紫色(#6366f1/#8b5cf6) 等 Tailwind 默认色 = 直接 L3
3. **禁止静态文字** — Hero 区标题必须有渐变色/发光效果/打字机动画之一
4. **板块分割只用深浅色交替** — 禁止任何分割线（波浪线/SVG线/直线/几何图案）。section 之间靠背景色深浅交替区分（如深色→浅色→深色），配合大量 padding 留白。参考 Figma/Stripe/Linear 的做法
5. **背景要克制高级** — 禁止堆砌特效（粒子/SVG线条/网格纹理）。好看的背景 = 微妙的渐变 + 大留白 + 3D 玻璃素材点缀。参考 Cosmos/Celestia/Circle 的风格：柔和渐变 + 高对比文字 + 少量精致装饰
6. **3D 玻璃素材必须用** — 从本地素材库选 5-8 个精美素材作为视觉焦点（Hero 装饰、Feature 图标、CTA/Dashboard 装饰），这是和别人拉开差距的关键
7. **排版决定品质** — 字体层次分明（Display字体做标题 + Sans字体做正文）、行间距宽松(leading-relaxed)、section 内部大量留白(py-24+)。参考 Coinbase/Hedera 的克制排版
8. **禁止手绘 Logo SVG** — 如果用户提供了 Logo 图片（PNG/JPG/WebP 等），必须用 `vtracer` 命令行工具转成 SVG，禁止 Agent 手写/手绘 SVG logo。没提供 Logo 的情况下才用文字 Logo
   - **vtracer v0.6.5 已预装在本机，直接 bash 调用即可，无需 cargo install**

### Agent PUA 注入模板
每个 Agent 的 prompt 末尾**必须**附加：
```
开工前用 Read 工具读取 ~/.claude/skills/pua/SKILL.md，按 P8 行为协议执行。
你是 P8 级别，交付标准：
1. 代码完成后自行验证（TypeScript 编译通过、import 路径正确）
2. 主动补全边界情况（空状态、加载态、错误态、移动端适配）
3. 每个组件必须有 Framer Motion 入场动画 — 没动画 = 偷懒
4. 设计要克制高级 — 柔和渐变背景 + 大留白 + 3D玻璃素材点缀 + 高对比文字。禁止堆砌特效（SVG线条/粒子/网格纹理）
5. section 之间只用深浅背景色交替 + 大 padding 分隔，禁止任何分割线组件
6. 用 [PUA生效 🔥] 标记额外完成的工作
7. 不做 NPC — 发现问题主动修复，发现优化点主动加上
8. 如果用户提供了 Logo 图片，必须用 `vtracer --input {logo路径} --output public/logo.svg` 转换，禁止手绘 SVG logo（vtracer 已预装，直接调用，无需安装）
```

---

## 执行流程

### Phase 1: 收集项目信息

如果用户已提供项目信息，直接解析。缺失的用 `AskUserQuestion` 一次性收集：

```
必填：
- 项目名称
- 一句话简介
- 代币符号和总量（如有）
- 合约地址（已部署的，或标注"待部署"）
- 社交链接（推特、TG、Discord 等）

可选：
- 已有智能合约 ABI（DApp 场景，如有则直接导入）
- 品牌色（不提供则根据风格生成）
- Logo 图片路径（PNG/JPG/WebP 等，如提供会自动用 vtracer 转 SVG；不提供则用文字 Logo）
- 额外页面需求
```

### Phase 2: 问用户关键问题（用 AskUserQuestion）

#### 问题 1: 项目类型
```
你要做什么类型的项目？

【网站类】
A) DeFi — 去中心化金融项目官网
B) GameFi — 链游/P2E 项目官网
C) SocialFi — 社交+金融项目官网
D) Move2Earn — 运动赚币项目官网
E) Meme — 迷因币官网
F) NFT — NFT 项目/平台官网
G) Infrastructure — 基础设施/工具链官网
H) DAO — 去中心化组织官网

【DApp 类】
I) DEX / Swap — 代币兑换（PancakeSwap 风格）
J) Staking / Yield — 质押挖矿、收益农场
K) Lending / Borrowing — 借贷协议（Aave 风格）
L) NFT Marketplace — NFT 买卖、拍卖
M) DAO / Governance — 提案投票治理
N) Launchpad — 代币发射平台（Pinksale 风格）
O) Bridge — 跨链桥
P) Portfolio / Dashboard — 资产管理看板
Q) Custom — 自定义（描述你要的）
```

根据用户选择，设置内部变量 `projectMode`：
- A-H → `projectMode = "website"`
- I-Q → `projectMode = "dapp"`

#### 问题 2: 设计风格

根据类型推荐 3-4 个最匹配的风格：

**网站类推荐：**

| 类别 | 推荐风格 |
|------|---------|
| DeFi | Dark+Neon, Glassmorphism, Aurora, Gradient Mesh |
| GameFi | 3D Immersive, Dark+Neon, Scroll Storytelling, Parallax |
| SocialFi | Bento Grid, Gradient Mesh, Big Typography, Minimalism |
| Move2Earn | Aurora, Organic Shapes, Gradient Mesh, Scroll Storytelling |
| Meme | Brutalism, Big Typography, Dark+Neon, Kinetic Typography |
| NFT | Infinite Gallery, Dark+Neon, Horizontal Scroll, Masked Image |
| Infrastructure | Minimalism, Bento Grid, Card Stacking, Neumorphism |
| DAO | Dark+Neon, Card Stacking, Layered Paper, Aurora |

**DApp 类推荐：**

| DApp 类型 | 推荐风格 |
|-----------|---------|
| DEX/Swap | Dark+Neon, Glassmorphism, Aurora |
| Staking | Dark+Neon, Bento Grid, Gradient Mesh |
| Lending | Minimalism, Glassmorphism, Card Stacking |
| NFT Marketplace | Infinite Gallery, Dark+Neon, Horizontal Scroll |
| DAO/Governance | Dark+Neon, Card Stacking, Layered Paper |
| Launchpad | Aurora, Dark+Neon, Gradient Mesh |
| Bridge | Glassmorphism, Minimalism, Aurora |
| Dashboard | Bento Grid, Glassmorphism, Neumorphism |

#### 问题 3（仅 DApp）: 合约状态
```
你的智能合约情况？
A) 已部署 — 给我合约地址和 ABI，我直接对接
B) 需要写合约 — 我帮你写 + 部署
C) 只要前端 — 先做界面，合约后面再说
```

> 如果 `projectMode = "website"` 则跳过此问题。

### Phase 3: 加载风格预设 + 素材库（自动）

1. 读取 `~/.claude/styles-presets/{序号}-{风格名}.md`
2. 提取 CSS Variables、Tailwind Config、Core CSS Classes、Component Patterns
3. 读取 `~/.claude/styles-presets/svg-components.md` 获取 SVG 动效组件库
4. 根据风格确定最匹配的 SVG 动效组合
5. **加载 3D 玻璃素材库**：读取 `/Users/heart/Desktop/图片储存/建站素材/.catalog/index.json`
6. 根据项目类别选择素材分类（参考素材选择策略表）

### Phase 4: 初始化项目（自动，根据 projectMode 区分）

**网站模式：**
```bash
mkdir -p {projectSlug}/src/{app/{about,features,tokenomics,community},components/{svg,sections,ui,layout},styles,lib,hooks}
mkdir -p {projectSlug}/public/assets/{decorations,icons,backgrounds}
```

**DApp 模式：**
```bash
mkdir -p {projectSlug}/src/{app/{swap,pool,stake,dashboard,governance},components/{svg,sections,ui,layout,web3},contracts/{abis,hooks},styles,lib/{web3,utils},hooks}
mkdir -p {projectSlug}/public/assets/{decorations,icons,backgrounds}
```

生成基础配置文件：

**公共配置（两种模式都生成）：**
- `package.json`（依赖见下方区分）
- `tailwind.config.ts` — 注入风格预设（⚠️ 必须用 Tailwind v3，禁止 v4）
- `tsconfig.json`
- `next.config.ts`
- `src/styles/globals.css` — CSS Variables
- `src/styles/style-preset.css` — 风格专属 CSS 类
- `src/styles/animations.css` — 动画关键帧
- `.style-config.json` — 风格元数据
- `src/lib/constants.ts` — 项目常量
- `src/lib/metadata.ts` — SEO 元数据配置

**DApp 额外配置：**
- `src/lib/web3/config.ts` — wagmi config（BSC Mainnet + Testnet）
- `src/lib/web3/chains.ts` — 链配置
- `src/lib/web3/formatters.ts` — 地址/金额/时间格式化

**package.json 依赖区分：**
- 网站基础：Next.js 15 + TypeScript + Tailwind CSS v3 + GSAP + Framer Motion + lucide-react + lottie-web + vivus + three + @react-three/fiber
- DApp 额外增加：wagmi v2 + viem + @rainbow-me/rainbowkit + @tanstack/react-query

---

### Phase 5: Agent Teams 并行构建

根据 `projectMode` 启动不同数量的 Agent：
- **网站模式** → 5 个 Agent 同时启动
- **DApp 模式** → 7 个 Agent 同时启动（多了 Web3 核心层 + 合约集成层）

---

#### Agent 1: SVG 动效 + 动画库集成（公共）
```
subagent_type: general-purpose
mode: bypassPermissions
任务：根据 {选定风格} 为 {项目名} 生成全套动效组件
⚠️ 质量红线：视觉手法多样化。背景优先用 CSS 渐变/光晕/粒子效果，SVG 用于装饰元素/图表/图标。全部背景都是 SVG 线条 = 不合格。

**Part A: 视觉组件**
参考 ~/.claude/styles-presets/svg-components.md 中的 20 种组件
根据风格调整颜色使用 CSS Variables var(--primary) var(--accent) 等

必须生成：
1. HeroBackground.tsx — Hero 区微妙渐变背景组件（CSS radial-gradient + 柔和色彩过渡，不是 SVG 线条）
2. FloatingDecor.tsx — 3D 玻璃素材浮动装饰封装（float animation + subtle glow）
3. GradientOrb.tsx — 模糊渐变光球装饰（CSS blur + opacity，用于 section 背景点缀）
4. TokenGlow.tsx — 代币脉冲/光环动效
5. SvgChart.tsx — SVG 数据可视化组件（饼图/环形图/时间线/TVL曲线）
6. LoadingSpinner.tsx — 加载动效（SVG 旋转）
7. EmptyState.tsx — 空状态插画（SVG）
8. index.ts — 统一导出
⚠️ 禁止生成 SectionDivider — section 之间只用深浅背景色交替

仅 DApp 模式额外生成：
9. TransactionPulse.tsx — 交易脉冲动效（每次交易触发）

**Part B: 动画库组件（按需使用）**
10. LottieAnimation.tsx — lottie-web 封装组件（懒加载 + 交叉观察器触发）
11. SvgDrawAnimation.tsx — vivus 封装（SVG 路径绘制动画，用于 Logo 入场/图标入场）
12. Scene3D.tsx — @react-three/fiber 3D 场景组件（仅 GameFi/Metaverse 类项目需要）

动画库选用策略：
- Logo/图标入场 → vivus（SVG 路径绘制）
- 复杂序列动画 → lottie-web（JSON 动画）
- 3D 装饰/GameFi → react-three-fiber
- 滚动动画/交互动画 → GSAP ScrollTrigger
- 入场/过渡动画 → Framer Motion

输出到 src/components/svg/
所有颜色用 CSS Variables，不硬编码

开工前用 Read 工具读取 ~/.claude/skills/pua/SKILL.md，按 P8 行为协议执行。
你是 P8 级别。设计要克制高级：
- 背景用 CSS 渐变（radial-gradient 柔和光球 + linear-gradient 色彩过渡），不是 SVG 线条
- 装饰用 3D 玻璃素材浮动 + subtle glow，不是粒子/网格纹理
- SVG 只用于图表（饼图/环形图）、Logo、图标，不做背景
- 每个组件必须有 CSS animation 或 Framer Motion 动画
- 禁止生成任何 SectionDivider 组件 — section 之间靠深浅背景色交替
```

#### Agent 2: 3D 玻璃素材选取 + 集成（公共）
```
subagent_type: general-purpose
mode: bypassPermissions
任务：从本地 3D 玻璃素材库中选取最匹配的素材，压缩后集成到项目
⚠️ 质量红线：必须选 5-8 个素材，不能只选 1-2 个。每个素材要有悬浮动画 + 发光效果。

素材库路径：/Users/heart/Desktop/图片储存/建站素材/
联系表路径：/Users/heart/Desktop/图片储存/建站素材/.catalog/sheets/
索引文件：/Users/heart/Desktop/图片储存/建站素材/.catalog/index.json

按项目类别选择分类：

【网站类】
| 项目类别 | 首选素材分类 | 备选 |
|----------|------------|------|
| DeFi/Web3 | 627W镭射玻璃, 1237镀铬形状 | 704W科幻晶体 |
| GameFi | 704W科幻晶体, 627W镭射玻璃 | 1237镀铬形状 |
| SocialFi | 35Y玻璃晶体, G314透明玻璃 | Abstract Shapes |
| NFT | 447A艺术玻璃, 5082立体抽象 | 627W镭射玻璃 |
| Meme | 5082立体抽象, Abstract Shapes | 751W艺术图形 |
| Infrastructure | 503抽象立体金属, G314透明玻璃 | 35Y玻璃晶体 |
| DAO | 1237镀铬形状, G314透明玻璃 | 503抽象立体金属 |

【DApp 类】
| DApp 类型 | 首选素材 | 备选 |
|-----------|---------|------|
| DEX/Swap | 627W镭射玻璃, 1237镀铬形状 | 704W科幻晶体 |
| Staking | 1237镀铬形状, G314透明玻璃 | 503抽象立体金属 |
| Lending | G314透明玻璃, 35Y玻璃晶体 | 503抽象立体金属 |
| NFT Marketplace | 447A艺术玻璃, 5082立体抽象 | 627W镭射玻璃 |
| DAO/Governance | 503抽象立体金属, G314透明玻璃 | 1237镀铬形状 |
| Launchpad | 627W镭射玻璃, 5082立体抽象 | Abstract Shapes |
| Bridge | 704W科幻晶体, 1237镀铬形状 | 627W镭射玻璃 |
| Dashboard | G314透明玻璃, Abstract Shapes | 35Y玻璃晶体 |

执行步骤：
1. 用 Read 工具查看对应分类的联系表（.catalog/sheets/{分类名}.jpg）
2. 选择 5-8 个最匹配的素材
3. 用 magick 压缩并转换为 WebP：
   - Hero 装饰: 800-1200px
   - Feature 图标: 200-400px
   - 背景装饰: 600-1000px
   - 小装饰: 100-200px
4. 输出到 public/assets/{decorations,icons,backgrounds}/
5. 生成 src/lib/assets.ts — 素材路径常量映射
6. 生成 src/components/ui/GlassDecor.tsx — 玻璃装饰组件（悬浮动画 + 发光效果）

CSS 集成：
.glass-float { animation: float 6s ease-in-out infinite; }
.chrome-glow { filter: drop-shadow(0 0 20px rgba(120, 200, 255, 0.3)); }

开工前用 Read 工具读取 ~/.claude/skills/pua/SKILL.md，按 P8 行为协议执行。
你是 P8 级别。素材必须精心选择（看联系表），不是随便挑几个。
每个素材都要有对应的悬浮动画和发光特效 CSS。只选不集成 = 偷懒。
```

#### Agent 3: 页面结构（根据 projectMode 不同）

**网站模式：**
```
subagent_type: general-purpose
mode: bypassPermissions
任务：创建 {项目名} 的所有页面，使用 {风格} 预设样式
⚠️ 质量红线：每个页面必须精美到让人 WOW。纯文字无动效 = 3.25。

页面列表：
1. src/app/layout.tsx — 根布局，引入字体+全局样式+Header+Footer
2. src/app/page.tsx — 首页：Hero区 + 功能介绍 + 数据统计 + 代币经济 + 社区 + CTA
3. src/app/about/page.tsx — 关于：使命愿景 + 团队 + 路线图
4. src/app/tokenomics/page.tsx — 代币经济：分配比例(SVG饼图) + 合约信息 + 购买方式
5. src/app/community/page.tsx — 社区：社交链接 + 加入方式

所有页面：
- 使用风格预设的 className
- 引用 SVG 组件（import from @/components/svg）
- 颜色只用 var(--xxx) 或 Tailwind 自定义色
- 大量使用动画（Framer Motion / CSS animation）
- metadata 导出 SEO 信息
- Hero 区必须有：微妙渐变背景 + 3D 玻璃素材装饰 + 渐变/发光标题 + Framer Motion 入场动画
- section 之间靠深浅背景色交替分隔（如 bg-[--bg-primary] → bg-[--bg-secondary] → bg-[--bg-primary]），禁止用任何分割线组件
- 每个 section 大量留白（py-24 md:py-32），让内容呼吸
- 每个 section 必须有 Framer Motion whileInView 入场动画

开工前用 Read 工具读取 ~/.claude/skills/pua/SKILL.md，按 P8 行为协议执行。
你是 P8 级别。页面必须精美 — 纯文字列表 = 偷懒 = 3.25。
设计要克制高级：微妙渐变 + 大留白 + 3D 素材点缀 + 精排版。section 之间只用深浅背景色交替，禁止分割线。
```

**DApp 模式（根据 DApp 类型生成不同页面）：**
```
subagent_type: general-purpose
mode: bypassPermissions
⚠️ 质量红线：每个页面必须精美到让人 WOW。纯文字无动效 = 3.25。设计要克制高级：微妙渐变背景 + 大留白 + 3D玻璃素材点缀 + 渐变发光标题 + Framer Motion 入场动画。section 之间只用深浅背景色交替 + 大 padding，禁止任何分割线。
```

**DEX/Swap：**
```
src/app/layout.tsx — 根布局 + WalletProvider
src/app/page.tsx — 首页（Hero + 功能介绍 + 统计数据）
src/app/swap/page.tsx — 兑换页面（代币选择 + 金额输入 + 滑点设置 + Swap按钮）
src/app/pool/page.tsx — 流动性池（添加/移除流动性）
src/app/dashboard/page.tsx — 个人仪表盘（持仓 + 交易记录）
```

**Staking：**
```
src/app/layout.tsx
src/app/page.tsx — 首页
src/app/stake/page.tsx — 质押页面（质押/解押 + APY 显示 + 锁仓期）
src/app/rewards/page.tsx — 奖励页面（可领取奖励 + 历史）
src/app/dashboard/page.tsx — 仪表盘
```

**NFT Marketplace：**
```
src/app/layout.tsx
src/app/page.tsx — 首页（精选 + 热门 + 最新）
src/app/explore/page.tsx — 浏览（筛选 + 排序 + 网格/列表）
src/app/item/[id]/page.tsx — 详情页（图片 + 属性 + 出价 + 历史）
src/app/create/page.tsx — 创建/上架
src/app/profile/page.tsx — 个人主页
```

**DAO/Governance：**
```
src/app/layout.tsx
src/app/page.tsx — 首页
src/app/proposals/page.tsx — 提案列表
src/app/proposals/[id]/page.tsx — 提案详情 + 投票
src/app/delegate/page.tsx — 委托投票权
src/app/treasury/page.tsx — 金库总览
```

**Launchpad：**
```
src/app/layout.tsx
src/app/page.tsx — 首页
src/app/projects/page.tsx — 项目列表（即将/进行中/已结束）
src/app/projects/[id]/page.tsx — 项目详情（参与/认购）
src/app/portfolio/page.tsx — 我的参与
```

**Dashboard：**
```
src/app/layout.tsx
src/app/page.tsx — 首页仪表盘（资产总览 + 代币列表 + PnL图表）
src/app/history/page.tsx — 交易历史
src/app/settings/page.tsx — 设置
```

所有 DApp 页面通用要求：
- 使用风格预设 className + 克制高级视觉（微妙渐变 + 3D 素材点缀 + 大留白）+ Framer Motion 动画
- section 之间靠深浅背景色交替分隔，禁止任何分割线
- 每个 section 大量留白（py-24 md:py-32）
- Hero 区标题必须有渐变色/发光效果 + Framer Motion 入场
- 主动补全空状态、加载态、错误态、移动端适配

```
开工前用 Read 工具读取 ~/.claude/skills/pua/SKILL.md，按 P8 行为协议执行。
你是 P8 级别，交付标准：
1. 代码完成后自行验证（TypeScript 编译通过、import 路径正确）
2. 设计要克制高级 — 微妙渐变背景 + 大留白 + 3D玻璃素材点缀 + 高对比文字
3. Hero 区标题必须有渐变色/发光效果 + Framer Motion 入场
4. section 之间只用深浅背景色交替 + 大 padding，禁止任何分割线
5. 主动补全空状态、加载态、错误态、移动端适配
6. 用 [PUA生效 🔥] 标记额外完成的工作
7. 不做 NPC — 发现页面可以更精美就主动加
```

#### Agent 4: 组件库（根据 projectMode 区分组件数量）

**公共组件（两种模式都生成）：**
```
subagent_type: general-purpose
mode: bypassPermissions
⚠️ 质量红线：每个组件必须有 Framer Motion 入场动画 + TypeScript 类型。没动画 = 偷懒。

布局组件 src/components/layout/：
1. Header.tsx — 固定导航栏，Logo+菜单+钱包连接按钮(DApp)/社交图标(网站)，滚动时背景变化
2. Footer.tsx — 页脚，Logo+链接+社交+合约地址+版权
3. Sidebar.tsx — 侧边导航（仅 DApp 模式需要）

区块组件 src/components/sections/：
4. Hero.tsx — 全屏 Hero，微妙渐变背景 + 3D 素材装饰 + 大标题 + CTA
5. Features.tsx — 功能网格/Bento，每个功能用 SVG 图标+标题+描述
6. Stats.tsx — 数据统计区，数字滚动动画

网站额外区块（仅网站模式）：
7. Tokenomics.tsx — 代币分配 SVG 环形图 + 分配详情表
8. Community.tsx — 社交卡片网格
9. CTA.tsx — 行动号召区
10. Roadmap.tsx — 路线图时间线

UI 组件 src/components/ui/：
11. Button.tsx — 风格化按钮（primary/secondary/outline/ghost）
12. Card.tsx — 风格化卡片
13. GlowText.tsx — 发光/渐变文字
14. AnimatedCounter.tsx — 数字滚动计数器
15. SocialIcon.tsx — 社交媒体 SVG 图标组件

DApp 额外 UI 组件（仅 DApp 模式）：
16. Input.tsx — 风格化输入框（数字输入 + Max按钮）
17. TokenSelector.tsx — 代币选择器（搜索 + Logo + 余额）
18. SlippageSettings.tsx — 滑点设置弹窗
19. Modal.tsx — 模态框
20. Tabs.tsx — 标签页
21. Table.tsx — 数据表格
22. Badge.tsx — 状态标签
23. Tooltip.tsx — 提示框
24. Skeleton.tsx — 骨架屏加载
25. ProgressBar.tsx — 进度条（质押进度/募集进度）

Logo 处理规则：
- vtracer v0.6.5 已预装在本机，直接 bash 调用即可，无需 cargo install
- 如果用户提供了 Logo 图片，先用 `vtracer --input {logo路径} --output public/logo.svg --colormode color --filter_speckle 4 --color_precision 6 --corner_threshold 60 --segment_length 4` 转成 SVG
- Header.tsx 和 Footer.tsx 中引用 public/logo.svg（`<img src="/logo.svg" alt="{项目名} Logo" />`）
- OG 图片（opengraph-image.tsx）中也引用 logo.svg
- **禁止手写 SVG path 来画 logo** — 必须用 vtracer 从图片转换
- 没提供 Logo 图片时才用文字 Logo（项目名首字母或全名）

所有组件必须：
- 使用风格预设 className
- TypeScript props 接口
- Framer Motion 入场动画（motion.div + initial/animate/whileInView）
- 移动端响应式
- 按钮有 hover 效果 + 发光/渐变
- 卡片有 hover:scale + 阴影变化

开工前用 Read 工具读取 ~/.claude/skills/pua/SKILL.md，按 P8 行为协议执行。
你是 P8 级别。组件要精美 — 比如 Button 要有渐变背景+hover 发光效果+点击缩放。
基础的 bg-gray + text-white = P6 水平。P8 要做到让用户说 WOW。
```

#### Agent 5: 配置与 SEO（公共）
```
subagent_type: general-purpose
mode: bypassPermissions
任务：完善 {项目名} 的所有配置和 SEO

1. 完善 tailwind.config.ts — 确保风格预设配置正确
2. src/styles/animations.css — 所有自定义动画 @keyframes
3. src/lib/fonts.ts — 根据风格配置 Google Fonts（next/font）
4. src/app/sitemap.ts — 站点地图
5. src/app/robots.ts — robots.txt
6. src/app/manifest.ts — PWA manifest
7. src/lib/metadata.ts — 统一 SEO 元数据（title/description/OG/Twitter Card）
8. src/app/opengraph-image.tsx — OG 图片（SVG 生成，不用图片文件）
9. src/app/icon.tsx — Favicon（SVG 生成）

开工前用 Read 工具读取 ~/.claude/skills/pua/SKILL.md，按 P8 行为协议执行。
```

#### Agent 6: Web3 核心层（仅 DApp 模式启动）
```
subagent_type: general-purpose
mode: bypassPermissions
⚠️ 质量红线：每个 Web3 组件必须有完整状态处理（loading/success/error/disconnected）+ 动画过渡。ConnectButton 必须精美匹配设计风格，不能用默认样式。
任务：创建 DApp Web3 交互核心

src/lib/web3/：
1. config.ts — wagmi createConfig（BSC chains, transports, connectors）
2. chains.ts — BSC Mainnet/Testnet 链定义
3. formatters.ts — formatAddress, formatTokenAmount, formatUSD, formatTxHash
4. errors.ts — 用户友好的交易错误消息映射
5. constants.ts — WBNB 地址, PancakeSwap Router, 常用代币地址

src/components/web3/：
6. WalletProvider.tsx — wagmi + QueryClient + RainbowKit Provider 封装
7. ConnectButton.tsx — 风格化钱包连接按钮（匹配设计风格）
8. ChainSwitcher.tsx — 链切换组件
9. TransactionStatus.tsx — 交易状态组件（pending/success/error + 动画）
10. ApprovalFlow.tsx — 代币授权流程组件（检查授权→授权→执行）
11. TokenBalance.tsx — 代币余额显示
12. AddressDisplay.tsx — 地址显示（缩略+复制+BSCScan链接）

开工前用 Read 工具读取 ~/.claude/skills/pua/SKILL.md，按 P8 行为协议执行。
你是 P8 级别，交付标准：
1. 代码完成后自行验证（TypeScript 编译通过、import 路径正确）
2. 主动补全边界情况（钱包未连接、链错误、交易失败、余额不足）
3. ConnectButton 必须精美匹配设计风格 — 不能用 RainbowKit 默认样式
4. TransactionStatus 必须有 Framer Motion 动画过渡
5. 用 [PUA生效 🔥] 标记额外完成的工作
6. 不做 NPC — 发现 Web3 交互问题主动修复
```

#### Agent 7: 合约集成层（仅 DApp 模式启动，根据问题3的回答决定内容）
```
subagent_type: general-purpose
mode: bypassPermissions
⚠️ 质量红线：合约 hooks 必须有完整错误处理 + TypeScript 严格类型。写合约必须遵循 Checks-Effects-Interactions + 自定义错误 + 事件。
```

**如果用户选"已部署"：**
```
根据提供的 ABI 生成：
src/contracts/abis/{contractName}.ts — ABI 常量
src/contracts/addresses.ts — 地址映射
src/contracts/hooks/use{ContractName}.ts — wagmi hooks 封装
  - useReadXxx() — 读取合约状态
  - useWriteXxx() — 写入交易
  - useWatchXxxEvent() — 事件监听
```

**如果用户选"需要写合约"：**
```
src/contracts/solidity/{ContractName}.sol — Solidity 合约
  - DEX: Router + Factory + Pair
  - Staking: StakingPool + RewardDistributor
  - NFT: Marketplace + Escrow
  - DAO: Governor + Timelock
  - Launchpad: LaunchPool + VestingWallet
hardhat.config.ts — Hardhat 配置
scripts/deploy.ts — 部署脚本
test/{ContractName}.test.ts — 合约测试
```

**如果用户选"只要前端"：**
```
src/contracts/abis/mock.ts — Mock ABI
src/contracts/hooks/useMock.ts — Mock hooks（返回假数据）
src/lib/web3/mockData.ts — 模拟数据
```

```
开工前用 Read 工具读取 ~/.claude/skills/pua/SKILL.md，按 P8 行为协议执行。
你是 P8 级别，交付标准：
1. 合约 hooks 必须有完整错误处理 + TypeScript 严格类型
2. Solidity 合约遵循 Checks-Effects-Interactions + 自定义错误 + 事件
3. 用 [PUA生效 🔥] 标记额外完成的工作
4. 不做 NPC — 发现合约安全问题主动修复
```

---

### Phase 6: 组装验证（等所有 Agent 完成后）

**公共验证：**
1. 检查所有 import 路径是否正确
2. 确保 SVG 组件被引入到页面
3. 确保 3D 玻璃素材正确引用到 Hero/Feature/CTA 区域
4. 确保 globals.css 包含所有 CSS Variables
5. 确保动画库组件正确懒加载
6. 修复任何 TypeScript 类型错误

**DApp 额外验证：**
7. 确保 WalletProvider 包裹整个 app
8. 确保 Web3 hooks 正确连接
9. 确保合约 ABI 和地址配置正确

**最终：**
10. 运行 `pnpm install && pnpm build` 验证

---

## 关键约束

### 视觉设计原则（参考 Cosmos/Stripe/Linear/Coinbase）
**克制 > 堆砌。好看的网站/DApp 不是特效多，而是每个细节都精致。**

| 视觉元素 | 做法 | 禁止 |
|----------|------|------|
| 背景 | 微妙 CSS 渐变（radial-gradient 柔和光球 + 深浅色交替） | SVG 线条/网格/粒子效果 |
| 装饰 | 3D 玻璃素材浮动 + subtle glow | 堆砌多种特效 |
| 分隔 | section 深浅背景色交替 + 大 padding(py-24+) | 任何分割线（波浪/直线/SVG/几何） |
| 文字 | Display 字体大标题 + 渐变色/发光 + Sans 正文 | 静态普通文字 |
| 动画 | Framer Motion 入场 + hover 微交互 + 数字滚动 | 过度动画/闪烁 |
| 图表 | SVG 饼图/环形图/TVL曲线/时间线 | — |
| 图标 | Lucide React 或 3D 玻璃素材 | — |

**section 深浅交替示例：**
```
Hero:       bg-[--color-bg-primary]    (深色)  + 渐变光球装饰 + 3D素材
Features:   bg-[--color-bg-secondary]  (浅一点) + 3D 素材图标/功能卡片
Stats:      bg-[--color-bg-primary]    (深色)  + 数字滚动
Tokenomics: bg-[--color-bg-secondary]  (浅一点) + SVG 环形图
CTA:        bg-[--color-bg-primary]    (深色)  + 发光按钮
```

### 风格强制
- 颜色只用 CSS Variables（var(--primary) 等）
- 不允许 Tailwind 默认颜色（bg-blue-500 ❌）
- 只用自定义 Tailwind 色（bg-primary ✅）
- className 必须来自风格预设

### 代币集成
- 合约地址可点击跳转 BSCScan
- 代币符号全站使用
- 社交链接放 Header + Footer
- Tokenomics 页 SVG 环形图展示分配

### Web3 UX 标准（仅 DApp 模式）
- 所有链上操作必须有 loading/success/error 状态
- 交易前必须显示 gas 估算
- 代币操作前检查 allowance
- 链 ID 不对自动提示切链
- 断开钱包后清空状态
- 错误消息要用户友好，不直接显示合约报错

## 相关技能
`pick-style`, `gen-svg`, `setup-stack`, `connect-wallet`, `deploy-contract`, `contract-review`, `design-system`
