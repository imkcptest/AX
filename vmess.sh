#!/bin/bash

rm -f web config.json
wget -N https://raw.githubusercontent.com/imkcptest/test/main/web
chmod +x ./web

if [[ -z $id ]]; then
    id="f5199c2d-e1c0-492f-a33a-58f24ce21c04"
fi

cat <<EOF > ~/config.json
{
    "log": {
        "loglevel": "warning"
    },
    "inbounds": [
        {
            "port": $PORT,
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "$id"
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "ws",
                "security": "none"
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
EOF

./web -config=config.json
