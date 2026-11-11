#!/usr/bin/env bash
# Set Git commit identity globally or for the current project.
# This does not change GitHub authentication.
set -euo pipefail

usage() {
    printf 'Usage: bash %s <haoyan-ts|haoyan-dev> [global|project]\n' "$0"
}

if [[ $# -eq 1 && ( $1 == --help || $1 == -h ) ]]; then
    usage
    exit 0
fi

if [[ $# -lt 1 || $# -gt 2 ]]; then
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

scope="${2:-global}"
case "$scope" in
    global) config_scope='--global' ;;
    project)
        if ! git rev-parse --git-dir >/dev/null 2>&1; then
            printf 'Project scope requires running inside a Git repository.\n' >&2
            exit 1
        fi
        config_scope='--local'
        ;;
    *)
        usage >&2
        exit 2
        ;;
esac

git config "$config_scope" --replace-all user.name "$1"
git config "$config_scope" --replace-all user.email "$email"

git config "$config_scope" --get user.name
git config "$config_scope" --get user.email
