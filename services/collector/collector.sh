#!/usr/bin/env bash

###############################################################################
#
# KRT Collector Service
#
###############################################################################

get_current_user() {
    whoami
}

get_hostname() {
    hostname
}

get_kernel() {
    uname -r
}

get_architecture() {
    uname -m
}

get_execution_time() {
    date
}
