# Git Boilerplate

Switch your global or project Git commit identity with a single Bash or PowerShell command.
Run directly from GitHub without cloning this repository.

| Identity | Commit email |
| --- | --- |
| `haoyan-ts` | `haoyan.li@techshare.co.jp` |
| `haoyan-dev` | `haoyan.li.ac@gmail.com` |

## Quick start

Install Git and make sure `git` is available on your `PATH`. Use Bash with `curl`,
or PowerShell with `Invoke-RestMethod` (`irm`) and `Invoke-Expression` (`iex`).
The commands below download and execute the scripts from this repository's
`main` branch.

### Bash

Select the work identity:

```bash
curl -fsSL https://raw.githubusercontent.com/haoyan-dev/git-boilerplate/main/scripts/set-git-identity.sh | bash -s -- haoyan-ts
```

Or select the personal identity:

```bash
curl -fsSL https://raw.githubusercontent.com/haoyan-dev/git-boilerplate/main/scripts/set-git-identity.sh | bash -s -- haoyan-dev
```

`bash -s --` reads the script from the pipe and passes the selected identity as
its first argument. Add `global` or `project` as the second argument to choose
the scope. Omitting it defaults to `global`.

To set the identity only for the current project, run inside that Git repository:

```bash
curl -fsSL https://raw.githubusercontent.com/haoyan-dev/git-boilerplate/main/scripts/set-git-identity.sh | bash -s -- haoyan-dev project
```

### PowerShell

Select the work identity:

```powershell
iex "& { $(irm 'https://raw.githubusercontent.com/haoyan-dev/git-boilerplate/main/scripts/set-git-identity.ps1') } haoyan-ts"
```

Or select the personal identity:

```powershell
iex "& { $(irm 'https://raw.githubusercontent.com/haoyan-dev/git-boilerplate/main/scripts/set-git-identity.ps1') } haoyan-dev"
```

`irm` downloads the script. The `iex` expression wraps it in a script block so
the selected identity is passed to the script's `Identity` parameter.
Add `global` or `project` as the second argument to choose the scope.
Omitting it defaults to `global`.

To set the identity only for the current project, run inside that Git repository:

```powershell
iex "& { $(irm 'https://raw.githubusercontent.com/haoyan-dev/git-boilerplate/main/scripts/set-git-identity.ps1') } haoyan-dev project"
```

To use a fixed version, replace `main` in the URL with a commit SHA.

## What changes

Each invocation replaces `user.name` and `user.email` in the chosen scope and
prints the saved values.

| Scope | Effect |
| --- | --- |
| `global` (default) | Sets the default identity for all repositories for your user. |
| `project` | Sets the identity in the current repository's local Git configuration. Requires running inside a Git repository, including a subdirectory. |

Project settings override global defaults. Selecting `global` leaves existing
project overrides in place. Existing commits and GitHub authentication are unaffected.

For example, selecting `haoyan-dev` prints:

```text
haoyan-dev
haoyan.li.ac@gmail.com
```

## Run from a local checkout

After cloning this repository, run either script from the repository root:

```bash
bash ./scripts/set-git-identity.sh haoyan-ts
bash ./scripts/set-git-identity.sh haoyan-dev
bash ./scripts/set-git-identity.sh haoyan-dev global
bash ./scripts/set-git-identity.sh haoyan-ts project
```

```powershell
pwsh -File ./scripts/set-git-identity.ps1 haoyan-ts
pwsh -File ./scripts/set-git-identity.ps1 haoyan-dev
pwsh -File ./scripts/set-git-identity.ps1 haoyan-dev global
pwsh -File ./scripts/set-git-identity.ps1 haoyan-ts project
```

Each command selects one identity; run the one you want to use.

## Check the global defaults

```bash
git config --global --get user.name
git config --global --get user.email
```

## Check the project identity

Run inside that repository:

```bash
git config --local --get user.name
git config --local --get user.email
```
