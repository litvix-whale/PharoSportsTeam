Class {
	#name : 'SportsClub',
	#superclass : 'Object',
	#instVars : [
		'name',
		'athletes'
	],
	#category : 'SportsTeam',
	#package : 'SportsTeam'
}

{ #category : 'actions' }
SportsClub >> addAthlete: anAthlete [
    (athletes includes: anAthlete)
        ifFalse: [ athletes add: anAthlete ]
]

{ #category : 'accessing' }
SportsClub >> athletes [
    ^ athletes
]

{ #category : 'files' }
SportsClub >> athletes: aCollection [
    athletes := aCollection
]

{ #category : 'statistics' }
SportsClub >> averageAge [
    ^ athletes 
        ifEmpty: [ 0 ]
        ifNotEmpty: [ (athletes sum: [ :a | a age ]) / athletes size ]
]

{ #category : 'statistics' }
SportsClub >> averageEarnings [
    ^ athletes 
        ifEmpty: [ 0 ]
        ifNotEmpty: [ self totalEarnings / athletes size ]

]

{ #category : 'actions' }
SportsClub >> footballPlayers [
    ^ athletes select: [ :a | a isKindOf: FootballPlayer ]
]

{ #category : 'data' }
SportsClub >> highestPaidAthlete [
    ^ athletes 
        ifEmpty: [ nil ]
        ifNotEmpty: [ athletes detectMax: [ :a | a earnings ] ]
]

{ #category : 'initialization' }
SportsClub >> initialize [
    super initialize.
    name := 'Unnamed Club'.
    athletes := OrderedCollection new
]

{ #category : 'initialization' }
SportsClub >> initializeWindow: aWindowPresenter [
    aWindowPresenter
        title: 'Спортивний Клуб';
        initialExtent: 800@600
]

{ #category : 'actions' }
SportsClub >> loadClub [
    | file newClub |
    file := StOpenFilePresenter new
        title: 'Завантажити клуб';
        extensionFilters: {'STON файли' -> #('ston'). 'Fuel файли' -> #('fuel')};
        defaultFolder: FileLocator home;
        openModal.
    
    file ifNotNil: [
        newClub := SportsClub new.
        file extension = 'ston'
            ifTrue: [ newClub loadFromSTONFile: file fullName ]
            ifFalse: [ newClub loadFromFuelFile: file fullName ].
        self club: newClub.
        self updateClubInfo.
        self inform: 'Клуб завантажено!' ]
]

{ #category : 'files' }
SportsClub >> loadFromFuelFile: filename [
    | loaded |
    loaded := FLMaterializer materializeFromFileNamed: filename asFileReference fullName.
    self name: loaded name.
    self athletes: loaded athletes
]

{ #category : 'files' }
SportsClub >> loadFromSTONFile: filename [
    | loaded |
    loaded := filename asFileReference readStreamDo: [ :stream |
        STON fromStream: stream ].
    self name: loaded name.
    self athletes: loaded athletes
]

{ #category : 'accessing' }
SportsClub >> name [
    ^ name


]

{ #category : 'accessing' }
SportsClub >> name: aString [
    name := aString
]

{ #category : 'data' }
SportsClub >> printCategory: categorySymbol on: aStream [
    | category |
    category := categorySymbol = #tennis
        ifTrue: [ self tennisPlayers ]
        ifFalse: [ self footballPlayers ].
    
    aStream 
        nextPutAll: '=== ';
        nextPutAll: (categorySymbol = #tennis ifTrue: ['Тенісисти'] ifFalse: ['Футболісти']);
        nextPutAll: ' ==='; cr.
    
    category do: [ :a |
        aStream nextPutAll: '  '; print: a; cr ]
]

{ #category : 'printing' }
SportsClub >> printDetailsOn: aStream [
    aStream 
        nextPutAll: '=== '; nextPutAll: name; nextPutAll: ' ==='; cr;
        nextPutAll: 'Всього спортсменів: '; print: self size; cr;
        nextPutAll: 'Тенісистів: '; print: self tennisPlayers size; cr;
        nextPutAll: 'Футболістів: '; print: self footballPlayers size; cr;
        nextPutAll: 'Сумарний заробіток: '; print: self totalEarnings; cr;
        nextPutAll: 'Середній заробіток: '; print: self averageEarnings; cr;
        nextPutAll: 'Середній вік: '; print: self averageAge rounded; cr;
        cr;
        nextPutAll: 'Спортсмени:'; cr.
    athletes do: [ :a |
        aStream nextPutAll: '  - '; print: a; cr ]
]

{ #category : 'printing' }
SportsClub >> printOn: aStream [
    aStream 
        nextPutAll: 'SportsClub(';
        nextPutAll: name;
        nextPutAll: ', athletes: ';
        print: athletes size;
        nextPutAll: ', earnings: ';
        print: self totalEarnings;
        nextPut: $)
]

{ #category : 'actions' }
SportsClub >> removeAthlete: anAthlete [
    athletes remove: anAthlete ifAbsent: [ ]
]

{ #category : 'actions' }
SportsClub >> reviewContracts: percentageIncrease [
    self footballPlayers do: [ :f |
        f annualContract: (f annualContract * (1 + (percentageIncrease / 100))) ]
]

{ #category : 'files' }
SportsClub >> saveToFuelFile: filename [
    FLSerializer serialize: self toFileNamed: filename asFileReference fullName
]

{ #category : 'files' }
SportsClub >> saveToSTONFile: filename [
    filename asFileReference writeStreamDo: [ :stream |
        STON put: self onStream: stream ]

]

{ #category : 'actions' }
SportsClub >> size [
    ^ athletes size

]

{ #category : 'actions' }
SportsClub >> tennisPlayers [
    ^ athletes select: [ :a | a isKindOf: TennisPlayer ]

]

{ #category : 'data' }
SportsClub >> topGoalScorers: n [
    | footballers |
    footballers := self footballPlayers.
    ^ (footballers asSortedCollection: [ :a :b | a goals > b goals ]) 
        first: (n min: footballers size)
]

{ #category : 'data' }
SportsClub >> topRankedTennisPlayers: n [
    | tennis |
    tennis := self tennisPlayers.
    ^ (tennis select: [ :t | t worldRanking <= n ])
        asSortedCollection: [ :a :b | a worldRanking < b worldRanking ]
]

{ #category : 'statistics' }
SportsClub >> totalEarnings [
    ^ athletes 
        ifEmpty: [ 0 ]
        ifNotEmpty: [ athletes sum: [ :a | a earnings ] ]

]

{ #category : 'data' }
SportsClub >> ukrainianAthletes [
    ^ athletes select: [ :a | a nationality = 'Ukraine' ]
]
