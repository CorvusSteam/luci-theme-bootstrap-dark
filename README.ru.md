[English](README.md) | **Русский**

# luci-theme-bootstrap-dark

Тёмная тема для LuCI на **OpenWrt 19.07**, максимально близкая к стандартной теме `bootstrap`
и оформленная по образцу тёмного режима в OpenWrt 22.03/23.05.

<!-- Добавьте скриншоты: -->
<!-- ![Status](screenshots/status.png) -->

## Особенности

- Не заменяет стандартную тему: ставится отдельным пунктом **BootstrapDark**
  в *Система → Система → Язык и тема → Тема оформления*.
- Только CSS, без пакетов и компиляции.
- Покрывает главную, интерфейсы, мониторинг, формы, динамические списки, таблицы, модальные окна.

## Требования

- OpenWrt 19.07 (проверено на 19.07.10)
- установленный `luci-theme-bootstrap` (есть по умолчанию)

## Установка

На роутере по SSH:

```sh
opkg update && opkg install git git-http   # либо просто скачайте архив с GitHub
git clone https://github.com/CorvusSteam/luci-theme-bootstrap-dark.git
cd luci-theme-bootstrap-dark
sh install.sh            # добавляет пункт BootstrapDark в меню тем
# или:
sh install.sh --activate # то же + сразу делает тему активной
```

Без git: скачайте zip на компьютере, скопируйте на роутер (`scp -O -r luci-theme-bootstrap-dark root@192.168.1.1:/tmp/`)
и запустите `sh /tmp/luci-theme-bootstrap-dark/install.sh`.

Затем обновите страницу (Ctrl+F5) и выберите **BootstrapDark** в *Система → Система → Язык и тема*.

Скрипт сам:
- копирует тему `bootstrap` в `bootstrap-dark` и дописывает тёмный CSS;
- регистрирует тему в `uci` (`luci.themes.BootstrapDark`);
- добавляет пути темы в `/etc/sysupgrade.conf`, чтобы она пережила обновление прошивки.

> Важно: установка делается на **неизменённой** теме `bootstrap`. Скрипт это проверит.

## Удаление

```sh
sh uninstall.sh
```

## Автоматический режим (по настройке системы)

Если нужна тема, которая включается только при тёмном режиме ОС/браузера, не создавайте отдельную тему,
а допишите `bootstrap-dark.css` в конец `/www/luci-static/bootstrap/cascade.css` как есть
(файл обёрнут в `@media (prefers-color-scheme: dark)`).

## Известные ограничения

- Графики на странице мониторинга перекрашиваются инверсией цветов, оттенки могут слегка отличаться.
- Тема проверялась на 19.07; на 21.02 и новее у `bootstrap` другая вёрстка (там есть свой тёмный режим).
- Сторонние приложения LuCI (`luci-app-*`) с собственным CSS могут иметь светлые элементы.
  Присылайте скриншоты в Issues.

## Как помочь

Нашли светлый элемент или нечитаемый текст? Создайте Issue со скриншотом и, по возможности,
с кодом элемента (F12 → «Просмотреть код»).

## English summary

```sh
git clone https://github.com/CorvusSteam/luci-theme-bootstrap-dark.git
cd luci-theme-bootstrap-dark && sh install.sh
```

Then choose **BootstrapDark** under *System → System → Language and Style*.
`sh uninstall.sh` removes it. Works on OpenWrt 19.07 with the stock `luci-theme-bootstrap`.

## Лицензия

MIT, см. [LICENSE](LICENSE).
