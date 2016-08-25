# Command line introduction and shell scripting

## Overview

This provides an basic introduction to shell programming. If you
use Linux much at all, you'll at least occasionally find yourself needing
to use the shell/command line (i.e., what you get when you open the terminal program). Having experience with the shell is extremely useful, as you often
end up needing to, e.g., `ssh` into a remote or cloud system where you won't
have access to the nice GUI tools. This lab provides an introduction to a
variety of important shell tools and how programming/scripting is done
using shell commands.

:warning: Remember to complete the [Command line introduction pre-lab](https://github.com/UMM-CSci-Systems/Command-line-introduction-pre-lab) reading and preparation before this lab begins.

-   [Introduction](#introduction)
-   [Setting up](#setting-up)
-   [Exercises](#exercises)
    - [ ]  [First script: Compiling a C
    program](#first-script-compiling-a-c-program)
    - [ ]  [Second script: Clean up a big
    directory](#second-script-clean-up-a-big-directory)
    - [ ]  [Third script: Playing with find and
    sed](#third-script-playing-with-find-and-sed)
-   [Final Thoughts](#final-thoughts)
-   [What to turn in](#what-to-turn-in)


## Introduction

You will need to write several different scripts for this lab:

-   A script to extract the contents of a `tar` archive, and then compile and run
    the C program it contains
-   A script to delete a large number of unwanted files, leaving the
    other files in that directory alone
-   A script that separates executable files from non-executable ones,
    processing the two groups differently

None of these will be very long, but most or all of them will require
you to learn new shell commands or tools. We’ll give you hints and
pointers as to what commands/tools to be using, but you’ll need to
do some digging in the `man` pages and/or searching on-line to find
the details. Don’t bang your head against any piece of this for too
long. If you’ve spent more than 10 minutes on a single part or command,
you probably need to take a break and ask someone (like your instructor)
for some help. On the other side of the coin, however, don’t immediately
give up and ask at every step. Learning how to find and use this sort
of information is an enormously valuable skill, and will be useful
far longer and more often than the details that you’re actually looking
up. So make a bit of an effort, but know when to stop.

## Setting up

Before you start writing scripts, you’ll need get a copy of this repository
to work on. This is a two step process:

* First _fork_ the repository on Github
* Then _clone_ **your fork** to the machine you're working on

If you're working in pairs or larger groups only _one_ of you needs to fork
the repository, but that person then needs to add everyone else as collaborators on the project, and then everyone will need to clone the project to their machine to work on it.

You’ll “turn in” your work simply by having it committed to the
repository. We’ll check it out from there to run and grade it.
We'll obviously need to be able to find your repository to grade it,
so make sure to submit the URL of your forked repository
using whatever technique is indicated by your instructor.

Be certain to **commit often**, and **trade places at the keyboard
often**. At a minimum you should probably trade every time you solve
a specific problem that comes out of the test script. You should probably
consider committing that often as well.

---

# Exercises

There are three exercises that you should complete for this lab:

- [ ] [First script: Compiling a C program](#first-script-compiling-a-c-program)
- [ ] [Second script: Clean up a big directory](#second-script-clean-up-a-big-directory)
- [ ] [Third script: Playing with `find` and `sed`](#third-script-playing-with-find-and-sed)

The tests and any relevant files for each part are in the appropriate
sub-directory in this repository:

* `compiling`
* `cleaning`
* `find_and_sed`

In each case there are tests written using the [`bats` testing tool for `bash` scripts](https://github.com/sstephenson/bats) in a file called `tests.bats`.
You should be able to run the tests with `bats tests.bats`, and use the testing
results as a guide to the development of your scripts. If you ever find that you
don't understand what the tests are "telling you", definitely ask; they are
there to help you, and if they aren't communicating effectively then they're
not doing their job.

You should get all the tests to pass before you "turn in" your work. Having
the tests pass doesn't guarantee that your scripts are 100% correct, but it's a
strong initial indicator.

One thing the tests _can't_ gracefully test is the proper use temporary scratch
directories when appropriate. If your script is supposed to create a temporary
directory, do some work there, and then delete it, then there's no easy way
to confirm that you actually did that "correctly". We've demonstrated how to
properly create, use, and delete temporary scratch directories in
the [`git-bats-demo` videos](https://www.youtube.com/playlist?list=PLSAR9qWL-3y7Z--_jF7KUMUwjCwPjjJCY);
make sure you ask questions about that if you're unsure, though, as the tests
aren't necessarily going to alert you if you have a problem with this part of
the process.

## First script: Compiling a C program

The tests and data for this problem are in the `compiling` directory of this project, and the discussion of this problem will all assume that you've `cd`ed into that directory. Your goal is to get the tests in `tests.bats` (in the `compiling` directory) to pass.

For this you should write a bash script called `extract_and_compile.sh` that:

-   Takes two arguments.
    -   The first is a number that will be used as an argument when you call the C program that you'll be compiling in a bit.
    -   The second is the name of a directory that you should do extract the files into and compile the program.
-   Extracts the contents of the tar archive `NthPrime.tgz` into the
    specified directory. This is a compressed tar file (indicated by
    the `gz`, for `gzip`, in the file extension),
    so you’ll need to uncompress and then extract; the `tar` command can
    do both things in one step. You might find the `man` pages
    for `tar`.
-   Compiles the C program that gets extracted, generating an executable
    called `NthPrime` (still in the specified temporary directory).
-   Call the resulting executable (`NthPrime`). `NthPrime` requires a single
    number as a command line argument; you should pass it the first of the two
    command line arguments your script received.

As an example, imagine your script is called using:

```bash
./extract_and_compile.sh 17 /tmp/tmp.7dMpfowoGF
```

Then it should

* Extract the contents of `NthPrime.tgz` into
`/tmp/tmp.7dMpfowoGF`.
* Compile the files in `/tmp/tmp.7dMpfowoGF` to generate the binary
`/tmp/tmp.7dMpfowoGF/NthPrime`.
* Run that binary with the argument `17` (the first argument in this example); this should generate the output `Prime 17 = 59.`

Remember that you can call your script "by hand" as a debugging aid so you can
see exactly what it's doing and where. So you could do something like

```bash
mkdir /tmp/frogs
./extract_and_compile.sh 8 /tmp/frogs
```

and then go look in `/tmp/frogs` and see what your script did there. It's
important that the scratch directory exist before you call your script (hence
the `mkdir` call first). You would want to empty the contents of the scratch
directory before calling your script a second time, or you won't be able to
tell what was left over from the first call. You probably want to delete
`/tmp/frogs` (or whatever you called it) when you're done just as a politness
so you don't clutter up `/tmp/` unnecessarily.

### Some notes on compiling a C program

The C compiler in the lab is `gcc`.

There are two .c files in this program, both of which will need to be
compiled and linked. You can do this in a single line (handing gcc both
.c files) or you can compile them separately and then link them.

You can tell `gcc` what you want the executable called, or you can take
the default output and rename it.

Most of you have never compiled a C program before, so this might be a
good time to ask me to say a little about how that works. Alternately,
you might see what you can figure out with `man gcc`.

:exclamation: When you run the program you compiled (`NthPrime`) give it
the second command line argument _your_ script received as its sole command
line argument.

### :alert: Some non-obvious assumptions that the test script makes:

-   The `.tgz` version of the tar archive will be in the specified directory
    when you’re done. This means that if you first `gunzip` and then, in a
    separate step, untar, the test is likely to fail since you’ll end up
    with a `.tar` file instead of a `.tgz` file.

## Second script: Clean up a big directory

Your goal here is to get the test in
`~dolanp/pub/CSci3403/Lab0/big_clean_test.sh` to pass.

For this you should write a bash script named `big_clean.sh` that:

-   Takes two arguments:
    - The first will be the name of a compressed `tar` archive (`.tgz` file) that contains the files you'll process.   
    - The second will be the name of a scratch directory you can do your work in.
-   Extracts the contents of the `tar` archive into the specified scratch directory. This will take a few seconds for `big_dir.tgz` since that has over 1000 files in it.
-   Removes all the files from the scratch directory (i.e., the files that came from your `tar` archive) containing the line “DELETE ME!”, while
    leaving all the others alone. (There are quite a few ways to
    do this. The `grep` family of tools is probably the easiest way to
    see if a file has the “DELETE ME!” line. You could then use a shell
    loop to loop through all the files and remove the ones that have the
    line, or you can use backticks and `rm`.)
-   Create a _new_ compressed `tar` archive that contains the files in the scratch directory _after_ you've removed the "DELETE ME!" files. The files in the archive should _not_ have the path to the scratch directory in their filenames.
    - This is probably the trickiest part of the lab because you have to be in the scratch directory when you create the `tar` archive or you'll end up with the path to the scratch directory in all the file names.
    - It's easy enough to `cd $SCRATCH` or `pushd $SCRATCH` to get to the scratch directory to run the `tar -zcf...` command, but then how do you know where you came from, so you can put the new tar file in the right place? The `pwd` command returns your current working directory, so something like `here=\`pwd\`` will capture your current directory in a shell variable called `here` so you can use `$here` later to refer to where you had been.

## Third script: Playing with `find` and `sed`

The command `find` is an extremely powerful and cool tool which I use
all the time in teaching, lab admin, and research. There are also a
number of very useful scriptable editing tools that are good to know
about. In this exercise we’ll use `sed` (which stands for “stream
editor”), which is one of a number of cool scriptable editing tools that
are good to know about; `awk` is another one that’s particularly worth
looking up.

There’s a test script in
`~dolanp/pub/CSci3403/Lab0/Fix_headers/fix_header_test.sh` that you want
to make pass. You’ll want to make a script called <span
class="highlight">fix\_headers.sh</span> that does the following:

-   Copy the directory `~dolanp/pub/CSci3403/Lab0/Fix_headers/files` to
    the working directory (specified as the first command line
    argument again)
-   For every executable file in that directory, remove the space from
    the header line, i.e., change `#! /bin/bash` to `#!/bin/bash`. (It
    turns out that having a space there is in fact an error and causes
    the specified program to be ignored, so we want to remove those.)
-   For every file that’s not executable, replace the string “Running a
    script” with “Not running a script”.

# Final Thoughts

Make sure that all your code passes the appropriate tests. Passing the
test will make up the majority of your grade. There will also be a
portion of your grade that will take into account how clean your code
is. Also when we said that you should commit often –- we meant it. Also be
professional and informative about your commit messages; we'll be looking
at them in the grading. Finally, it is easy to overlook important details. If
the test isn’t being passed go back and re-read the directions
*carefully*.

# What to turn in

You'll "turn this in" by committing your work to your fork of this starter
project. You should also submit the URL of your repository in whatever way
indicated by your instructor. Remember to make sure you've completed each
of the three assigned tasks:

- [ ] First script: Compiling a C program
- [ ] Second script: Clean up a big directory
- [ ] Third script: Playing with `find` and `sed`
