# OpenList + rclone

This setup keeps the same local interface on each macOS machine:

- OpenList runs from `~/openlist/bin/openlist` as `org.openlist.local`.
- OpenList stores runtime state in `~/openlist/data` and exposes WebDAV on
  `http://127.0.0.1:5244/dav`.
- rclone reads `~/.config/rclone/rclone.conf` and uses the remote name `alist:`.
- Cryptomator vaults are uploaded as ciphertext with `rclone copy`; never use
  `rclone sync` for this backup workflow.

The rclone config is encrypted in chezmoi. OpenList's initial `config.json` and
`data.db` are also encrypted, but marked `create_`: they seed a new machine only
when the files do not already exist. Runtime database changes remain local and
are never overwritten by a later `chezmoi apply`.

Useful checks:

```sh
launchctl print "gui/$(id -u)/org.openlist.local"
rclone lsf alist:quark/Encrypted --dirs-only --max-depth 1
rclone check LOCAL_VAULT alist:quark/Encrypted/VAULT --size-only --one-way
```

Upload additions without deleting either side:

```sh
rclone copy LOCAL_VAULT alist:quark/Encrypted/VAULT \
  --size-only --transfers 2 --checkers 4 \
  --retries 5 --low-level-retries 10 --progress
```
