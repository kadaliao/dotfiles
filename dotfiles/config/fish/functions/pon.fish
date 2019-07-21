function pon --description 'Set rallets proxy'
  echo 'rallets proxy on'
  set -gx all_proxy http://127.0.0.1:8119
  set -gx ftp_proxy http://127.0.0.1:8119
  set -gx http_proxy http://127.0.0.1:8119
  set -gx https_proxy http://127.0.0.1:8119
  set -gx FTP_PROXY http://127.0.0.1:8119
  set -gx HTTPS_PROXY http://127.0.0.1:8119
  set -gx HTTP_PROXY http://127.0.0.1:8119
end
