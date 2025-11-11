function fish_user_key_bindings
    # fzf key bindings must be inside this function
    # to prevent breaking default bindings like up-or-search
    fzf --fish | source

    # Custom bindings
    for mode in insert default visual
        bind -M $mode \cf forward-char
    end
end
