-- Tsalesis Evangelos
-- AM: 1779

-----------------------------------------------------------------------------------------

-- ASKHSH 1


cost :: Int->Float->Float													-- "Total Cost" Function
cost n p   																	-- Conditions
	| n < 0		= 0 														-- wrong input, return 0
	| p < 0 	= 0 														-- wrong input, return 0
	| n < 5 	= discount((fromIntegral n) * p)							-- no free item
	| n >= 5 && n < 9 	= discount((fromIntegral (n-1)) * p)				-- one free item
	| n >= 9 	= discount((fromIntegral (n - (2 + div (n-9) 3 ))) * p)		-- two free items plus one free item every three items


discount :: Float -> Float													-- Discount (10% when >100) Function
discount d
	| d <= 100	= d
	| d > 100	= d * 0.9


-----------------------------------------------------------------------------------------
     
-- ASKHSH 2

call :: (Int,Int,Int)->(Int,Int,Int)->Float							 -- "Call Charge" Function
call (h1,m1,s1) (h2,m2,s2) 											 -- Conditions
	| d == 0 	= 0 												 -- zero duration call
	| d <= 180 	= 0.58												 -- charge for call less than 3min
	| d > 180 	= 0.58 + 0.003 * (d - 180)       					 -- charge for call more than 3min                                
	where	{	sec1 	= h1*3600 + m1*60 + s1; 					 -- starting time in secs
				sec2 	= h2*3600 + m2*60 + s2;						 -- ending time in secs
				d 	 	= fromIntegral (mod (sec2 - sec1) 86400)}	 -- duration in secs







-----------------------------------------------------------------------------------------
     
-- ASKHSH 3

pow :: Integer->Integer												 -- "Nearest power of 2" Function
pow n = pow2 n (h:t)												 -- return result of function pow2(n, inf_list)
	where (h:t) = [0,1..]                             				 -- inf_list = [0,1,2...]


pow2 :: Integer->[Integer]->Integer									 -- pow2 Function
pow2 n (h:t)														 
	| abs (n-2^h) >= abs (n-2^(head t)) = pow2 n t 					 -- if |n-2^head|>=|n-2^(head+1)|, return pow2(n,tail)
	| abs (n-2^h) < abs (n-2^(head t)) 	= 2^h 						 -- if |n-2^head|<|n-2^(head+1)|, return 2^head







-----------------------------------------------------------------------------------------
     
-- ASKHSH 4

num2dig :: Integer->Integer 										-- "Digits Multiplier" Function
num2dig n 
	| n >= 10  = num2dig(multiply (digits n))						-- if n >= 10, call the recursive function for the new n
	| otherwise 	= n   											-- otherwise return the final result        


digits :: Integer -> [Integer]										-- function which returns a list of the digits of n
digits n
	| n >= 10 	= (mod n 10) : (digits (div (n -  (mod n 10)) 10))	-- if n>=10, return (last digit of n) : digits(n without the last digit)  (recursion)
	| n < 10 	= [n]												-- if n<10, return the number n in a list


multiply :: [Integer] -> Integer 									-- function to multiply the digits of a list
multiply []		= 1 												-- if the list is empty return 1
multiply (h:t)
	| h == 0 	= multiply t  										-- if head of the list == 0, return  1*multiply(tail)  (recursion)
	| otherwise = h * multiply t 									-- otherwise, return  head*multiply(tail)




-----------------------------------------------------------------------------------------
     
-- ASKHSH 5                                   

ijk :: Int->(Int,Int,Int) 																					-- "Factorization" Function
ijk n = selection n (0,0,0) (divisors n (h:t)) (divisors n (h:t)) (divisors n (h:t))						-- return the result
	where (h:t) = [1,2..n] 																				  	-- list = [1,2,3,...,n]


divisors :: Int->[Int]->[Int] 																				-- function to find all the divisors
divisors n [] = []																							-- if list is empty return empty list
divisors n (h:t)  																							-- Conditions
	| (mod n h) == 0 	= h : (divisors n t) 																-- if n mod(head) = 0, return head:(divisors(n,tail)) (recursion)
	| otherwise 		= divisors n t 																		-- otherwise, return divisors(n,tail) (recursion)
	

selection :: Int->(Int,Int,Int)->[Int]->[Int]->[Int]->(Int,Int,Int) 										-- function to find the right triplet in the list of all divisors
selection d (r1,r2,r3) (hi:ti) (hj:tj) [] 			= selection d (r1,r2,r3) (hi:ti) tj tj 					-- The algorithm		|	for (i=0; i<length(list); i++)
selection d (r1,r2,r3) (hi:ti) [] []				= selection d (r1,r2,r3)  ti ti ti 						-- uses 3 loops.		|		for (j=0; j<length(list); j++)
selection d (r1,r2,r3) [] [] []						=  (r1,r2,r3) 											-- In a imperative		|		 	for (z=0; z<length(list); z++)
selection d (r1,r2,r3) (hi:ti) (hj:tj) (hz:tz) 																-- language 			|				if (n = list[i]*list[j]*list[z] && list(z)-list(j)<=d)
	| last(hi:ti) == hi*hj*hz && (hz-hj)<=d  		= selection (hz-hj) (hi,hj,hz) (hi:ti) (hj:tj) tz 		-- pseudocode is		|						d = d;
	| otherwise 									= selection d (r1,r2,r3) (hi:ti) (hj:tj) tz 			-- like this --->		|						(a,b,c) = (list[i],list[j],list[z])
																											--						|	return (a,b,c)