#!/usr/bin/env bash

dist=NthPrime

# Create a temporary scratch directory for the shell script to work in.
setup() {
  BATS_TMPDIR=`gmktemp --directory`
}

# Remove the temporary scratch directory to clean up after ourselves.
teardown() {
  rm -rf $BATS_TMPDIR
}

# If this test fails, your script file doesn't exist, or there's
# a typo in the name, or it's in the wrong directory, etc.
@test "extract_and_compile.sh exists" {
  [ -f "extract_and_compile.sh" ]
}

# If this test fails, your script isn't executable.
@test "extract_and_compile.sh is executable" {
  [ -x "extract_and_compile.sh" ]
}

# If this test fails, your script either didn't run at all, or it
# generated some sort of error when it ran.
@test "extract_and_compile.sh runs successfully" {
  run ./extract_and_compile.sh 5 $BATS_TMPDIR
  [ "$status" -eq 0 ]
}

# If this test fails, you either didn't extract the contents of the
# `tar` archive, or you extracted them into the wrong directory. If you're
# having trouble debugging this, you might find it useful to call your
# script directly from the command line and see where it extracted the files.
@test "extract_and_compile.sh extracts the 'tar' archive contents" {
  run ./extract_and_compile.sh 5 $BATS_TMPDIR
  [ -d $BATS_TMPDIR/$dist ]
  [ -f $BATS_TMPDIR/$dist/main.c ]
  [ -f $BATS_TMPDIR/$dist/nth_prime.c ]
  [ -f $BATS_TMPDIR/$dist/nth_prime.h ]
}

# If this test fails, you either moved or renamed the compressed `tar` archive.
# One common way this can happen is if you used `gunzip` to uncompressed the
# archive, and then used `tar xf` to extract the contents in a separate step.
# That would leave the archive as `NthPrime.tar` instead of `NthPrime.tgz`.
@test "extract_and_compile.sh doesn't remove or rename the compressed 'tar' archive" {
  run ./extract_and_compile.sh 5 $BATS_TMPDIR
  [ -f "NthPrime.tgz" ]
}

# If this fails you either haven't compiled the source successfully, or you
# didn't give it the right name. I'd run your script "by hand" and go look in
# your scratch directory to see what's there.
@test "extract_and_compile.sh compiles the source" {
  run ./extract_and_compile.sh 5 $BATS_TMPDIR
  [ -x $BATS_TMPDIR/$dist/NthPrime ]
}

# If this fails you either didn't call the compiled program, or you didn't give
# it the right command line argument. I'd run your script "by hand" and see
# what output it generates.
@test "extract_and_compile.sh computes the correct 5th prime" {
  run ./extract_and_compile.sh 5 $BATS_TMPDIR
  [ "$output" == "Prime 5 = 11." ]
}

# If this fails you either didn't call the compiled program, or you didn't give
# it the right command line argument. I'd run your script "by hand" and see
# what output it generates.
@test "extract_and_compile.sh computes the correct 103rd prime" {
  run ./extract_and_compile.sh 103 $BATS_TMPDIR
  [ "$output" == "Prime 103 = 563." ]
}
