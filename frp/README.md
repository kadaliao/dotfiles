# FRP

日常只需要记一个入口：

```bash
chezmoi edit ~/frp/machines.toml
```

`machines.toml` 是共享的机器清单，只放 hostname、机器短名、frps 地址、远端端口和域名。不要把 token、代理密码放进去。
它在 dotfiles source 里以 GPG 加密文件保存，GitHub 上不会出现明文配置。

秘密只放本机的 `~/.config/chezmoi/chezmoi.toml`：

```toml
[data.frp_secrets.machines.<hostname>.endpoints.qiniu]
auth_token = "..."
```

常用命令：

```bash
~/frp/frpc.sh status all
~/frp/frpc.sh restart tx
~/frp/frpc.sh logs qiniu 80
```

加一台新电脑：

1. 在新电脑上跑 `chezmoi execute-template '{{ .chezmoi.hostname }}'`。
2. 跑 `chezmoi edit ~/frp/machines.toml`。
3. 复制 `machines.xingyi-mbp16-1263` 这一组，改成新电脑的 hostname。
4. 改 `label` 和远端端口，避免两台电脑抢同一个 frps 端口。
5. 如果服务器需要 token，把 token 放进那台电脑自己的 `~/.config/chezmoi/chezmoi.toml`。
6. 应用并重启：

```bash
chezmoi diff ~/frp
chezmoi apply ~/frp ~/Library/LaunchAgents/com.user.frpc-tx.plist ~/Library/LaunchAgents/com.user.frpc-qiniu.plist
~/frp/frpc.sh install-launchd all
```

不要把运行时文件加入 chezmoi：`*.log`、`*.err.log`、`*.pid` 都是本机状态。
