/*

  Sicherman Dice in B-Prolog.

  From http://en.wikipedia.org/wiki/Sicherman_dice
  """ 
  Sicherman dice are the only pair of 6-sided dice which are not normal dice, 
  bear only positive integers, and have the same probability distribution for 
  the sum as normal dice.
  
  The faces on the dice are numbered 1, 2, 2, 3, 3, 4 and 1, 3, 4, 5, 6, 8.
  """

  I read about this problem in a book/column by Martin Gardner long
  time ago, and got inspired to model it now by the WolframBlog post
  "Sicherman Dice": http://blog.wolfram.com/2010/07/13/sicherman-dice/

  This model gets the two different ways, first the standard way and
  then the Sicherman dice:
  
  x1 = array1d(1..6, [1, 2, 3, 4, 5, 6]);
  x2 = array1d(1..6, [1, 2, 3, 4, 5, 6]);
  ----------
  x1 = array1d(1..6, [1, 2, 2, 3, 3, 4]);
  x2 = array1d(1..6, [1, 3, 4, 5, 6, 8]);


  Extra: If we also allow 0 (zero) as a valid value then the 
  following two solutions are also valid:
  
  x1 = array1d(1..6, [0, 1, 1, 2, 2, 3]);
  x2 = array1d(1..6, [2, 4, 5, 6, 7, 9]);
  ----------
  x1 = array1d(1..6, [0, 1, 2, 3, 4, 5]);
  x2 = array1d(1..6, [2, 3, 4, 5, 6, 7]);
  
  These two extra cases are mentioned here:
  http://mathworld.wolfram.com/SichermanDice.html

  Model created by Hakan Kjellerstrand, hakank@gmail.com
  See also my B-Prolog page: http://www.hakank.org/bprolog/

*/

go :-
        N = 6,  % number of dice
        M = 10, % max value of each side
        % standard distribution of 2 pair of dice
        StandardDist = [1,2,3,4,5,6,5,4,3,2,1],

        Min = 1, % min value: 0 or 1 (see above)

        length(X1,N),
        length(X2,N),
        X1 :: Min..M,
        X2 :: Min..M,

        % ensure standard distributions of the sums
        foreach(K in 1..10,
                StandardDist[K] #= sum([(X1[I]+X2[J] #= K+1) : I in 1..N, J in 1..N]) 
               ),

        % Symmetry breaking
        increasing(X1),
        increasing(X2),

        % x1 is less <= to x2
        foreach(I in 1..N,X1[I] #=< X2[I]),


        term_variables([X1,X2],Vars),
        labeling([degree,split], Vars),

        writeln(X1),
        writeln(X2),
        nl,
        fail.
        

increasing(List) :-
        foreach(I in 2..List^length, List[I-1] #=< List[I]).

