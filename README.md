# template-bash-utility

Template repository for creating POSIX / Bash shell script utilities deployed via `sstix-tools` for **APT**, **RPM**, and **Nix** with **Zsh autocompletion**.

## Repository Structure
```
├── .github/workflows/
│   ├── release.yaml             # Automated packaging and release pipeline
│   └── test.yaml                # CI test workflow
├── bin/
│   └── template-bash-utility    # Main executable script
├── completion/
│   └── _template-bash-utility   # Zsh completion definition
├── packaging/
│   ├── debian/                  # Debian package metadata
│   └── rpm/                     # RPM spec file
├── flake.nix                    # Nix package & app definition
├── flake.lock                   # Nix lockfile
├── LICENSE
└── README.md
```

## How to Use This Template
1. Create a new repository in GitHub from this template under the `sstix-tools` organization.
2. Rename the files and occurrences of `template-bash-utility` to your tool name:
   - `bin/template-bash-utility` -> `bin/<your-tool>`
   - `completion/_template-bash-utility` -> `completion/_<your-tool>`
   - `packaging/rpm/template-bash-utility.spec` -> `packaging/rpm/<your-tool>.spec`
   - In `flake.nix`: update `pname = "<your-tool>"` and description
   - In `.github/workflows/release.yaml`: update `pkg_name="<your-tool>"`
   - In `packaging/debian/control`: update `Package:` and `Description:`
3. Implement your utility logic in `bin/<your-tool>`.
4. Commit your changes and tag a release:
   ```bash
   git tag v1.0.0
   git push origin v1.0.0
   ```
5. GitHub Actions will automatically build Debian (`.deb`), RPM (`.rpm`), and Nix assets and dispatch a trigger to `sstix-tools/registry`.
