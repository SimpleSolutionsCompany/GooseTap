# GooseTap
Tap, grow and have fun with your own goose!🪿 Earn points with every tap, upgrade your goose and boost your progress step by step. Join thousands of players, climb the leaderboard and show that geese can dominate the tapper world! 🏆🔥







# Best practices для зберігання Connection String у .NET проєкті
## Робота з Connection String через ENV

### 1. У репозиторії

* В `appsettings.json` **не зберігається** справжній ключ.
  Приклад:

  ```json
  {
    "ConnectionStrings": {
      "DefaultConnection": ""
    }
  }
  ```
* У `.gitignore` додати рядок:

  ```
  .env
  ```

### 2. Для розробників (локально)

#### Варіант А – через `.env` файл

1. Створи файл `.env` у корені проєкту (цей файл **не пушиться в GitHub**).
2. Запиши туди свій ключ:

   ```
   ConnectionStrings__DefaultConnection=Server=...;Database=...;User Id=...;Password=...
   ```
3. Запусти проєкт – ключ підтягнеться автоматично.

#### Варіант Б – через `dotnet user-secrets`

1. У консолі виконай:

   ```bash
   dotnet user-secrets init
   dotnet user-secrets set "ConnectionStrings:DefaultConnection" "Server=...;Database=...;User Id=...;Password=..."
   ```
2. Запускай застосунок – ключ буде доступний тільки на твоїй машині.

---

### 3. На сервері (продакшн / тест)

* Ключ задається як **Environment Variable**.

  * Windows PowerShell:

    ```powershell
    $env:ConnectionStrings__DefaultConnection="Server=...;Database=...;User Id=...;Password=..."
    ```
  * Linux/macOS bash:

    ```bash
    export ConnectionStrings__DefaultConnection="Server=...;Database=...;User Id=...;Password=..."
    ```

* У CI/CD (GitHub Actions, Azure, Docker, etc.) – ключ зберігається у **Secrets**.

---

### 4. У коді

Доступ завжди однаковий:

```csharp
var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
```

---

✅ Результат:

* Ніяких ключів у GitHub.
* Кожен розробник має свій `.env` або user-secrets.
* На сервері ключи зберігаються у системних ENV або GitHub Secrets.
