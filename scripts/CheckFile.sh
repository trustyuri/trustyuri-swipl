#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd ../ && pwd )"
swipl -f $DIR/trustyuri/check_file.pl -g run -t halt -- $*
