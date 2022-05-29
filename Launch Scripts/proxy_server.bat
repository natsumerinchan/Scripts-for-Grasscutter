@echo off
cd /d %~dp0
set CA_CERT_FILE="%USERPROFILE%\.mitmproxy\mitmproxy-ca-cert.cer" >nul
certutil -addstore root %CA_CERT_FILE% >nul
mitmdump -s proxy.py --ssl-insecure --set block_global=false --listen-port 23121
