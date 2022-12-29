%% lp2c

% p(Grid1,Grid2,...) :- add_to_grid(Grid1,Grid3).

% -> p(grid1,grid2,...){ add_to_grid(grid1,grid3);}


lp2c1(Algorithm1,Algorithm2) :-
	%% note: without type, mode statements
	memberlp2c10(Algorithm1,"#include <stdio.h>\n#include <stdlib.h>\n",Algorithm2).
		%%string_concat(Algorithm3,"]",Algorithm2).

memberlp2c10([],Algorithm1,Algorithm1) :- !.
memberlp2c10(Functions2,Algorithm1,Algorithm2) :-
	Functions2=[Functions3|Functions4],
	memberlp2c1(Functions3,Algorithm1,Algorithm3),
	memberlp2c10(Functions4,Algorithm3,Algorithm2).

memberlp2c1(Functions2,Algorithm1,Algorithm2) :-
        Functions2=[Function,Arguments2,_Symbol,Body],
                	string_concat(Algorithm1,"int ",Algorithm1a),
        interpretstatementlp2c2a(Function,Algorithm1a,Algorithm3a),
        	string_concat(Algorithm3a,"(",Algorithm3d),
        interpretstatementlp2c2(Arguments2,Algorithm3d,Algorithm3e),
        	string_concat(Algorithm3e,"){",Algorithm3f),
                	concat_list([Algorithm3f,""],Algorithm3),
	interpretbodylp2c(Body,Algorithm3,Algorithm2a),
	      write_full_stop_if_last_item([],Algorithm2a,Algorithm2),
!.
	%%;
%%		memberlp2c11(Functions2,Algorithm1,Algorithm2)).
		
memberlp2c1(Functions2,Algorithm1,Algorithm2) :-
        Functions2=[Function,_Symbol,Body],
        interpretstatementlp2c2a(Function,Algorithm1,Algorithm3b),
                	concat_list([Algorithm3b,"(void){"],Algorithm3a),
		%%string_concat(Algorithm3a,"(",Algorithm3d),
        interpretbodylp2c(Body,Algorithm3a,Algorithm2a),
        write_full_stop_if_last_item([],Algorithm2a,Algorithm2),!.
      %%string_concat(Algorithm3e,")",Algorithm2))).
/**
	(
	memberlp2c12(Functions2,Algorithm1,Algorithm2))
	).
**/
	
memberlp2c1(Functions2,Algorithm1,Algorithm2) :-
        Functions2=[Function,Arguments2],
                interpretstatementlp2c2a(Function,Algorithm1,Algorithm3a),
                		string_concat(Algorithm3a,"(",Algorithm3d),
        interpretstatementlp2c2b(Arguments2,Algorithm3d,Algorithm2a),
        write_full_stop_if_last_item([],Algorithm2a,Algorithm2),!.
/**
        ;
	(memberlp2c13(Functions2,Algorithm1,Algorithm2)
	)).
**/

memberlp2c1(Functions2,Algorithm1,Algorithm2) :-
        Functions2=[Function],
        interpretstatementlp2c2b(Function,Algorithm1,Algorithm2a),
        write_full_stop_if_last_item([],Algorithm2a,Algorithm2),!.
/**
	,
	(Functions2=[_Function|Functions3],
				write_comma_if_not_empty_list(Functions3,Algorithm2b,Algorithm2a),
	memberlp2c1(Functions3,Algorithm2a,Algorithm2c),
					write_full_stop_if_last_item(Functions3,Algorithm2c,Algorithm2))
	).
**/

interpretbodylp2c([],Algorithm1,Algorithm1) :- !.
interpretbodylp2c(Body,Algorithm1,Algorithm2) :-
	Body=[Statement|Statements],
	Statement=[v,_],
	interpretstatementlp2c2a(Statement,Algorithm1,Algorithm3),		write_comma_if_not_empty_list(Statements,Algorithm3,Algorithm4),
interpretbodylp2c(Statements,Algorithm4,Algorithm2),
%%write_full_stop_if_last_item(Statements,Algorithm5,Algorithm2),
!.
interpretbodylp2c(Body,Algorithm1,Algorithm2) :-
        Body=[[Statements1|Statements1a]|Statements2],
		not(predicate_or_rule_name(Statements1)),
	string_concat(Algorithm1,"(",Algorithm3),
	interpretbodylp2c([Statements1],Algorithm3,Algorithm4),
	write_comma_if_not_empty_list(Statements1a,Algorithm4,Algorithm5),
	interpretbodylp2c(Statements1a,Algorithm5,Algorithm6),
		string_concat(Algorithm6,")",Algorithm6a),
			write_comma_and_newline_if_not_empty_list(Statements2,Algorithm6a,Algorithm7),
	interpretbodylp2c(Statements2,Algorithm7,Algorithm2),
				%%write_full_stop_if_last_item(Statements2,Algorithm8,Algorithm2),
	!.
        
interpretbodylp2c(Body,Algorithm1,Algorithm2) :-
        Body=[[[n,not],[Statement]]|Statements2],
	string_concat(Algorithm1,"not((",Algorithm3),
        	interpretbodylp2c([Statement],Algorithm3,Algorithm4),
		string_concat(Algorithm4,"))",Algorithm5),
	write_comma_if_not_empty_list(Statements2,Algorithm5,Algorithm6),
        interpretbodylp2c(Statements2,Algorithm6,Algorithm2),
        				%%write_full_stop_if_last_item(Statements2,Algorithm7,Algorithm2),
	!.

interpretbodylp2c(Body,Algorithm1,Algorithm2) :-
        Body=[[[n,or],[Statements1,Statements2]]|Statements3],
        	string_concat(Algorithm1,"((",Algorithm3),

        interpretbodylp2c([Statements1],Algorithm3,Algorithm4),
                	string_concat(Algorithm4,");(",Algorithm5),

        interpretbodylp2c([Statements2],Algorithm5,Algorithm6),
		string_concat(Algorithm6,"))",Algorithm7),
	write_comma_if_not_empty_list(Statements3,Algorithm7,Algorithm8),
        interpretbodylp2c(Statements3,Algorithm8,Algorithm2),
        				%%write_full_stop_if_last_item(Statements3,Algorithm9,Algorithm2),
        !.

interpretbodylp2c(Body,Algorithm1,Algorithm2) :-
        Body=[[[n,"->"],[Statements1,Statements2]]|Statements3],
        	string_concat(Algorithm1,"(",Algorithm3),
        interpretbodylp2c([Statements1],Algorithm3,Algorithm4),
        	string_concat(Algorithm4,"->(",Algorithm5),
                interpretbodylp2c([Statements2],Algorithm5,Algorithm6),
        	string_concat(Algorithm6,"))",Algorithm7),
	write_comma_if_not_empty_list(Statements3,Algorithm7,Algorithm8),
        interpretbodylp2c(Statements3,Algorithm8,Algorithm2),
        				%%write_full_stop_if_last_item(Statements3,Algorithm9,Algorithm2),
        !.

interpretbodylp2c(Body,Algorithm1,Algorithm2) :-
        Body=[[[n,"->"],[Statements1,Statements2,Statements2a]]|Statements3],
        	string_concat(Algorithm1,"(",Algorithm3),
        interpretbodylp2c([Statements1],Algorithm3,Algorithm4),
        	string_concat(Algorithm4,"->(",Algorithm5),
                interpretbodylp2c([Statements2],Algorithm5,Algorithm6),
        	string_concat(Algorithm6,");(",Algorithm7),
                interpretbodylp2c([Statements2a],Algorithm7,Algorithm8),
        	string_concat(Algorithm8,"))",Algorithm9),
	write_comma_if_not_empty_list(Statements3,Algorithm9,Algorithm10),
        interpretbodylp2c(Statements3,Algorithm10,Algorithm2),
        				%%write_full_stop_if_last_item(Statements3,Algorithm11,Algorithm2),
        !.

interpretbodylp2c(Body,Algorithm1,Algorithm2) :-
%trace,
        Body=[[[n,code]|Statements1]|Statements3],
        	string_concat(Algorithm1,"{",Algorithm3),
        	%trace,
        interpretbodylp2c(Statements1,Algorithm3,Algorithm4),
                	string_concat(Algorithm4,"}",Algorithm7),

	write_comma_if_not_empty_list(Statements3,Algorithm7,Algorithm8),
        interpretbodylp2c(Statements3,Algorithm8,Algorithm2),
        				%%write_full_stop_if_last_item(Statements3,Algorithm9,Algorithm2),
        !.


interpretbodylp2c(Body,Algorithm1,Algorithm2) :-
        Body=[[[n,findall],[Statements1,Statements2,Statements2a]]|Statements3],
        	%string_concat(Algorithm1,"(",Algorithm3),
        interpretstatementlp2c1([Statements1],"",Algorithm4),
        	%string_concat(Algorithm4,"->(",Algorithm5),
                interpretbodylp2c([Statements2],"",Algorithm6),
        	%string_concat(Algorithm6,");(",Algorithm7),
                interpretstatementlp2c1([Statements2a],"",Algorithm8),
        	%string_concat(Algorithm8,"))",Algorithm9),
        	foldr(string_concat,[Algorithm1,"findall(",Algorithm4,",",Algorithm6,",",Algorithm8,")"],Algorithm9),
	write_comma_if_not_empty_list(Statements3,Algorithm9,Algorithm10),
        interpretbodylp2c(Statements3,Algorithm10,Algorithm2),
        				%%write_full_stop_if_last_item(Statements3,Algorithm11,Algorithm2),
        !.


interpretbodylp2c(Body,Algorithm1,Algorithm2) :-
	Body=[Statement|Statements],
	not(predicate_or_rule_name(Statement)),
	interpretstatementlp2c1(Statement,Algorithm1,Algorithm3),		write_comma_if_not_empty_list2(Statements,Algorithm3,Algorithm4),
interpretbodylp2c(Statements,Algorithm4,Algorithm2),
%%write_full_stop_if_last_item(Statements,Algorithm5,Algorithm2),
!.

interpretbodylp2c(Arguments1,Algorithm1,Algorithm2) :-
	Arguments1=[Arguments2|Arguments3],
	interpretstatementlp2c2([Arguments2],Algorithm1,Algorithm3a),
	write_comma_if_not_empty_list(Arguments3,Algorithm3a,Algorithm4),
	interpretbodylp2c(Arguments3,Algorithm4,Algorithm2),!.

write_comma_if_not_empty_list(Statements2,Algorithm6,Algorithm7) :-
	(not(Statements2=[])->string_concat(Algorithm6,",",Algorithm7);
	Algorithm6=Algorithm7),!.

write_comma_if_not_empty_list2(Statements2,Algorithm6,Algorithm7) :-
	(not(Statements2=[])->string_concat(Algorithm6,";",Algorithm7);
	Algorithm6=Algorithm7),!.

write_comma_and_newline_if_not_empty_list(Statements2,Algorithm6,Algorithm7) :-
	(not(Statements2=[])->string_concat(Algorithm6,";\n",Algorithm7);
	Algorithm6=Algorithm7),!.

write_full_stop_if_last_item(Statements2,Algorithm8,Algorithm2) :-
	((length(Statements2,A),(A=0%%->true;A=1
	)
	)->string_concat(Algorithm8,";}\n",Algorithm2);
	Algorithm8=Algorithm2),!.

write_close_bracket_and_full_stop_if_last_item(Statements2,Algorithm8,Algorithm2) :-
	((length(Statements2,A),(A=0%%->true;A=1
	))->string_concat(Algorithm8,").\n",Algorithm2);
	Algorithm8=Algorithm2),!.

write_close_bracket_if_last_item(Statements2,Algorithm8,Algorithm2) :-
	((length(Statements2,A),(A=0%%->true;A=1
	))->string_concat(Algorithm8,")",Algorithm2);
	Algorithm8=Algorithm2),!.

write_close_bracket_and_comma_if_not_empty_list(Statements2,Algorithm6,Algorithm7) :-
	(not(Statements2=[])->string_concat(Algorithm6,"),",Algorithm7);
	Algorithm6=Algorithm7),!.
	
interpretstatementlp2c1(Statement,Algorithm1,Algorithm2) :-
	Statement=[[N_or_v,Name]],(N_or_v=n;N_or_v=v),
	interpretstatementlp2c2a([N_or_v,Name],Algorithm1,Algorithm2),!.
        	
interpretstatementlp2c1(Statement,Algorithm1,Algorithm2) :-
	Statement=[[N_or_v,Name],Arguments],(N_or_v=n;N_or_v=v),
	interpretstatementlp2c2a([N_or_v,Name],Algorithm1,Algorithm3a),
        	string_concat(Algorithm3a,"(",Algorithm3),
	interpretstatementlp2c2(Arguments,Algorithm3,Algorithm4),
        	string_concat(Algorithm4,")",Algorithm2),!.

interpretstatementlp2c2([],Algorithm1,Algorithm2) :- 
	string_concat(Algorithm1,"",Algorithm2),!.
interpretstatementlp2c2(Arguments1,Algorithm1,Algorithm2) :-
	Arguments1=[Arguments1a|Arguments2],
	interpretstatementlp2c2a(Arguments1a,Algorithm1,Algorithm3),
		write_comma_if_not_empty_list(Arguments2,Algorithm3,Algorithm4),
	interpretstatementlp2c2(Arguments2,Algorithm4,Algorithm2),!.
	   %%write_close_bracket_and_full_stop_if_last_item(Arguments2,Algorithm5,Algorithm2).

interpretstatementlp2c2b([],Algorithm1,Algorithm1) :- !.
interpretstatementlp2c2b(Arguments1,Algorithm1,Algorithm2) :-
	Arguments1=[Arguments1a|Arguments2],
	interpretstatementlp2c2a(Arguments1a,Algorithm1,Algorithm3),
		write_comma_if_not_empty_list(Arguments2,Algorithm3,Algorithm4),
	interpretstatementlp2c2b(Arguments2,Algorithm4,Algorithm5),
	   write_close_bracket_if_last_item(Arguments2,Algorithm5,Algorithm2),!.

interpretstatementlp2c2a(Arguments1,Algorithm1,Algorithm2) :-
	interpretstatementlp2c3(Arguments1,Name),
	string_concat(Algorithm1,Name,Algorithm2),!.

interpretstatementlp2c3([],"[]") :- 
!.

interpretstatementlp2c3([n,cut],"!") :- !.
interpretstatementlp2c3([n,Name],Name) :- !.
interpretstatementlp2c3([v,Name1],Name2) :- %string_concat(A,B,Name1),atom_length(A,1),%upcase_atom(A,A1),
string_concat("",Name1,Name2),!.
%%interpretstatementlp2c3([],"[]") :- !.
%%interpretstatementlp2c3("","\"\"") :- !.
interpretstatementlp2c3(Term1,Term2) :-
%not(is_list(Term1)),
not(contains_var([v,_],Term1)),
not(contains_var([n,_],Term1)),
term_to_atom(Term1,Term1a),
 foldr(string_concat,[Term1a],Term2),!.

interpretstatementlp2c3([Term1|Term1a],Term2) :- interpretstatementlp2c3(Term1,Term3),	
(Term1a=[]->
 foldr(string_concat,["[",Term3,"]"],Term2);
(interpretstatementlp2c4(Term1a,Term3a),	
 foldr(string_concat,["[",Term3,",",Term3a,"]"],Term2))),!.
%	string_concat("[",Term3,Term4),	string_concat(Term4,"]",Term2),!.

interpretstatementlp2c4([Term1|Term1a],Term2) :- interpretstatementlp2c3(Term1,Term3),	
(Term1a=[]->
 foldr(string_concat,[Term3],Term2);
(interpretstatementlp2c4(Term1a,Term3a),	
 foldr(string_concat,[Term3,",",Term3a],Term2))),!.
%	string_concat("[",Term3,Term4),	string_concat(Term4,"]",Term2),!.

interpretstatementlp2c3(Value1,Value2):-term_to_atom(Value1,Value2),!.



