# --- История команд ---
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE

# --- Подключение плагинов Fedora ---
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

# Настройка автодополнений
autoload -U compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Нечувствительность к регистру
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"   # Цвета как в ls

# --- Алиасы для современных утилит ---
alias ls='eza --icons=always --group-directories-first'
alias ll='eza -la --icons=always --group-directories-first'
alias tree='eza --tree --icons=always'
alias cat='bat --style=plain'
alias fastfetch='fastfetch'

# --- Инициализация окружения ---
eval "$(starship init zsh)"
eval "$(zoxide init zsh --cmd cd)"

# Запуск красивого инфо-экрана при открытии
if [[ $- == *i* ]]; then
    fastfetch
fi
