--- 
layout: simple
title: Scope, Goals and Open Questions
---

[See this page rendered](http://twitwi.github.io/lesson-manager/01-scope-and-goals.html)

<ul class="keypoints">
    <li>this is an attempt at defining the project and motivating some choices</li>
    <li>this is also a base for opening discussions</li>
</ul>

(by Rémi Emonet)

This is a follow-up on the [post by Raniere](http://blog.rgaiacs.com/2014/07/02/import_lesson_is_possible.html).
I agree on a lot of it, including the fact that we should build on top of versioning systems, use HTML, that we can use a JSON format for metadata, …
In this document I detail some comments and additional reflections that I find important for the project.

## Scope: installing lessons vs having a lesson platform

<ul class="keypoints">
    <li>being able to view the graph of "learning units" is important</li>
    <li><a href="http://www.metacademy.org/">metacademy</a> is amazing</li>
    <li>metacademy is a graph of concept (with attached lessons) but without versioning</li>
</ul>

The original formulation of the project is to be able to choose and import lessons when preparing for a bootcamp.
However, once we start describing lessons, much more can be done, such as:

- giving an overview of the graph of lessons (when preparing, when you're a new instructor, …)
- using the graph to make it possible for learners to know what they can do/explore after the bootcamp
- using the graph to explicitly state the requirements (pre-conditions) to attend a bootcamp (e.g., installation can be pre-condition for novice bootcamp) (e.g., novice shell lesson may be a precondition for a not-totally-novice bootcamp)
- supporting self-learners (out of bootcamps) and past learners that want to stay up to date

I personally think that we shouldn't restrict the scope to an “import lesson”.
A recent project started [drawing graphs of lessons/concepts](http://www.metacademy.org/graphs/concepts/regularization#focus=x6e7glql&mode=explore) is called [metacademy](http://www.metacademy.org/).
I find it very promising (these guys are in my research domain so I might be biased).
One problem I've seen is that their lessons are un-versioned.


## Global structure: lessons, collections, skill, etc

<ul class="keypoints">
    <li>we should have lessons (that can depend on each others etc), maybe named “learning units”</li>
    <li>we should also have collections of lessons with added glue (menu page, etc)</li>
</ul>

Raniere proposed to have two hierarchical levels: lessons and collections.
This is very interesting.
The alternative are to just have lessons (and no concept of collections) but this is limiting when building (and sharing or forking) an existing bootcamp.
Another alternative is to allow hierarchical lessons: a collection is just a lessons that contains others lessons + some glue, but it is a lesson in itself and thus can be depended on etc.
This last solution is probably too complicated for an unclear gain (hierarchical dependencies are difficult to grok).

On the naming aspects, maybe a individual lesson could be named “learning unit/object” because these might be more varied than only lessons (installation, hands-on, …).
This is just a suggestion to be discussed.

The collection is the place where the instructors specify what they want to teach and include.
We might consider also the things they don't want to include, for example if some lessons are considered as prerequisites, or if some lessons are just "recommended" and not hard dependencies.


## What's in the graph

<ul class="keypoints">
    <li>we should first focus on plain dependencies, with fixed versions</li>
    <li>we should consider "virtual packages" early</li>
</ul>

The most structuring questions are around what we put in the dependency graph.
There are many concepts in existing package managers and most of them are actually meaningful for lessons:

- A depends on X: the basic concept of dependency from a lesson A on X.
  One open question is: what is the nature of X?
- A provides X: we call X a virtual package.
  The principle is that multiple lessons (A, B, ...) are different but provide the same skill/knowledge X.
  This is a way of making "or" between lessons, for example, if "C depends on X", then anyone who followed A or B can follow C.
  The concept of virtual package, or we could call it "skill/achievement/..." is quite important as the lessons are starting to get diversified.
- A recommends X (or even, X recommends Y): to express things that are not required but interesting to have.
  This is interesting but not a core functionality.

It is probably simpler if each lesson has a unique name, if this name does not contain any white space, e.g. from Raniere, "shell-filedir".
Maven uses an "artifact id" (the lesson name) and a "group id" (the organization name), [together they should be unique](http://maven.apache.org/pom.html#Maven_Coordinates).
We could adopt the same strategy but it is probably not necessary at first (most lessons would be in the software-carpentry group anyways).

All software and package dependency systems use version and each dependency is expressed using a name and a version (or version range).
To avoid problems when we evolve lessons, I think we should include such information right away.


## Semantic versioning

<ul class="keypoints">
    <li>we should use semantic versioning (e.g., 4.0.3, which has been proven useful</li>
    <li>we need to specify/document/explain the different levels</li>
</ul>

To reference a version of a lessons, we could just use the plain git SHA1 (or mercurial equivalent)
As a lesson maintainer, this is simpler on one side but it makes it very difficult to know if can safely update our dependencies, or if we something important changed in the lessons we depends on.
[Semantic versioning](http://semver.org/) is used a lot is software development: versions are made of 3 numbers, fore example 4.0.3 or 1.2.3.

The last number is indicates the "patch" number, and if only this number changes it means only small fixes have been applied (e.g., in a lesson, removed a typo, reformulated a few sentences, ...) but nothing notable changed (e.g., we're still talking about Nelle, we still cover the loops in bash, ...).
The second number in the version is increased when new elements are added but the one covered before are still there, e.g., if we add exercises in a lesson.
This might be a hint (for people depending on it) that it might be good to review the changes in the new version to maybe improve the transition between the lessons.
The first number is changed when the changes are such that something very central changed, e.g., the bash intro don't talk about Nelle anymore, or the python intro is totally rewritten and shows numpy, etc.

Usually, people will upgrade their dependencies as such: "patch" are applied blindly (e.g., from 4.0.3 to 4.0.7), "minor" versions will need a quick review of the diff before upgrading (e.g., from 4.0.3 to 4.1.0), "major" upgrades will require some rewrite and discussions (e.g., from 4.0.3 to 5.0.0).

Semantic versioning (is very beneficial but) requires people to understand the meaning of the version numbers and we will have to document, explain and teach this.


## Distributed deployment

<ul class="keypoints">
    <li>we should avoid repeating github urls as much as possible</li>
    <li>we should still allow direct references (e.g., to a git repo)</li>
    <li>we should accept a repository containing multiple lessons</li>
</ul>

Most package system distinguishes name of the required package from where to find it.
In dpkg (debian, ubuntu, ...) a package depend on another using a name and a version, and a configuration file tells where to find repositories with lists of packages.
Maven (java, ...) has the same concept of repositories and a project depends only on libraries using their name and version (no precise location).
I think we should adopt a similar solution, compared to the example proposed by Raniere.
In the examples, there is a lot of repetitions of "http://github.com" and other urls (and also the "protocol") which mixes two concerns: what to import and from where to import it.
We should however keep it possible to use easily new repositories if we want to mix and match things from the mainstream repositories and from a custom one.

As implicitly proposed by Raniere, it might be tempting to cleanly split the existing repository such that we get one repository per lesson (this is what is usually done in package systems such as npm, etc).
Even if I like this clean split, I expect such an architecture to be a huge obstacle for our instructors working on multiple lessons.
It would also discourage instructors in doing proper fine-grained description of lessons, e.g.: “I don't want to create 3 repositories for the git lessons so I'll just say it's one big lesson”.
Overall I think a lesson should be a folder in a repo (maybe defaulting to the root of the repo) such that it is easy to have multiple lessons in a single repository.
A bonus is that we can start reusing existing repositories (software carpentry ones, tutorials for some projects, ...) without really requiring to first slice and dice these repository.
A potential issue to work around is that we might need to clone the same repo many times (to get different subparts at different git revisions).


## Licenses and formats

I agree with going for only open licenses and formats.
We should use HTML as suggested by Raniere, as it is widely readable.
This can include videos and interactive Javascript "applets".
We should strongly encourage anything that can be written/converted into HTML to be.

## Implementation: what to reuse

<ul class="keypoints">
    <li>it is more flexible to not use a complete existing package manager</li>
    <li>we can use a library to help in resolving dependencies</li>
</ul>

I can think of multiple ways of implementing this.
We could reuse some complete package manager like pip, 0install, apt, maven, …
I think (but I'm far from sure) that this would be to much of a constraint, especially if we want to reference existing material (e.g., on github) and not repackage everything.
We could also start from scratch, but handling dependencies etc can get complicated.
The best would be to find a flexible library that helps in managing and resolving dependencies.
I found a promising [project for dependency management](https://github.com/enthought/depsolver) and the author seems to be reactive.





## More links

- On depsolver
  - https://github.com/enthought/depsolver
  - https://speakerdeck.com/cournape/depsolver-pycon-dot-fr
- Discussions etc on the formats (epub, ...)
  - https://lists.okfn.org/pipermail/open-education/2014-July/000500.html
  - http://blogs.cetis.ac.uk/wilbert/2014/06/24/when-does-a-book-become-a-web-platform/
- About metacademy
  - http://www.metacademy.org/
  - http://hunch.net/?p=2714 (blog post)
  - https://github.com/metacademy/metacademy-content/wiki/Database-format
- On some existing packaging systems
  - http://debian-handbook.info/browse/stable/sect.package-meta-information.html
  - https://www.npmjs.org/
  - http://bower.io/docs/api/
