#!/usr/bin/env bash
set -euo pipefail

project_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
utility="$project_root/bin/git-clone-remote"
test_root="$(mktemp -d)"
trap 'rm -rf "$test_root"' EXIT

git init --bare "$test_root/origin.git" >/dev/null
git init --initial-branch=main "$test_root/source" >/dev/null
git -C "$test_root/source" config user.name "Test User"
git -C "$test_root/source" config user.email "test@example.com"
git -C "$test_root/source" commit --allow-empty -m "Initial commit" >/dev/null
git -C "$test_root/source" remote add origin "$test_root/origin.git"
git -C "$test_root/source" push --set-upstream origin main >/dev/null
git -C "$test_root/source" switch -c feature >/dev/null
git -C "$test_root/source" commit --allow-empty -m "Feature commit" >/dev/null
git -C "$test_root/source" push --set-upstream origin feature >/dev/null
git -C "$test_root/source" tag v1.0.0
git -C "$test_root/source" push origin v1.0.0 >/dev/null
git -C "$test_root/source" switch main >/dev/null
git --git-dir="$test_root/origin.git" symbolic-ref HEAD refs/heads/main

git clone "$test_root/origin.git" "$test_root/pull-all" >/dev/null
(
  cd "$test_root/pull-all"
  "$utility" --pull-all
)
git -C "$test_root/pull-all" show-ref --verify --quiet refs/heads/feature

git init --bare "$test_root/destination.git" >/dev/null
(
  cd "$test_root/source"
  "$utility" "$test_root/destination.git"
)

for ref in refs/heads/main refs/heads/feature refs/tags/v1.0.0; do
  git --git-dir="$test_root/destination.git" show-ref --verify --quiet "$ref"
done

printf 'All git-clone-remote checks passed.\n'