---
title: github pages 部署方式变更
date: 2026-10-02 10:50:57
tags:
---

## 1. 核心问题：Hexo 部署后自定义域名被刷掉

**原因：** Hexo 的 `hexo deploy` 会清空并重建目标分支，GitHub 自动生成的 `CNAME` 文件被删除。

**解决：**
- 在 `source/` 下放置 `CNAME` 文件（内容为纯域名，无 `http://`）。
- 但每次部署仍有短暂验证窗口，因为 Hexo 的“清空-重建-推送”流程本身会导致 GitHub 重新识别 CNAME。

**根治方案：** 改用 **GitHub Actions 部署**。GitHub 官方文档说明，通过自定义 Actions 工作流发布时，GitHub 不依赖仓库中的 CNAME 文件，自定义域名由服务端设置直接管理，不再被刷掉。

---

## 2. 使用 GitHub Actions 后的博客更新流程

**以前：** 本地 `hexo generate` + `hexo deploy`。

**现在：**
```bash
hexo new post "标题"
# 编辑 source/_posts/标题.md
git add .
git commit -m "post: 标题"
git push origin main
```
推送后 GitHub Actions 自动在 Runner 上：
1. checkout 源码
2. 安装 Node 和依赖
3. `npx hexo generate`
4. 部署到 GitHub Pages

**关键：** 推送到 GitHub 的必须是**完整 Hexo 源码项目**，不是只有 md 文件。本地不再需要 `hexo deploy`。

**推荐工作流：** 用官方 `actions/upload-pages-artifact` + `actions/deploy-pages`，并在仓库 `Settings -> Pages -> Source` 选择 **GitHub Actions**，在 `Custom domain` 填写自定义域名。

---

## 3. 主题 Butterfly 的 submodule 处理

**最初做法：**
```bash
git clone -b master https://github.com/jerryc127/hexo-theme-butterfly.git themes/butterfly
```
这只是普通克隆，保留了 `.git`，不是正规 submodule。

**两种正确做法：**

| 方式 | 操作 | Actions 是否需要 `submodules: recursive` |
| :--- | :--- | :--- |
| **普通文件** | `rm -rf themes/butterfly/.git` 后提交 | 不需要（加了也无害） |
| **正规 submodule** | `git submodule add -b master <url> themes/butterfly` | 必须加 |

**报错 `origin/master is not a commit` 的原因：** `--depth 1` 与 `-b master` 组合导致浅克隆无法解析远程分支。**去掉 `--depth 1`** 即可。

**结论：** 个人博客若不常改主题，推荐删掉 `.git` 当普通文件提交，最省事。`submodules: recursive` 在无 submodule 时不会报错，可安全保留。

---

## 4. GitHub Pages 仓库命名与类型

| 类型 | 仓库命名要求 | 默认网址 | 数量限制 |
| :--- | :--- | :--- | :--- |
| **用户主页** | 必须为 `username.github.io` | `https://username.github.io` | 一个账号仅一个 |
| **项目主页** | 任意名称（如 `blog`） | `https://username.github.io/仓库名/` | 可多个 |

**结论：** Hexo 博客仓库**不必**叫 `linuxmint17.github.io`。叫 `blog` 也可以。绑自定义域名后，项目主页的仓库名无所谓；用户主页的仓库名则不能改。

**若仓库叫 `blog` 且不绑域名：** 需在 `_config.yml` 配置：
```yaml
url: https://linuxmint17.github.io/blog
root: /blog/
```
绑自定义域名后改为：
```yaml
url: https://你的域名
root: /
```

---

## 5. 概念澄清：用户主页 ≠ GitHub 首页 ≠ 个人主页

- **GitHub 首页：** `https://github.com`
- **你的 GitHub 个人主页：** `https://github.com/linuxmint17`（站内资料页）
- **用户主页（GitHub Pages）：** `https://linuxmint17.github.io`（你部署的独立网站）

三者完全不同，不要混淆。

---

## 6. 最终建议

- **自定义域名问题：** 迁移到 GitHub Actions 部署，仓库 Settings 里配域名。
- **主题管理：** 简单起见删掉主题 `.git` 当普通文件；想跟随更新再用正规 submodule。
- **仓库命名：** 想绑自定义域名，仓库随便叫 `blog` 即可；不绑域名且想要根网址，才必须叫 `username.github.io`。
- **更新博客：** 本地写 md → `git push` → Actions 自动构建部署。