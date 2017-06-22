% Tsalesis Evanelos
% AM: 1997
%**************************************************************************
% note 1:
% some queries return "true ?" instead of "yes".
% (prolog tries to find multiples answers)
% The problem is solved when I insert cut (!) in the end of the rule,
% but then the "setof" queries don't work.

% note 2:
% in the excersise 5 the main rule is "oplus", not "oplus2".
%*************************************************************************

%-----------------------------------------------------------------------------------------

%-- ASKHSH 1

q1(C1,C2) :- 	event(E1,C1,D), 
				event(E2,C2,D).


q2(X,Y,C) :- 	at(X,A1,B1,C),
				at(Y,A2,B2,C),
				A1=<B2,
				A2=<B1,
				dif(X,Y).  

q3(S) :- 		event(E1,C1,D1), 
				event(E2,C2,D2), 
				event(E3,C3,D3),
				country(C1,S),
				country(C2,S),
				country(C3,S),
				dif(E1,E2), 
				dif(E1,E3), 
				dif(E2,E3), 
				D1=<D2, 
				D2=<D3, 
				D3-D1<7.

q4(X) :- 		at(X,A1,B1,C1), 
				at(X,A2,B2,C2), 
				dif_country(C1,C2),
				event(E1,C1,D1),
				event(E2,C2,D2),
				A1=<D1,
				B1>=D1,
				A2=<D2,
				B2>=D2.


dif_country(X,Y) :- country(X,S1), 
					country(Y,S2), 
					dif(S1,S2).


%-----------------------------------------------------------------------------------------

%-- ASKHSH 2

e(A,B) :-  	plane(A,B),
			dif(A,B).
e(A,B) :-  	plane(A,Z),
			e(Z,B),
			dif(A,Z).
e(A,B) :-  	train(A,B),
			dif(A,B).
e(A,B) :-  	train(A,Z),
			e(Z,B),
			dif(A,Z).
e(A,B) :-  	boat(A,B),
			dif(A,B).
e(A,B) :-  	boat(A,Z),
			e(Z,B),
			dif(A,Z).



q(A,B) :-	qN(A,B,2).

% N to count number of plane/boat travels
qN(A,B,N) :-  	N>1,
				plane(A,B),
				dif(A,B).
qN(A,B,N) :-  	N>0,
				plane(A,Z),
				K is N-1,
				qN(Z,B,K),
				dif(A,Z).
qN(A,B,N) :-  	N>1,
				boat(A,B),
				dif(A,B).
qN(A,B,N) :-  	N>0,
				boat(A,Z),
				K is N-1,
				qN(Z,B,K),
				dif(A,Z).
qN(A,B,N) :-  	N>0,
				train(A,B),
				dif(A,B).
qN(A,B,N) :-  	N>0,
				train(A,Z),
				qN(Z,B,N),
				dif(A,Z).


% using "or" symbol ";" 
% a,b;c,d. 		--> 	(a and b) or (c and d)
% a,(b;c),d. 	--> 	 a and (b or c) and d
p(A,B,1) :-	plane(A,B);boat(A,B);train(A,B);plane(B,A);boat(B,A);train(B,A).			
p(A,B,N) :-	N>1,
			(plane(A,Z);boat(A,Z);train(A,Z);plane(Z,A);boat(Z,A);train(Z,A)),
			K is N-1,
			p(Z,B,K).





%-----------------------------------------------------------------------------------------

%-- ASKHSH 3

thesis(A,B,C,S) :- 	(A<0;A>100;B<0;B>100;C<0;C>100),
					S is 0,
					!.


thesis(A,B,C,S) :- 	A=<B,
					B=<C,
					A < 50,
					B < 50,
					((A*30+B*45+C*25)//100) >= 50,
					S is 49,
					!.
thesis(A,B,C,S) :- 	B=<A,
					A=<C,
					B < 50,
					A < 50,
					((B*30+A*45+C*25)//100) >= 50,
					S is 49,
					!.
thesis(A,B,C,S) :- 	C=<A,
					A=<B,
					C < 50,
					A < 50,
					((C*30+A*45+B*25)//100) >= 50,
					S is 49,
					!.
thesis(A,B,C,S) :- 	C=<B,
					B=<A,
					C < 50,
					B < 50,
					((C*30+B*45+A*25)//100) >= 50,
					S is 49,
					!.
thesis(A,B,C,S) :- 	A=<C,
					C=<B,
					A < 50,
					C < 50,
					((A*30+C*45+B*25)//100) >= 50,
					S is 49,
					!.
thesis(A,B,C,S) :- 	B=<C,
					C=<A,
					B < 50,
					C < 50,
					((B*30+C*45+A*25)//100) >= 50,
					S is 49,
					!.


thesis(A,B,C,S) :- 	A=<B,
					B=<C,
					B >= 50,
					C >= 50,
					((A*30+B*45+C*25)//100) < 50,
					S is 50,
					!.
thesis(A,B,C,S) :- 	B=<A,
					A=<C,
					A >= 50,
					C >= 50,
					((B*30+A*45+C*25)//100) < 50,
					S is 50,
					!.
thesis(A,B,C,S) :- 	C=<A,
					A=<B,
					A >= 50,
					B >= 50,
					((C*30+A*45+B*25)//100) < 50,
					S is 50,
					!.
thesis(A,B,C,S) :- 	C=<B,
					B=<A,
					B >= 50,
					A >= 50,
					((C*30+B*45+A*25)//100) < 50,
					S is 50,
					!.
thesis(A,B,C,S) :- 	A=<C,
					C=<B,
					C >= 50,
					B >= 50,
					((A*30+C*45+B*25)//100) < 50,
					S is 50,
					!.
thesis(A,B,C,S) :- 	B=<C,
					C=<A,
					C >= 50,
					A >= 50,
					((B*30+C*45+A*25)//100) < 50,
					S is 50,
					!.

thesis(A,B,C,S) :- 	A=<B,
					B=<C,
					S is (A*30+B*45+C*25)//100,
					!.
thesis(A,B,C,S) :- 	B=<A,
					A=<C,
					S is (B*30+A*45+C*25)//100,
					!.
thesis(A,B,C,S) :- 	C=<A,
					A=<B,
					S is (C*30+A*45+B*25)//100,
					!.
thesis(A,B,C,S) :- 	C=<B,
					B=<A,
					S is (C*30+B*45+A*25)//100,
					!.
thesis(A,B,C,S) :- 	A=<C,
					C=<B,
					S is (A*30+C*45+B*25)//100,
					!.
thesis(A,B,C,S) :- 	B=<C,
					C=<A,
					S is (B*30+C*45+A*25)//100,
					!.





%-----------------------------------------------------------------------------------------

%-- ASKHSH 4

d(I,K,N,D) :- 	K == 0,
				D is 0,
				!.

d(I,K,N,D) :- 	K == 1,
				D is N,
				!.

d(I,K,N,D) :- 	K >= 2,
				K =< I,
				J is mod(I,K),
				d(J,K,N,R),
				D is R,
				!.

d(I,K,N,D) :- 	K == 2,
				I == 0,
				f(0,0,N,R),
				D is N-((R*(R+1))/2),
				!.

d(I,K,N,D) :- 	K == 2,
				I == 1,
				f(0,0,N,R),
				d(0,2,N,C),
				D is R-C,
				!.

d(I,K,N,D) :- 	K >= 3,
				I == 0,
				d(0,2,N,R),
				D is R,
				!.

d(I,K,N,D) :- 	K >= 3,
				I >= 1,
				K > I,
				J is I-1,
				L is K-1,
				d(1,2,N,M),
				d(J,L,M,R),
				D is R,
				!.


f(X,Y,N,R)	:-	Y > N,
				R is X-1,
				!.

f(X,Y,N,R)	:-	Y =< N,
				W is X+1,
				Z is X+Y+1,
				f(W,Z,N,Q),
				R is Q,
				!.




%-----------------------------------------------------------------------------------------

%-- ASKHSH 5

nat(0).
nat(s(X))				:-	nat(X).
nat(r(X))				:- 	nat(X).

% max final state
oplus(X,0,X)			:-	nat(X),!.
oplus(0,Y,Y)			:-	nat(Y),!.

% 	or
oplus(r(X),s(Y),r(Z))	:-	oplus(X,s(Y),Z),!.
oplus(s(X),r(Y),r(Z))	:-	oplus(s(X),Y,Z),!.

% max(a,b) recursion
oplus(r(X),r(Y),r(Z))	:-	oplus(X,Y,Z).


% make x,y,z all s(X)
oplus(s(X),s(Y),Z)	:-	oplus2(s(X),s(Y),Z).


% |b-d| final state
oplus2(X,0,X)			:-	nat(X),!.
oplus2(0,Y,Y)			:-	nat(Y),!.


% |b-d| recursion
oplus2(s(X),s(Y),Z) 	:-	oplus2(X,Y,Z).
	


%-----------------------------------------------------------------------------------------
%-----------------------------------------------------------------------------------------
%-----------------------------------------------------------------------------------------

%-- MHN TROPOPOIHSETE TO PARAKATW TMHMA KWDIKA 


dif(X,Y) :- X \= Y.

at(tiger,1,15,'Berlin').
at(tiger,16,37,'Athens').
at(tiger,38,50,'Rome').
at(wolf,1,4,'Rome').
at(wolf,5,5,'London').
at(wolf,6,7,'Rome').
at(wolf,8,8,'Rotterdam').
at(wolf,9,24,'Rome').
at(wolf,25,25,'Athens').
at(wolf,26,30,'Rome').
at(wolf,31,31,'Paris').
at(wolf,32,41,'Rome').
at(wolf,42,42,'Barcelona').
at(wolf,43,50,'Rome').
at(hawk,1,10,'Berlin').
at(hawk,11,20,'Stuttgart').
at(hawk,21,35,'Hamburg').
at(hawk,36,50,'Frankfurt').
at(shark,1,16,'Amsterdam').
at(shark,17,20,'London').
at(shark,21,29,'Paris').
at(shark,30,45,'Rome').
at(shark,43,48,'Brussels').
at(shark,49,50,'London').
at(spider,1,12,'Brussels').
at(spider,13,17,'Berlin').
at(spider,18,50,'Brussels').

event(e001,'Berlin',2).
event(e002,'Madrid',3).
event(e003,'London',5).
event(e004,'Rome',7).
event(e005,'Bristol',10).
event(e006,'Stuttgart',13).
event(e007,'Milan',17).
event(e008,'Amsterdam',17).
event(e009,'Rotterdam',18).
event(e010,'Hamburg',24).
event(e011,'Amsterdam',24).
event(e012,'Athens',25).
event(e013,'Groningen',25).
event(e014,'Paris',31).
event(e015,'Strasbourg',31).
event(e016,'Paris',37).
event(e017,'Brussels',40).
event(e018,'Brussels',41).
event(e019,'Barcelona',42).
event(e020,'Frankfurt',43).
event(e021,'Brussels',43).
event(e022,'London',47).

country('Amsterdam','Netherlands').
country('Athens','Greece').
country('Barcelona','Spain').
country('Berlin','Germany').
country('Bristol','United Kingdom').
country('Brussels','Belgium').
country('Frankfurt','Germany').
country('Groningen','Netherlands').
country('Hamburg','Germany').
country('London','United Kingdom').
country('Madrid','Spain').
country('Milan','Italy').
country('Paris','France').
country('Rome','Italy').
country('Rotterdam','Netherlands').
country('Strasbourg','France').
country('Stuttgart','Germany').

train(2,3).
train(3,4).
train(5,6).
train(6,7).
train(7,8).
train(7,9).
train(10,11).
train(10,13).
train(11,12).
train(12,13).
train(14,15).

boat(1,4).
boat(4,5).
boat(5,9).
boat(9,10).
boat(12,15).

plane(1,3).
plane(1,6).
plane(3,11).
plane(6,9).
plane(6,11).

