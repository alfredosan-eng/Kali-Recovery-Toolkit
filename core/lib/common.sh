#!/usr/bin/env bash

###############################################################################
#
# Kali Recovery Toolkit
# Common Library
#
###############################################################################

krt_timestamp() {

    date "+%Y-%m-%d %H:%M:%S"

}

krt_separator() {

    printf '%*s\n' 62 '' | tr ' ' '='

}

krt_small_separator() {

    printf '%*s\n' 62 '' | tr ' ' '-'

}

krt_banner() {

    local title="$1"

    echo

    krt_separator

    printf "%31s\n" "$title"

    krt_separator

}

krt_title() {

    echo

    echo "$1"

    krt_small_separator

}

###############################################################################
# END OF FILE
###############################################################################
