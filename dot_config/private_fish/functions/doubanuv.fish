function doubanuv --description 'Toggle Douban PyPI usage for uv'
    if test "$UV_DEFAULT_INDEX" = https://pypi.sapps.douban/simple
        set -e UV_DEFAULT_INDEX
        set -e UV_SYSTEM_CERTS
        echo "Disabled Douban PyPI for uv"
    else
        set -gx UV_DEFAULT_INDEX https://pypi.sapps.douban/simple
        set -gx UV_SYSTEM_CERTS true
        echo "Enabled Douban PyPI for uv"
    end
end
