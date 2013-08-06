/*

  (Decomposition of) global constraint nvalues in B-Prolog.

  Reference: 
  Clobal Constraint Catalog
  http://www.emn.fr/x-info/sdemasse/gccat/Cnvalues.html
  """
  Purpose
 
      Let N be the number of distinct values assigned to the variables of the 
      VARIABLES collection. Enforce condition N <RELOP> LIMIT to hold.
 
  Example
      (<4,5,5,4,1,5>,=,3)
 
      The nvalues constraint holds since the number of distinct values occurring within 
      the collection 4,5,5,4,1,5 is equal (i.e., RELOP is set to =) to its 
      third argument LIMIT=3.
  """


  Model created by Hakan Kjellerstrand, hakank@gmail.com
  See also my B-Prolog page: http://www.hakank.org/bprolog/

*/


go :-
        Len = 5,
        length(X,Len),
        X :: 1..Len,
        N :: 1..Len,      

        % It's better to fix N,
        % otherwise the same X may yield many
        % solutions (when op is not #=).
        N #= 3,

        nvalues(X,#=<,N),

        nvalue(N2,X), % So, how many different values was it?

        term_variables([X,N], Vars),

        labeling(Vars),

        writeln([n:N, n2:N2, x:X]),
        fail.


%
% nvalues(X,Op,N)
%
% Requires that the number of distinct values in the array X is 
%    Op N 
% where
% Op is either one of 
%   #=, #<m, #=<, #>=, #>
% (this is not checked though)    
%
nvalues(X, Op, N) :-
        nvalue(M,X),
        T =.. [Op,M,N], 
        call(T).

%
% nvalue(?N,?X)
%
% Requires that the number of distinct values in X is N.
% (See http://www.hakank.org/bprolog/nvalue.pl)
%
nvalue(N, X) :-
        length(X,Len),
        N #= sum([ (sum([ (X[J] #= I) : J in 1..Len]) #> 0) : I in 1..Len]).
