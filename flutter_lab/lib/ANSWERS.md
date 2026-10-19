Name: Maryam Bashir
Roll no: 04072313017

A1: 6
A2: 8
A3: 12
A4: 45

B1: StudentCard, GoalBanner, HomePage and LabApp are Stateless because they only show the data they are given and never change by themselves. Tally, Countdown and BuggyCounter are Stateful because they keep values that change (count, seconds left, clicks).
B2: The Timer keeps running even after the widget is removed. If it is not cancelled in dispose(), it keeps calling setState on a disposed State, which causes errors and wastes memory.
B3: HomePage(), Tally(), Countdown(), BuggyCounter(), the SizedBox widgets and Text('Reset') can be const. StudentCard cannot, because course is not a const value. const lets Flutter reuse the same object, so it uses less memory and skips unnecessary rebuilds.