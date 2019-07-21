for i in ~/bin /usr/local/bin ~/.SpaceVim/bin
    if not contains $i $PATH
        set PATH $PATH $i
    end
end

