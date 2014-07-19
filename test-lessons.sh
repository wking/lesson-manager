#!/bin/sh

rm -rf shell git workshop &&

mkdir shell &&
(
	cd shell &&
	git init &&
	echo "Here's how you use the posix shell..." > README.md &&
	git add README.md &&
	cat <<-EOF > bower.json &&
		{
			"name": "shell-lesson",
			"description": "Introduce folks to basic POSIX-shell usage",
			"license": "CC BY 3.0 Unported",
			"homepage": "http://example.invalid/shell",
			"main": "README.md",
			"ignore": []
		}
		EOF
	git add bower.json &&
	git commit -m "Bump to 0.1.0" &&
	git tag v0.1.0
	sed -i 's/posix/POSIX/' README.md &&
	git commit -am "Fix 'posix' -> 'POSIX' capitalization" &&
	git tag v0.1.1
	echo 'Also talk about some POSIX utilities (cat, grep, ...).' >> README.md &&
	git commit -am 'Introduce POSIX utilities (cat, grep, ...)' &&
	git tag v0.2.0
) &&

mkdir git &&
(
	cd git &&
	git init &&
	echo "Here's how you use Git..." > README.md &&
	git add README.md &&
	cat <<-EOF > bower.json &&
		{
			"name": "git-lesson",
			"description": "Introduce folks to basic Git usage",
			"license": "CC BY 3.0 Unported",
			"homepage": "http://example.invalid/git",
			"main": "README.md",
			"ignore": [],
			"dependencies": {
				"shell-lesson": "git://localhost/shell#^0.1"
			}
		}
		EOF
	git add bower.json &&
	git commit -m "Bump to 0.1.0" &&
	git tag v0.1.0
) &&

GIT_DAEMON_PID_FILE=$(mktemp git-daemon-pid.XXXXXX) &&
git daemon --detach --pid-file="${GIT_DAEMON_PID_FILE}" \
	--export-all --base-path=. &&
sleep 1 &&
GIT_DAEMON_PID=$(cat "${GIT_DAEMON_PID_FILE}")

mkdir workshop &&
(
	cd workshop &&
	bower cache clean &&
	bower install git://localhost/git &&
	tree &&
	bower list
) &&

kill "${GIT_DAEMON_PID}"
