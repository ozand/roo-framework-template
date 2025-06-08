# My Agent Framework

## Установка

Этот репозиторий является **шаблоном**, который вы можете использовать для создания собственных проектов с AI-агентами.

### Пошаговая Инструкция

1.  **Склонируйте этот репозиторий-шаблон** в удобное для вас место (например, `C:\Users\YourUser\Projects\templates`):
    ```bash
    git clone [https://github.com/ozand/roo-framework-template.git](https://github.com/ozand/roo-framework-template.git)
    ```

2.  **Создайте и перейдите в директорию для вашего нового проекта** (где будет жить ваш новый агент):
    ```powershell
    mkdir T:\Code\MyNewAgent
    cd T:\Code\MyNewAgent
    ```

3.  **Запустите установочный скрипт**, указав полный или относительный путь к нему из директории шаблона.

Windows (PowerShell)
```PowerShell
# Важно: Убедитесь, что политика выполнения PowerShell разрешает запуск скриптов.
# Пример вызова скрипта из директории вашего нового проекта:
T:\Code\python\RuRu\framework-template\scripts\install.ps1
```

macOS / Linux
```Bash
# Пример вызова скрипта из директории вашего нового проекта:
/path/to/your/cloned/roo-framework-template/scripts/install.sh
```
