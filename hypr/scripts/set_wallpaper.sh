#!/bin/bash

# Путь к папке с твоими обоями
DIR="/$HOME/wallpapers"
# Файл, где будем хранить номер текущего изображения
INDEX_FILE="$HOME/.config/hypr/scripts/wallpaper_index"

# Собираем список всех изображений в массив
mapfile -t WALLPAPERS < <(find "$DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.gif" \) | sort)

# Если массив пуст, выходим
if [ ${#WALLPAPERS[@]} -eq 0 ]; then
    exit 1
fi

# Читаем индекс из файла, если файла нет — ставим 0
INDEX=$(cat "$INDEX_FILE" 2>/dev/null || echo 0)

# Проверяем, не вышел ли индекс за границы (если удалили картинки)
if [ "$INDEX" -ge "${#WALLPAPERS[@]}" ]; then
    INDEX=0
fi

# Устанавливаем текущие обои с твоим "быстрым кругом"
swww img "${WALLPAPERS[$INDEX]}" \
    --transition-type grow \
    --transition-pos 0.5,0.5 \
    --transition-step 255 \
    --transition-duration 0.2 \
    --transition-fps 144

# Вычисляем следующий индекс и сохраняем его
NEXT_INDEX=$(( (INDEX + 1) % ${#WALLPAPERS[@]} ))
echo "$NEXT_INDEX" > "$INDEX_FILE"
