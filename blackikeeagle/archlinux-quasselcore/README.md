archlinux-quasselcore
=====================

When you want ssl encrypted communication between your quassel client and the quassel core, generate a certificate `quasselCert.pem`.

Sample (taken from the quassel documentation):

~~~
openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout ~/.config/quassel-irc.org/quasselCert.pem -out ~/.config/quassel-irc.org/quasselCert.pem
~~~
