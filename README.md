# dotfiles

## Get started

### 1. Install chezmoi

```bash
mise use -g chezmoi@latest
```

### 2. Apply dotfiles

```
chezmoi init --apply harutaka
```

## 開発方法

### 初期化

コードベースが`~/.local/share/chezmoi`に展開される。

```bash
chezmoi init harutaka
```

### 設定ファイルの配置

シークレット情報などの変数は、`~/.config/chezmoi/chezmoi.toml`に定義する運用とする。

```toml
[data]
  name = "hogehoge"
```

定義した変数は後述のテンプレートファイルにて以下のように使用する。

```
name = {{ .name }}
```

### ソースディレクトリへの移動

```bash
chezmoi cd
```

### 最新版の反映

```bash
chezmoi update
```

### ファイル追加

```bash
# 通常
chezmoi add ~/.vimrc
# テンプレートファイルとして追加
chezmoi add --template ~/.vimrc
# 既存ファイルをテンプレートファイルにする
chezmoi chattr +template ~/.zshrc
```

### ファイル編集

直接編集してもよい。

```bash
chezmoi edit ~/.vimrc
```

### テンプレートの確認
```bash
# 単発
chezmoi execute-template '{{ .chezmoi.hostname }}'
# ファイル
chezmoi execute-template < dot_vimrc.tmpl
```

### 変更確認

```bash
chezmoi diff
```

### 適用

```bash
chezmoi -v apply
```