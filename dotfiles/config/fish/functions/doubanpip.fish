function doubanpip --description 'Toggle pip.conf usage'
    if set -q PIP_CONFIG_FILE
        # 如果环境变量PIP_CONFIG_FILE已经设置，那么取消设置
        set -e PIP_CONFIG_FILE
        echo "Disabled doubanpip.conf"
    else
        # 如果环境变量PIP_CONFIG_FILE未设置，那么进行设置
        set -gx PIP_CONFIG_FILE $HOME/.pip/doubanpip.conf
        echo "Enabled doubanpip.conf"
    end
end

