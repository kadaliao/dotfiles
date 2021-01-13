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
