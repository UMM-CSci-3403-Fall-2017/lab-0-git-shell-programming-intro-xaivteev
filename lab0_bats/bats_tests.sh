#!/usr/bin/env bash

dist=NthPrime

# If this test fails, your script file doesn't exist
@test "copy_and_compile.sh exists" {
  [[ -f "copy_and_compile.sh" ]]
}

# If this test fails, your script isn't executable
@test "copy_and_compile.sh is executable" {
  [[ -x "copy_and_compile.sh" ]]
}

# If this test fails, your script either didn't run at all, or it
# generated some sort of error when it ran.
@test "copy_and_compile runs successfully" {
  run ./copy_and_compile.sh $BATS_TMPDIR/target 0
  [ "$status" -eq 0 ]
}

# If this test fails, your script doesn't create the directory
# provided in the first argument.
@test "copy_and_compile creates the specified directory" {
  run ./copy_and_compile.sh $BATS_TMPDIR/target 0
  [ -d $BATS_TMPDIR/target ]
}

@test "copy_and_compile copies the tarball" {
  run ./copy_and_compile.sh $BATS_TMPDIR/target 0
  [ -f $BATS_TMPDIR/target/$dist.tgz ]
}

@test "copy_and_compile expands the tarball" {
  run ./copy_and_compile.sh $BATS_TMPDIR/target 0
  [ -d $BATS_TMPDIR/target/$dist ]
}

@test "expanding the tarball generates the source" {
  run ./copy_and_compile.sh $BATS_TMPDIR/target 0
  [ -f $BATS_TMPDIR/target/$dist/main.c ]
  [ -f $BATS_TMPDIR/target/$dist/nth_prime.c ]
  [ -f $BATS_TMPDIR/target/$dist/nth_prime.h ]
}

@test "copy_and_compile compiles the source" {
  run ./copy_and_compile.sh $BATS_TMPDIR/target 0
  [ -x $BATS_TMPDIR/target/$dist/NthPrime ]
}

@test "copy_and_compile didn't run the compiled program" {
  run "./copy_and_compile.sh $BATS_TMPDIR/target 103"
  [ -f $BATS_TMPDIR/results.txt ]
}
