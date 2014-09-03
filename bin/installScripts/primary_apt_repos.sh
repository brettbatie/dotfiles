#!/bin/bash
echo -e 'Package: *\nPin: release l=Debian-Security\nPin-Priority: 1000' > /etc/apt/preferences.d/security.pref
echo -e 'Package: *\nPin: release a=stable\nPin-Priority: 995' > /etc/apt/preferences.d/stable.pref
echo -e 'Package: *\nPin: release a=testing\nPin-Priority: 750' > /etc/apt/preferences.d/testing.pref
echo -e 'Package: *\nPin: release a=unstable\nPin-Priority: 50' > /etc/apt/preferences.d/unstable.pref
echo -e 'Package: *\nPin: release a=experimental\nPin-Priority: 1' > /etc/apt/preferences.d/experimental.pref

echo -e 'deb     http://security.debian.org/         stable/updates  main contrib non-free\ndeb     http://security.debian.org/         testing/updates main contrib non-free' > /etc/apt/sources.list.d/security.list

echo -e 'deb     http://mirror.steadfast.net/debian/ stable main contrib non-free\ndeb-src http://mirror.steadfast.net/debian/ stable main contrib non-free\ndeb     http://ftp.us.debian.org/debian/    stable main contrib non-free\ndeb-src http://ftp.us.debian.org/debian/    stable main contrib non-free' > /etc/apt/sources.list.d/testing.list
echo -e 'deb     http://mirror.steadfast.net/debian/ testing main contrib non-free\ndeb-src http://mirror.steadfast.net/debian/ testing main contrib non-free\ndeb     http://ftp.us.debian.org/debian/    testing main contrib non-free\ndeb-src http://ftp.us.debian.org/debian/    testing main contrib non-free' > /etc/apt/sources.list.d/testing.list
echo -e 'deb     http://mirror.steadfast.net/debian/ unstable main contrib non-free\ndeb-src http://mirror.steadfast.net/debian/ unstable main contrib non-free\ndeb     http://ftp.us.debian.org/debian/    unstable main contrib non-free\ndeb-src http://ftp.us.debian.org/debian/    unstable main contrib non-free' > /etc/apt/sources.list.d/unstable.list
echo -e 'deb     http://mirror.steadfast.net/debian/ experimental main contrib non-free\ndeb-src http://mirror.steadfast.net/debian/ experimental main contrib non-free\ndeb     http://ftp.us.debian.org/debian/    experimental main contrib non-free\ndeb-src http://ftp.us.debian.org/debian/    experimental main contrib non-free' > /etc/apt/sources.list.d/experimental
aptitude update
