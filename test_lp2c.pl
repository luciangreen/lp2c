%% Test file for List Prolog to C converter

% Load the converter
:- ['lp2cconverter'].

% Test case 1: Simple function with arguments
test_simple :-
    % List Prolog: add(a, b, c) :- +(a, b, c)
    ListPrologCode = [[[n,add], [[v,a], [v,b], [v,c]], [n,':-'], [[[n,'+'],[v,a],[v,b],[v,c]]]]],
    lp2c1(ListPrologCode, CCode),
    write('Test 1 - Simple function:'), nl,
    write(CCode), nl, nl.

% Test case 2: Function without arguments
test_no_args :-
    % List Prolog: hello :- print("hello world")
    % Try with just the string, not wrapped in a list
    ListPrologCode = [[[n,hello], [n,':-'], [[[n,print],"hello world"]]]],
    lp2c1(ListPrologCode, CCode),
    write('Test 2 - No arguments:'), nl,
    write(CCode), nl, nl.

% Test case 3: Function with multiple statements  
test_multiple_statements :-
    % List Prolog: function(a,b,c) :- +(a,b,d), +(d,1,c)
    ListPrologCode = [[[n,function], [[v,a], [v,b], [v,c]], [n,':-'], [[[n,'+'],[v,a],[v,b],[v,d]], [[n,'+'],[v,d],1,[v,c]]]]],
    lp2c1(ListPrologCode, CCode),
    write('Test 3 - Multiple statements:'), nl,
    write(CCode), nl, nl.

% Run all tests
run_tests :-
    write('Running List Prolog to C Converter Tests'), nl,
    write('========================================'), nl, nl,
    test_simple,
    test_no_args, 
    test_multiple_statements,
    write('Tests completed.'), nl.