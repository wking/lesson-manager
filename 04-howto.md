--- 
layout: simple
title: How To
---

We selected [Bower][] because:

1. it store the metadata as [JSON][],
2. the dependencies can be [Git][] repositories and
3. it resolve the dependencies pretty well.

**We thought that [Bower][] will download the [Git][] repositories and keep it
but that isn't true.** [Bower][] will try to download an "zip" file of the
[Git][] repository at the need version and "unzip" it. There is a [fork][upt] of
[Bower][] that allow the user download the [Git][] repositories and keep it but
this is for another text.

Before install Bower you need to install Git and [Node][].  Then:

~~~
# npm install -g bower
~~~

## Getting and building a lesson collection (the manual way)

(see also "Getting and building lessons with the work-in-progress script")

~~~
$ git clone https://github.com/SoftwareCarpentryLessonManager/shell-based-bc.git
$ cd shell-based-bc
$ bower update
$ ls
bower.json   gloss.md  novice-git-backup/  novice-git-open/      novice-shell-filedir/  README.md
contents.md  intro.md  novice-git-intro/   novice-shell-create/  novice-shell-intro/    template/
~~~

To get the HTML version of the lesson you need [Jekyll][] installed and to run:

~~~
$ jekyll build --plugins template/_plugins --layouts template/_layouts --config template/_config.yml
~~~

After that you can point your web browser to `_site`.

### Open questions

- How create the index for the lessons?
- How create navigation links for the lessons?
- How build the lessons from some markup to HTML?

## Getting and building lessons with the work-in-progress script

There is a script which is a thin layer on top of [Bower][]+[Jekyll][] and
which aims at simplify our/your life. You can test it with

~~~
$ git clone git@github.com:SoftwareCarpentryLessonManager/lesson-manager.git
$ git clone git@github.com:SoftwareCarpentryLessonManager/shell-based-bc.git
$ cd shell-based-bc/
$ ../lesson-manager/protolearningunit.sh update
$ ../lesson-manager/protolearningunit.sh build
~~~

And pointing your web browser to `_site`.

## Create a new lesson

Let say that your have a HTML lesson named `index.html` and you want
to make it easyily available to others import it and reuse. Your first
step is create a metadata file for your lesson.

~~~
$ ls
index.html
$ bower init
[?] name: Your Awesome Lesson
[?] version: 0.1.0
[?] description: Your first lesson that will be easy to people reuse
[?] main file: index.md
[?] what types of modules does this package expose?
[?] keywords:
[?] authors: Jane Doe <jane@email.com>
[?] license: CC BY 3.0 Unported
[?] homepage: http://www.your-web-page.com
[?] set currently installed components as dependencies? No
[?] add commonly ignored files to ignore list? No
[?] would you like to mark this package as private which prevents it from being accidentally published to the registry? No

{
  name: 'Your Awesome Lesson',
  version: '0.1.0',
  authors: [
    'Jane Doe <jane@email.com>'
  ],
  description: 'Your first lesson that will be easy to people reuse',
  main: 'index.md',
  license: 'CC BY 3.0 Unported',
  homepage: 'http://www.your-web-page.com'
}

[?] Looks good? Yes
$ cat bower.json
{
  "name": "Your Awesome Lesson",
  "version": "0.1.0",
  "authors": [
    "Jane Doe <jane@email.com>"
  ],
  "description": "Your first lesson that will be easy to people reuse",
  "main": "index.md",
  "license": "CC BY 3.0 Unported",
  "homepage": "http://www.your-web-page.com"
}
~~~

After create your metadata file you *must* create a Git repository for it and
you *must* add the proper tag (e.g., v0.1.0) to it and publish it somewhere.

~~~
$ ls
bower.json  index.html
$ git init
Initialized empty Git repository in /tmp/tmp.MxUuUzX5I8/your-awesome-lesson/.git/
$ git add *
$ git commit -m 'Creating lesson that can be imported'
[master (root-commit) 2c165fb] Creating lesson that can be imported
 2 files changed, 11 insertions(+)
 create mode 100644 bower.json
 create mode 100644 index.html
$ git tag v0.1.0
$ git remote add origin https://github.com/username/your-awesome-lesson
$ git push --tags origin master
~~~

Congratulations. Someone can import your lesson following the steps at the
first section of this page.

## Adding dependencies to your lesson

If you want to import someone's lesson that is already published, you
just need to:

~~~
$ cat bower.json
{
  "name": "Your Awesome Lesson",
  "version": "0.1.0",
  "authors": [
   "Jane Doe <jane@email.com>"
  ],
  "description": "Your first lesson that will be easy to people reuse",
  "main": "index.md",
  "license": "CC BY 3.0 Unported",
  "homepage": "http://www.your-web-page.com"
}
$ bower install --save --config.directory=. https://github.com/SoftwareCarpentryLessonManager/novice-git-intro.git
bower cached        https://github.com/SoftwareCarpentryLessonManager/novice-git-intro.git#0.1.0
bower validate      0.1.0 against https://github.com/SoftwareCarpentryLessonManager/novice-git-intro.git#*
bower install       novice-git-intro#0.1.0

novice-git-intro#0.1.0 novice-git-intro
$ cat bower.json
{
  "name": "Your Awesome Lesson",
  "version": "0.1.0",
  "authors": [
    "Jane Doe <jane@email.com>"
  ],
  "description": "Your first lesson that will be easy to people reuse",
  "main": "index.md",
  "license": "CC BY 3.0 Unported",
  "homepage": "http://www.your-web-page.com",
  "dependencies": {
    "novice-git-intro": "https://github.com/SoftwareCarpentryLessonManager/novice-git-intro.git#~0.1.0"
  }
}
$ ls
bower.json  index.html  novice-git-intro/
~~~

Pretty easy. After you do that you probably want to change something at your
`index.html`, add the dependencies to your `.gitignore`, save the changes and
update your git remote repository.

[Bower]: http://bower.io/
[Git]: http://git-scm.com/
[JSON]: http://json.org/
[Jekyll]: http://jekyllrb.com/
[Node]: http://nodejs.org/
[lesson-manager]: https://github.com/SoftwareCarpentryLessonManager
[upt]: https://github.com/hyperweb2/upt
