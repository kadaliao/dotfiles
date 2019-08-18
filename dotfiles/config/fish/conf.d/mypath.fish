for i in ~/bin ~/go/bin /usr/local/bin
    if not contains $i $PATH
        set PATH $PATH $i
    end
end

