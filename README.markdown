OSinfo.bash
===========

Dumps the platform and distro.

    Anthony M. Cook (2012-2021)

Usage
-----

I use this in my startup scripts to determine which configuration blocks should run on Linux or Mac systems.

Designed to be unixy, use filters with this to get the information you want.

Example of usage:

```bash
$ osinfo.bash
linux
ubuntu
$ platform=$(osinfo.bash | head -1)
$ distro=$(osinfo.bash | tail -1)
```

Possible future enhancements
----------------------------

If you think any of these are particularly useful, let me know, or even better send me code.

* Detect PureDarwin/OpenDarwin
* Detect OSX version (eg Lion, Leopard, Mountain Lion)
* Detect Ubuntu version (eg Raring Ringtail, Lucid Lynx, Hardy Heron)

