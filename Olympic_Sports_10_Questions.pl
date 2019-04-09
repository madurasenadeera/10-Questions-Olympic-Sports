% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% Title: Prolog - Ten Questions                                         %
% Author: Madura Senadeera                                              %                                        
% Last Update: 07/04/2019                                               %
% Description: AI integrated prolog program asking yes or no questions  %
% to identify the Olympic sport a user is thinking of.                  %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialiser                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Ten Question prolog can be started by: ?- begin.

begin :- sportOption(Sport), % runs through different options for olympic sports
      write('The Olympic sport must be: '), % once identified, prints out identified sport
      write(Sport),
      nl,
      undo.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Olympic Sports                                                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This lists the olympic sports capable of being identifying */

sportOption(aquatics)   :- aquatics, !.
sportOption(athletics)   :- athletics, !.
sportOption(cycling)   :- cycling, !.
sportOption(weightlifting)   :- weightlifting, !.
sportOption(gymnastics)   :- gymnastics, !.
sportOption(archery)   :- archery, !.
sportOption(volleyball)   :- volleyball, !.
sportOption(basketball)   :- basketball, !.
sportOption(soccer)   :- soccer, !.
sportOption(tabletennis)   :- tabletennis, !.

sportOption(unknown). % final option, unable to identify the sport

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Knowledge Base - Categories                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Identified categories of the Knowledge bases */

equipment([ball_sport, use_bicycle]).
type([team_sport, individual_sport]).
location([played_on_a_court, played_in_a_stadium]).
body([use_whole_body, mainly_use_legs, mainly_use_arms]).
activity([includes_relays, includes_running]).
opponents([one_at_a_time, versing_each_other]).
unique([played_in_sand, played_in_water, played_on_grass, played_in_a_velodrome,
lifting_of_heavy_weights, includes_a_hoop,requires_a_racket, involves_flips,
shooting_target, played_on_a_court]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Knowledge Base - Sport Characterisitcs                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% linked Knowledge base to the specific sports as their characterisitcs.
% The unique identifier of the sport has been listed at the bottom as the final question.

aquatics :- verify(played_in_a_stadium),
            verify(individual_sport),
            verify(use_whole_body),
            verify(includes_relays),
            verify(versing_each_other),
            verify(played_in_water).


athletics :- verify(played_in_a_stadium),
             verify(individual_sport),
             verify(mainly_use_legs),
             verify(includes_relays),
             verify(includes_running),
             verify(versing_each_other),
             verify(played_on_a_track).

cycling :- verify(played_in_a_stadium),
           verify(use_bicycle),
           verify(individual_sport),
           verify(mainly_use_legs),
           verify(versing_each_other),
           verify(played_in_a_velodrome).

weightlifting :- verify(played_in_a_stadium),
                 verify(use_weights),
                 verify(individual_sport),
                 verify(use_whole_body),
                 verify(one_at_a_time),
                 verify(lifting_of_heavy_weights).

gymnastics :- verify(played_in_a_stadium),
              verify(individual_sport),
              verify(use_whole_body),
              verify(includes_running),
              verify(one_at_a_time),
              verify(involves_flips).

archery :- verify(played_outdoors),
           verify(individual_sport),
           verify(mainly_use_arms),
           verify(one_at_a_time),
           verify(shooting_target).

volleyball :- verify(played_on_a_court),
              verify(ball_sport),
              verify(team_sport),
              verify(use_whole_body),
              verify(includes_running),
              verify(played_in_sand).

basketball :- verify(played_on_a_court),
              verify(ball_sport),
              verify(team_sport),
              verify(use_whole_body),
              verify(includes_running),
              verify(includes_a_hoop).

soccer :- verify(played_in_a_stadium),
          verify(ball_sport),
          verify(team_sport),
          verify(mainly_use_legs),
          verify(includes_running),
          verify(played_on_grass).


tabletennis :- verify(played_in_a_stadium),
               verify(ball_sport),
               verify(individual_sport),
               verify(mainly_use_arms),
               verify(requires_a_racket).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Asking Questions                                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% standardised question to be asked filtering through the knowledge base

ask(Question) :-
    write('Characteristic of the Olympic sport: '),
    write(Question),
    write('? '),
    read(Response),
    nl,
    ( (Response == yes ; Response == y)
      ->
       assert(yes(Question)) ;
       assert(no(Question)), fail).

:- dynamic yes/1,no/1.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Verification                                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% verification of knowledge base and making it clear that it is a true statement.

verify(S) :-
   (yes(S)
    ->
    true ;
    (no(S)
     ->
     fail ;
     ask(S))).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reset                                                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% resetting the whole system for another question session

undo :- retract(yes(_)),fail.
undo :- retract(no(_)),fail.
undo.
