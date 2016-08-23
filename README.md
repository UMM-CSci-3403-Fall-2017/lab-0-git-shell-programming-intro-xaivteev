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

-   A script to copy and open up a `tar` archive, and then compile and run
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

Your goal here is to get the test in
`~dolanp/pub/CSci3403/Lab0/copy_and_compile_test.sh` to pass.

For this you should write a bash script called <span
class="highlight">`copy_and_compile.sh`</span> that:

-   Takes two arguments.
-   The first should be the name of a directory that you can safely
    assume doesn’t currently exist.
-   The second should be a number that will be used as an argument to
    the C program later.
-   Creates that directory
-   Copies the tarball `~dolan118/pub/CSci3403/Lab0/NthPrime.tgz` to
    your new directory
-   Extracts the files from that tarball (This is a compressed tar file,
    so you’ll need to uncompress and then extract. The `tar` command can
    do both things in one step, or you can use `gunzip` to decompress
    and then tar to extract. I’d definitely visit the man pages
    for tar.)
-   Compiles the C program that gets extracted and call the resulting
    executable `NthPrime`. The executable should be place in the same
    directory as the C files, i.e., the NthPrime directory.

The C compiler in the lab is `gcc`.

There are two .c files in this program, both of which will need to be
compiled and linked. You can do this in a single line (handing gcc both
.c files) or you can compile them separately and then link them.

You can tell `gcc` what you want the executable called, or you can take
the default output and rename it.

Most of you have never compiled a C program before, so this might be a
good time to ask me to say a little about how that works. Alternately,
you might see what you can figure out with `man gcc`.

\*\* Run the program with your second argument as its sole command line
argument, putting the results in the file `results.txt` in the
\*NthPrime\*\* directory you created. This will require output
redirection as described in the tutorial in the pre-reading.

-   Run the test file in the same directory as your script (which will
    require that you copy the test file to whatever directory you’re
    building your script in).

**ALERT!** Some non-obvious assumptions that my test script makes:

-   The .tgz version of the tarball will be in the specified directory
    when you’re done. This means that if you first unzip and then, in a
    separate step, untar, the test is likely to fail since you’ll end up
    with a .tar file instead of a .tgz file.

## Second script: Clean up a big directory

Your goal here is to get the test in
`~dolanp/pub/CSci3403/Lab0/big_clean_test.sh` to pass.

For this you should write a bash script named <span
class="highlight">big\_clean.sh</span> that:

-   Takes one argument (This should be the name of a directory that you
    can safely assume doesn’t currently exist.)
-   Creates that directory
-   Copies the directory `~dolanp/pub/CSci3403/Lab0/big_dir` to your
    new directory. (This will require copying a directory with many
    files, so you’ll need the recursive version of `cp`.) This will also
    take a few seconds - there are 1001 files in the directory.
-   Removes all the files containing the line “DELETE ME!”, while
    leaving all the others alone. (There are quite a few ways to
    do this. The `grep` family of tools is probably the easiest way to
    see if a file has the “DELETE ME!” line. You could then use a shell
    loop to loop through all the files and remove the ones that have the
    line, or you can use backticks and `rm`.)
-   Counts the number of remaining files and puts the result in
    `remaining_file_count.txt`. That file should just contain that
    number and nothing else. The command `wc` might be useful here, but
    you’ll need to look at flags and figure out how to connect `wc` to
    `ls`. Output redirection will be useful again.
-   Run the test file in the same directory as your script (which will
    require that you copy the test file to whatever directory you’re
    building your script in).

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
