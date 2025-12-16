Class {
	#name : 'SportsTeamManager',
	#superclass : 'Object',
	#instVars : [
		'athletes'
	],
	#category : 'SportsTeam',
	#package : 'SportsTeam'
}

{ #category : 'adding' }
SportsTeamManager >> addAthlete: anAthlete [
    athletes add: anAthlete
]

{ #category : 'accessing' }
SportsTeamManager >> athletes [
    ^ athletes
]

{ #category : 'arithmetic' }
SportsTeamManager >> incrementAllAges [
    athletes do: [ :a | a incrementAge ]
]

{ #category : 'creation' }
SportsTeamManager >> initialize [
    super initialize.
    athletes := OrderedCollection new
]

{ #category : 'accessing' }
SportsTeamManager >> isRichestFootballer [
    ^ self richestAthlete isKindOf: FootballPlayer
]

{ #category : 'files' }
SportsTeamManager >> loadFromFuelFile: filename [
    | file |
    file := filename asFileReference.
    athletes := FLMaterializer materializeFromFileNamed: file fullName
]

{ #category : 'files' }
SportsTeamManager >> loadFromSTONFile: filename [
    | file |
    file := filename asFileReference.
    file readStreamDo: [ :stream |
        athletes := STON fromStream: stream ]
]

{ #category : 'printing' }
SportsTeamManager >> printOn: aStream [
    aStream nextPutAll: 'SportsTeamManager with '.
    athletes size printOn: aStream.
    aStream nextPutAll: ' athletes:'; cr.
    athletes do: [ :a | 
        aStream nextPutAll: '  '.
        a printOn: aStream.
        aStream cr ]
]

{ #category : 'accessing' }
SportsTeamManager >> richestAthlete [
    ^ athletes detectMax: [ :a | a earnings ]
]

{ #category : 'files' }
SportsTeamManager >> saveToCSVFile: filename [
    | file |
    file := filename asFileReference.
    file writeStreamDo: [ :stream |
        "Заголовок"
        stream nextPutAll: 'Type,Surname,Age,Nationality,Earnings,Extra1,Extra2'; cr.
        "Дані"
        athletes do: [ :athlete |
            (athlete isKindOf: TennisPlayer)
                ifTrue: [
                    stream 
                        nextPutAll: 'Tennis,';
                        nextPutAll: athlete surname; nextPut: $,;
                        print: athlete age; nextPut: $,;
                        nextPutAll: athlete nationality; nextPut: $,;
                        print: athlete earnings; nextPut: $,;
                        print: athlete worldRanking; nextPut: $,;
                        nextPutAll: (athlete lastThreePrizes asString); cr ]
                ifFalse: [
                    stream 
                        nextPutAll: 'Football,';
                        nextPutAll: athlete surname; nextPut: $,;
                        print: athlete age; nextPut: $,;
                        nextPutAll: athlete nationality; nextPut: $,;
                        print: athlete earnings; nextPut: $,;
                        nextPutAll: athlete club; nextPut: $,;
                        print: athlete goals; cr ] ] ]
]

{ #category : 'files' }
SportsTeamManager >> saveToFuelFile: filename [
    | file |
    file := filename asFileReference.
    FLSerializer serialize: athletes toFileNamed: file fullName

]

{ #category : 'files' }
SportsTeamManager >> saveToJSONFile: filename [
    | file data |
    file := filename asFileReference.
    data := athletes collect: [ :athlete |
        (athlete isKindOf: TennisPlayer)
            ifTrue: [
                Dictionary newFromPairs: {
                    'type'. 'Tennis'.
                    'surname'. athlete surname.
                    'age'. athlete age.
                    'nationality'. athlete nationality.
                    'worldRanking'. athlete worldRanking.
                    'lastThreePrizes'. athlete lastThreePrizes asArray.
                    'earnings'. athlete earnings } ]
            ifFalse: [
                Dictionary newFromPairs: {
                    'type'. 'Football'.
                    'surname'. athlete surname.
                    'age'. athlete age.
                    'nationality'. athlete nationality.
                    'club'. athlete club.
                    'annualContract'. athlete annualContract.
                    'goals'. athlete goals.
                    'earnings'. athlete earnings } ] ].
    file writeStreamDo: [ :stream |
        STON jsonWriter on: stream; nextPut: data ]
]

{ #category : 'files' }
SportsTeamManager >> saveToSTONFile: filename [
    | file |
    file := filename asFileReference.
    file writeStreamDo: [ :stream |
        STON put: athletes onStream: stream ]

]

{ #category : 'accessing' }
SportsTeamManager >> ukrainianAthletes [
    ^ athletes select: [ :a | a nationality = 'Ukraine' ]
"test"
]
