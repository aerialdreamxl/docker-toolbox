if [[ -f /hermes-nginx-conf/.htpasswd ]]; then
    nginx -c /hermes-nginx-conf/proxy-htpasswd.conf -g 'daemon off;'
else
    nginx -c /hermes-nginx-conf/proxy-no-passwd.conf -g 'daemon off;'
fi