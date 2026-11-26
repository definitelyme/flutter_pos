#!/usr/bin/env bash
set -euo pipefail

# Starts the Firebase emulators with the seed data. Needs Java 21 or newer on PATH.
# Nothing is exported on exit, so every start begins from the same seed.
cd "$(dirname "$0")/../.."

npx -y firebase-tools@15.28.1 emulators:start --project demo-flutter-pos --import firebase/emulator-seed
