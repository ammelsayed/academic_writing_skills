#!/usr/bin/env python3
"""Push a directory to GitHub via the Contents API.

git-over-https is blocked in this environment but the gh REST API works, so we
commit file-by-file. Each file becomes one commit through the API.

Usage: python push_api.py <owner/repo> <branch> <local_dir>
Requires: gh CLI authenticated.
"""
import base64
import json
import subprocess
import sys
from pathlib import Path

SKIP_DIRS = {".git", "node_modules", "__pycache__", ".venv"}


def gh(method, endpoint, payload=None):
    cmd = ["gh", "api", "-X", method, endpoint]
    if payload is not None:
        cmd += ["--input", "-"]
    proc = subprocess.run(
        cmd,
        input=json.dumps(payload) if payload is not None else None,
        capture_output=True,
        text=True,
    )
    return proc.returncode, proc.stdout, proc.stderr


def remote_sha(repo, branch, path):
    code, out, _ = gh("GET", f"repos/{repo}/contents/{path}?ref={branch}")
    if code != 0:
        return None
    try:
        return json.loads(out)["sha"]
    except (json.JSONDecodeError, KeyError):
        return None


def main():
    repo, branch, local = sys.argv[1], sys.argv[2], Path(sys.argv[3])

    files = sorted(
        p for p in local.rglob("*")
        if p.is_file() and not any(part in SKIP_DIRS for part in p.parts)
    )
    print(f"{len(files)} files to push to {repo}@{branch}")

    ok = failed = 0
    for p in files:
        rel = p.relative_to(local).as_posix()
        content = base64.b64encode(p.read_bytes()).decode()

        payload = {
            "message": f"Add {rel}",
            "content": content,
            "branch": branch,
        }
        sha = remote_sha(repo, branch, rel)
        if sha:
            payload["sha"] = sha
            payload["message"] = f"Update {rel}"

        code, out, err = gh("PUT", f"repos/{repo}/contents/{rel}", payload)
        if code == 0:
            ok += 1
            print(f"  ok    {rel}")
        else:
            failed += 1
            print(f"  FAIL  {rel}: {(err or out).strip()[:200]}")

    print(f"\n{ok} pushed, {failed} failed")
    return 1 if failed else 0


if __name__ == "__main__":
    sys.exit(main())
