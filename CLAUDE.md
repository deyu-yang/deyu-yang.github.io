# CLAUDE.md

这个文件是写给 Claude Code 的项目说明。每次在本文件夹中启动 Claude Code 时会被自动读取。

## 项目背景

- 用户：香港科技大学（HKUST）机械工程专业博士新生，非计算机专业背景。有基础电脑知识，但不熟悉 Git、命令行（command line）和网页开发（web development）。
- 项目：基于 [al-folio](https://github.com/alshedivat/al-folio) 模板的个人学术主页。
  - GitHub 仓库（repository）：`deyu-yang/deyu-yang.github.io`
  - 网站地址：<https://deyu-yang.github.io>
  - 本地路径：`X:\Claude\Projects\personal-website`
- **网站内容以英文为主**；例外：摄影页的照片标题和回忆**中英并列**（用户的中文原文 + Claude 的英文翻译）。与用户的交流使用中文。
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
  - PR 上的 "Visual regression checks" **永远会失败**：它要和模板的 `v0.16.3` 版本对比截图，但本仓库是用模板创建的，没有这个版本标记（报错 `fatal: invalid reference: v0.16.3`）。这是给模板开发者用的检查，可以忽略，以后和 Lighthouse Badger 一起关闭
  - `_pages/about_einstein.md` 等示例页面、示例文章和项目仍在仓库里：已从导航栏隐藏，但知道网址仍能打开，右上角搜索（ctrl k）也能搜到。以后"清理示例内容"时一起删除
- [x] 第二阶段 A（2026-09-24 完成）：用 Docker 本地预览
- [x] 第二阶段 B（2026-09-24 完成）：基础个人信息
  - 名字 Deyu Yang；副标题为 MAE 系 PhD 学生（纯文字，还没加系网站链接）；英文简介；照片
  - 首页隐藏了示例论文、博客和社交图标（`about.md` 中的 `selected_papers` / `latest_posts` / `social` 都设为 false）；新闻只保留一条上线公告
  - `_data/socials.yml` 所有条目都已注释掉（用户暂不公开邮箱或其他链接）
  - 还没做：导师 / 研究方向、邮箱与社交链接、浏览器标签图标 favicon（目前是 ⚛️）
- [x] 第三阶段（2026-09-25 完成，分支 `feature/nav-and-photography`，第一次用 PR 合并）：精简导航栏 + 摄影页
  - 导航栏只保留 about 和 photography；其他 8 个示例页面设为 `nav: false`（文件保留，改回 `true` 即可恢复）
  - `_config.yml` 的 `scholar:` 已改为 `last_name: [Yang]`、`first_name: [Deyu, D.]`
  - README 顶部加了个人介绍，模板原文保留在下方
  - 新增摄影页 `/photography/`：11 张照片、中英标题、5 条中英回忆（详见下面"摄影页"一节）
- [ ] 以后的阶段（计划中）：
  - 论文列表（publications）、简历（CV）、新闻（news）、清理示例内容
  - **照片故事长文（D）**：为较长的回忆写博客文章（一次旅行一篇）。需要先清理示例文章、重新启用 blog 栏目；`_data/photography.yml` 可加一项指向对应文章，让照片和故事互相链接；回忆本里的"完整回忆"可作为草稿
  - 浏览器标签图标 favicon（用户暂时不换，仍是 ⚛️）

## 本地预览（local preview）

在项目根目录下运行以下命令：

- 前提：先打开 **Docker Desktop**，等到显示 "Engine running"。
- 启动：`docker compose up -d`，然后打开 <http://localhost:8080>。首次生成网站大约需要 40 秒。镜像 `amirpourmand/al-folio:latest`（1.47 GB）已经下载好了。
- 查看状态和日志：`docker compose ps`、`docker compose logs --tail 30`。日志中出现 `done in xx seconds` 表示网站生成完成。
- 停止：`docker compose down`。
- 修改普通文件（页面、图片、`_data`、`_news` 等）后会自动重新生成，一般需要十几秒到一分钟。浏览器**不会自动刷新**（livereload 被网站的安全策略拦截了），需要手动刷新。
- **改了 `_config.yml` 后必须手动运行 `docker compose restart`**：容器的自动重启依赖 inotify 监听文件变化，但它在 Windows 文件夹上不起作用。重启后大约 20 秒生成完成。
- 日志里的 `directory is already being watched` 和 `template_error` 都不是错误，可以忽略。
- 预览产生的 `.jekyll-cache/`、`.tweet-cache/` 已被 `.gitignore` 排除，不会被提交。
- 以后要更新镜像时运行 `docker compose pull`，可以用 `docker image prune` 清理旧镜像（清理前先确认）。

## 摄影页（photography）

### 文件分工

- `_pages/photography.md`：页面本身。网格排列缩略图，点击后用 Spotlight 全屏浏览（大图只显示中英标题 · 年份 + 拍摄参数）。有回忆的照片，缩略图下方有可展开的"回忆 · Memory"。
- `_data/photography.yml`：**照片清单，平时只改这个文件**。按日期从新到旧排列。每条的字段：`file`、`date`、`title_zh` / `title_en`、`alt`（英文替代文字）、拍摄参数、可选的 `memory_zh` / `memory_en`。每条上方的 `#` 中文注释是给用户看的画面描述，不会显示在网站上。
- `assets/img/photography/`：网页版照片（长边 2000 像素，约 0.4–0.7 MB）。缩略图（480/800/1400 宽的 WebP）由模板自动生成，不用手动做。
- `bin/photo-web-version.sh`：照片处理脚本（`bin/` 在 `_config.yml` 的 exclude 列表里，不会被发布）。**不要放进 `_scripts/`**：模板的 Integration tests 规定 `_scripts`、`_includes`、`_layouts`、`_sass` 等文件夹名由插件专用，个人网站占用会导致检查失败。

### 本地文件（不在仓库里）

- 原片：`X:\Claude\Photos-for-projects\Photos-for-personal-webpage\gallery\`（头像原图在同级的 `profile\`，不放进摄影页）
- **私人回忆本**：`X:\Claude\Photos-for-projects\Photos-for-personal-webpage\回忆.md`。每张照片分"完整回忆"（只给自己看，**绝不上传**）和"网站版"（用户愿意公开的部分）。
- ExifTool：`X:\Claude\Tools\exiftool-13.59\`（从官方 GitHub 仓库下载的源码版，在 Docker 里用 Perl 运行；exiftool.org 在用户网络下连不上）
- 在 Mac 上这些路径都不存在：回忆可以请用户直接在对话里发过来；原片需要用户在 Mac 上另建同样结构的文件夹。

### 添加新照片的流程

1. 用户把导出的 JPEG（或 HEIC）放进 `gallery\`。RAW 文件要先在 Lightroom / 照片 App 里导出成 JPEG。
2. 运行处理脚本（用法写在脚本开头）。它会跳过已处理的照片，最后检查有没有残留的序列号、GPS 和厂商私有数据。
   - **全部元数据清除后，只写回**：相机、镜头、焦距、光圈、快门、ISO、拍摄时间、色彩空间，以及统一的作者 `Deyu Yang` 和版权 `© <拍摄年份> Deyu Yang. All rights reserved.`（EXIF、IPTC、XMP 三种标准都写）。
   - **不写社交账号**。相机里旧的版权设置（`@deyu1729`、`deyurainsnowindfrost`）不要沿用。
3. Claude 看照片，起草英文替代文字、中英标题和中文注释，**请用户确认**。
4. 在 `_data/photography.yml` 里按日期加一条 → 本地预览 → 提交。

### 添加或修改回忆的流程

1. 用户在 `回忆.md` 的"网站版"里写中文（或直接在对话里发过来）。
2. Claude 翻译成英文。**翻译要保留原文的意境和语气，不要平铺直叙**（用户明确喜欢这种译法，例如把"我的整个19、20岁都留在了那里"译成 "my whole nineteenth and twentieth years had stayed there"）。
3. 先给用户看中英对照，确认后再写进 `memory_zh` / `memory_en`。字符串用双引号括起来，英文里常有冒号，不加引号会让 YAML 出错。
4. 本地预览 → 提交。

### 注意事项

- **隐私**：地点只写用户自己说出来的，不要从画面推断具体地点后写进网站。标题只写到城市或地标，不写住处等具体位置。
- **回忆不要放进大图说明**：Spotlight 的说明是纯文字，而且盖在照片上，长文字会挡住画面。现在的设计是把回忆放在缩略图下方，可以展开。
- 中文文字要加 `lang="zh-CN"`，这样读屏软件会用中文发音朗读。

## 关键技术要点

- **Git 署名**：`deyu-yang` / `180747901+deyu-yang@users.noreply.github.com`（GitHub 隐私邮箱，不要换成个人邮箱）。
- **发布流程**：推送（push）到 `main` 分支后，`.github/workflows/deploy.yml`（"Deploy site"）会生成网站并写入 `gh-pages` 分支，GitHub Pages 再从 `gh-pages` 分支发布。整个过程大约需要 3 到 5 分钟。
- **baseurl 必须留空**：`AGENTS.md` 里说 "baseurl 是 `/al-folio`、清空会出错"，这条只适用于模板仓库本身，**不适用于本网站**。本网站位于域名根目录。
- **推送凭据**：Claude 的命令窗口无法弹出登录框。首次推送由用户在自己的 PowerShell 中完成登录，凭据保存在 Windows 凭据管理器中。如果凭据失效，请用户自己在 PowerShell 中运行 `git push` 重新登录。
- **推送前先 `git pull`**：模板里的一些工作流（例如 `update-tocs.yml`）可能会自动往 `main` 提交。如果本地没有同步，推送会被拒绝。
- **Prettier 等检查失败不影响发布**：Actions 中 Prettier、链接检查等出现红色 ❌ 时，网站仍然可以正常发布，可以之后再处理。
- **Windows 上找不到 git 时**：Claude 的 PowerShell 窗口不会自动更新 PATH，每条命令前先运行：
  `$env:Path = [Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [Environment]::GetEnvironmentVariable('Path','User')`
- **分支和 PR**：较大的改动在分支（branch）上做，推送后用 `gh pr create` 创建 PR，由用户在 GitHub 网页上合并（merge）。GitHub CLI（`gh`）已安装并登录（账号 deyu-yang）。
- **提交说明（commit message）**：PowerShell 5.1 的 here-string 传给 `git commit -F -` 时会出错。先把提交说明写进临时文件，再用 `git commit -F <文件>`。
- **在 Docker 里运行多行 shell 命令**：PowerShell 会弄乱引号。先把命令写成 `.sh` 文件，挂载进容器后再运行。
- **本地没有安装 Ruby / Node.js**：一律用 Docker 预览（见上文），不要在 Windows 上直接安装 Ruby。
- **照片隐私**：手机照片带有 GPS 等 EXIF 元数据，放到网站之前必须先清除。用容器里的 ImageMagick 处理，原图只读挂载、不会被修改：
  `docker run --rm -v "<原图文件夹>:/in:ro" -v "<项目>\assets\img:/out" --entrypoint convert amirpourmand/al-folio:latest /in/<文件名> -auto-orient -strip -resize 1200x1600 -quality 85 /out/<输出文件名>.jpg`
- **本文件已在 `_config.yml` 的 `exclude` 列表中**，不会被发布成网页。

## 技术参考（需要时查阅）

以下文件来自 al-folio 模板，主要写给模板开发者看。其中部分规则（如 baseurl、测试命令）并不适用于个人网站。

- [`AGENTS.md`](AGENTS.md)：模板的结构和修改规则
- [`docs/CUSTOMIZE.md`](docs/CUSTOMIZE.md)：如何自定义网站内容
- [`docs/INSTALL.md`](docs/INSTALL.md)：安装、部署与本地预览
- [`docs/FAQ.md`](docs/FAQ.md)：常见问题
- [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md)：模板与插件（gem）的关系
