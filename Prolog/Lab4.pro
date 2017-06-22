
%-----------------------------------------------------------------------------------------

%-- ASKHSH 1

% initial conditions (N=1, S=1-A)
p(X,A,N) 		:-	L is 1-A,
					phlp(X,A,N,1,L).

%  this rule is true when the condition is met.
phlp(X,A,N,M,L)	:-	L >= X,
					N is M,
					!.
% this rule implements the steps
phlp(X,A,N,M,L) 	:- 	K is M + 1,
						P is L+(1-A/K),
				 		phlp(X,A,N,K,P).



%-----------------------------------------------------------------------------------------

%-- ASKHSH 2

sumOf2Cubes(N) 	:- 	cube2(N,P,0),
					sumof2Cubeshlp(N,P).


% returns true when N-R^3 has an integer cube root
sumof2Cubeshlp(N,R)	:-	P is N - R*R*R,
						P > 0,
						cube(P,0),
						!.
sumof2Cubeshlp(N,0) :- !,fail.

% this rule implements the steps (from cuberoot(N) to zero)
sumof2Cubeshlp(N,R) :- 	K is R-1,
						sumof2Cubeshlp(N,K).


% returns true when X has an integer cube root
cube(X,N)	:-	X =:= N*N*N,
				!.
cube(X,X) 	:- 	!,fail.
cube(X,N) 	:- 	K is N+1,
				cube(X,K).


% calculates nearest integer to cube root of X.
cube2(X,R,N)	:-	X =< N*N*N,
					R is N,
				!.
cube2(X,R,N) 	:- 	K is N+1,
					cube2(X,R,K).


%-----------------------------------------------------------------------------------------

%-- ASKHSH 3


replace([],X,S,[])			:- 		!.

% when S is emply, delete the elements of L that is equal to X
replace([H|T],X,[],R) 		:- 		H = X,
									replace(T,X,[],R),!.

% when an element of L is equal to X, replace it with the respective element of S.
replace([H|T],X,[Q|S],[Q|R]) 	:- 	H = X,
									replace(T,X,S,R),!.
replace([H|T],X,S,[H|R]) 		:- 	replace(T,X,S,R),!.




%-----------------------------------------------------------------------------------------

%-- ASKHSH 4

majority(L,X)  			:-	halflength(L,N,0),
							candidates(L,X,N).

% returns the candidate who got more than n/2 votes, or "no" if there is none.
candidates([H|T],X,N) 	:- 	votes([H|T],X,N),
							!.						
candidates([H|T],X,N) 	:- 	candidates(T,X,N).

% returns "yes" if the current candidate got more than n/2 votes, or "no" if he did not.
votes(L,X,0).
votes([],X,N) 		:- 	!,fail.
votes([H|T],X,N) 	:- 	H=X,
						K is N - 1,
						votes(T,X,K),!.
votes([H|T],X,N) 	:- 	votes(T,X,N),!.

% returns min integer that is >n/2
halflength([],N,C) 		:- 	N is 1+truncate(C/2).
halflength([H|T],N,C) 	:- 	K is C+1,
							halflength(T,N,K).




%-----------------------------------------------------------------------------------------

%-- ASKHSH 5

domino([]) :- !,fail.

domino(L).








