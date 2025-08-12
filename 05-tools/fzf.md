# fzf
## 1.install
```shell
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```
## 2.parameter
```shell
--preview

--preview 'cat {} --bind 'alt-j:preview-page-down,alt-k:preview-page-up,q:abort''

--style [ full | minimal]

--layout reverse

--bind 'hotkey:action'
```
## 2.1 preview
```bash
fzf --preview "cat {}"
```
## 3.hotkey binding
### 3.1action
- up
- down
- preview-page-up
- preview-page-down
- abort


### 3.2Format
```shell
--bind 'hotkey:action'
# ctrl & alt
ctrl-q:action

alt-q:action
```

## 4export
```shell
FZF_DEFAULT_OPTS="--bind='ctrl-k:up,ctrl-j:down,alt-k:preview-page-up,alt-j:preview-page-down' --preview '(batcat --color=always --style=number {} || less -R {})'"
FZF_COMPLETION_TRIGGER='/'
```
