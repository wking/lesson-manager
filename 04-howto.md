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
Cloning into 'shell-based-bc'...
remote: Counting objects: 76, done.
remote: Compressing objects: 100% (61/61), done.
remote: Total 76 (delta 13), reused 74 (delta 12)
Unpacking objects: 100% (76/76), done.
Checking connectivity... done.
$ cd shell-based-bc
$ bower update
bower not-cached    git://github.com/SoftwareCarpentryLessonManager/software-carpentry-template.git#*
bower resolve       git://github.com/SoftwareCarpentryLessonManager/software-carpentry-template.git#*
bower cached        git://github.com/SoftwareCarpentryLessonManager/novice-shell-intro.git#0.1.0
bower validate      0.1.0 against git://github.com/SoftwareCarpentryLessonManager/novice-shell-intro.git#*
bower cached        git://github.com/SoftwareCarpentryLessonManager/novice-shell-filedir.git#0.1.0
bower validate      0.1.0 against git://github.com/SoftwareCarpentryLessonManager/novice-shell-filedir.git#*
bower cached        git://github.com/SoftwareCarpentryLessonManager/novice-shell-create.git#0.1.0
bower validate      0.1.0 against git://github.com/SoftwareCarpentryLessonManager/novice-shell-create.git#*
bower cached        git://github.com/SoftwareCarpentryLessonManager/novice-git-intro.git#0.1.0
bower validate      0.1.0 against git://github.com/SoftwareCarpentryLessonManager/novice-git-intro.git#*
bower cached        git://github.com/SoftwareCarpentryLessonManager/novice-git-backup.git#0.1.0
bower validate      0.1.0 against git://github.com/SoftwareCarpentryLessonManager/novice-git-backup.git#*
bower cached        git://github.com/SoftwareCarpentryLessonManager/novice-git-open.git#0.1.0
bower validate      0.1.0 against git://github.com/SoftwareCarpentryLessonManager/novice-git-open.git#*
bower download      https://github.com/SoftwareCarpentryLessonManager/software-carpentry-template/archive/v0.1.0.tar.gz
bower new           version for git://github.com/SoftwareCarpentryLessonManager/novice-git-intro.git#*
bower resolve       git://github.com/SoftwareCarpentryLessonManager/novice-git-intro.git#*
bower new           version for git://github.com/SoftwareCarpentryLessonManager/novice-git-open.git#*
bower resolve       git://github.com/SoftwareCarpentryLessonManager/novice-git-open.git#*
bower download      https://github.com/SoftwareCarpentryLessonManager/novice-git-intro/archive/v0.1.0.tar.gz
bower download      https://github.com/SoftwareCarpentryLessonManager/novice-git-open/archive/v0.1.0.tar.gz
bower extract       novice-git-intro#* archive.tar.gz
bower invalid-meta  novice-git-intro is missing "ignore" entry in bower.json
bower resolved      git://github.com/SoftwareCarpentryLessonManager/novice-git-intro.git#0.1.0
bower extract       novice-git-open#* archive.tar.gz
bower invalid-meta  novice-git-open is missing "ignore" entry in bower.json
bower resolved      git://github.com/SoftwareCarpentryLessonManager/novice-git-open.git#0.1.0
bower extract       template#* archive.tar.gz
bower invalid-meta  software-carpentry-template is missing "ignore" entry in bower.json
bower resolved      git://github.com/SoftwareCarpentryLessonManager/software-carpentry-template.git#0.1.0
bower install       novice-shell-intro#0.1.0
bower install       novice-shell-filedir#0.1.0
bower install       novice-shell-create#0.1.0
bower install       novice-git-backup#0.1.0
bower install       novice-git-intro#0.1.0
bower install       novice-git-open#0.1.0
bower install       template#0.1.0

novice-shell-intro#0.1.0 novice-shell-intro

novice-shell-filedir#0.1.0 novice-shell-filedir
└── novice-shell-intro#0.1.0

novice-shell-create#0.1.0 novice-shell-create
├── novice-shell-filedir#0.1.0
└── novice-shell-intro#0.1.0

novice-git-backup#0.1.0 novice-git-backup
├── novice-git-intro#0.1.0
└── novice-shell-filedir#0.1.0

novice-git-intro#0.1.0 novice-git-intro

novice-git-open#0.1.0 novice-git-open

template#0.1.0 template
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
