Class {
	#name : 'SportsClubMemoryStore',
	#superclass : 'Object',
	#classVars : [
		'SavedClub'
	],
	#category : 'SportsTeam',
	#package : 'SportsTeam'
}

{ #category : 'accessing' }
SportsClubMemoryStore class >> clear [
    SavedClub := nil

]

{ #category : 'actions' }
SportsClubMemoryStore class >> save: aClub [
    SavedClub := aClub


]

{ #category : 'as yet unclassified' }
SportsClubMemoryStore class >> savedClub [
    ^ SavedClub

]
