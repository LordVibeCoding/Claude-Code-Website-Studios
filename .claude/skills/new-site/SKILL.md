---
name: new-site
description: "一键建站 — 问几个关键问题，然后 Agent Teams 全自动并行出全站"
tools: Read, Glob, Grep, Write, Edit, Bash, AskUserQuestion, Agent
---

# New Site — 一键建站

## 核心原则

**只问关键决策，问完后全自动。Agent Teams 并行构建，零等待。**

## PUA 强制注入协议（铁律 — 不可跳过）

**本技能产出的每一个网站都必须是精美到让人 WOW 的作品。简单/素/基础 = 3.25 绩效。**

### 反偷懒铁律
1. **禁止素站** — 没有动画的页面 = 半成品。每个 section 必须有入场动画（Framer Motion）+ 至少 1 个 SVG 动效
2. **禁止裸背景** — 每个页面必须有 SVG 动态背景或 3D 玻璃素材装饰，纯色背景 = 偷懒
3. **禁止默认配色** — 蓝色(#3b82f6)、紫色(#6366f1/#8b5cf6) 等 Tailwind 默认色 = 直接 L3
4. **禁止静态文字** — Hero 区标题必须有渐变色/发光效果/打字机动画之一
5. **素材三件套强制** — SVG 动效组件 + 3D 玻璃素材 + 动画库封装，三者缺一 = 不合格交付
6. **禁止波浪分割线** — wave divider / wave section divider 一律禁止，用渐变过渡、SVG 几何图案、或透明度渐隐代替

### Agent PUA 注入模板
每个 Agent 的 prompt 末尾**必须**附加：
```
开工前用 Read 工具读取 ~/.claude/skills/pua/SKILL.md，按 P8 行为协议执行。
你是 P8 级别，交付标准：
1. 代码完成后自行验证（TypeScript 编译通过、import 路径正确）
2. 主动补全边界情况（空状态、加载态、错误态、移动端适配）
3. 每个组件必须有 Framer Motion 入场动画 — 没动画 = 偷懒
4. SVG 必须大尺寸（viewBox 至少 1920x1080）、多元素、有动画 — 简单几条线 = 3.25
5. 用 [PUA生效 🔥] 标记额外完成的工作
6. 不做 NPC — 发现问题主动修复，发现优化点主动加上
```

## 执行流程

### Phase 1: 收集项目信息

如果用户已经提供了项目信息（名称、简介、代币等），直接解析。

如果信息不完整，用 `AskUserQuestion` 一次性收集缺失的：

```
必填：
- 项目名称
- 一句话简介
- 代币符号和总量
- 合约地址
- 社交链接（推特、TG、Discord 等）

可选：
- 品牌色（不提供则根据风格生成）
- Logo SVG（不提供则生成文字 Logo）
- 额外页面需求
```

### Phase 2: 问用户两个关键问题（用 AskUserQuestion）

#### 问题 1: 项目类别
```
你的项目属于哪个类别？
A) DeFi — 去中心化金融（DEX、借贷、质押）
B) GameFi — 链游、Play-to-Earn
C) SocialFi — 社交+金融
D) Move2Earn — 运动赚币
E) Meme — 迷因币
F) NFT — NFT 项目/平台
G) Infrastructure — 基础设施/工具链
H) DAO — 去中心化组织
```

#### 问题 2: 设计风格
根据用户选的类别，推荐 3-4 个最匹配的风格，让用户选。展示预览描述：

**DeFi 推荐：**
- Dark+Neon — 纯黑背景+霓虹发光，赛博朋克科技感（Uniswap/Phantom 风格）
- Glassmorphism — 毛玻璃半透明，轻盈高级感（iOS 风格）
- Aurora — 极光流动背景，梦幻科幻
- Gradient Mesh — 多点渐变，流动色彩（Stripe 风格）

**GameFi 推荐：**
- 3D Immersive — WebGL 沉浸式，全屏3D场景
- Dark+Neon — 霓虹赛博朋克
- Scroll Storytelling — 电影级滚动叙事
- Parallax — 多层视差，景深动感

**SocialFi 推荐：**
- Bento Grid — 便当盒布局，信息密度高（Linear 风格）
- Gradient Mesh — 流动渐变，现代感
- Big Typography — 巨型排版冲击
- Minimalism — 极简留白

**Move2Earn 推荐：**
- Aurora — 极光流动+活力感
- Organic Shapes — 有机曲线+自然活力
- Gradient Mesh — 渐变+动感
- Scroll Storytelling — 故事化产品展示

**Meme 推荐：**
- Brutalism — 野蛮主义反叛感
- Big Typography — 大字冲击
- Dark+Neon — 霓虹狂欢
- Kinetic Typography — 文字疯狂动起来

**NFT 推荐：**
- Infinite Gallery — 无限滚动画廊
- Dark+Neon — 暗黑氛围
- Horizontal Scroll — 横向画廊体验
- Masked Image — 图片遮罩创意

**Infrastructure 推荐：**
- Minimalism — 专业克制
- Bento Grid — 模块化展示
- Card Stacking — 功能层叠
- Neumorphism — 控制面板感

**DAO 推荐：**
- Dark+Neon — 科技治理感
- Card Stacking — 提案层叠
- Layered Paper — 文档层次
- Aurora — 梦幻共治

### Phase 3: 加载风格预设 + 素材库（自动）

根据用户选择的风格：
1. 读取 `~/.claude/styles-presets/{序号}-{风格名}.md`
2. 提取 CSS Variables、Tailwind Config、Core CSS Classes、Component Patterns
3. 读取 `~/.claude/styles-presets/svg-components.md` 获取 SVG 动效组件库
4. 根据风格选择最匹配的 SVG 动效组合（参考 svg-motion-designer agent 的风格映射表）
5. **加载 3D 玻璃素材库**：读取 `/Users/heart/Desktop/图片储存/建站素材/.catalog/index.json`
6. 根据项目类别选择素材分类（参考素材选择策略表）

### Phase 4: 初始化项目（自动）

用 Bash 执行：
```bash
mkdir -p {projectSlug}/src/{app/{about,features,tokenomics,community},components/{svg,sections,ui,layout},styles,lib,hooks}
mkdir -p {projectSlug}/public/assets/{decorations,icons,backgrounds}
```

生成基础配置文件：
- `package.json` — Next.js 15 + TypeScript + Tailwind CSS v3（⚠️ 禁止 v4，大量 CSS 会失效）+ GSAP + Framer Motion + lucide-react + lottie-web + vivus + three + @react-three/fiber
- `tailwind.config.ts` — 注入风格预设的 extend 配置（Tailwind v3 格式）
- `tsconfig.json`
- `next.config.ts`
- `src/styles/globals.css` — 注入风格 CSS Variables
- `src/styles/style-preset.css` — 风格专属 CSS 类
- `src/styles/animations.css` — 动画关键帧
- `.style-config.json` — 风格元数据
- `src/lib/constants.ts` — 项目常量（名称、合约、链接等）
- `src/lib/metadata.ts` — SEO 元数据配置

### Phase 5: Agent Teams 并行构建（核心 — 必须 5 个 Agent 同时启动）

**用 Agent tool 同时发起 5 个 agent，run_in_background=true：**

#### Agent 1: SVG 动效 + 动画库集成
```
subagent_type: general-purpose
mode: bypassPermissions
任务：根据 {选定风格} 为 {项目名} 生成全套动效组件
⚠️ 质量红线：简单的几条线/几个圆 = 不合格。每个 SVG 必须复杂精美，至少 50+ SVG 元素。

**Part A: SVG React 组件**
参考 ~/.claude/styles-presets/svg-components.md 中的 20 种组件
根据风格调整颜色使用 CSS Variables var(--primary) var(--accent) 等

必须生成：
1. HeroBackground.tsx — 全屏动态 SVG 背景（匹配风格）
2. FloatingDecor.tsx — 2-3 个浮动装饰元素
3. SectionDivider.tsx — 波浪/斜切分隔器
4. TokenGlow.tsx — 代币脉冲/光环动效
5. GridBackground.tsx — 网格/粒子背景
6. index.ts — 统一导出

输出到 src/components/svg/
所有颜色用 CSS Variables，不硬编码
viewBox 统一 0 0 1920 1080（Hero）或 0 0 1920 200（Divider）

**Part B: 动画库组件（按需使用）**
7. LottieAnimation.tsx — lottie-web 封装组件（懒加载 + 交叉观察器触发）
8. SvgDrawAnimation.tsx — vivus 封装（SVG 路径绘制动画，用于 Logo 入场/图标入场）
9. Scene3D.tsx — @react-three/fiber 3D 场景组件（仅 GameFi/Metaverse 类项目需要）

动画库选用策略：
- Logo/图标入场 → vivus（SVG 路径绘制）
- 复杂序列动画 → lottie-web（JSON 动画）
- 3D 装饰/GameFi → react-three-fiber
- 滚动动画/交互动画 → GSAP ScrollTrigger
- 入场/过渡动画 → Framer Motion

开工前用 Read 工具读取 ~/.claude/skills/pua/SKILL.md，按 P8 行为协议执行。
你是 P8 级别。SVG 必须复杂精美（50+ 元素），简单几条线 = 3.25。
每个组件必须有 CSS animation 或 Framer Motion 动画。没动画 = 偷懒。
完成后自检：viewBox 够大吗？元素够多吗？动画够流畅吗？颜色用 CSS Variables 了吗？
```

#### Agent 5: 3D 玻璃素材选取 + 集成
```
subagent_type: general-purpose
mode: bypassPermissions
任务：从本地 3D 玻璃素材库中选取最匹配的素材，压缩后集成到项目
⚠️ 质量红线：必须选 5-8 个素材，不能只选 1-2 个。每个素材要有悬浮动画 + 发光效果。

素材库路径：/Users/heart/Desktop/图片储存/建站素材/
联系表路径：/Users/heart/Desktop/图片储存/建站素材/.catalog/sheets/
索引文件：/Users/heart/Desktop/图片储存/建站素材/.catalog/index.json

按项目类别选择分类：
| 项目类别 | 首选素材分类 | 备选 |
|----------|------------|------|
| DeFi/Web3 | 627W镭射玻璃, 1237镀铬形状 | 704W科幻晶体 |
| GameFi | 704W科幻晶体, 627W镭射玻璃 | 1237镀铬形状 |
| SocialFi | 35Y玻璃晶体, G314透明玻璃 | Abstract Shapes |
| NFT | 447A艺术玻璃, 5082立体抽象 | 627W镭射玻璃 |
| Meme | 5082立体抽象, Abstract Shapes | 751W艺术图形 |
| Infrastructure | 503抽象立体金属, G314透明玻璃 | 35Y玻璃晶体 |
| DAO | 1237镀铬形状, G314透明玻璃 | 503抽象立体金属 |

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

#### Agent 2: 页面结构
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
- 每个 section 之间用 SectionDivider
- metadata 导出 SEO 信息
- Hero 区必须有：SVG 动态背景 + 3D 玻璃素材装饰 + 渐变/发光标题 + 入场动画
- 每个 section 必须有 Framer Motion whileInView 入场动画

开工前用 Read 工具读取 ~/.claude/skills/pua/SKILL.md，按 P8 行为协议执行。
你是 P8 级别。页面必须精美 — 纯文字列表 = 偷懒 = 3.25。
每个 section 要有视觉冲击力：背景效果 + 动画 + 装饰元素。
```

#### Agent 3: 组件库
```
subagent_type: general-purpose
mode: bypassPermissions
任务：创建 {项目名} 的全部 React 组件，使用 {风格} 预设
⚠️ 质量红线：每个组件必须有 Framer Motion 入场动画 + TypeScript 类型。没动画 = 偷懒。

布局组件 src/components/layout/：
1. Header.tsx — 固定导航栏，Logo+菜单+钱包连接按钮+社交图标，滚动时背景变化
2. Footer.tsx — 页脚，Logo+链接+社交+合约地址+版权

区块组件 src/components/sections/：
3. Hero.tsx — 全屏 Hero，SVG 背景 + 大标题 + 简介 + CTA 按钮 + 向下箭头
4. Features.tsx — 功能网格/Bento，每个功能用 SVG 图标+标题+描述
5. Stats.tsx — 数据统计区，数字滚动动画（总量/持有者/交易量/市值）
6. Tokenomics.tsx — 代币分配 SVG 环形图 + 分配详情表
7. Community.tsx — 社交卡片网格（推特/TG/Discord 等）
8. CTA.tsx — 行动号召区，SVG 背景 + 大标题 + 按钮
9. Roadmap.tsx — 路线图时间线（SVG 连线+阶段节点）

UI 组件 src/components/ui/：
10. Button.tsx — 风格化按钮（primary/secondary/outline/ghost）
11. Card.tsx — 风格化卡片
12. GlowText.tsx — 发光/渐变文字
13. AnimatedCounter.tsx — 数字滚动计数器
14. SocialIcon.tsx — 社交媒体 SVG 图标组件

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

#### Agent 4: 配置与 SEO
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
```

### Phase 6: 组装验证（等 5 个 Agent 完成后）

1. 检查所有 import 路径是否正确
2. 确保 SVG 组件被引入到页面
3. 若配置了素材库，确保 3D 玻璃素材正确引用到 Hero/Feature/CTA 区域
4. 确保 globals.css 包含所有 CSS Variables
5. 确保动画库组件正确懒加载
6. 修复任何 TypeScript 类型错误
7. 运行 `pnpm install && pnpm build` 验证

## 关键约束

### 视觉素材强制规则
**每个网站必须同时使用 SVG 动效 + 3D 玻璃素材 + 动画库，三者缺一不可：**

| 素材类型 | 用途 | 来源 |
|----------|------|------|
| SVG 动画组件 | 背景动效、分隔器、脉冲效果 | svg-components.md（代码生成） |
| 3D 玻璃素材 | Hero 装饰、Feature 图标、视觉焦点 | /Users/heart/Desktop/图片储存/建站素材/（879张PNG） |
| 动画库 | Logo 入场(vivus)、复杂动效(lottie)、3D场景(R3F) | npm 包 |
| GSAP | 滚动驱动动画、时间线编排 | npm 包（已集成） |
| Framer Motion | 组件入场/退出/布局动画 | npm 包（已集成） |

- Logo → SVG 文字组合 + vivus 路径绘制入场
- 图标 → Lucide React SVG 或 3D 玻璃素材图标
- 背景 → SVG 动画 + CSS gradient + 3D 玻璃装饰悬浮
- 图表 → SVG 绘制
- 装饰 → 3D 玻璃素材（悬浮动画 + 发光效果）+ SVG 动效叠加

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

## 相关技能
`pick-style`, `gen-svg`, `setup-stack`, `connect-wallet`, `design-system`
