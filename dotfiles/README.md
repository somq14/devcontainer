# devcontainer/dotfiles

vscode の settings.json に以下を設定し、devcontainer を起動してください。

```json
{
  "dotfiles.repository": "https://github.com/somq14/devcontainer.git",
  "dotfiles.targetPath": "~/devcontainer",
  "dotfiles.installCommand": "~/devcontainer/dotfiles/install.sh"
}
```
