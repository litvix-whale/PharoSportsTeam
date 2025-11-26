# SportsTeam - Pharo Project

Проєкт для управління інформацією про спортсменів (тенісистів та футболістів).

## Опис завдання

Реалізація системи для роботи зі спортсменами:

- **Спортсмен (Athlete)**: базовий клас з прізвищем, віком та громадянством
- **Тенісист (TennisPlayer)**: світовий рейтинг та призові з трьох останніх турнірів
- **Футболіст (FootballPlayer)**: клуб, річний контракт, кількість голів (кожен гол +1% до доходу)

## Функціональність

### Реалізовані можливості:

1. Створення та управління спортсменами
2. Обчислення заробітку кожного спортсмена
3. Порівняння спортсменів за прибутками
4. Арифметичні операції (збільшення віку)
5. Пошук найбагатшого спортсмена
6. Фільтрація за громадянством
7. Збереження/завантаження з файлів (STON, Fuel, CSV, JSON)
8. Модульні тести
9. Приклади використання

## Структура проєкту

```
SportsTeam/
├── Athlete           # Базовий клас спортсмена
├── TennisPlayer      # Підклас для тенісистів
├── FootballPlayer    # Підклас для футболістів
├── SportsTeamManager # Менеджер для роботи з колекцією спортсменів
├── SportsTeamExamples # Приклади використання
└── AthleteTest       # Модульні тести
```

## Встановлення та запуск

### Вимоги:

- Pharo 13.0 64bit
- Pharo Launcher 3.4.1

### Інсталяція:

1. Клонуйте репозиторій:

```bash
git clone https://github.com/litvix-whale/PharoSportsTeam.git
```

2. Відкрийте Pharo Launcher та створіть новий image (Pharo 13.0)

3. У Pharo відкрийте Repositorues:
   - World -> Browse -> Git Repositoies Browser
   - Add -> Clone remote repository
   - Вкажіть URL: `https://github.com/litvix-whale/PharoSportsTeam.git`

## Приклади використання

### Створення спортсменів:

```smalltalk
| manager t1 f1 |

manager := SportsTeamManager new.

"Створення тенісиста"
t1 := TennisPlayer new
    surname: 'Свитолина';
    age: 29;
    nationality: 'Ukraine';
    worldRanking: 15;
    yourself.
t1 lastThreePrizes: (OrderedCollection withAll: #(500000 300000 200000)).

"Створення футболіста"
f1 := FootballPlayer new
    surname: 'Зінченко';
    age: 27;
    nationality: 'Ukraine';
    club: 'Arsenal';
    annualContract: 5000000;
    goals: 3;
    yourself.

manager addAthlete: t1.
manager addAthlete: f1.
```

### Запуск всіх прикладів:

```smalltalk
SportsTeamExamples new runAllExamples.
```

## Тестування

Запустити всі тести:

- Tools → Test Runner
- Знайдіть пакет `SportsTeam`
- Виберіть `AthleteTest`
- Натисніть "Run Selected"

Або через код:

```smalltalk
AthleteTest suite run.
```

## Формати збереження даних

Проєкт підтримує збереження та завантаження у форматах:

- **STON** - Smalltalk Object Notation (текстовий, читабельний)
- **Fuel** - бінарний формат Pharo (швидкий, компактний)
- **CSV** - для експорту в Excel/Google Sheets
- **JSON** - для інтеграції з веб-додатками

### Приклад:

```smalltalk
manager saveToSTONFile: 'athletes.ston'.
manager saveToCSVFile: 'athletes.csv'.

"Завантаження"
manager loadFromSTONFile: 'athletes.ston'.
```

## Труднощі та рішення

### Підключення Git (Iceberg):

**Проблема**: Складність налаштування remote репозиторію через API  
**Рішення**: Використання UI Iceberg або командного рядка git

### Автентифікація GitHub:

**Проблема**: HTTPS вимагає Personal Access Token  
**Рішення**: Створення токена в GitHub Settings та збереження через IceCredentialStore

### Синтаксис Pharo:

**Проблема**: Відмінності від інших мов (каскади, блоки)  
**Рішення**: Використання документації та експериментування в Playground

### Серіалізація об'єктів:

**Проблема**: Різні формати мають різні обмеження  
**Рішення**: STON для простих випадків, Fuel для складних об'єктних графів

## Переваги Pharo

Інтегроване середовище - все в одному місці  
Live coding - зміни застосовуються миттєво  
Потужні інструменти дебагінгу та інспекції  
Iceberg - зручна інтеграція з Git  
Чиста об'єктно-орієнтована архітектура  
STON та Fuel - відмінні формати серіалізації

## Ліцензія

MIT License

## Автори

Команда Rest

- Кирило - [GitHub профіль](https://github.com/litvix-whale)

## Посилання

- [Pharo](https://pharo.org/)
- [Pharo by Example](https://books.pharo.org/)
- [GitHub Repository](https://github.com/litvix-whale/PharoSportsTeam)
