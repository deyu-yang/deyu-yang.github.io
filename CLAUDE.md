# CLAUDE.md

这个文件是写给 Claude Code 的项目说明。每次在本文件夹中启动 Claude Code 时会被自动读取。

## 项目背景

- 用户：香港科技大学（HKUST）机械工程专业博士新生，非计算机专业背景。有基础电脑知识，但不熟悉 Git、命令行（command line）和网页开发（web development）。
- 项目：基于 [al-folio](https://github.com/alshedivat/al-folio) 模板的个人学术主页。
  - GitHub 仓库（repository）：`deyu-yang/deyu-yang.github.io`
  - 网站地址：<https://deyu-yang.github.io>
  - 本地路径：`X:\Claude\Projects\personal-website`
- **网站内容一律使用英文**；与用户的交流使用中文。
- 环境：Windows 11，Claude 桌面应用，PowerShell 5.1。

## 合作方式（必须遵守）

1. **先检查、再计划、等确认**：开始新任务前，先检查相关环境和文件，给出分步计划，等用户确认后再执行。
2. **每一步前先说明**：执行任何一步之前，用通俗的中文说明要做什么、为什么这样做；专业术语给出英文原文，例如"提交（commit）"。
3. **登录和密码由用户自己完成**：凡是需要登录 GitHub 或输入密码的环节，只告诉用户怎么操作，由用户亲自完成。不要代为输入任何凭据。
4. **每个阶段提交一次**：每完成一个阶段，做一次 Git 提交（commit），并用中文告诉用户这次提交保存了什么。
5. **保持本文件更新**：阶段完成或合作方式有变化时，更新下面的"当前进度"等内容。

## 当前进度

- [x] 第一阶段（2026-09-24 完成）：用 al-folio 默认内容让网站在 deyu-yang.github.io 上线
  - [x] 安装 Git，设置署名；用模板创建仓库；克隆到本地
  - [x] 修改 `_config.yml`：`url: https://deyu-yang.github.io`，`baseurl` 留空
  - [x] 推送后由 GitHub Actions 发布到 `gh-pages` 分支，开启 GitHub Pages（Source：`gh-pages` / root），确认网站可以访问
- 待处理的小问题：
  - "Lighthouse Badger" 工作流运行失败（它只负责生成网站性能评分徽章，不影响发布），以后查明原因或关闭它
  - `_pages/about.md` 的示例文字里写死了 `/al-folio/publications/` 链接，填写个人简介时会一并替换
- [x] 第二阶段 A（2026-09-24 完成）：用 Docker 本地预览
- [ ] 第二阶段 B（进行中）：基础个人信息（名字、简介、照片、联系方式、社交链接）
- [ ] 以后的阶段（计划中）：论文列表（publications）、简历（CV）、新闻（news）、清理示例页面等

## 本地预览（local preview）

在项目根目录下运行以下命令：

- 前提：先打开 **Docker Desktop**，等到显示 "Engine running"。
- 启动：`docker compose up -d`，然后打开 <http://localhost:8080>。首次生成网站大约需要 40 秒。镜像 `amirpourmand/al-folio:latest`（1.47 GB）已经下载好了。
- 查看状态和日志：`docker compose ps`、`docker compose logs --tail 30`。日志中出现 `done in xx seconds` 表示网站生成完成。
- 停止：`docker compose down`。
- 修改文件后会自动重新生成；Windows 上一般需要等十几秒到一分钟，然后刷新浏览器。**改了 `_config.yml` 以后容器会自动重启**，需要等得更久一些。
- 预览产生的 `.jekyll-cache/`、`.tweet-cache/` 已被 `.gitignore` 排除，不会被提交。
- 以后要更新镜像时运行 `docker compose pull`，可以用 `docker image prune` 清理旧镜像（清理前先确认）。

## 关键技术要点

- **Git 署名**：`deyu-yang` / `180747901+deyu-yang@users.noreply.github.com`（GitHub 隐私邮箱，不要换成个人邮箱）。
- **发布流程**：推送（push）到 `main` 分支后，`.github/workflows/deploy.yml`（"Deploy site"）会生成网站并写入 `gh-pages` 分支，GitHub Pages 再从 `gh-pages` 分支发布。整个过程大约需要 3 到 5 分钟。
- **baseurl 必须留空**：`AGENTS.md` 里说 "baseurl 是 `/al-folio`、清空会出错"，这条只适用于模板仓库本身，**不适用于本网站**。本网站位于域名根目录。
- **推送凭据**：Claude 的命令窗口无法弹出登录框。首次推送由用户在自己的 PowerShell 中完成登录，凭据保存在 Windows 凭据管理器中。如果凭据失效，请用户自己在 PowerShell 中运行 `git push` 重新登录。
- **推送前先 `git pull`**：模板里的一些工作流（例如 `update-tocs.yml`）可能会自动往 `main` 提交。如果本地没有同步，推送会被拒绝。
- **Prettier 等检查失败不影响发布**：Actions 中 Prettier、链接检查等出现红色 ❌ 时，网站仍然可以正常发布，可以之后再处理。
- **Windows 上找不到 git 时**：Claude 的 PowerShell 窗口不会自动更新 PATH，每条命令前先运行：
  `$env:Path = [Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [Environment]::GetEnvironmentVariable('Path','User')`
- **本地没有安装 Ruby / Node.js**：一律用 Docker 预览（见上文），不要在 Windows 上直接安装 Ruby。
- **本文件已在 `_config.yml` 的 `exclude` 列表中**，不会被发布成网页。

## 技术参考（需要时查阅）

以下文件来自 al-folio 模板，主要写给模板开发者看。其中部分规则（如 baseurl、测试命令）并不适用于个人网站。

- [`AGENTS.md`](AGENTS.md)：模板的结构和修改规则
- [`docs/CUSTOMIZE.md`](docs/CUSTOMIZE.md)：如何自定义网站内容
- [`docs/INSTALL.md`](docs/INSTALL.md)：安装、部署与本地预览
- [`docs/FAQ.md`](docs/FAQ.md)：常见问题
- [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md)：模板与插件（gem）的关系
