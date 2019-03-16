PLYMOUTH_THEMES_PATH=/usr/share/plymouth/themes

TEXT=Cimpress
FONT=./SEGA.TTF
POINT_SIZE=144
COLOR=\#0047AB

ANIMATION_GLINT_FRAME_COUNT=50
ANIMATION_FADEIN_FRAME_COUNT=25
ANIMATION_IDLE_FRAME_COUNT=50
ANIMATION_FADEOUT_FRAME_COUNT=15

build: clean frames.png sega.script

frames.png:
	( cd sega-animation-generator && make && cp frame* .. )

test:
	plymouthd --debug --debug-file=/tmp/plymouth-debug-out
	plymouth --show-splash
	for I in $(shell seq 50); do sleep 0.1; plymouth --update=event$I; done
	plymouth --hide-splash
	plymouth --quit

clean:
	rm -rf sega.script
	rm -rf *.png

sega.script: 
	sed -e 's/$$ANIMATION_GLINT_FRAME_COUNT/${ANIMATION_GLINT_FRAME_COUNT}/g' \
		-e 's/$$ANIMATION_FADEIN_FRAME_COUNT/${ANIMATION_FADEIN_FRAME_COUNT}/g' \
		-e 's/$$ANIMATION_IDLE_FRAME_COUNT/${ANIMATION_IDLE_FRAME_COUNT}/g' \
		-e 's/$$ANIMATION_FADEOUT_FRAME_COUNT/${ANIMATION_FADEOUT_FRAME_COUNT}/g' < sega.script.template > sega.script

install:
	mkdir -p "${PLYMOUTH_THEMES_PATH}/sega"
	cp sega.plymouth sega.script sega-animation-generator/frame* "${PLYMOUTH_THEMES_PATH}/sega"
	cat Instructions

uninstall:
	rm -rf "${PLYMOUTH_THEMES_PATH}/sega"
ifeq ("$(shell readlink -m "${PLYMOUTH_THEMES_PATH}/default.plymouth")", "${PLYMOUTH_THEMES_PATH}/sega/sega.plymouth")
	echo "Warning: ${PLYMOUTH_THEMES_PATH}/default.plymouth still points at the Sega theme, which has just been removed. Please configure plymouth to point to an existing theme."
endif
