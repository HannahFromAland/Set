#  Set Board Game

Application of single-player version game [Set](https://en.wikipedia.org/wiki/Set_(card_game))

## Thoughts

- The matching/non-matching operation to set will be triggered only if the fourth card is being selected, but by updating an extra status of set-matching everytime a selection is done, we will have the effect of matching / not-matching set indication through animation

- Making the card shown on table changable by intent function `Deal 3 More Cards` needs total number shown on table (variable `cardsNumShown`) to be marked as `@Published`
