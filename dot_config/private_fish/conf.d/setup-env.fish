# Load the decrypted, chezmoi-managed secret source for fish sessions.
# GUI applications receive selected variables through com.liaoxingyi.codex.env.
if test -f ~/.local/bin/setup-env.fish
    source ~/.local/bin/setup-env.fish
end
