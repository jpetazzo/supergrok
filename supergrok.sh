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
cat <<EOF

Your supergrok tunnelizer is available at: $URL

If you go to that URL, you should see the default "Welcome to NGINX!" page.
To connect to one of your Docker nodes, add the IP address of that node (and
an optional port number) after that URL. For instance, to reach the service
running on node 10.0.3.5 and exposed on port 8000, just go to the following
address: http://xxxx.ngrok.io/10.0.3.5:8000 

Note that NGINX will not rewrite absolute links contained in your pages. In
other words, if you serve a web page containing a link to "/hello", it will
translate to http://xxxx.ngrok.io/hello, which will not work. The correct
link would be http://xxxx.ngrok.io/10.0.3.5:8000/hello! However, NGINX will
rewrite "Location:" headers, so simple HTTP redirections should work.

Here is the URL in a machine-catchable format (so you can grep ^URL= these
messages, if you are so inclined):

URL=$URL
EOF
wait
