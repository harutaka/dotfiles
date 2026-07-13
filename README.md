# dotfiles

## Get started

### 1. dotfiles リポジトリを clone

```bash
git clone https://github.com/harutaka/dotfiles.git ~/.dotfiles
```

### 2. ツールのインストール

```bash
./run_once_install-packages.sh
```

### 3. mise をインストール

```bash
curl https://mise.run | sh
echo "eval \"\$(~/.local/bin/mise activate bash)\"" >> ~/.bashrc
source ~/.bashrc
```

### 4. mise の初期設定

```bash
mkdir -p ~/.config/mise
cp ~/.dotfiles/.config/mise/config.toml ~/.config/mise/config.toml
```

### 5. mise 管理ツールインストールと dotfiles の適用

```bash
mise install
mise dotfiles apply
```

### 6. local ファイルの適用・編集

```bash
cp ~/.dotfiles/.gitconfig_work.example ~/.gitconfig_work
vim ~/.gitconfig_work
```

### 7. シェルを再ログイン

```bash
exec $SHELL -l
```


## 開発方法

* 各設定ファイルはシンボリックリンクになっている。変更後はこまめにコミット・プッシュする。
* miseの設定ファイル(config.toml)はシンボリックリンクではないので、変更後はリポジトリにも反映する。

### 既存ファイルを管理対象へ追加
`mise dotfiles add` を使うと、追加できる。この時点ではシンボリックリンクは貼られない。

```bash
mise dotfiles add ~/.zshrc
```

### 適用テスト

```bash
mise dotfiles apply --dry-run
```

### 設定ファイルの適用
この時点でシンボリックリンクが貼られる。

```bash
mise dotfiles apply
```

### 状態の確認

```bash
mise dotfiles status
```
