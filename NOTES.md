## Version Control

Dotfiles are managed by yadm.

After installing yadm, dotfiles can be cloned with:

```bash
yadm clone https://github.com/artichoked1/dotfiles.git
```
We use HTTPS since SSH keys are not set up yet.

### Making Changes

To push modified dotfiles to the remote repository, use yadm as if it were git:

```bash
yadm add <file>
yadm commit -m "message"
yadm push
```

## SSH Keys

SSH keys are encrypted by yadm, as specified in `$HOME/.config/yadm/encrypt`.

Run `yadm encrypt` to encrypt the files listed in `$HOME/.config/yadm/encrypt`.

Run `yadm decrypt` to decrypt the files listed in `$HOME/.config/yadm/encrypt`.

In `.ssh/config`, SSH is configured to use seperate keys for logging into github and gitea respectively. The generic `.ssh/id_ed25519` key is used for everything else.

## Git

in `.gitconfig`, Git is configured to use seperate identities and signing keys for github and gitea.

For repos located in `~/Projects/github`, `.gitconfig` is configured to include `~/.gitconfig-github`, containing the github identity and signing key. For repos located in `~/Projects/git.artichoke.cc`, `.gitconfig` is configured to include `~/.gitconfig-git.artichoke.cc`, containing the gitea identity and signing key. For all other repos, the github identity and signing key are used.

To manually set the identity and signing key for a specific repo, run:

```bash
git config user.name "username"
git config user.email "github-email@example.com"
git config gpg.format ssh
git config user.signingkey ~/.ssh/id_ed25519_github_sign.pub
git config commit.gpgsign true
```