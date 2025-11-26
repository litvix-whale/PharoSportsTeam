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

{ #category : 'tests' }
AthleteTest >> testRichestAthlete [
    | manager t1 f1 |
    manager := SportsTeamManager new.
    
    t1 := TennisPlayer new.
    t1 lastThreePrizes: (OrderedCollection withAll: #(100000 100000 100000)).
    
    f1 := FootballPlayer new
        annualContract: 1000000;
        goals: 0;
        yourself.
    
    manager addAthlete: t1.
    manager addAthlete: f1.
    
    self assert: manager richestAthlete equals: f1.
    self assert: manager isRichestFootballer
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

{ #category : 'tests' }
AthleteTest >> testUkrainianAthletes [
    | manager ukrainian |
    manager := SportsTeamManager new.
    
    manager addAthlete: (TennisPlayer new 
        nationality: 'Ukraine'; 
        surname: 'Test1';
        yourself).
    manager addAthlete: (FootballPlayer new 
        nationality: 'Poland'; 
        surname: 'Test2';
        yourself).
    manager addAthlete: (FootballPlayer new 
        nationality: 'Ukraine'; 
        surname: 'Test3';
        yourself).
    
    ukrainian := manager ukrainianAthletes.
    
    self assert: ukrainian size equals: 2.
    self assert: (ukrainian allSatisfy: [ :a | a nationality = 'Ukraine' ])
]
