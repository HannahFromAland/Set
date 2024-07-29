#  Set Board Game

Application of single-player version game [Set](https://en.wikipedia.org/wiki/Set_(card_game))

## Thoughts

- When there is a state in model which will have multiple stages along the way of an intent function change, the animation will only show the end state of it. The way to preserve all states of changes is to encapsulate all intermediate changes into a new function. -- see `SetGame.matchStatus` in `func choose()`

