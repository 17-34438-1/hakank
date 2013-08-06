/*

  Twin letters problem in B-Prolog.

  From
  http://www.comp.nus.edu.sg/~henz/projects/puzzles/digits/index.html
  """
  Twin Letters    

  In the following puzzle, there are ten pairs of
  letters to be assigned to the same digit so that the multiplication
  (including intermediate results) is correct. Can you find out the
  pairs and their values?

          A B C
   *      D E F
   ____________
          G H I
        J K L
      M N O
   ____________
      P Q R S T



  Q=R=0, D=H=1, A=B=2, J=M=3, C=P=4, 
  K=N=5, I=T=6, E=G=7, L=O=8, F=S=9

  224 * 179
  _________
        716
       358
      358
  _________
      40096 
  """""


  Model created by Hakan Kjellerstrand, hakank@gmail.com
  See also my B-Prolog page: http://www.hakank.org/bprolog/

*/




go :-

        LD = [A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T],
        twin(LD), 
        writeln([a:A,b:B,c:C,d:D,e:E,f:F,g:G,h:H,i:I,j:J]),
        writeln([k:K,l:L,m:M,n:N,o:O,p:P,q:Q,r:R,s:S,t:T]),

        Alpha = [a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t],
        length(LD,Len),
        foreach(CC in 0..9, (El,II) in (LD,1..Len),
                [X],
                (
                    El =:= CC -> 
                        element(II,Alpha,X),
                        format("~d:~w ",[CC,X])
                ; 
                        true
                )),
        nl.


twin(LD) :-
        LD = [A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T],
        LD in 0..9,

        C1 in 0..1,
        C2 in 0..2,
        C3 in 0..1,

        % exactly 2 occurrences of each digit
        foreach(CC in 0..9,  exactly(2,LD,CC)), 

        100*G + 10*H + I +
        1000*J + 100*K + 10*L +
        10000*M + 1000*N + 100*O #=
        10000*P + 1000*Q + 100*R + 10*S + T,
        
        (100*D + 10*E + F)*C #= 100*G + 10*H + I,
        (100*D + 10*E + F)*B #= 100*J + 10*K + L,
        (100*D + 10*E + F)*A #= 100*M + 10*N + O,
        
        (100*A + 10*B + C) * (100*D + 10*E + F) #=
        10000*P + 1000*Q + 100*R + 10*S + T,

        % Carry restrictions
        T         #= I,
        S + 10*C1 #= H + L,
        R + 10*C2 #= G + K + O + C1,
        Q + 10*C3 #= J + N + C2,
        P         #= M + C3,

        % term_variables([LD,C1,C2,C3],Vars),
        % labeling([split],Vars).
        labeling([],LD),
        labeling([], [C1,C2,C3]).

