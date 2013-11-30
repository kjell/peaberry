ssl:
	echo "enter localhost as the Common Name"
	echo "When it opens the cert in Keychain, make it Trusted for SSL"
	echo "The Key and Cert will be copied to your clipboard. Paste them at the bottom of bin/peaberry"
	echo "Then `make reload`"
	openssl genrsa -des3 -passout pass:x -out server.pass.key 2048
	openssl rsa -passin pass:x -in server.pass.key -out server.key
	rm server.pass.key
	openssl req -new -key server.key -out server.csr
	openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
	open -a Keychain\ Access server.crt
	cat server.crt server.key | pbcopy

reload:
	launchctl unload -w ~/Library/LaunchAgents/com.kjell.peaberry.plist
	launchctl load -w ~/Library/LaunchAgents/com.kjell.peaberry.plist

