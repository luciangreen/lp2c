%% Comprehensive test cases for List Prolog to C converter
%% Based on the README example and additional functionality

:- ['lp2cconverter'].

% Test case matching the README example exactly
test_readme_example :-
    % README example: function(a,b,c) :- +(a,b,d), +(d,1,c)
    ListPrologCode = [[[n,function], [[v,a], [v,b], [v,c]], [n,':-'], [[[n,'+'],[v,a],[v,b],[v,d]], [[n,'+'],[v,d],1,[v,c]]]]],
    lp2c1(ListPrologCode, CCode),
    write('README Example:'), nl,
    write(CCode), nl, nl.

% Test multiple functions in one program
test_multiple_functions :-
    ListPrologCode = [
        [[n,add], [[v,x], [v,y], [v,result]], [n,':-'], [[[n,'+'],[v,x],[v,y],[v,result]]]],
        [[n,multiply], [[v,a], [v,b], [v,product]], [n,':-'], [[[n,'*'],[v,a],[v,b],[v,product]]]]
    ],
    lp2c1(ListPrologCode, CCode),
    write('Multiple Functions:'), nl,
    write(CCode), nl, nl.

% Test function with no arguments and simple body
test_simple_function :-
    ListPrologCode = [[[n,main], [n,':-'], [[[n,printf],"Hello World"]]]],
    lp2c1(ListPrologCode, CCode),
    write('Simple Function:'), nl,
    write(CCode), nl, nl.

% Test complex expressions with nested calls
test_complex_expression :-
    % complex(x,y,z) :- +(x,*(y,2),temp), +(temp,z,result)
    ListPrologCode = [[[n,complex], [[v,x], [v,y], [v,z]], [n,':-'], [[[n,'+'],[v,x],[[n,'*'],[v,y],2],[v,temp]], [[n,'+'],[v,temp],[v,z],[v,result]]]]],
    lp2c1(ListPrologCode, CCode),
    write('Complex Expression (nested):'), nl,
    write(CCode), nl, nl.

% Run all comprehensive tests
run_comprehensive_tests :-
    write('List Prolog to C Converter - Comprehensive Tests'), nl,
    write('=================================================='), nl, nl,
    test_readme_example,
    test_multiple_functions,
    test_simple_function,
    test_complex_expression,
    write('All tests completed successfully!'), nl.