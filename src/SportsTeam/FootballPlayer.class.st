Class {
	#name : 'FootballPlayer',
	#superclass : 'Athlete',
	#instVars : [
		'club',
		'annualContract',
		'goals'
	],
	#category : 'SportsTeam',
	#package : 'SportsTeam'
}

{ #category : 'accessing' }
FootballPlayer >> annualContract [
    ^ annualContract
]

{ #category : 'accessing' }
FootballPlayer >> annualContract: aNumber [
    annualContract := aNumber
]

{ #category : 'accessing' }
FootballPlayer >> club [
    ^ club
]

{ #category : 'accessing' }
FootballPlayer >> club: aString [
    club := aString
]

{ #category : 'methods' }
FootballPlayer >> earnings [
    ^ annualContract * (1 + (goals / 100))
]

{ #category : 'accessing' }
FootballPlayer >> goals [
    ^ goals


]

{ #category : 'accessing' }
FootballPlayer >> goals: anInteger [
    goals := anInteger
]

{ #category : 'initialization' }
FootballPlayer >> initialize [
    super initialize.
    club := ''.
    annualContract := 0.
    goals := 0

]

{ #category : 'printing' }
FootballPlayer >> printOn: aStream [
    aStream 
        nextPutAll: 'FootballPlayer(';
        nextPutAll: surname;
        nextPutAll: ', age: ';
        print: age;
        nextPutAll: ', club: ';
        nextPutAll: club;
        nextPutAll: ', earnings: ';
        print: self earnings;
        nextPutAll: ', goals: ';
        print: goals;
        nextPut: $)
]
