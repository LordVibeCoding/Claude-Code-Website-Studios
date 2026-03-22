---
name: new-site
description: "一键建站 — 问几个关键问题，然后 Agent Teams 全自动并行出全站"
tools: Read, Glob, Grep, Write, Edit, Bash, AskUserQuestion, Agent
---

# New Site — 一键建站

## 核心原则

**只问关键决策，问完后全自动。Agent Teams 并行构建，零等待。**

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

### Phase 3: 加载风格预设（自动）

根据用户选择的风格：
1. 读取 `~/.claude/styles-presets/{序号}-{风格名}.md`
2. 提取 CSS Variables、Tailwind Config、Core CSS Classes、Component Patterns
3. 读取 `~/.claude/styles-presets/svg-components.md` 获取 SVG 动效组件库
4. 根据风格选择最匹配的 SVG 动效组合（参考 svg-motion-designer agent 的风格映射表）

### Phase 4: 初始化项目（自动）

用 Bash 执行：
```bash
mkdir -p {projectSlug}/src/{app/{about,features,tokenomics,community},components/{svg,sections,ui,layout},styles,lib,hooks}
```

生成基础配置文件：
- `package.json` — Next.js 15 + TypeScript + Tailwind 4 + GSAP + Framer Motion + lucide-react
- `tailwind.config.ts` — 注入风格预设的 extend 配置
- `tsconfig.json`
- `next.config.ts`
- `src/styles/globals.css` — 注入风格 CSS Variables
- `src/styles/style-preset.css` — 风格专属 CSS 类
- `src/styles/animations.css` — 动画关键帧
- `.style-config.json` — 风格元数据
- `src/lib/constants.ts` — 项目常量（名称、合约、链接等）
- `src/lib/metadata.ts` — SEO 元数据配置

### Phase 5: Agent Teams 并行构建（核心 — 必须 4 个 Agent 同时启动）

**用 Agent tool 同时发起 4 个 agent，run_in_background=true：**

#### Agent 1: SVG 动效全套
```
subagent_type: general-purpose
任务：根据 {选定风格} 为 {项目名} 生成全套 SVG React 组件
参考 ~/.claude/styles-presets/svg-components.md 中的 8 种基础组件
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
```

#### Agent 2: 页面结构
```
subagent_type: general-purpose
任务：创建 {项目名} 的所有页面，使用 {风格} 预设样式

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
```

#### Agent 3: 组件库
```
subagent_type: general-purpose
任务：创建 {项目名} 的全部 React 组件，使用 {风格} 预设

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
- Framer Motion 入场动画
- 移动端响应式
```

#### Agent 4: 配置与 SEO
```
subagent_type: general-purpose
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

### Phase 6: 组装验证（等 4 个 Agent 完成后）

1. 检查所有 import 路径是否正确
2. 确保 SVG 组件被引入到页面
3. 确保 globals.css 包含所有 CSS Variables
4. 修复任何 TypeScript 类型错误
5. 运行 `pnpm install && pnpm build` 验证

## 关键约束

### 零图片原则
- **整个网站不使用任何 PNG/JPG/WebP 图片**
- Logo → SVG 文字组合
- 图标 → Lucide React SVG 或自绘 SVG
- 背景 → SVG 动画 + CSS gradient
- 图表 → SVG 绘制
- 装饰 → CSS + SVG

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
