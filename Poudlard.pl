% Déclaration des suspects
suspect(drago).
suspect(neville).
suspect(ginny).

% Déclarations des suspects
% Drago : "Si je suis coupable, alors Neville est innocent."
declaration(drago, Coupable) :- (Coupable = drago -> innocent(neville); true).

% Neville : "Si Drago est coupable, alors Ginny est innocente."
declaration(neville, Coupable) :- (Coupable = drago -> innocent(ginny); true).

% Ginny : "Si je suis coupable, alors ni Drago ni Neville ne le sont."
declaration(ginny, Coupable) :- (Coupable = ginny -> (innocent(drago), innocent(neville)); true).

% Règle définissant l'innocence
guilty(Suspect) :-
    suspect(Suspect),
    declaration(drago, Suspect),
    declaration(neville, Suspect),
    declaration(ginny, Suspect).

innocent(Suspect) :-
    suspect(Suspect),
    \+ guilty(Suspect).

% Règle principale pour trouver le coupable parmi les suspects
coupable_unique(Coupable) :-
    suspect(Coupable),
    guilty(Coupable),
    findall(S, guilty(S), Coupables),
    length(Coupables, 1).

% Règle pour analyser une liste de suspects et déterminer le coupable unique
coupable_par_liste([Suspect|_], Coupable) :-
    coupable_unique(Suspect),
    Coupable = Suspect.
coupable_par_liste([_|Reste], Coupable) :-
    coupable_par_liste(Reste, Coupable).

% Question pour tester le programme
% ?- coupable_unique(Coupable).
% % ?- coupable_par_liste([drago, neville, ginny], Coupable).



