#!/bin/bash

steam -silent -nofriendsui &
pid=$!
steam "steam://rungameid/$1"
kill $pid
