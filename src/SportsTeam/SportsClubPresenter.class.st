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

{ #category : 'methods' }
SportsClubPresenter >> addAthlete [
| dialog newAthlete |

    dialog := AthleteDialog new.
    dialog openModal.

    newAthlete := dialog athlete.
    (newAthlete isKindOf: Athlete) ifFalse: [ ^ self ].

    club addAthlete: newAthlete.

    self applyFilter: filterDropdown selectedItem.
    self updateClubInfo.

]

{ #category : 'api' }
SportsClubPresenter >> applyFilter: filterName [
    | base filtered |

    "Беремо ТІЛЬКИ спортсменів"
    base := club athletes
        select: [ :a | a isKindOf: Athlete ].

    filterName = 'Всі'
        ifTrue: [ filtered := base ]
        ifFalse: [
            filterName = 'Тенісисти'
                ifTrue: [
                    filtered := base
                        select: [ :a | a isKindOf: TennisPlayer ] ]
                ifFalse: [
                    filterName = 'Футболісти'
                        ifTrue: [
                            filtered := base
                                select: [ :a | a isKindOf: FootballPlayer ] ]
                        ifFalse: [ filtered := base ] ] ].

    athletesList items: filtered

]

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
        addColumn: (SpStringTableColumn
            title: 'Прізвище'
            evaluated: [ :item |
                (item respondsTo: #surname)
                    ifTrue: [ item surname ]
                    ifFalse: [ '' ] ]);

        addColumn: (SpStringTableColumn
            title: 'Вік'
            evaluated: [ :item |
                (item respondsTo: #age)
                    ifTrue: [ item age asString ]
                    ifFalse: [ '' ] ]);

        addColumn: (SpStringTableColumn
            title: 'Тип'
            evaluated: [ :item |
                (item isKindOf: TennisPlayer)
                    ifTrue: [ 'Тенісист' ]
                    ifFalse: [
                        (item isKindOf: FootballPlayer)
                            ifTrue: [ 'Футболіст' ]
                            ifFalse: [ '' ] ] ]);

        addColumn: (SpStringTableColumn
            title: 'Громадянство'
            evaluated: [ :item |
                (item respondsTo: #nationality)
                    ifTrue: [ item nationality ]
                    ifFalse: [ '' ] ]);

        addColumn: (SpStringTableColumn
            title: 'Заробіток'
            evaluated: [ :item |
                (item respondsTo: #earnings)
                    ifTrue: [ item earnings asString ]
                    ifFalse: [ '' ] ]).

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
        items: #('Всі' 'Тенісисти' 'Футболісти');
        selectIndex: 1;
        whenSelectedItemChangedDo: [ :item | self applyFilter: item ].

    self updateClubInfo.
    self updateAthletesList

]

{ #category : 'methods' }
SportsClubPresenter >> loadClub [
    | saved |

    saved := SportsClubMemoryStore savedClub.
    saved ifNil: [
        ^ self inform: 'Немає збереженого клубу'
    ].

    club := saved.

    self updateAthletesList.
    self updateClubInfo.

    self inform: 'Клуб завантажено з памʼяті'.

]

{ #category : 'methods' }
SportsClubPresenter >> removeSelectedAthlete [
    | selected |

    selected := athletesList selectedItem.

    selected ifNil: [
        self inform: 'Оберіть спортсмена для видалення'.
        ^ self
    ].

    club removeAthlete: selected.

    self updateAthletesList.
    self updateClubInfo.

]

{ #category : 'methods' }
SportsClubPresenter >> saveClub [
    | file |

    "1. збереження в пам’яті"
    SportsClubMemoryStore save: club.

    "2. резервне збереження у файл"
    file := FileLocator home / 'club.ston'.
    club saveToSTONFile: file fullName.

    self inform: 'Клуб збережено'.

]

{ #category : 'methods' }
SportsClubPresenter >> showStatistics [
    | total tennis football avgAge text |

    club ifNil: [
        self inform: 'Клуб не завантажений'.
        ^ self
    ].

    total := club athletes size.

    tennis := club athletes count: [ :a | a isKindOf: TennisPlayer ].
    football := club athletes count: [ :a | a isKindOf: FootballPlayer ].

    avgAge := total = 0
        ifTrue: [ 0 ]
        ifFalse: [
            (club athletes collect: #age) average asFloat roundTo: 0.1
        ].

    text :=
        'Назва клубу: ', club name, String cr,
        'Всього спортсменів: ', total asString, String cr,
        'Тенісисти: ', tennis asString, String cr,
        'Футболісти: ', football asString, String cr,
        'Середній вік: ', avgAge asString.

    self inform: text.

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
