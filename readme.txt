*** NIRA GUI v1.1 README ***

** Changes from v1.0 **

+ Added support for MATLAB 2013b.

+ Fixed miscellaneous bugs, particularly with regard to variables or
  functions sharing parts of names.

** Usage **

+ To initiate NIRA-GUI, type ‘NIRA’ into the MATLAB console.

+ NIRA supports both static and open loop games. While its core functionality is to solve for
  coupled-constraint Nash equilibria, it can also solve for welfare-maximising solutions.

+ In order to allow the number of periods in an open loop game to be changed quickly, the term "(n)"
  can be used in the payoff and constraint functions. If we say that T = total periods, (n) will be
  substituted as:
  
   * the current period (from 0 to T-1) in the stage payoffs,
   * T in the scrap payoffs, and
   * for each constraint that contains (n), that constraint will be duplicated with (n) = 0,...,T-1.

+ If vectors are entered in the constants 'Value' column, NIRA will solve for every possible
  combination of constants. This allows results from a range of parameterisations to be solved.

+ From the results screen, the output can be exported to the workspace. It is stored in a
  structure array called Output. Output has the same number of dimensions as the number of
  constants that were entered as vectors, so each combination of constants (and therefore
  each solution) has a unique cell in Output.
  
+ NIRA-GUI automatically produces a log. This can be accessed through the global variable LOG.

+ The custom solution functionality allows for greater flexibility in using NIRA-GUI. It
  allows the power of the GUI (and its simplification algorithms) to be combined with the
  flexibility of directly-coded solutions. For example, it could allow an openloop game to
  be run dynamically with different numbers of periods, and different specifications of
  variables in each length.

   * A game’s specification is stored in a global structure GAME. GAME stores both the
     game as entered into the GUI and its simplified form that NIRA-GUI has produced. It
     does not store results. Accessing GAME through the MATLAB dashboard is possible
     through the command ‘global GAME’ after NIRA has been initiated. Exploring this
     structure is recommended before using the custom solution functionality, as presumably
     the user will want to edit GAME directly.

   * The variables in the GUI will be loaded into GAME and simplified before the custom
     solution code is run. After editing GAME directly, calling simplifystruct() will
     update the simplified forms stored within GAME to match its unsimplified forms.

   * [NashEquilibrium, Payoffs, Constraints, Exitflag, Time] = solveNIRA() will solve
     the game for its coupled-constraint equilibrium using NIRA, with that vector of
     outputs having their obvious interpretations.

   * The following  is an example of code that could be entered into the custom solution:
      demand1 = 0:0.5:3
      p = zeros (1,7)
      for n = 1:7
	  GAME.constants(1).value  = demand1(n)
	  simplifystruct()
	  [payoff, ~, ~, ~,~] = solveNIRA()
	  p(n) = payoff(1)
      end
      assignin('base', 'Player1Payoffs', p)
