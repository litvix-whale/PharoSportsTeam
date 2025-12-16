Class {
	#name : 'AthleteDialog',
	#superclass : 'SpPresenter',
	#instVars : [
		'athlete',
		'typeDropdown',
		'surnameInput',
		'ageInput',
		'nationalityInput',
		'specificInputs',
		'okButton',
		'cancelButton'
	],
	#category : 'SportsTeam',
	#package : 'SportsTeam'
}

{ #category : 'accessing' }
AthleteDialog >> athlete [
    ^ athlete
]

{ #category : 'methods' }
AthleteDialog >> createAthlete [
    | surname age nationality |

    "Валідація загальних полів"
    surname := surnameInput text.
    surname isEmpty ifTrue: [ ^ self inform: 'Введіть прізвище!' ].

    age := ageInput number.
    age isNil ifTrue: [ ^ self inform: 'Введіть вік!' ].

    nationality := nationalityInput text.
    nationality isEmpty ifTrue: [ ^ self inform: 'Введіть громадянство!' ].

    "Створення обʼєкта"
    athlete := (typeDropdown selectedItem = 'Тенісист')
        ifTrue: [ self createTennisPlayer: surname age: age nationality: nationality ]
        ifFalse: [ self createFootballPlayer: surname age: age nationality: nationality ].

    "Закриваємо діалог тільки якщо реально створили спортсмена"
    (athlete isKindOf: Athlete)
        ifTrue: [ self delete ].
]

{ #category : 'as yet unclassified' }
AthleteDialog >> createFootballPlayer: surname age: age nationality: nationality [
    | clubName contract goals |

    "М'яко читаємо поля: якщо пусто/не число — беремо дефолти"
    clubName := (specificInputs at: 1) text trimBoth.
    clubName isEmpty ifTrue: [ clubName := 'Unknown club' ].

    contract := (specificInputs at: 2) number.
    contract isNil ifTrue: [ contract := 0 ].

    goals := (specificInputs at: 3) number.
    goals isNil ifTrue: [ goals := 0 ].

    ^ FootballPlayer new
        surname: surname;
        age: age;
        nationality: nationality;
        club: clubName;
        annualContract: contract;
        goals: goals;
        yourself

]

{ #category : 'methods' }
AthleteDialog >> createTennisPlayer: surname age: age nationality: nationality [
    | ranking prizesText prizes |

    ranking := (specificInputs at: 1) number
        ifNil: [ ^ self inform: 'Введіть світовий рейтинг!' ].

    prizesText := (specificInputs at: 2) text
        ifEmpty: [ ^ self inform: 'Введіть призові!' ].

    "Парсимо: 1000,2000,3000 → #(1000 2000 3000)"
    prizes := (prizesText findTokens: ',')
    collect: [ :each | each trimBoth asNumber ].

    ^ TennisPlayer new
        surname: surname;
        age: age;
        nationality: nationality;
        worldRanking: ranking;
        lastThreePrizes: (OrderedCollection withAll: prizes);
        yourself

]

{ #category : 'layout' }
AthleteDialog >> defaultLayout [
    | layout |
    layout := SpBoxLayout newTopToBottom
        add: 'Тип спортсмена:' expand: false;
        add: typeDropdown expand: false;
        add: 'Прізвище:' expand: false;
        add: surnameInput expand: false;
        add: 'Вік:' expand: false;
        add: ageInput expand: false;
        add: 'Громадянство:' expand: false;
        add: nationalityInput expand: false;
        yourself.
    
    "Додаємо специфічні поля"
    typeDropdown selectedItem = 'Тенісист'
        ifTrue: [ 
            layout 
                add: 'Світовий рейтинг:' expand: false;
                add: (specificInputs at: 1) expand: false;
                add: 'Призові (через кому):' expand: false;
                add: (specificInputs at: 2) expand: false ]
        ifFalse: [
            layout 
                add: 'Клуб:' expand: false;
                add: (specificInputs at: 1) expand: false;
                add: 'Річний контракт:' expand: false;
                add: (specificInputs at: 2) expand: false;
                add: 'Голи:' expand: false;
                add: (specificInputs at: 3) expand: false ].
    
    layout
        add: (SpBoxLayout newLeftToRight
            add: okButton;
            add: cancelButton;
            yourself) expand: false.
    
    ^ layout
]

{ #category : 'initialization' }
AthleteDialog >> initialize [
    athlete := nil.
    super initialize
]

{ #category : 'initialization' }
AthleteDialog >> initializePresenters [
    "Тип спортсмена"
    typeDropdown := self newDropList.
    typeDropdown 
        items: #('Тенісист' 'Футболіст');
        selectIndex: 1;
        whenSelectedItemChangedDo: [ :item | self updateSpecificFields ].
    
    "Загальні поля"
    surnameInput := self newTextInput 
        placeholder: 'Прізвище';
        yourself.
    
    ageInput := self newNumberInput
        placeholder: 'Вік';
        minimum: 15;
        maximum: 50;
        yourself.
    
    nationalityInput := self newTextInput
        placeholder: 'Громадянство';
        yourself.
    
    "Специфічні поля (динамічні)"
    specificInputs := OrderedCollection new.
    
    "Кнопки"
    okButton := self newButton
        label: 'OK';
        action: [ self createAthlete ];
        yourself.
    
    cancelButton := self newButton
        label: 'Скасувати';
        action: [ self delete ];
        yourself.
    
    self updateSpecificFields
]

{ #category : 'initialization' }
AthleteDialog >> initializeWindow: aWindowPresenter [
    aWindowPresenter
        title: 'Додати спортсмена';
        initialExtent: 400@500

]

{ #category : 'methods' }
AthleteDialog >> updateSpecificFields [
    specificInputs removeAll.
    
    typeDropdown selectedItem = 'Тенісист'
        ifTrue: [ 
            specificInputs 
                add: (self newNumberInput placeholder: 'Рейтинг'; yourself);
                add: (self newTextInput placeholder: '100000, 200000, 300000'; yourself) ]
        ifFalse: [
            specificInputs 
                add: (self newTextInput placeholder: 'Назва клубу'; yourself);
                add: (self newNumberInput placeholder: 'Контракт'; yourself);
                add: (self newNumberInput placeholder: 'Голи'; yourself) ].
    
    self needRebuild: true
]
