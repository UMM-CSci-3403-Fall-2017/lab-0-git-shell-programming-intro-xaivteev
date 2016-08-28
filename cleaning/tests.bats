#!/usr/bin/env bats

little=little_dir
num_little_remaining_files=16

big=big_dir
num_big_remaining_files=792

# Create a temporary scratch directory for the shell script to work in.
setup() {
  BATS_TMPDIR=`mktemp --directory`
}

# Remove the temporary scratch directory to clean up after ourselves.
teardown() {
  rm -rf $BATS_TMPDIR
}

# If this test fails, your script file doesn't exist, or there's
# a typo in the name, or it's in the wrong directory, etc.
@test "big_clean.sh exists" {
  [ -f "big_clean.sh" ]
}

# If this test fails, your script isn't executable.
@test "big_clean.sh is executable" {
  [ -x "big_clean.sh" ]
}

# If this test fails, your script either didn't run at all, or it
# generated some sort of error when it ran.
@test "big_clean.sh runs successfully" {
  run ./big_clean.sh $little.tgz $BATS_TMPDIR
  [ "$status" -eq 0 ]
}

# If this test fails, you either didn't extract the contents of the
# `tar` archive, or you extracted them into the wrong directory. If you're
# having trouble debugging this, you might find it useful to call your
# script directly from the command line and see where it extracted the files.
@test "big_clean.sh extracts the 'tar' archive contents" {
  run ./big_clean.sh $little.tgz $BATS_TMPDIR
  [ -d $BATS_TMPDIR/$little ]
  # This just checks that a few of the files are there.
  [ -f $BATS_TMPDIR/$little/file_6 ]
  [ -f $BATS_TMPDIR/$little/file_12 ]
  [ -f $BATS_TMPDIR/$little/file_18 ]
}

# If this test fails, you either moved or renamed the compressed `tar` archive.
# One common way this can happen is if you used `gunzip` to uncompressed the
# archive, and then used `tar xf` to extract the contents in a separate step.
# That would leave the archive as `NthPrime.tar` instead of `NthPrime.tgz`.
@test "big_clean.sh doesn't remove or rename the compressed 'tar' archive" {
  run ./big_clean.sh $little.tgz $BATS_TMPDIR
  [ -f "$little.tgz" ]
}

@test "big_clean.sh creates new 'cleaned_little_dir.tgz' archive" {
  run ./big_clean.sh $little.tgz $BATS_TMPDIR
  [ -f "cleaned_$little.tgz" ]
}

@test "The new archive has the right number of files in it" {
  ./big_clean.sh $little.tgz $BATS_TMPDIR
  run bash -c "tar -ztf cleaned_$little.tgz | grep '/f' | wc -l"
  [ "$output" -eq $num_little_remaining_files ]
}

@test "The new archive has (some) of the right files in it" {
  ./big_clean.sh $little.tgz $BATS_TMPDIR
  run bash -c "tar -ztf cleaned_$little.tgz | grep '/f' | sort"
  [ "${lines[0]}" == "little_dir/file_1" ]
  [ "${lines[1]}" == "little_dir/file_10" ]
  [ "${lines[8]}" == "little_dir/file_19" ]
}

@test "big_clean.sh returns the right number of files on the big archive" {
  run ./big_clean.sh $big.tgz $BATS_TMPDIR
  run bash -c "tar -ztf cleaned_$big.tgz | grep '/f' | wc -l"
  [ "$output" -eq $num_big_remaining_files ]
}
