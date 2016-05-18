# Toy Robot

#### Edited specifications

The original specifications are available within full_spec.md. This file just contains a rewording of the original to group and simplify concepts.

Command support:
- PLACE X,Y,F - puts robot on table  
- MOVE - move robot one unit forward in current facing direction  
- LEFT - face 90 degrees anti clockwise  
- RIGHT - face 90 degrees clockwise  
- REPORT - standard out, x, y and facing

Overall requirements:
- Square Tabletop. 5 units x 5 units.
- Ignore movement that would cause falling, including during placing.
- Co-ordinate "0,0" is in the bottom left corner.
- The app discards all commands until a valid PLACE.
- Input can be from file and standard input.
- Provide input test data


The following is assumed to be a mistake:

> A robot that is not on the table **can choose the ignore the** MOVE, LEFT, RIGHT and REPORT commands

- It seems the words "choose the ignore the" should be "choose to ignore the".
- Using the words "can choose" also conflicts with a statement earlier in spec "The application should discard all commands in the sequence until a valid PLACE command has been executed."

As such I have interpreted the statement as "A robot that is not on the table should ignore the MOVE, LEFT, RIGHT and REPORT commands."


Example input and output
------------------------
```
a)
PLACE 0,0,NORTH
MOVE
REPORT
Output: 0,1,NORTH

b)
PLACE 0,0,NORTH
LEFT
REPORT
Output: 0,0,WEST

c)
PLACE 1,2,EAST
MOVE
MOVE
LEFT
MOVE
REPORT
Output: 3,3,NORTH
```

Reasoning behind decisions
--------------------------

shared_examples in tests
  I want it to be explicit when two tests only differ in the test data. I use Rspec's shared_examples functionality to separate the things that change between each test, from the things that do not. In tests where this is not done, it is easy to miss that one test that is testing is a slightly different way to the tests that surround it.

  While many prefer to duplicate code between tests so tests are isolated from each other, I think grouping test logic can be a huge benefit if done sparingly. However I do realize that much of this is subjective.
