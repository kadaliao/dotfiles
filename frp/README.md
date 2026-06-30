# FRP

日常只需要记一个入口：

```bash
chezmoi edit ~/frp/machines.toml
```

`machines.toml` 是共享的机器清单，只放稳定机器 ID、机器短名、frps 地址、远端端口和域名。不要把 token、代理密码放进去。
它在 dotfiles source 里以 GPG 加密文件保存，GitHub 上不会出现明文配置。

每台机器用本机 `~/.config/chezmoi/chezmoi.toml` 里的 `frp_machine` 选择配置，不依赖 `.chezmoi.hostname`：

```toml
[data]
    frp_machine = "mbp16"
```

秘密也只放本机的 `~/.config/chezmoi/chezmoi.toml`：

```toml
[data.frp_secrets.machines.<frp_machine>.endpoints.qiniu]
auth_token = "..."
```

常用命令：

```bash
~/frp/frpc.sh status all
~/frp/frpc.sh restart tx
~/frp/frpc.sh logs qiniu 80
```

加一台新电脑：

1. 给新电脑选一个稳定机器 ID，比如 `mini`。
2. 在新电脑自己的 `~/.config/chezmoi/chezmoi.toml` 的 `[data]` 下设置 `frp_machine = "mini"`。
3. 跑 `chezmoi edit ~/frp/machines.toml`。
4. 复制 `machines.mbp16` 这一组，改成 `machines.mini`。
5. 改 `label` 和远端端口，避免两台电脑抢同一个 frps 端口。
6. 如果服务器需要 token，把 token 放进那台电脑自己的 `~/.config/chezmoi/chezmoi.toml`。
7. 应用并重启：

```bash
chezmoi diff ~/frp
chezmoi apply ~/frp ~/Library/LaunchAgents/com.user.frpc-tx.plist ~/Library/LaunchAgents/com.user.frpc-qiniu.plist
~/frp/frpc.sh install-launchd all
```

不要把运行时文件加入 chezmoi：`*.log`、`*.err.log`、`*.pid` 都是本机状态。
