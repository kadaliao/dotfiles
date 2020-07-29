function srl --description "source conf.d/.fish files"
    for snippet in $__fish_config_dir/conf.d/*
        echo sourcing $snippet
        source $snippet
    end
end
