# Git Boilerplate

PowerShell and Bash helpers for selecting a global Git commit identity.

| Identity | Commit email |
| --- | --- |
| `haoyan-ts` | `haoyan.li@techshare.co.jp` |
| `haoyan-dev` | `haoyan.li.ac@gmail.com` |

## Usage

Install Git and either PowerShell (`pwsh`) or Bash, then run from this repository's root.

### PowerShell

```powershell
pwsh -File ./scripts/set-git-identity.ps1 haoyan-ts
# Or select the personal identity:
pwsh -File ./scripts/set-git-identity.ps1 haoyan-dev
```

### Bash

```bash
bash ./scripts/set-git-identity.sh haoyan-ts
# Or select the personal identity:
bash ./scripts/set-git-identity.sh haoyan-dev
```

Each invocation replaces global `user.name` and `user.email` with the selected
identity and prints the saved values. There is one global default at a time.
Repository-local settings can override these defaults. Existing commits and
GitHub authentication are unaffected.

### Check the global defaults

```bash
git config --global --get user.name
git config --global --get user.email
```

### Override one repository

Run inside that repository:

```bash
git config --local user.name "haoyan-dev"
git config --local user.email "haoyan.li.ac@gmail.com"
```
