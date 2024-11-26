## Upcaddy Todos
- [ ] When consolidating to the Caddyfile, it should in the comment the path to the `.caddy` file
- [ ] Option to just restart Caddy, especially if there's no change in the Caddyfile, or the previous process was cancelled.


## For next implementation:
Select options:
1. Create a new .caddy file
	1. Domain/sub-domain name
	2. Select:
		1. Reverse Proxy
			1. Enable TLS with Cloudflare DNS?
			2. Host/IP Address/Container Name:
			3. Port:
		2. File Server
			1. Enable TLS with Cloudflare DNS?
			2. Location in Caddy container:
		3. Redirect
			1. Enable TLS with Cloudflare DNS?
			2. Redirect URL
		4. HTTP Transport Out
		5. HTTP Transport In
2. Consolidate Caddyfile and restart Caddy
3. Exit
