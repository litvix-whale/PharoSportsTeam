Class {
	#name : 'AthleteTest',
	#superclass : 'TestCase',
	#category : 'SportsTeam',
	#package : 'SportsTeam'
}

{ #category : 'testing' }
AthleteTest >> testAthleteComparison [
    | tennis football |
    tennis := TennisPlayer new
        lastThreePrizes: (OrderedCollection withAll: #(100000 100000 100000));
        yourself.
    football := FootballPlayer new
        annualContract: 500000;
        goals: 0;
        yourself.
    self assert: football > tennis
]

{ #category : 'testing' }
AthleteTest >> testFootballPlayerEarnings [
    | player |
    player := FootballPlayer new
        surname: 'Test';
        age: 25;
        nationality: 'Ukraine';
        club: 'TestFC';
        annualContract: 1000000;
        goals: 10;
        yourself.
    "1000000 * 1.10 = 1100000"
    self assert: player earnings equals: 1100000

]

{ #category : 'testing' }
AthleteTest >> testIncrementAge [
    | athlete |
    athlete := TennisPlayer new age: 25; yourself.
    athlete incrementAge.
    self assert: athlete age equals: 26
]

{ #category : 'testing' }
AthleteTest >> testTennisPlayerEarnings [
    | player |
    player := TennisPlayer new
        surname: 'Test';
        age: 25;
        nationality: 'Ukraine';
        worldRanking: 10;
        lastThreePrizes: (OrderedCollection withAll: #(100000 200000 300000));
        yourself.
    self assert: player earnings equals: 600000
]
