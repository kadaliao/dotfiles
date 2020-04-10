function don --description 'Set douban proxy'
  echo 'douban proxy on'
  set -gx all_proxy http://tunnel.douban.com:8118
  set -gx ALL_PROXY http://tunnel.douban.com:8118

  set -gx http_proxy http://tunnel.douban.com:8118
  set -gx ftp_proxy http://tunnel.douban.com:8118
  set -gx https_proxy https://tunnel.douban.com:8443

  set -gx FTP_PROXY http://tunnel.douban.com:8118
  set -gx HTTP_PROXY http://tunnel.douban.com:8118
  set -gx HTTPS_PROXY https://tunnel.douban.com:8443
end
