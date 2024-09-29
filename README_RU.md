# wayland-clipboard-fix

[EN](README.md) | **RU**

2024-09-29: Заархивировано - используйте [clipboard-sync](https://github.com/dnut/clipboard-sync) вместо этого.

## 1. Описание

Цель тут - синхронизировать содержимое буфера обмена при работе в VirtualBox.
Буфер обмена Wayland не синхронизируется, но буфер обмена X11 - синхронизируется.
Поэтому сервис, создаваемый этим скриптом, смотри на буфер обмена Wayland, и когда тот меняется, копирует его содержимое в буфер обмена X11, и наоборот.

## 2. Требования

- Установленный `pacman` (Arch-основа) или `apt-get` (Debian-основа);
- Установленный `sudo`.

## 3. Использование

Выполнить внутри виртуальной машины для обычного пользователя:

```bash
curl -s https://raw.githubusercontent.com/Nikolai2038/wayland-clipboard-fix/main/fix.sh | sh
```

## 4. Развитие

Не стесняйтесь участвовать в развитии репозитория, используя [pull requests](https://github.com/Nikolai2038/wayland-clipboard-fix/pulls) или [issues](https://github.com/Nikolai2038/wayland-clipboard-fix/issues)!
