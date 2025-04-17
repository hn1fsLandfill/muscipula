Muscipula
=========

Yet another Markov trap designed to trap bots

Usage
-----

Create a directory called `dataset`

Now from there add any source of text you can to `dataset`. It can be anything,
Go wild.

Run `generate.sh` and then `cook.sh`.
> Note: You'll need the `zip` command available.

Resulting executable `out/muscipula-1.0.com` should be an APE executable, you
can run it using `sh` on Linux/FreeBSD/NetBSD/OpenBSD or directly on Windows 8
or later.

Example: `sh out/muscipula-1.0.com -p 6950`

You are expected to hide the trap behind Nginx or a webserver, example nginx
snippet:

    location /muscipula {
        proxy_pass http://127.0.0.1:6950;
        proxy_set_header X-Path "/muscipula";
        proxy_buffering off;
    }
