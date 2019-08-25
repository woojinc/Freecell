# A02 Prep Freecell

Note: Refactored just the essential parts of the test 
lib/piles
foundation_pile.rb
freecell_pile.rb
tableau_pile.rb
pile.rb

lib/
board.rb
piles.rb

## Current version
Key notes:
To run simple run "ruby lib/board.rb" on CML.
You can move multiple cards too (as long as the move follows the game rule)

Pile is a Parent class to FoundationPile, FreecellPile, and TableauPile.

It doesn't have a Player class yet.
So, Board class is responsible for setting up the Piles and moving them also.

Spec files are also not done yet and I'm not sure if I will be able to do them before the test.

So any help with setting up spec would be much appreciated.

Do not pay attention to display or cursor as they are bit massy and probably not going to be on the tests.



