/*

  Breaking news puzzle (Dell Logic Puzzles) in B-Prolog.

  From http://brownbuffalo.sourceforge.net/BreakingNewsClues.html
  """
  Title: Breaking News
  Author: Faith Johnson
  Publication: Dell Logic Puzzles
  Issue: April, 1998
  Page: 9
  Stars: 1

  The Daily Galaxy sent its four best reporters 
      (Corey, Jimmy, Lois, and Perry) 
  to different locations 
      (Bayonne, New Hope, Port Charles, and South Amboy) 
  to cover four breaking news events 
      (30-pound baby, blimp launching, skyscraper dedication, and 
       beached whale). 
  Their editor is trying to remember where each of the reporters is. 
  Can you match the name of each reporter with the place he or she 
  was sent, and the event that each covered?

  1. The 30-pound baby wasn't born in South Amboy or New Hope.
  2. Jimmy didn't go to Port Charles.
  3. The blimp launching and the skyscraper dedication were covered, 
     in some order, by Lois and the reporter who was sent to Port Charles.
  4. South Amboy was not the site of either the beached whale or the 
     skyscraper dedication.
  5. Bayonne is either the place that Corey went or the place where 
     the whale was beached, or both.

  Determine: Reporter -- Location -- Story
  """

  Model created by Hakan Kjellerstrand, hakank@gmail.com
  See also my B-Prolog page: http://www.hakank.org/bprolog/

*/



go :-

        N = 4,

        Corey = 1,
        Jimmy = 2,
        Lois  = 3,
        Perry = 4,
        Reporters = [Corey, Jimmy, Lois, Perry],
        ReportersS = ['Corey', 'Jimmy', 'Lois', 'Perry'],

        Locations = [Bayonne, NewHope, PortCharles, SouthAmboy],
        LocationsS = ['Bayonne', 'New Hope', 'Port Charles', 'South Amboy'],
        Locations :: 1..N,
        
        News = [Baby, Blimp, Skyscraper, Whale],
        NewsS = ['Baby', 'Blimp', 'Skyscraper', 'Whale'],
        News :: 1..N,
        
        alldifferent(Locations),
        alldifferent(News),
        
        % 1. The 30-pound baby wasn't born in South Amboy or New Hope.
        Baby #\= SouthAmboy,
        Baby #\= NewHope,
        
        % 2. Jimmy didn't go to Port Charles.
        Jimmy #\= PortCharles,
        
        % 3. The blimp launching and the skyscraper dedication were covered, 
        %    in some order, by Lois and the reporter who was sent to 
        %    Port Charles.
        Lois #\= PortCharles,
        ( 
            (Blimp #= Lois, Skyscraper #= PortCharles)
        ;
            (Skyscraper #= Lois, Blimp #= PortCharles)
        ),

        % 4. South Amboy was not the site of either the beached whale or the 
        %    skyscraper dedication.
        SouthAmboy #\= Whale,
        SouthAmboy #\= Skyscraper,

        % 5. Bayonne is either the place that Corey went or the place where 
        %    the whale was beached, or both.
        ( 
            Bayonne #= Corey #\/ Bayonne #= Whale
        ),

        term_variables([Locations,News], Vars),
        labeling(Vars),

        print_all('Reporters',Reporters,ReportersS),
        print_all('Locations',Locations,LocationsS),
        print_all('News',News,NewsS),
        nl,
        statistics(backtracks,Backtracks),
        writeln('Backtracks':Backtracks).
        


print_all(What, X,S) :-
        length(X,Len),
        write(What),write(': '),
        foreach(I in 1..Len, [IX,This],
                (nth1(IX,X,I),
                 nth1(IX,S,This),
                 write(This), write(' ')
                )
        ),nl.
