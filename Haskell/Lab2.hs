-- Tsalesis Evangelos
-- AM: 1779


-----------------------------------------------------------------------------------------

-- ASKHSH 1


statistics :: [(Int,Int)]->(Int,Int,Int,Int,Int)														-- "Goal Statistics" Function
statistics [] 		= (0,0,0,0,0)																		-- If emply list, return zeroes
statistics list 	= (length list, points list, goalsFor list, goalsAgainst list, maximum (diff list))	-- otherwise return results


points :: [(Int,Int)]->Int 																				-- "Sum of Points" Function
points [] = 0 																							-- If empty list, return zero
points ((f,a):t) 																						-- otherwise, compare the pair of first tuple:
	| f > a 	= 3 + points t 																			-- 		if (goals for) > (goals against), add 3 points 
	| f < a 	= 0 + points t 																			-- 		if (goals for) < (goals against), add 0 points
	| f == a 	= 1 + points t 																			-- 		if (goals for) = (goals against), add 1 point 


goalsFor :: [(Int,Int)]->Int 																			-- "Goals for" Function				
goalsFor [] 			= 0 																			-- If empty list, return zero
goalsFor ((f,a):t)		= f + goalsFor t 																-- otherwise, add the "goals for" of the first pair


goalsAgainst :: [(Int,Int)]->Int 																		-- "Goals against" Function	
goalsAgainst [] 		= 0 																			-- If empty list, return zero
goalsAgainst ((f,a):t) 	= a + goalsAgainst t 															-- otherwise, add the "goals against" of the first pair


diff :: [(Int,Int)]->[Int] 																				-- "Goals difference" Function
diff [] 		= [] 																					-- If empty list, return empty list
diff ((f,a):t) 	= (f-a) : (diff t) 																		-- otherwise, return a list with the "goals difference" of every pair




-----------------------------------------------------------------------------------------
     
-- ASKHSH 2

wordList :: String->[String]																			-- "Word List" Function
wordList [] 	= []																					-- if string is empty, return empty list
wordList (h:t) 																							-- if string is not empty:
	| isLetter h 	= (word srt) : (wordList (rest srt))												-- 		if the first character is letter, add the first word in the list and call the recursive function with the rest of the string as new input
	| otherwise 	= wordList t 																		-- 		otherwise, call recursive fuction with the rest of string (without the first char) as an input
	where srt = (h:t) 																					-- str = the input string


word :: String->String 																					-- "First Word" Function (returns the first word in a string)
word []						= [] 																		-- if string is empty, return empty string
word (h:t)																								-- if string is not empty:
	| isLetter h == True  	= h : word(t) 	 															-- 		if first character is a letter, add it in the returned string													
	| otherwise			 	= [] 																		-- 		otherwise, return empty list


rest :: String->String 																					-- "Rest String" Function (returns the rest of the string without the first word)
rest [] 														= [] 									-- if string is empty, return empty string
rest (h:t) 																								-- if string is not empty:
	| t == []													= [] 									-- 		if rest of the string (without the first char) is empty, return empty string
	| ((isLetter h == True) && (isLetter (head t) == False))  	= t 									-- 		if first char is letter and second is not, return rest of the string
	| otherwise													= rest t 								-- 		otherwise, call the function again with rest of the string as an input


isLetter :: Char->Bool 																					-- "isLetter" Function (returns true if a char is a letter)
isLetter h 
	| (h_ascii >= 65 && h_ascii <= 90) || (h_ascii >= 97 && h_ascii <= 122) = True          			-- if the ascii number of the character shows that the char is a letter, return true
	| otherwise 															= False  					-- otherwise, return false
			where h_ascii = fromEnum h



-----------------------------------------------------------------------------------------
     
-- ASKHSH 3

move :: Eq u => [u]->u->Int->[u]																		-- "Move" Function
move s x n 																								-- if:	
	| elem x s == False  				= s 															-- 		if list s does not include item x, return list s 
	| n == 0							= delete s position 											--		if n = 0, delete the item x from list s
	| n > 0								= add (delete s position) x (position + n) 						-- 		if n > 0, add item x into list "s minus item x" in (previous position) + n
	| (n < 0) && ((abs n)<position)		= add (delete s position) x (position + n)						--		if n < 0 and |n|<(previous position), add item x into list "s minus item x" in (previous position) - n
	| (n < 0) && ((abs n)>=position) 	= x : (delete s position) 										--		if n < 0 and |n|>(previous position), add item x into list "s minus item x" as a first item
	where position = pos s x 0 																			--		position = returned value of "pos" function


pos :: Eq u => [u]->u->Int->Int 																		-- "Position of Item" Function (finds the position of an item in a list)
pos (h:t) x p 																							-- if:
	| h == x 		= p 																				--		if (head of list) = item, return position
	| h /= x		= pos t x (p+1) 																	--  	if (head of list) != item, move to the next position (position++)


delete :: [u]->Int->[u] 																				-- "Delete" Function (deletes an item in the position p)
delete [] p			= [] 																				-- if list is empty, return empty list
delete (h:t) p 																							-- if:
	| p == 0	 	= t																					-- 		if position = 0, return the rest of the list						
	| otherwise		= h : (delete t (p-1)) 																-- 		if position != 0, move to the next item (position--)
												

add :: [u]->u->Int->[u] 																				-- "Add" Function (adds the item x in the position p)
add [] x p 			= [x] 																				-- if list is empty, return item x
add (h:t) x p 																							-- otherwise:
	| p == 0 		= x : (h:t) 																		-- 		if position = 0, add item x
	| otherwise	 	= h : (add t x (p-1)) 																-- 		otherwise, move to the next position (position--)





-----------------------------------------------------------------------------------------
     
-- ASKHSH 4

integral :: (Double -> Double) -> Double-> Double-> Double-> Double 									-- "Integral" Function (numerical integration of a function f)
integral f a b d 																						-- if:
	| (b - a) <= d 	= (f ((a+b)/2))*(b-a) 																--  	if (b-a)<=d, compute the approximation
	| otherwise		= (integral f a ((a+b)/2) d) + (integral f ((a+b)/2) b d) 							--		otherwise, recursive method		




-----------------------------------------------------------------------------------------
     
-- ASKHSH 5                                   

hof :: [Integer]->(Integer->Integer) 																	-- "High Order Function"
hof s = \n -> positionF s n 1 																			-- declaration of secondary function


positionF :: [Integer]->Integer->Integer->Integer  														-- "Position of Item" Function (finds the position of an item in a list)										
positionF [] n p 	= 0																					-- if list empty, return 0
positionF (h:t) n p 																					-- if:
	| h == n 		= p 																				--		if (head of list) = item, return position
	| h /= n		= positionF t n (p+1) 																--		if (head of list) != item, move to the next position (position++)


