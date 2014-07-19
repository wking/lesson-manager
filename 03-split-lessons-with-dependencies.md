


This file aims at documenting/proposing a split of the current lessons and expressing dependencies.

# Describing dependencies

Important: see also [the glossary](04-glossary.md).

We'll use the notion of "concept", which is something that could be learned via different "learning units".
It is a kind of "virtual package" in traditional package managers, to fulfill it, one can follow either of the "learning units".
Concepts (or virtual packages) are a way of doing "logical OR" in a dependency tree.
The CONCEPTS section below lists these (that will then appear in a box in the rendered graph.

The DEPENDENCIES section below contains relations between concepts and/or learning units.
The arrows go forward, "A -> B" means "B requires A", if B is lesson and A is either a concept or a lesson.
"A -> B" means "A provides B", if B is a concept (and A is either a concept or a lesson).

We can use a dot-like notation, then run « ./03-view.sh » to view the result (requires graphviz to be installed).

Important: we describe here the current situation, so we don't show any version for the learning units, but in the end all we get a version number.

CONCEPTS

    InstalledShell
    IntroducedNorthPacificGyre
    IntroducedNelleNemo
    IntroducedTabCompletion
    IntroducedTextEdition
    IntroducedShellHasOption
    
    # these are maybe too fine-grained for a first version?
    IntroducedCommandLs
    IntroducedCommandCd
    IntroducedCommandPwd
    IntroducedCommandRm
    IntroducedCommandMv
    IntroducedCommandMkdir

DEPENDENCIES

    ShellIntro -> IntroducedNelleNemo
    ShellIntro -> IntroducedNorthPacificGyre

    # from shell filedir (could be seen in two parts also, with a vlad part and a Nelle recap)
    InstalledShell -> ShellFiledir
    IntroducedNelleNemo -> ShellFiledir
    ShellFiledir -> IntroducedCommandPwd
    ShellFiledir -> IntroducedCommandLs
    ShellFiledir -> IntroducedCommandCd
    ShellFiledir -> IntroducedTabCompletion
    ShellFiledir -> IntroducedShellHasOption
    
    # from shell create (simple dependency here, but could also rather depend on the introduced concepts?)
    ShellFiledir -> ShellCreate
    ShellCreate -> IntroducedTextEdition
    ShellCreate -> IntroducedCommandRm
    ShellCreate -> IntroducedCommandMv
    ShellCreate -> IntroducedCommandMkdir
    
    # ......
    ShellCreate -> ShellPipefilter

    # maybe we want to specify installation requirement as learning units
    InstallingAnaconda27 -> InstalledShell
    InstallingAnaconda27 -> InstalledPython27

END

<img src="http://twitwi.github.io/lesson-manager/03-graph.svg" alt="rendered graph from gh-pages" />
