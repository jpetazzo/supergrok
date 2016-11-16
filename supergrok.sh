#!/bin/sh
echo "Starting NGINX."
nginx
echo "Starting ngrok."
ngrok http 80 --log /ngrok.log >/dev/null &
echo "Waiting for tunnel URL..."
while true; do
  URL=$(curl -s localhost:4040/api/tunnels | jq -r .tunnels[0].public_url)
  [ "$URL" ] && break
  sleep 1
done
echo "Your supergrok tunnelizer is available at: $URL"
echo "And here it is in machine-catchable format:"
echo "URL=$URL"
wait
