all:
	chmod +x build.sh
	./build.sh
	mkdir bin/
	./assets/compile
	rm main.luastatic.c
	./bin/main

install:
	cp bin/main /usr/bin/luadock
	cp assets/luadock.desktop /usr/share/applications/luadock.desktop