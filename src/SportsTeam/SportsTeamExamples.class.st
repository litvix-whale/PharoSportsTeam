Class {
	#name : 'SportsTeamExamples',
	#superclass : 'Object',
	#category : 'SportsTeam',
	#package : 'SportsTeam'
}

{ #category : 'examples' }
SportsTeamExamples >> example01CreateAthletes [
    | manager t1 t2 f1 f2 f3 |
    
    manager := SportsTeamManager new.
    
    t1 := TennisPlayer new
        surname: 'Свитолина';
        age: 29;
        nationality: 'Ukraine';
        worldRanking: 15;
        yourself.
    t1 lastThreePrizes: (OrderedCollection withAll: #(500000 300000 200000)).
    
    t2 := TennisPlayer new
        surname: 'Федерер';
        age: 42;
        nationality: 'Switzerland';
        worldRanking: 50;
        yourself.
    t2 lastThreePrizes: (OrderedCollection withAll: #(100000 150000 80000)).
    
    f1 := FootballPlayer new
        surname: 'Зінченко';
        age: 27;
        nationality: 'Ukraine';
        club: 'Arsenal';
        annualContract: 5000000;
        goals: 3;
        yourself.
    
    f2 := FootballPlayer new
        surname: 'Мудрик';
        age: 22;
        nationality: 'Ukraine';
        club: 'Chelsea';
        annualContract: 8000000;
        goals: 8;
        yourself.
    
    f3 := FootballPlayer new
        surname: 'Роналду';
        age: 39;
        nationality: 'Portugal';
        club: 'Al Nassr';
        annualContract: 200000000;
        goals: 35;
        yourself.
    
    manager addAthlete: t1.
    manager addAthlete: t2.
    manager addAthlete: f1.
    manager addAthlete: f2.
    manager addAthlete: f3.
    
    ^ manager
]

{ #category : 'examples' }
SportsTeamExamples >> example02FindRichest [
    | manager richest |
    manager := self example01CreateAthletes.
    richest := manager richestAthlete.
    
    Transcript 
        show: 'Найбагатший спортсмен: ';
        show: richest surname;
        show: ', заробіток: ';
        show: richest earnings;
        cr;
        show: 'Це футболіст? ';
        show: manager isRichestFootballer;
        cr.
    
    ^ richest
]

{ #category : 'examples' }
SportsTeamExamples >> example03UkrainianAthletes [
    | manager ukrainian |
    manager := self example01CreateAthletes.
    ukrainian := manager ukrainianAthletes.
    
    Transcript 
        show: 'Українські спортсмени (';
        show: ukrainian size;
        show: '):';
        cr.
    
    ukrainian do: [ :athlete |
        Transcript 
            show: '  - ';
            show: athlete surname;
            show: ', вік: ';
            show: athlete age;
            show: ', заробіток: ';
            show: athlete earnings;
            cr ].
    
    ^ ukrainian

]

{ #category : 'examples' }
SportsTeamExamples >> example04IncrementAges [
    | manager |
    manager := self example01CreateAthletes.
    
    Transcript show: 'Вік до збільшення:'; cr.
    manager athletes do: [ :a | 
        Transcript show: a surname; show: ' - '; show: a age; cr ].
    
    manager incrementAllAges.
    
    Transcript cr; show: 'Вік після збільшення:'; cr.
    manager athletes do: [ :a | 
        Transcript show: a surname; show: ' - '; show: a age; cr ].
    
    ^ manager
]

{ #category : 'examples' }
SportsTeamExamples >> example05CompareAthletes [
    | t1 f1 |
    t1 := TennisPlayer new
        surname: 'Тенісист';
        age: 25;
        nationality: 'Ukraine';
        worldRanking: 10;
        yourself.
    t1 lastThreePrizes: (OrderedCollection withAll: #(100000 100000 100000)).
    
    f1 := FootballPlayer new
        surname: 'Футболіст';
        age: 25;
        nationality: 'Ukraine';
        club: 'TestFC';
        annualContract: 500000;
        goals: 0;
        yourself.
    
    Transcript 
        show: t1 surname; show: ' заробіток: '; show: t1 earnings; cr;
        show: f1 surname; show: ' заробіток: '; show: f1 earnings; cr;
        show: 'Футболіст > Тенісист? '; show: (f1 > t1); cr.
    
    ^ { t1. f1 }
]

{ #category : 'examples' }
SportsTeamExamples >> example06SaveAndLoad [
    | manager1 manager2 |
    
    "Створюємо та зберігаємо"
    manager1 := self example01CreateAthletes.
    manager1 saveToSTONFile: 'athletes_demo.ston'.
    manager1 saveToFuelFile: 'athletes_demo.fuel'.
    manager1 saveToCSVFile: 'athletes_demo.csv'.
    manager1 saveToJSONFile: 'athletes_demo.json'.
    
    Transcript show: 'Файли збережено!'; cr.
    
    "Завантажуємо з STON"
    manager2 := SportsTeamManager new.
    manager2 loadFromSTONFile: 'athletes_demo.ston'.
    
    Transcript 
        show: 'Завантажено '; 
        show: manager2 athletes size; 
        show: ' спортсменів з файлу'; 
        cr.
    
    ^ manager2
]

{ #category : 'as yet unclassified' }
SportsTeamExamples >> exampleOpenGUI [
    | club presenter |
    club := self exampleSportsClub.
    
    presenter := SportsClubPresenter new.
    presenter club: club.
    presenter open
]

{ #category : 'examples' }
SportsTeamExamples >> exampleSportsClub [
    | club |
    club := SportsClub new name: 'Спортивний клуб Україна'; yourself.
    
    "Додаємо тенісистів"
    #(('Свитолина' 29 15 #(500000 300000 200000))
      ('Костюк' 21 50 #(100000 150000 80000)))
    do: [ :data |
        | player |
        player := TennisPlayer new
            surname: data first;
            age: data second;
            nationality: 'Ukraine';
            worldRanking: data third;
            yourself.
        player lastThreePrizes: (OrderedCollection withAll: data fourth).
        club addAthlete: player ].
    
    "Додаємо футболістів"
    #(('Зінченко' 27 'Arsenal' 5000000 3)
      ('Мудрик' 22 'Chelsea' 8000000 8)
      ('Ярмоленко' 34 'Dynamo Kyiv' 2000000 12))
    do: [ :data |
        club addAthlete: (FootballPlayer new
            surname: data first;
            age: data second;
            nationality: 'Ukraine';
            club: data third;
            annualContract: data fourth;
            goals: data fifth;
            yourself) ].
    
    Transcript clear.
    Transcript show: '=== Інформація про клуб ==='; cr.
    club printDetailsOn: Transcript.
    
    Transcript cr; show: '=== Топ 2 голеадорів ==='; cr.
    (club topGoalScorers: 2) do: [ :f |
        Transcript show: f surname; show: ' - '; show: f goals; show: ' голів'; cr ].
    
    Transcript cr; show: '=== Тенісисти топ-50 ==='; cr.
    (club topRankedTennisPlayers: 50) do: [ :t |
        Transcript show: t surname; show: ' - рейтинг '; show: t worldRanking; cr ].
    
    Transcript cr; show: '=== Найоплачуваніший ==='; cr.
    Transcript show: club highestPaidAthlete surname; 
        show: ' - '; 
        show: club highestPaidAthlete earnings; cr.
    
    ^ club
]

{ #category : 'examples' }
SportsTeamExamples >> runAllExamples [
    Transcript clear; show: '=== Приклади використання SportsTeam ==='; cr; cr.
    
    Transcript show: '--- Приклад 1: Створення ---'; cr.
    self example01CreateAthletes.
    
    Transcript cr; show: '--- Приклад 2: Найбагатший ---'; cr.
    self example02FindRichest.
    
    Transcript cr; show: '--- Приклад 3: Українці ---'; cr.
    self example03UkrainianAthletes.
    
    Transcript cr; show: '--- Приклад 4: Збільшення віку ---'; cr.
    self example04IncrementAges.
    
    Transcript cr; show: '--- Приклад 5: Порівняння ---'; cr.
    self example05CompareAthletes.
    
    Transcript cr; show: '--- Приклад 6: Збереження/Завантаження ---'; cr.
    self example06SaveAndLoad.
    
    Transcript cr; show: '=== Всі приклади виконано! ==='; cr.
]
