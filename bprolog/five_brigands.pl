/*

  Five brigands problem in B-Prolog.

  From http://www.comp.nus.edu.sg/~henz/projects/puzzles/arith/index.html
  """
  The Five Brigands    from "Amusements in Mathematics, Dudeney",
  number 133.

  The five Spanish brigands, Alfonso, Benito, Carlos, Diego, and Esteban,
  were counting their spoils after a raid, when it was found that they
  had captured altogether exacly 200 doubloons. One of the band pointed
  out that if Alfonso had twelve times as much, Benito three times as
  much, Carlos the same amount, Diego half as much, and Esteban one-
  third as much, they would still have altogether just 200 doubloons.
  How many doubloons had each?

  There are a good many equally correct answers to this problem. The
  puzzle is to discover exactly how many different answers there are, it
  being understood that every man had something and there is to be no
  fractional money. 
  """


  Model created by Hakan Kjellerstrand, hakank@gmail.com
  See also my B-Prolog page: http://www.hakank.org/bprolog/

*/



go :-
        findall(LD, brigands(LD), L),
        length(L, Len),
        writeln(len:Len),
        foreach(El in L, writeln(El)).

brigands(LD) :-

        LD = [A,B,C,D2,E3],
        LD :: 8..160, % Everybody has at least 8d.; nobody has more than 160
        A + B + C + 2*D2 + 3*E3 #= 200,
        A * 12 + B * 3 + C + D2 + E3  #= 200,
        D2 :: 8..100,
        E3 :: 8..66,

        labeling(LD).
