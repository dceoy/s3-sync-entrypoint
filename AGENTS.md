# Repository Guidelines

## Project Structure & Module Organization

- `s3-sync-entrypoint` is the core Bash script (single-file implementation).
- `README.md` documents usage and examples.

## Build, Test, and Development Commands

- `./s3-sync-entrypoint --help` shows CLI options and defaults.
- Example run (local):
  ```sh
  INPUT_DATA_DIR=/input OUTPUT_DATA_DIR=/output \
    ./s3-sync-entrypoint --input-s3=s3://bucket/in --output-s3=s3://bucket/out \
    ls -la /input
  ```

## Coding Style & Naming Conventions

- Bash script uses 2-space indentation and `set -euo pipefail` style safety.
- Environment variables are uppercase (e.g., `INPUT_DATA_DIR`).
- Internal variables use the `SSE_` prefix; functions use `snake_case`.
- Keep new options consistent with existing `--kebab-case` flags and the help block.

## Testing Guidelines

- No automated test suite is currently present.
- When changing behavior, run the script locally and/or via Docker to validate:
  - `./s3-sync-entrypoint --version` and `--help`
  - A minimal `aws s3 sync` flow (use test buckets or `--dryrun`).

## Commit & Pull Request Guidelines

- Commit messages in history are short, imperative, and descriptive (e.g., “Implement --wait-for-ebs-mount option”, “Fix a bug”).
- Occasional `fix:` prefixes appear; there is no strict Conventional Commits rule.
- PRs should include:
  - A brief summary of behavior changes.
  - Any required environment variables or AWS setup.
  - Validation notes (commands run, dry-run outputs, or Docker build). If no tests were run, say so.

## Security & Configuration Tips

- This tool relies on AWS CLI credentials available in the runtime environment.
- Prefer `--dryrun` when validating new sync logic.
- Avoid checking secrets into the repo; use environment variables or AWS profiles instead.
