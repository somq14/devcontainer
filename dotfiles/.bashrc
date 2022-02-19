# タイムゾーンを日本にする
export TZ='Asia/Tokyo'

# コマンド履歴の保存先を設定
mkdir -p ~/.persistent
export HISTFILE=~/.persistent/.bash_history

# コマンド履歴の保存件数を設定
export HISTSIZE=10000
export HISTFILESIZE=100000

# コマンド履歴は重複を除去し、空白から始まるコマンドは記録しない
export HISTCONTROL=ignoreboth

# コマンド実行のたびに履歴をファイルと同期する
share_history(){
  history -a # ファイルに履歴を書き出す
  history -c # メモリ上に保持している履歴をクリア
  history -r # ファイルから履歴を読み出す
}
export PROMPT_COMMAND='share_history'

# Git の補完を有効化
if [ ! -e ~/.persistent/git-completion.bash ]; then
  curl --silent https://raw.githubusercontent.com/git/git/v2.35.1/contrib/completion/git-completion.bash -o ~/.persistent/git-completion.bash
fi
source ~/.persistent/git-completion.bash

# プロンプトの設定
if [ ! -e ~/.persistent/git-prompt.sh ]; then
  curl --silent https://raw.githubusercontent.com/git/git/v2.35.1/contrib/completion/git-prompt.sh -o ~/.persistent/git-prompt.sh
fi
source ~/.persistent/git-prompt.sh
export PS1='\[\e[1;34m\]\D{%FT%T%z}:\[\e[1;32m\]\w\[\e[1;37m\]$(__git_ps1)\n\[\e[1;37m\]$\[\e[m\] '

# ls, grep をカラフルにする
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# ファイル削除前に確認する
alias rm='rm -i'
