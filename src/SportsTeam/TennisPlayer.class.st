Class {
	#name : 'TennisPlayer',
	#superclass : 'Athlete',
	#instVars : [
		'worldRanking',
		'lastThreePrizes'
	],
	#category : 'SportsTeam',
	#package : 'SportsTeam'
}

{ #category : 'copying' }
TennisPlayer >> copy [
    | newPlayer |
    newPlayer := super copy.
    newPlayer worldRanking: worldRanking.
    newPlayer lastThreePrizes: lastThreePrizes copy.
    ^ newPlayer
]

{ #category : 'methods' }
TennisPlayer >> earnings [
    ^ lastThreePrizes sum
]

{ #category : 'initialization' }
TennisPlayer >> initialize [
    super initialize.
    worldRanking := 0.
    lastThreePrizes := OrderedCollection new
]

{ #category : 'accessing' }
TennisPlayer >> lastThreePrizes [
    ^ lastThreePrizes
]

{ #category : 'accessing' }
TennisPlayer >> lastThreePrizes: aCollection [
    lastThreePrizes := aCollection
]

{ #category : 'printing' }
TennisPlayer >> printOn: aStream [
    aStream 
        nextPutAll: 'TennisPlayer(';
        nextPutAll: surname;
        nextPutAll: ', age: ';
        print: age;
        nextPutAll: ', ranking: ';
        print: worldRanking;
        nextPutAll: ', earnings: ';
        print: self earnings;
        nextPut: $)
]

{ #category : 'accessing' }
TennisPlayer >> worldRanking [
    ^ worldRanking

]

{ #category : 'accessing' }
TennisPlayer >> worldRanking: anInteger [
    worldRanking := anInteger
]
