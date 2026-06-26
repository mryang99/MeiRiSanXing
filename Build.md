# BUILD.md — 从零开始在 iPhone 上运行

> 不需要 Mac，不需要 $99 开发者账号。只需要一台 Windows PC + iPhone。

---

## 目录

1. [第一阶段：把代码推送到 GitHub](#第一阶段把代码推送到-github)
2. [第二阶段：GitHub Actions 自动编译](#第二阶段github-actions-自动编译)
3. [第三阶段：下载编译好的 App](#第三阶段下载编译好的-app)
4. [第四阶段：安装到 iPhone（AltStore）](#第四阶段安装到-iphonealtstore)
5. [第五阶段：日常更新流程](#第五阶段日常更新流程)
6. [如果后续想发布 App Store](#如果后续想发布-app-store)

---

## 第一阶段：把代码推送到 GitHub

### 1.1 注册 GitHub 账号

访问 [github.com](https://github.com) → 点 Sign up → 用邮箱注册即可，免费。

### 1.2 在 GitHub 创建仓库

1. 登录后点右上角 + → New repository
2. Repository name: `MeiRiSanXing`
3. 设为 **Public**（公开仓库可以用免费的 GitHub Actions 额度）
4. 不要勾选任何初始化选项（README, .gitignore 等）
5. 点 Create repository

创建后会显示一个页面，里面有几行命令。往下看。

### 1.3 在 Windows 上推送代码

打开 Windows 的 **命令提示符 (cmd)** 或 **PowerShell**，逐行执行：

```bash
cd E:\agent\codex\meirisanxing
git remote add origin https://github.com/你的用户名/MeiRiSanXing.git
git branch -M main
git add .
git commit -m "feat: 每日三醒 完整源代码 + CI 配置"
git push -u origin main
```

> 把 `你的用户名` 替换成你 GitHub 的用户名。
>
> 第一次 push 会弹出 GitHub 登录窗口，按提示登录即可。

---

## 第二阶段：GitHub Actions 自动编译

推送成功后，自动流程就会启动。

### 2.1 查看编译进度

1. 打开你的 GitHub 仓库页面: `https://github.com/你的用户名/MeiRiSanXing`
2. 点顶部的 **Actions** 标签
3. 你会看到一个名为 "Build & Test" 的工作流正在运行（黄色圆点）
4. 点进去可以看实时日志

编译大约需要 **5-10 分钟**。

### 2.2 编译成功标志

工作流运行完成后，黄点变成**绿色勾** ✅。点击这个工作流，你会看到 3 步全部通过：

- ✅ Checkout
- ✅ Install XcodeGen
- ✅ Generate Xcode Project
- ✅ Build
- ✅ Run Tests
- ✅ Archive .app
- ✅ Upload artifact

### 2.3 如果编译失败

如果红叉 ❌ ，点进去看日志，把报错信息发给我，我来修。

---

## 第三阶段：下载编译好的 App

### 3.1 下载 artifact

1. 在 Actions 页面，点击成功运行的那个 workflow
2. 往下滚动到底部，看到 **Artifacts** 区域
3. 点击 **MeiRiSanXing-app** 下载一个 `.zip` 文件
4. 解压后会得到一个 `MeiRiSanXing.app` 文件夹

### 3.2 这个 .app 文件是什么

这就是你的 App 的编译成品。但它还没有签名，所以不能直接装到 iPhone 上。下一步就是签名 + 安装。

---

## 第四阶段：安装到 iPhone（AltStore）

### 4.1 准备工作

| 需要什么 | 获取方式 |
|---------|---------|
| 免费 Apple ID | appleid.apple.com 注册，5 分钟 |
| AltStore (Windows 版) | altstore.io 下载 |
| iTunes (Windows) | 从 Microsoft Store 安装 |
| iCloud (Windows) | 从 Microsoft Store 安装 |

### 4.2 安装 AltServer

1. 从 altstore.io 下载 AltStore for Windows
2. 安装并运行 AltServer
3. 确保 iPhone 用 USB 线连接到电脑
4. 确保 iPhone 和电脑在**同一个 WiFi** 下

### 4.3 在 iPhone 上安装 AltStore

1. 在 Windows 任务栏找到 AltServer 图标（菱形）
2. 右键 → **Install AltStore** → 选择你的 iPhone
3. 输入你的 Apple ID 和密码（仅用于签名，信息本地处理）
4. 等待安装完成，iPhone 上会出现 AltStore App

### 4.4 用 Sideloadly 签名并安装你的 App

> 因为你的 .app 是 GitHub Actions 编译的，没有 Mac 环境签名，
> 我们用一个 Windows 工具来签名 + 安装。

**方案 A — 用 Sideloadly（推荐）:**

1. 下载 [Sideloadly](https://sideloadly.io/)
2. iPhone 连接电脑，打开 Sideloadly
3. 把第一步下载的 `MeiRiSanXing.app`（或打包的 .ipa）拖到 Sideloadly 窗口
4. 输入你的免费 Apple ID
5. 点击 Start
6. 等待完成，App 就会出现在 iPhone 上 ✅

**方案 B — 用 AltStore 安装 .ipa:**

1. 下载 Sideloadly 或使用在线工具把 `.app` 转成 `.ipa`
2. 把 `.ipa` 传到 iPhone（通过 AirDrop、微信文件传输助手等）
3. 在 iPhone 上打开 AltStore
4. 点 **My Apps** → 左上角 **+** → 选择刚才的 .ipa 文件
5. 等待安装完成

### 4.5 信任证书

第一次打开 App 时，iPhone 会提示"未受信任的开发者"：

1. 打开 iPhone **设置** → **通用** → **VPN 与设备管理**
2. 找到你的 Apple ID 邮箱
3. 点进去 → **信任**
4. 返回桌面，App 就可以打开了 ✅

### 4.6 关于 7 天续签

免费签名有效期为 7 天。到期后：

- **如果电脑开着** + 同一 WiFi → AltStore 会自动在后台续签，App 一直能用
- **如果电脑关了** → App 会闪退打不开 → 下次开机连上 WiFi 后，打开 AltStore 手动续签即可

**保持电脑常开 + 不锁屏休眠**，就可以做到长期无感使用。

---

## 第五阶段：日常更新流程

以后改了代码，想更新 iPhone 上的 App：

```bash
# 1. 推送新代码到 GitHub
cd E:\agent\codex\meirisanxing
git add .
git commit -m "feat: 修复了 XX / 增加了 XX"
git push

# 2. 等 GitHub Actions 编译完成（5-10 分钟）
# 3. 下载新的 artifact
# 4. 用 Sideloadly 重新安装（会覆盖旧版本，数据保留）
```

---

## 如果后续想发布 App Store

当你觉得 App 好用、想发布时：

1. 花 $99 购买 [Apple Developer Program](https://developer.apple.com/)
2. 在 GitHub 仓库 Settings → Secrets → 添加 App Store Connect API Key
3. 我写的 CI 配置就可以直接自动上传到 TestFlight
4. 你手机上装 TestFlight → 接收更新 → 提交审核

**不需要改任何代码**，直接就能发布。

---

## 常见问题

**Q: 编译失败怎么办？**
把 GitHub Actions 的日志链接或截图发给我，我来排查。

**Q: AltStore 安装失败？**
确保 iTunes 和 iCloud 已从 Microsoft Store 安装，iPhone 用 USB 线连接。这是常见坑。

**Q: 数据会丢失吗？**
SwiftData 数据存在手机本地。卸载 App 会丢失数据。iCloud 同步功能默认关闭，如需开启需要开发者账号。

**Q: 可以改 App 名字和图标吗？**
可以。修改 Info.plist 里的 CFBundleDisplayName，Assets.xcassets 里加 AppIcon。
