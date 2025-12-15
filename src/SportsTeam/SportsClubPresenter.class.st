Class {
	#name : 'SportsClubPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'club',
		'athletesList',
		'clubInfoText',
		'addButton',
		'removeButton',
		'saveButton',
		'loadButton',
		'statsButton',
		'filterDropdown'
	],
	#category : 'SportsTeam',
	#package : 'SportsTeam'
}

{ #category : 'initialization' }
SportsClubPresenter >> club: aSportsClub [
    club := aSportsClub.
    self updateAthletesList
]

{ #category : 'layout' }
SportsClubPresenter >> defaultLayout [
    ^ SpBoxLayout newTopToBottom
        add: (SpBoxLayout newLeftToRight
            add: 'Клуб:' expand: false;
            add: clubInfoText;
            yourself) expand: false;
        add: (SpBoxLayout newLeftToRight
            add: 'Фільтр:' expand: false;
            add: filterDropdown width: 150;
            yourself) expand: false;
        add: athletesList;
        add: (SpBoxLayout newLeftToRight
            add: addButton;
            add: removeButton;
            add: saveButton;
            add: loadButton;
            add: statsButton;
            yourself) expand: false;
        yourself
]

{ #category : 'initialization' }
SportsClubPresenter >> initialize [
    club := SportsClub new name: 'Мій Спортивний Клуб'; yourself.
    super initialize
]

{ #category : 'initialization' }
SportsClubPresenter >> initializePresenters [
    "Список спортсменів"
    athletesList := self newTable.
    athletesList 
        addColumn: (SpStringTableColumn title: 'Прізвище' evaluated: [ :athlete | athlete surname ]);
        addColumn: (SpStringTableColumn title: 'Вік' evaluated: [ :athlete | athlete age asString ]);
        addColumn: (SpStringTableColumn title: 'Тип' evaluated: [ :athlete | 
            (athlete isKindOf: TennisPlayer) 
                ifTrue: [ 'Тенісист' ] 
                ifFalse: [ 'Футболіст' ] ]);
        addColumn: (SpStringTableColumn title: 'Громадянство' evaluated: [ :athlete | athlete nationality ]);
        addColumn: (SpStringTableColumn title: 'Заробіток' evaluated: [ :athlete | athlete earnings asString ]).
    
    "Текст з інформацією про клуб"
    clubInfoText := self newText.
    clubInfoText beNotEditable.
    
    "Кнопки"
    addButton := self newButton 
        label: 'Додати спортсмена';
        action: [ self addAthlete ];
        yourself.
    
    removeButton := self newButton
        label: 'Видалити';
        action: [ self removeSelectedAthlete ];
        yourself.
    
    saveButton := self newButton
        label: 'Зберегти';
        action: [ self saveClub ];
        yourself.
    
    loadButton := self newButton
        label: 'Завантажити';
        action: [ self loadClub ];
        yourself.
    
    statsButton := self newButton
        label: 'Статистика';
        action: [ self showStatistics ];
        yourself.
    
    "Фільтр"
    filterDropdown := self newDropList.
    filterDropdown 
        items: #('Всі' 'Тенісисти' 'Футболісти' 'Українці');
        selectIndex: 1;
        whenSelectedItemChangedDo: [ :item | self applyFilter: item ].
    
    self updateClubInfo.
    self updateAthletesList
]

{ #category : 'methods' }
SportsClubPresenter >> updateAthletesList [
    athletesList items: club athletes
]

{ #category : 'methods' }
SportsClubPresenter >> updateClubInfo [
    | info |
    info := String streamContents: [ :s |
        s 
            nextPutAll: club name;
            nextPutAll: ' | Спортсменів: ';
            print: club size;
            nextPutAll: ' | Заробіток: ';
            print: club totalEarnings ].
    clubInfoText text: info
]
