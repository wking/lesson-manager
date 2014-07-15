--- 
layout: simple
title: Choices, Focus and Tasks for the Sprint
---

# Important preamble

**NOTE**: the tasks will first be handled in the etherpad to make interactions more fluid

 **NOTE**: maybe, a very first version would be better of with using an existing package manager

 - bower is very promising as it uses git directly, but it is very flat on dependency handling (no resolution of transitive dependencies), bower does not handle "virtual packages"
 - most other package manager are either custom hosted (no direct git hosting) and/or handle only specific kind of packages (e.g., javascript modules)

 # Focus

A good target for the sprint is a complete system working with the main subpart of our lessons (shell, git, ...).
We should rather target a complete system with only a few lessons, rather than a feature-rich system that is incomplete.

Depending on the number of involved people, a lot of non-coding work can be done (and won't be lost) concerning the separation of existing lessons in subparts (and their dependencies).


# Global Choices (at first, can be reconsidered later)

High level choices:

- We'll use python as most of us know it.
- We'll use a library to help with dependency management: https://github.com/enthought/depsolver .
- We'll share the code, test, "collection" metadata, … in the current repo: https://github.com/twitwi/lesson-manager .
- We'll fork the main https://github.com/swcarpentry/bc if it needs to be reworked (add metadata, move thing around, ...)
- but it seems likely that we will start with a 1 lesson per repository as it is easier… so we might end up doing a lot of small repos
- We'll handle only git as a versioning backend (we won't allow mercurial hosted lessons for now).
- TODO: Test framework? focus on integration tests?

# User story

Big QUESTION: should we think about making it easy to contribute to lessons also (e.g., when we get a lesson, a fork is made with our account and a branch is created in case we edit other things… then we are close to submodules and their complexity).

Grace and Alan are preparing for a bootcamp to be held at Euphoric State University.
They decide that they will cover the shell basics, git and python.
They also want to add a domain-specific final exercise on studying data about the new euphoric particle.

It happens that there is already a template repository containing a "learning collection" including basic installation instructions, shell basics, git lessons and python.
When they consider this learning collection, the only missing things are the tuning for the particular bootcamp (location, time, ...), the lesson on github collaboration (that already exists and that they plan to cover in addition) and the final exercise that they need build up.

Here is what Grace and Alan will do in practice:

- install the "lesson" command (it is probably already installed as they did the instructor training which encourages to install it)
- run "lesson update" to get the list of available "lesson units" from a central lesson unit repository (this repository is just a file on github)
- fork the template repository: it contains a descriptor of the "learning collection" (not the actual lessons) and an index page (a jekyll page) 
- edit the settings file to fill in the location, time, etc (as it is done today)
- run "lesson get", this will fetch the "learning units" from the different repositories and put them is subfolders that are .gitignore'd and whose files are referenced in the index page (using the automatic menu and/or manual links).
  - QUESTION: how to handle the case of multiple versions of the same learning unit? probably give an error
  - QUESTION: how to handle the use case where we put multiple lessons in a same repo? do we clone multiple times? do we checkout and copy?
  - QUESTION: how do we prevent live edition of learning units? should we encourage and handle it?
  - running "lesson get" will also indicate that the python lesson has a new minor version (and encourage an update)
- run "lesson search github" getting a list of known lessons, and see that there is the swc-github, which latest version is 5.1.2
- update the collection descriptor file to add the reference to the swc-github learning unit, specifying the version 5.1.2 (or 5.1.*)
- run "lesson get" again (to fetch/get the content of the github lesson)
- add a custom text in the index page about github: even though it includes a automatic menu which will contain a link to the github lesson unit, the instructors can still edit the index page
- make a new repository for the final exercise
  - put resources in it
  - write a descriptor that
    - references the lessons on which it depends and their versions (actually all of them as it is a final exercise (python, git, github, shell))
    - specifies the current version
    - lists what to put in the menu
    - QUESTION what if we push patches and don't change the versions????!
  - push that in a public repository
- edit back their "learning collection" descriptor so that it references this new repository (without going through the central lesson unit repository (they might reference it there later)
- run "lesson collection publish"
  - this would warn them if they forgot to commit their changes (or are not on the master branch)
  - this will switch to the gh-pages branch, fast forward to master, and add/commit/push all the used lesson units so that they appear as a website


# Choices, Work-in-progress

- "include lesson swc-shell version 3.3.0 as old-shell" (a-la python, maybe to allow for multiple versions with different names)
- the tool clones each repository in a subfolder
- we must handle versioning (of lessons) right away, meaning there will be multiple versions of each lesson referenced in the central repository

# Open questions / Nice to have features

- Could "pip" packages be considered as "lessons" (to express dependencies and automatically install them)? same for anaconda? …
- 



