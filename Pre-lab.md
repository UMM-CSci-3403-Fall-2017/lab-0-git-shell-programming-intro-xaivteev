#Prelab 0

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents** 
  - [Working in groups](#working-in-groups)
  - [Tasks to learn](#tasks-to-learn)
  - [Picking a command line editor and starting to learn it](#picking-a-command-line-editor-and-starting-to-learn-it)
  - [Learning bash](#learning-bash)
     - [Exercises](#bash-exercises)
  - [gitting to it](#gitting-to-it)
     - [Exercises](#git-exercises)
  - [What to do](#what-to-do)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Working in groups

Working in small groups (preferably of size 2) is encouraged.  You'll want to come up with a name for your group.

## Tasks to learn

* Pick a command-line editor and start to learn it
* Start reading about 'bash'
* Start reading about 'git'

## Picking a command line editor and starting to learn it

It's enormously useful to know how to use a command line editor for those times when you don't have access to all the nifty windowing stuff that we've grown so happily used to using. Your best options are probably `emacs` and `vim` (or its less sophisticated ancestor `vi` ).  There are many other options, but these two are some of the more popular *powerful* options (I'll outline a few reasons below)

Some people prefer more user-friendly options like `nano` or `pico`, but if you are starting from scratch it is not a bad idea to pick one with a tougher learning curve like `vim` or `emacs`.  They are harder to learn at first, but offer more powerful options later.

I used to use `emacs`, but these days I default to `vim` for a couple of reasons:

* Almost every version of linux or unix comes with `vi` "out of the box"
* I like the `vi` philosophy 
* The tutorial http://vim-adventures.com/ was fun

On the other hand-- emacs has some pretty cool features too:

* It has a Turing Complete scripting language
* In some ways it's like a mini-operating system
* It's easy to extend (I've heard)

You might find some good material at https://www.masteringemacs.org/reading-guide.

##Learning bash

In just a moment I am going to ask you to do a tutorial.  In a few places that tutorial makes some assumptions about prior knowledge.  We will cover some of that material on Thursday.  In particular, we will be discussing:

* the structure of a file system
* a short overview of permissions
* how to execute a script
* Standard input, standard output, standard error, and piping
* Some relevant odds-and-ends

If these ideas are new to you (or you just want some reinforcement), then try

http://ryanstutorials.net/linuxtutorial/piping.php

**Now... back to your originally scheduled tutorial.**

Before the start of next week's lab you should complete this shell tutorial: http://www.linuxdoc.org/HOWTO/Bash-Prog-Intro-HOWTO.html. 

It may look a little daunting when you see the table of contents (there are 14 sections!), but each of the sections are very short so the reading shouldn't take long. I'd particularly concentrate on Sections 2 through 7, but the whole thing is worth reading through. I strongly would advise that you do the reading in the lab or at least at a machine that has a terminal program with the bash shell installed so you can try some of these things out.  

As you are going through the tutorial go through it once in a quick pass and don't worry too much if things don't make perfect sense the first time (this tutorial is good for review-- but frequently introduces useful information *after* the first time it uses it).  **AFTER** the first pass, if something is not making sense on your second reading, or does not seem to be working correctly **please** ask me about it.

The page http://tldp.org/LDP/Bash-Beginners-Guide/html/index.html also has a nice set of tutorials and goes a bit deeper on some subjects (you may find it useful to read them in tandem).  However, although it's worth looking at, please don't knock yourself out trying to understand it all before next class.

In addition, the video sequence starting here:

https://www.youtube.com/watch?v=NWWvZa-qlRE (start at minute 4:34)

is quite nice.  (You'll notice that the narrator is using `nano` as their editor-- **you** should be using the editor you choose earlier.)  These videos are better about **not** assuming prior knowledge but suffer from two problems:

* It's hard to go back and find previous information
* It takes a lot longer than reading (at least for me)

Feel free to watch them.

Most Windows users won't have a version of bash, and if you're not sure you almost certainly don't. It's available standard out of box on Macs and Linux boxes; if you have a Mac, look in your Applications/Utilities and you'll fine it.  If you are using windows you can install `cygwin` (https://www.cygwin.com/).

The final thing I'll mention here is the `man` command. If during your reading or the lab you run across a command that you aren't familiar with then the man command is your friend. To find out more about a certain shell function simply type in

```man function_name_here```

This will bring up a page that (supposedly) describes what that function does. Navigate the man page with the arrow keys and press q to quit back to the command line.

Keep in mind that man pages are written by the person or persons who created the function. This means that the man pages throughout the shell vary from extremely technical and detailed to non-existent. If the man page isn't helpful, some simple googling should bring up tons of sites to supplement a poor man page.

###<a name="bash-exercises"></a>Exercise (due before the start of lab on Tuesday)

You'll want to start by making a directory to hold your files and subdirectories.  Call that whatever you like-- you're not going to turn it in-- only its contents.  We'll call it the the prelab directory.

In the prelab directory, you are going to be creating a directory called `testing` that contains two files and an empty directory called `more_testing` (More on that down below.)  Your prelab directory should also contain a text file (that you will need to create) named *your_group.member_a.member_b.lab0_prelab.txt* (for example:  `eternal_lettuce.dolanp.lamberty.lab0_prelab.txt`).  That file will contain the answers to the questions I ask below:

You can either construct this directory and file structure by hand using tools like `mkdir` and editors, or you can copy the directory structure from `/home/dolanp/pub/CSci3403/testing` using `cp`. (You'll want to be able to do it both ways, so you might try it both ways as well.)

Everything that follows assumes that you're starting in the directory called `testing`.

The first file is called `testfile1.txt` and contains the following text:

```
I like coding with bash!
Shell scripts are awesome!
```


The file `testfile2.txt` is also contained in `testing` and contains the following text:

```
I'm scared without the safety of Eclipse!
Take me back Java!
```

Remember that the `testing` directory should also contain an **empty** directory named `more_testing`.

Assume all scripts start in the testing directory unless otherwise stated.  Your *your_group_lab0_prelab.txt* file should contain the directory you're in (the `pwd` [Print Working Directory] command will be useful here) after **each** line of the following code:

```
cd /home/dolanp/pub
pushd ~
pushd
```

It should also contain the output of each of the following lines:

```
grep bash testfile1.txt
grep bash testfile2.txt
grep -l bash *.txt
find -type f
find -type d
```

And finally, include the contents of `testfile1.txt` and `testfile2.txt` after the following two lines are executed:

```
sed -i "s_Eclipse_my cuddly IDE_g" testfile1.txt
sed -i "s_Eclipse_my cuddly IDE_g" testfile2.txt
```

##<a name="gitting-to-it"></a>`gitting` to it

We'll use `git` through the course as a way for groups to manage shared project resources (like code) and as the primary means for you to turn in your finished work. Some of you will be familiar with `git` from previous courses, while others will have never used it before. If you've never used `git` before you might want to read https://www.atlassian.com/git/tutorials/
and https://github.com/Kunena/Kunena-Forum/wiki/Create-a-new-branch-with-git-and-manage-branches

####<a name="git-exercises"></a>Exercise (also due before class on Tuesday)

You belong to the organization UMM-CSci3403-F15.  One person in your group should login to Github and go to [https://github.umn.edu/UMM-CSci3403-F15/Prelab-0] which has this file (as you know-- you **are** after all reading this).  Next you should create a fork of this repository and push the text files (and subdirectories) with your answers from above.   Don't forget the your file of the form *your_group.member_a.member_b.lab0_prelab.txt* needs to be in your project's root directory so I can know who is in your group.  Make the name of your branch your group name.

Here is one set of procedures you could follow (there are others):

* Clone the file(s) from the repository using `git clone  https://github.umn.edu/UMM-CSci3403-F15/Lab_0.git` (This will make a subdirectory.  Change the current directory to this subdirectory.)
* Create a new branch `git branch [name_of_your_branch]`
* Switch to that branch `git checkout [name_of_your_branch]`
* Make your changes to the contents.  (This is done on your local computer.)  This is where you make the subdirectories and files (or copy them) from your previous set of exercises.
* Add your new files to the repository using `git add .` while in the root directory of the project,
* commit your changes with the comment "This is my first git commit!" (you can figure this one out), 
* and then push them with `git push -u origin [name_of_your_branch]`.
*  You may want to log into github, go to your new branch, click "Settings", choose the "Collaborators" tab, and add your team-mates to the list.

ALERT! Remember to use `git add` to put your file under version control before you commit. You can use `git status` to see what has changed and needs to be committed.  **ALSO** empty subdirectories won't be added-- so your `more_testing` subdirectory won't be included (even if you try to add it by hand) unless you create a file inside of it.  You can also fork the project 

##What to do

By the start of next lab you should
* Have gone through this entire lab
* Choose an editor and have put some time into learning how to use it
    * Emacs
    * VIM (playing vim adventures counts)
* Finished the tutorial http://www.linuxdoc.org/HOWTO/Bash-Prog-Intro-HOWTO.html
* Completed the [Bash Exercises](#bash-exercises)
* Completed the [git Exercises](#gitting-to-it)
