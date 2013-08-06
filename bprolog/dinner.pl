/*

  A dinner problem in B-Prolog.

  http://www.sellsbrothers.com/spout/#The_Logic_of_Logic
  """
  My son came to me the other day and said, "Dad, I need help with a"
  "math problem." The problem went like this:

    * We're going out to dinner taking 1-6 grandparents, 1-10 parents and/or 1-40 children
    * Grandparents cost $3 for dinner, parents $2 and children $0.50
    * There must be 20 total people at dinner and it must cost $20
    * How many grandparents, parents and children are going to dinner?
  """

  Model created by Hakan Kjellerstrand, hakank@gmail.com
  See also my B-Prolog page: http://www.hakank.org/bprolog/

*/


go :-
        findall([grandparents:Grandparents, 
                 parents:Parents, 
                 children:Children], 
                solve([Grandparents,
                       Parents,
                       Children]),
                L),
        writeln(L),
        nl.

solve([Grandparents, Parents, Children]) :-
        Grandparents :: 0..100,
        Parents      :: 0..100,
        Children     :: 0..100,
        Grandparents * 3 + Parents * 2 + Children / 2 #= 20,

        Grandparents + Parents + Children #= 20, % number of people = 20

        % must be some of each
        Grandparents #> 0,
        Parents      #> 0,
        Children     #> 0,
        
        labeling([],[Grandparents, Parents, Children]).
        
