# SYSU NetAuth · Windows

一款面向 Windows 的中山大学有线校园网认证客户端。支持 802.1X / EAP-MD5 认证，通过后台服务处理自动认证和断线重连，并提供简洁的浅色与深色界面。

本项目是 [LoveElysia1314/sysu-netauth](https://github.com/LoveElysia1314/sysu-netauth) 的非官方 fork。本分支专注 Windows 界面与使用体验，保留上游的认证与后台服务逻辑。

> 当前为 Windows x64 测试版：已完成 Windows 构建、自动化测试和界面预览，尚未在真实校园网环境中验证认证连接。

## 功能

- 首页集中显示账号、认证操作和网络状态；网卡、通知及更新选项收纳在设置页。
- 暖白、深色与红色点缀的界面跟随系统主题切换，内置 Noto Serif SC 字体；支持托盘状态与开机启动界面。
- 自动或手动选择有线网卡，后台响应重新认证并在断线后重试。
- 支持认证状态通知、日志查看和检查上游版本更新。

程序负责有线认证；IP 地址与 DHCP 由系统管理。使用前请退出其他可能占用网卡的 802.1X 客户端。

## 下载与安装

本分支目前提供 Windows 10/11 **x64 测试版**。前往 [Releases 发布页](https://github.com/Dre-art/sysu-netauth/releases)，下载最新 Windows 界面版的 `Setup.exe` 安装包。

1. 运行安装包，按提示完成安装；安装和服务管理需要管理员权限。
2. 打开程序，填写 NetID 和密码，点击“认证”。默认自动选择已连接的有线网卡。
3. 如需固定网卡或调整启动和通知选项，打开右上角的“设置与更多”。更改网卡后，返回首页点击“认证”应用。

测试安装包尚未签名，Windows 可能显示安全提示。它沿用上游的安装标识和配置位置，安装时可能覆盖已有的 SYSU NetAuth 版本。

## 账号与更新

账户配置位于 `%ProgramData%\SYSUNetAuth\config.json`，其中包含明文凭据；系统和管理员账户可以访问。请勿分享该文件，也不要将密码提交到仓库。

本分支内置的 Noto Serif SC 字体遵循 [SIL Open Font License 1.1](assets/fonts/OFL-NotoSerifSC.txt)，由程序私有加载，不会安装到系统字体目录。

本分支保留了上游的更新检查来源；更新提示和发布说明指向上游项目，不代表本 fork 已发布新版。上游发布页中的安装包也不包含本分支的界面改动。

## 从源码构建

需要 Windows x64、Rust MSVC 工具链、Visual Studio C++ 工具及 Windows SDK；制作安装包还需要 Inno Setup 6。

```powershell
.\scripts\build.ps1 -Target x86_64-pc-windows-msvc
```

构建产物位于 `dist` 目录。上游的[安装与排障文档](docs/WINDOWS.md)和[构建文档](docs/BUILDING.md)仍可供参考，界面位置以本分支为准。
