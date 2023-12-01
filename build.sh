#TODO figure out a build system
git clone https://github.com/lgi-devs/lgi
cd lgi
rm -rf .travis.yml samples tests tools docs .github lgi-scm-1.rockspec meson.build meson_options.txt rockspec.in .gitignore Makefile
gcc -c lgi/*.c -lglib-2.0  -llua5.1 -lgmodule-2.0 $(pkg-config --libs gtk+-3.0) $(pkg-config --cflags --libs gobject-introspection-1.0) -lglib-2.0 -lgobject-2.0 -I/usr/include/lua5.1/
ar rcu libcorelgilua51.a *.o
cd ..
cp lgi/libcorelgilua51.a assets/
mv lgi lgi-second
mkdir lgi
cp -r lgi-second/lgi/* lgi
rm -rf lgi-second
rm -rf lgi/*.o
rm -rf lgi/*.c
rm -rf lgi/version.lua.in
rm -rf lgi/*.h
rm -rf lgi/meson.build
rm -rf lgi/Makefile