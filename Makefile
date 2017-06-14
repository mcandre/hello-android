APP=HelloAndroid
KEYSTORE=~/.android/production.keystore
ALIAS=yellosoft

all: debug

debug:
	ant debug

release:
	ant release

sign: release
	jarsigner -verbose -sigalg MD5withRSA -digestalg SHA1 -keystore $(KEYSTORE) bin/$(APP)-release-unsigned.apk $(ALIAS)

zipalign: sign
	-rm bin/HelloPhoneGap-release-aligned.apk # zipalign hates overwriting files
	zipalign -v 4 bin/$(APP)-release-unsigned.apk bin/$(APP)-release-aligned.apk

publish: zipalign

clean:
	-rm -rf bin

editorconfig:
	flcl . | xargs -n 100 editorconfig-cli check

lint: editorconfig
