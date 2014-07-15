#!/bin/bash

(
    echo 'digraph d {' \
    ; echo '  rankdir=LR;' \
    ; cat 03-split-lessons-with-dependencies.md \
      | awk '/^CONCEPTS$/ {show=1; next} /DEPENDENCIES/ {show=0; next} {if (show) print }' \
      | grep -v -e '^\s*$' \
      | sed 's@$@[shape=box]@g' \
    ; cat 03-split-lessons-with-dependencies.md \
      | awk '/^DEPENDENCIES$/ {show=1; next} /END/ {show=0; next} {if (show) print }' \
    ; echo '}' \
) > .graph.dot

#cat .graph.dot
dot -Tsvg .graph.dot -o 03-graph.svg && inkview 03-graph.svg
