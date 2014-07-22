#!/bin/sh

rm -rf shell my-shell git workshop my-workshop student-workshop &&

info() {
    #printf '\e[3;32m TEST \e[0;m'
    echo "#################### INFO ####################"
    for i in "$@"; do
        echo "#####   $i"
    done
    echo "####################"
    #printf '\e[0;m'
}
# stock shell lesson
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
        info "We just made a 'shell' repository that holds the shell lesson." "It has versions (tags):" "   $(git tag --list | tr '\n'  ' ')"
) &&

# customized shell lesson
git clone shell my-shell &&
(
	cd my-shell &&
	echo 'Also talk about find' >> README.md &&
	git commit -am 'Talk about find' &&
	git tag v0.3.0
        info "We just made a 'my-shell' repository as a fork/clone of 'shell' that holds changes by someone else." "It has an added version:" "   $(git tag --list | tr '\n'  ' ')"
) &&

# stock Git lesson
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
		    "shell-lesson": "git://localhost/shell#0.*"
		  }
		}
		EOF
	git add bower.json &&
	git commit -m "Bump to 0.1.0" &&
	git tag v0.1.0
        info "We just made a 'git' repository that holds the git lesson." "It has some version:" "   $(git tag --list | tr '\n'  ' ')"
) &&

# stock workshop collection
mkdir workshop &&
(
	cd workshop &&
	git init &&
	echo "Here's how you write software..." > README.md &&
	git add README.md &&
	cat <<-EOF > bower.json &&
		{
		  "name": "swc-workshop",
		  "description": "One-day introduction to software development",
		  "license": "CC BY 3.0 Unported",
		  "homepage": "http://example.invalid/swc",
		  "main": "README.md",
		  "ignore": [],
		  "dependencies": {
		    "git-lesson": "git://localhost/git#^0.*"
		  }
		}
		EOF
	git add bower.json &&
	git commit -m "Bump to 0.1.0" &&
	git tag v0.1.0
        info "We just made a 'workshop' repository that holds the typical bootcamp collection." "It has some version:" "   $(git tag --list | tr '\n'  ' ')"
) &&

# custom workshop collection, slotting in our custom shell lesson
git clone workshop my-workshop &&
(
	cd my-workshop &&
	sed -i 's|^\([[:space:]]*\)\(\"git-lesson".*\)|\1"shell-lesson": "git://localhost/my-shell",\n\1\2|' bower.json &&
	git commit -am "Swap in my-shell for the shell lesson" &&
	git tag v0.2.0
        info "We just made a 'my-workshop' repository that holds an evolution of the bootcamp collection." "It adds the custom 'my-shell' dependency." "It has some version:" "   $(git tag --list | tr '\n'  ' ')"
) &&

GIT_DAEMON_PID_FILE=$(mktemp git-daemon-pid.XXXXXX) &&
git daemon --detach --pid-file="${GIT_DAEMON_PID_FILE}" \
	--export-all --base-path=. &&
sleep 1 &&
GIT_DAEMON_PID=$(cat "${GIT_DAEMON_PID_FILE}")

# Student/instructor checkout for the workshop itself
git clone git://localhost/my-workshop student-workshop &&
(
	cd student-workshop &&
	bower cache clean &&
	bower install &&
	tree &&
	bower list
        info "We just created a repo 'student-workshop' as a clone of 'workshop', simulating the student behavior." "It is just a plain clone + some bower runs.:"
) &&

kill "${GIT_DAEMON_PID}"
