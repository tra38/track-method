#!/usr/bin/env zsh

for ((i=1; i<=5; i++)) do
  echo "### Story #$i ###" >> novel.md
  echo "||||" >> novel.md
  ruby story.rb >> novel.md
done