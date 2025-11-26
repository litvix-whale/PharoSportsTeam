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

{ #category : 'accessing' }
Athlete >> age [
    ^ age
]

{ #category : 'accessing' }
Athlete >> age: anInteger [
    age := anInteger.

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
