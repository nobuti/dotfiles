#!/usr/bin/env bash
set -euo pipefail

DOTFILES="${DOTFILES:-$HOME/Dev/dotfiles}"
CONFIG_SRC="$DOTFILES/config"
CONFIG_DST="$HOME/.config"

usage() {
  cat <<EOF
Usage: $(basename "$0") <command> [args]

Commands:
  link              Symlink every tracked config into ~/.config (idempotent)
  status            Show tracked configs and their state
  adopt <path>      Move existing ~/.config/<x> into dotfiles and symlink back
  check             Detect drift (target exists but is not a symlink to dotfiles)
  help              Show this message

Default command: link
EOF
}

iter_tracked() {
  find "$CONFIG_SRC" -mindepth 1 -maxdepth 1 -type d 2>/dev/null | sort
}

iter_untracked() {
  # Entries in ~/.config that have no counterpart in dotfiles/config
  [ -d "$CONFIG_DST" ] || return 0
  find "$CONFIG_DST" -mindepth 1 -maxdepth 1 2>/dev/null | sort | while IFS= read -r entry; do
    [ -n "$entry" ] || continue
    name=$(basename "$entry")
    [ -e "$CONFIG_SRC/$name" ] || echo "$entry"
  done
}

cmd_link() {
  mkdir -p "$CONFIG_DST"
  while IFS= read -r src; do
    [ -n "$src" ] || continue
    name=$(basename "$src")
    target="$CONFIG_DST/$name"
    if [ -L "$target" ]; then
      actual=$(readlink "$target")
      if [ "$actual" = "$src" ]; then
        echo "ok       $name"
      else
        echo "wrong    $name (symlink → $actual)"
      fi
    elif [ -e "$target" ]; then
      echo "skip     $name (target exists — run: $(basename "$0") adopt $target)"
    else
      ln -s "$src" "$target"
      echo "linked   $name"
    fi
  done < <(iter_tracked)
}

cmd_status() {
  printf "%-10s %-20s %s\n" "STATE" "NAME" "TARGET"
  while IFS= read -r src; do
    [ -n "$src" ] || continue
    name=$(basename "$src")
    target="$CONFIG_DST/$name"
    if [ -L "$target" ]; then
      actual=$(readlink "$target")
      if [ "$actual" = "$src" ]; then
        state="ok"
      else
        state="wrong-link"
      fi
    elif [ -e "$target" ]; then
      state="drift"
    else
      state="missing"
    fi
    printf "%-10s %-20s %s\n" "$state" "$name" "$target"
  done < <(iter_tracked)
  while IFS= read -r entry; do
    [ -n "$entry" ] || continue
    name=$(basename "$entry")
    printf "%-10s %-20s %s\n" "untracked" "$name" "$entry"
  done < <(iter_untracked)
}

cmd_adopt() {
  local path="${1:-}"
  if [ -z "$path" ]; then
    echo "usage: $(basename "$0") adopt <path>" >&2
    exit 1
  fi
  if [ ! -e "$path" ]; then
    echo "error: $path does not exist" >&2
    exit 1
  fi
  if [ -L "$path" ]; then
    echo "error: $path is already a symlink" >&2
    exit 1
  fi
  local abs
  abs=$(cd "$(dirname "$path")" && pwd)/$(basename "$path")
  local name
  name=$(basename "$abs")
  local dest="$CONFIG_SRC/$name"
  if [ -e "$dest" ]; then
    echo "error: $dest already exists in dotfiles" >&2
    exit 1
  fi
  mv "$abs" "$dest"
  ln -s "$dest" "$abs"
  echo "adopted  $name"
  echo "         source : $dest"
  echo "         link   : $abs"
}

cmd_check() {
  local drift=0
  while IFS= read -r src; do
    [ -n "$src" ] || continue
    name=$(basename "$src")
    target="$CONFIG_DST/$name"
    if [ -L "$target" ]; then
      actual=$(readlink "$target")
      if [ "$actual" != "$src" ]; then
        echo "wrong    $name (symlink → $actual, expected $src)"
        drift=1
      fi
    elif [ -e "$target" ]; then
      echo "drift    $name (real path at $target)"
      drift=1
    fi
  done < <(iter_tracked)
  while IFS= read -r entry; do
    [ -n "$entry" ] || continue
    name=$(basename "$entry")
    echo "untrack  $name ($entry — run: $(basename "$0") adopt $entry)"
    drift=1
  done < <(iter_untracked)
  if [ "$drift" -eq 0 ]; then
    echo "ok       no drift"
  else
    exit 1
  fi
}

cmd="${1:-link}"
shift || true
case "$cmd" in
  link)            cmd_link "$@" ;;
  status)          cmd_status "$@" ;;
  adopt)           cmd_adopt "$@" ;;
  check)           cmd_check "$@" ;;
  help|-h|--help)  usage ;;
  *)               echo "unknown command: $cmd" >&2; usage; exit 1 ;;
esac
