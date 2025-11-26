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
    ^ athletes max: [ :a | a earnings ]
]

{ #category : 'accessing' }
SportsTeamManager >> ukrainianAthletes [
    ^ athletes select: [ :a | a nationality = 'Ukraine' ]
]
