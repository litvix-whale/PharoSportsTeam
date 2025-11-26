Class {
	#name : 'Athlete',
	#superclass : 'Object',
	#instVars : [
		'surname',
		'age',
		'nationality'
	],
	#category : 'SportsTeam',
	#package : 'SportsTeam'
}

{ #category : 'arithmetic' }
Athlete >> + years [
    ^ self copy age: age + years

]

{ #category : 'arithmetic' }
Athlete >> - years [
    ^ self copy age: age - years
]

{ #category : 'comparing' }
Athlete >> < anAthlete [
    ^ self earnings < anAthlete earnings

]

{ #category : 'comparing' }
Athlete >> <= anAthlete [
    ^ self earnings <= anAthlete earnings
]

{ #category : 'comparing' }
Athlete >> = anAthlete [
    ^ self earnings = anAthlete earnings
]

{ #category : 'comparing' }
Athlete >> > anAthlete [
    ^ self earnings > anAthlete earnings
]

{ #category : 'comparing' }
Athlete >> >= anAthlete [
    ^ self earnings >= anAthlete earnings
]

{ #category : 'accessing' }
Athlete >> age [
    ^ age
]

{ #category : 'accessing' }
Athlete >> age: anInteger [
    age := anInteger.

]

{ #category : 'copying' }
Athlete >> copy [
    | newAthlete |
    newAthlete := self class new.
    newAthlete surname: surname.
    newAthlete age: age.
    newAthlete nationality: nationality.
    ^ newAthlete
]

{ #category : 'methods' }
Athlete >> earnings [
    self subclassResponsibility
]

{ #category : 'comparing' }
Athlete >> hash [
    ^ self earnings hash
]

{ #category : 'arithmetic' }
Athlete >> incrementAge [
    age := age + 1
]

{ #category : 'initialization' }
Athlete >> initialize [
    super initialize.
    surname := ''.
    age := 0.
    nationality := ''
]

{ #category : 'accessing' }
Athlete >> nationality [
    ^ nationality
]

{ #category : 'accessing' }
Athlete >> nationality: aString [
    nationality := aString
]

{ #category : 'printing' }
Athlete >> printOn: aStream [
    aStream 
        nextPutAll: 'Athlete(';
        nextPutAll: surname;
        nextPutAll: ', age: ';
        print: age;
        nextPutAll: ', ';
        nextPutAll: nationality;
        nextPut: $)
]

{ #category : 'accessing' }
Athlete >> surname [
    ^ surname
]

{ #category : 'accessing' }
Athlete >> surname: aString [
    surname := aString
]
