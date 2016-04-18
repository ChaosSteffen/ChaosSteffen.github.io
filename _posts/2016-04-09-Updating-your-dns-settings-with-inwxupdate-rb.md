---
layout: post
title: Updating your DNS records with inwxupdate.rb
---
I'm running a couple of Raspberry Pis in my closet that are connected to the rest of the world by IPv6.
For the obvious reasons each has its own DNS record at my favorite Registrar InterNetworX [INWX](https://inwx.com).

Unfortunately the my ISP thinks it is a good idea to rotate IPv6-prefixes to keep my devices secure.

To get around this circumstance I've build a small script to keep the IP-addresses updated.

Feel free to use and fork [inwxupdate](https://github.com/ChaosSteffen/inwxupdate).

This is how you use it:

```
git clone https://github.com/ChaosSteffen/inwxupdate.git
cd inwxupdate
cp config.rb.example config.rb
vi config.rb
ruby inwxupdate.rb
```

You can update multiple DNS records at a time and get IPs from different network interfaces.

```
CONFIG = {
  inwx_api: 'api.domrobot.com',
  inwx_user: 'your_username',
  inwx_pass: 'your_password',
  jobs: [
    {
      records: [
        { name: 'www.example.org', type: 'AAAA' }
      ],
      network_interface: 'en0'
    }
  ],
  debug: false
}
```