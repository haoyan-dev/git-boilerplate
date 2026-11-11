#!/usr/bin/env bash
# Set global Git commit defaults. Repository-local settings can override them.
# This does not change GitHub authentication.
set -euo pipefail

usage() {
    printf 'Usage: bash %s <haoyan-ts|haoyan-dev>\n' "$0"
}

if [[ $# -eq 1 && ( $1 == --help || $1 == -h ) ]]; then
    usage
    exit 0
fi

if [[ $# -ne 1 ]]; then
    usage >&2
    exit 2
fi

case "$1" in
    haoyan-ts) email='haoyan.li@techshare.co.jp' ;;
    haoyan-dev) email='haoyan.li.ac@gmail.com' ;;
    *)
        usage >&2
        exit 2
        ;;
esac

git config --global --replace-all user.name "$1"
git config --global --replace-all user.email "$email"

git config --global --get user.name
git config --global --get user.email
