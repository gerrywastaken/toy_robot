# Toy Robot

[![Build status](https://github.com/gerrywastaken/toy_robot/workflows/Ruby/badge.svg)](https://github.com/gerrywastaken/toy_robot/actions)

This is a simple program for moving a robot around on a platform.


#### Requirements

Ruby MRI version 2.3.1 is required. If you don't wish to run the specs then you
can get away with 2.3.0.


#### Installation

```bash
> git clone https://github.com/gerrywastaken/toy_robot.git
> cd toy_robot
# Your Ruby version manager should read the .ruby-version file and set the
# version accordingly. If not you will need to set it to MRI 2.3.1
> bundle install
```

#### Usage

Input from a file

```bash
> ./toy_robot commands.txt
```

Standard input:

```bash
> cat commands.txt | ./toy_robot
```

or

```bash
> echo "PLACE 1,2,NORTH\nLEFT\nMOVE\nRIGHT\nREPORT" | ./toy_robot
```

Manual input:

```bash
> ./toy_robot
PLACE 1,2,NORTH
LEFT
MOVE
RIGHT
REPORT
```


#### Edited specification

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


#### Example input and output

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


#### Assumptions and reasoning

<dl>
  <dt>shared_examples in tests</dt>
  <dd>I want it to be explicit when two tests only differ in the test data. I use Rspec's shared_examples functionality to separate the things that change between each test, from the things that do not. In tests where this is not done, it is easy to miss that one test that is testing is a slightly different way to the tests that surround it.

  While many prefer to duplicate code between tests so tests are isolated from each other, I think grouping test logic can be a huge benefit if done sparingly. However I do realize that much of this is subjective.</dd>

  <dt>Simulated Polymorphism</dt>
  <dd>While the `if placed?` checks could be removed from the Robot class by adding a PlacedRobot class, this will end up adding to the overall complexity and reducing readability.</dd>

  <dt>Additional Fuctionality</dt>
  <dd>The spec says:

  <blockquote>The application should <strong>discard</strong> all commands in the sequence until a valid PLACE command has been executed.</blockquote>

  If I was to strictly adhere to the <strong>discard</strong> requirement, then I would not show errors in case of invalid commands. However I felt this would hurt the end user, so I added these errors. If this functionality is not required, then it can easily be removed.</dd>

  <dt>Spec wording</dt>
  <dd>The spec says:

  <blockquote>A robot that is not on the table <strong>can choose the [sic]</strong> ignore the MOVE, LEFT, RIGHT and REPORT commands.</blockquote>

  This is contradicted by the phrase:

  <blockquote>The application <strong>should</strong> discard all commands in the sequence until a valid PLACE command has been executed.</blockquote>

  Typo aside, in my interpretation of the spec, I replaced <strong>can choose the</strong> with <strong>should</strong>. Trying to apply relative movements or reporting, for a robot that has not yet been placed, does not make sense. I suspect this was the original intent of the phrase.</dd>
</dl>

[ss1]: 
