# git-clone-remote

`git-clone-remote` copies every local branch and tag from the current repository to a new Git remote. It can also create local tracking branches for remote branches.

## Requirements

- Bash
- Git
- Zsh, if you want shell completion

## Usage

Run the command from inside a Git working tree:

```bash
git-clone-remote <new-git-remote-url>
git-clone-remote --pull-all
```

To mirror a repository to a new remote:

```bash
git-clone-remote git@github.com:example/project.git
```

The command fetches and prunes `origin`, creates local tracking branches for its remote branches, adds the destination as `new-origin`, then pushes all local branches and tags to it. The `new-origin` remote name should not already be configured.

`--pull-all` fetches and prunes all configured remotes, then creates local tracking branches for remote branches that do not already have a local branch. It does not push anything.

## Installation

Version tags (`v*`) trigger the GitHub Actions release workflow, which builds Debian and RPM packages and a source archive. The Nix flake provides a package and `nix run .` for the supported systems. Packages install the Zsh completion file as `_git-clone-remote` in the standard site-functions directory.

## Development

Run the local Git integration checks with:

```bash
bash tests/test-git-clone-remote.sh
```
