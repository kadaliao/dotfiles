function pon --description 'Set proxy'
  echo 'proxy on'
  set -gx all_proxy http://127.0.0.1:7890
  set -gx ftp_proxy http://127.0.0.1:7890
  set -gx http_proxy http://127.0.0.1:7890
  set -gx https_proxy http://127.0.0.1:7890
  set -gx FTP_PROXY http://127.0.0.1:7890
  set -gx HTTPS_PROXY http://127.0.0.1:7890
  set -gx HTTP_PROXY http://127.0.0.1:7890
end

function poff --description 'Unset proxy'
  echo 'proxy off'
  set -e all_proxy
  set -e ftp_proxy
  set -e http_proxy
  set -e https_proxy
  set -e ALL_PROXY
  set -e FTP_PROXY
  set -e HTTPS_PROXY
  set -e HTTP_PROXY
end

function don --description 'Set douban proxy'
  echo 'douban proxy on'
  set -gx all_proxy http://tunnel.douban.com:8118
  set -gx ALL_PROXY http://tunnel.douban.com:8118

  set -gx http_proxy http://tunnel.douban.com:8118
  set -gx ftp_proxy http://tunnel.douban.com:8118

  set -gx FTP_PROXY http://tunnel.douban.com:8118
  set -gx HTTP_PROXY http://tunnel.douban.com:8118
end

function doff --description 'Unset douban proxy'
  echo 'douban proxy off'
  set -e all_proxy
  set -e ftp_proxy
  set -e http_proxy
  set -e https_proxy
  set -e ALL_PROXY
  set -e FTP_PROXY
  set -e HTTPS_PROXY
  set -e HTTP_PROXY
end
