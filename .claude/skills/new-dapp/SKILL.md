---
name: new-dapp
description: "一键建 DApp — 问类型和风格，Agent Teams 并行出全套（钱包连接+合约交互+全SVG界面）"
tools: Read, Glob, Grep, Write, Edit, Bash, AskUserQuestion, Agent
---

# New DApp — 一键建 DApp

## 核心原则

**只问 DApp 类型 + 设计风格，问完后 Agent Teams 全自动并行出全套可运行 DApp。**

## 执行流程

### Phase 1: 收集项目信息

如果用户已提供项目信息，直接解析。缺失的用 `AskUserQuestion` 一次性收集：

```
必填：
- 项目名称
- 一句话简介
- 代币符号和总量（如有）
- 合约地址（已部署的，或标注"待部署"）
- 社交链接（推特、TG 等）

可选：
- 已有智能合约 ABI（如有则直接导入）
- 品牌色
```

### Phase 2: 问用户三个关键问题

#### 问题 1: DApp 类型
```
你要做什么类型的 DApp？
A) DEX / Swap — 代币兑换（PancakeSwap 风格）
B) Staking / Yield — 质押挖矿、收益农场
C) Lending / Borrowing — 借贷协议（Aave 风格）
D) NFT Marketplace — NFT 买卖、拍卖
E) DAO / Governance — 提案投票治理
F) Launchpad — 代币发射平台（Pinksale 风格）
G) Bridge — 跨链桥
H) Portfolio / Dashboard — 资产管理看板
I) Custom — 自定义（让用户描述）
```

#### 问题 2: 设计风格
根据 DApp 类型推荐风格：

| DApp 类型 | 推荐风格 |
|-----------|---------|
| DEX/Swap | Dark+Neon, Glassmorphism, Aurora |
| Staking | Dark+Neon, Bento Grid, Gradient Mesh |
| Lending | Minimalism, Glassmorphism, Card Stacking |
| NFT Marketplace | Infinite Gallery, Dark+Neon, Horizontal Scroll |
| DAO | Dark+Neon, Card Stacking, Layered Paper |
| Launchpad | Aurora, Dark+Neon, Gradient Mesh |
| Bridge | Glassmorphism, Minimalism, Aurora |
| Dashboard | Bento Grid, Glassmorphism, Neumorphism |

#### 问题 3: 合约状态
```
你的智能合约情况？
A) 已部署 — 给我合约地址和 ABI，我直接对接
B) 需要写合约 — 我帮你写 + 部署
C) 只要前端 — 先做界面，合约后面再说
```

### Phase 3: 加载风格预设 + 素材库（自动）

1. 读取 `~/.claude/styles-presets/{序号}-{风格名}.md`
2. 读取 `~/.claude/styles-presets/svg-components.md`
3. 确定 DApp 类型对应的 SVG 动效组合
4. **加载 3D 玻璃素材库**：读取 `/Users/heart/Desktop/图片储存/建站素材/.catalog/index.json`
5. 根据 DApp 类型选择素材分类（参考素材选择策略表）

### Phase 4: 初始化项目（自动）

```bash
mkdir -p {projectSlug}/src/{
  app/{swap,pool,stake,dashboard,governance},
  components/{svg,sections,ui,layout,web3},
  contracts/{abis,hooks},
  styles,
  lib/{web3,utils},
  hooks
}
mkdir -p {projectSlug}/public/assets/{decorations,icons,backgrounds}
```

生成基础配置：
- `package.json` — Next.js 15 + wagmi v2 + viem + RainbowKit + @tanstack/react-query + GSAP + Framer Motion + lottie-web + vivus + three + @react-three/fiber
- `tailwind.config.ts` — 风格预设
- `src/styles/globals.css` — CSS Variables
- `src/styles/style-preset.css` — 风格类
- `.style-config.json` — 风格配置
- `src/lib/constants.ts` — 项目常量
- `src/lib/web3/config.ts` — wagmi config（BSC Mainnet + Testnet）
- `src/lib/web3/chains.ts` — 链配置
- `src/lib/web3/formatters.ts` — 地址/金额/时间格式化

### Phase 5: Agent Teams 并行构建（必须 6 个 Agent 同时启动）

#### Agent 1: SVG 动效 + 动画库集成
```
subagent_type: general-purpose
参考 ~/.claude/styles-presets/svg-components.md

**Part A: DApp 专用 SVG 组件**
1. HeroBackground.tsx — DApp 首页动态背景
2. DashboardGrid.tsx — 仪表盘网格背景
3. TransactionPulse.tsx — 交易脉冲动效（每次交易触发）
4. TokenFlow.tsx — 代币流动路径动画（适合 DEX/Bridge）
5. StakingOrbit.tsx — 质押轨道动画（适合 Staking）
6. SectionDivider.tsx — 分隔器
7. LoadingSpinner.tsx — 加载动效（SVG 旋转）
8. EmptyState.tsx — 空状态插画（SVG）
9. index.ts — 统一导出

**Part B: 动画库封装组件**
10. LottieAnimation.tsx — lottie-web 封装（懒加载 + 交叉观察器）
11. SvgDrawAnimation.tsx — vivus 封装（Logo/图标路径绘制入场）
12. Scene3D.tsx — @react-three/fiber 3D 场景（仅需要时）

动画库选用：
- Logo/图标入场 → vivus
- 复杂序列动画 → lottie-web
- 3D 装饰 → react-three-fiber
- 滚动动画 → GSAP ScrollTrigger
- 入场/过渡 → Framer Motion

全部颜色用 CSS Variables
输出到 src/components/svg/
```

#### Agent 6: 3D 玻璃素材选取 + 集成
```
subagent_type: general-purpose
任务：从本地 3D 玻璃素材库选取素材，压缩集成到 DApp 项目

素材库：/Users/heart/Desktop/图片储存/建站素材/
联系表：/Users/heart/Desktop/图片储存/建站素材/.catalog/sheets/
索引：/Users/heart/Desktop/图片储存/建站素材/.catalog/index.json

按 DApp 类型选择：
| DApp 类型 | 首选素材 | 备选 |
|-----------|---------|------|
| DEX/Swap | 627W镭射玻璃, 1237镀铬形状 | 704W科幻晶体 |
| Staking | 1237镀铬形状, G314透明玻璃 | 503抽象立体金属 |
| Lending | G314透明玻璃, 35Y玻璃晶体 | 503抽象立体金属 |
| NFT Marketplace | 447A艺术玻璃, 5082立体抽象 | 627W镭射玻璃 |
| DAO | 503抽象立体金属, G314透明玻璃 | 1237镀铬形状 |
| Launchpad | 627W镭射玻璃, 5082立体抽象 | Abstract Shapes |
| Bridge | 704W科幻晶体, 1237镀铬形状 | 627W镭射玻璃 |
| Dashboard | G314透明玻璃, Abstract Shapes | 35Y玻璃晶体 |

执行：
1. 查看联系表选 5-8 个素材
2. magick 压缩转 WebP（Hero 800-1200px, 图标 200-400px, 装饰 100-200px）
3. 输出到 public/assets/
4. 生成 src/lib/assets.ts — 素材路径常量
5. 生成 src/components/ui/GlassDecor.tsx — 玻璃装饰组件
```

#### Agent 2: Web3 核心层
```
subagent_type: general-purpose
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
```

#### Agent 3: DApp 页面结构（根据类型生成不同页面）

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

**DAO：**
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

所有页面使用风格预设 className + SVG 组件 + Framer Motion 动画

#### Agent 4: UI 组件库
```
subagent_type: general-purpose

布局 src/components/layout/：
1. Header.tsx — 导航 + ConnectButton + 链信息
2. Footer.tsx — 链接 + 社交 + 合约地址
3. Sidebar.tsx — DApp 侧边导航（可选）

区块 src/components/sections/：
4. Hero.tsx — DApp Hero（SVG 背景 + 统计数据 + CTA）
5. Stats.tsx — 链上统计（TVL/Volume/Users/APY）
6. Features.tsx — 功能介绍

UI src/components/ui/：
7. Button.tsx — 风格化按钮
8. Card.tsx — 风格化卡片
9. Input.tsx — 风格化输入框（数字输入 + Max按钮）
10. TokenSelector.tsx — 代币选择器（搜索 + Logo + 余额）
11. SlippageSettings.tsx — 滑点设置弹窗
12. Modal.tsx — 模态框
13. Tabs.tsx — 标签页
14. Table.tsx — 数据表格
15. Badge.tsx — 状态标签
16. Tooltip.tsx — 提示框
17. Skeleton.tsx — 骨架屏加载
18. AnimatedCounter.tsx — 数字滚动
19. GlowText.tsx — 发光文字
20. ProgressBar.tsx — 进度条（质押进度/募集进度）

所有组件 TypeScript + 风格 className + 响应式
```

#### Agent 5: 合约集成层（根据问题3的回答决定）

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

### Phase 6: 组装验证

等 6 个 Agent 完成后：
1. 确保 WalletProvider 包裹整个 app
2. 确保所有 SVG 组件正确引入
3. 确保 3D 玻璃素材正确引用到 Hero/Stats/功能区
4. 确保动画库组件正确懒加载
5. 确保 Web3 hooks 正确连接
6. 修复 import 路径和类型错误
7. `pnpm install && pnpm build` 验证

## 关键约束

### 视觉素材强制规则
**每个 DApp 必须同时使用 SVG 动效 + 3D 玻璃素材 + 动画库，三者缺一不可：**

| 素材类型 | 用途 | 来源 |
|----------|------|------|
| SVG 动画组件 | 背景动效、交易脉冲、加载动画 | svg-components.md（代码生成） |
| 3D 玻璃素材 | Hero 装饰、功能图标、空状态插画 | /Users/heart/Desktop/图片储存/建站素材/（879张PNG） |
| 动画库 | Logo 入场(vivus)、复杂动效(lottie)、3D场景(R3F) | npm 包 |
| GSAP | 滚动驱动动画、数据可视化动效 | npm 包 |
| Framer Motion | 组件入场/退出/页面过渡 | npm 包 |

- 代币 Logo → SVG 圆形+文字 + vivus 路径绘制入场
- 空状态 → SVG 插画 + 3D 玻璃装饰
- Loading → SVG 动画（TransactionPulse/LoadingSpinner）
- 背景 → SVG 动效 + 3D 玻璃素材悬浮
- 图标 → Lucide React + 3D 玻璃素材图标

### Web3 UX 标准
- 所有链上操作必须有 loading/success/error 状态
- 交易前必须显示 gas 估算
- 代币操作前检查 allowance
- 链 ID 不对自动提示切链
- 断开钱包后清空状态
- 错误消息要用户友好，不直接显示合约报错

### 风格强制
- 颜色只用 CSS Variables
- className 必须来自风格预设
- 不允许 Tailwind 默认色

## 相关技能
`connect-wallet`, `deploy-contract`, `contract-review`, `pick-style`, `gen-svg`, `new-site`
