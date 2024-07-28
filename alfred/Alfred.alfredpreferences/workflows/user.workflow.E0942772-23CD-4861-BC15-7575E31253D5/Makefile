# make all
# Export workflow
# git push
# New release
# Submit packal
# Forum topic

REPO = ~/Sync/GitHub/Bitwarden-Accelerator

diff:
	diff -rq . ${REPO}

exec:
	find . \( -name '*.sh' -o -name '*.applescript' \) -exec chmod -c 755 {} \;

checkin: exec
	rsync -av --del --exclude=.git --exclude=*.plist --exclude=Makefile . ${REPO}

push: checkin

all: push
