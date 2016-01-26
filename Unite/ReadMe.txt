My final project is a game called Unite (which I learned from a Korean TV show)

The game consists of a 3 * 3 board with 9 patterns. Each pattern is randomly displayed, with three properties:

1. Shape: [Square, Circle, Triangle]
2. Inner Color: [purple, orange, green]
3. Background Color: [white, black, gray]

Three patterns A, B and C are considered as a group if their three properties are either different or the same, that is:

(A.shape == B.shape == C.shape) || (A.shape!=B.shape!=C.shape)

and

(A.innercolor == B.innercolor == C.innercolor) || (A.innercolor!=B.innercolor!=C.innercolor)

and

(A.backgroundcolor == B.backgroundcolor == C.backgroundcolor) || (A.backgroundcolor!=B.backgroundcolor!=C.backgroundcolor)


The player needs to select the groups of three patterns which satisfy the rule above as much as possible. When each three patterns are selected correctly, the patterns will disappear and be replaced with three random new patterns, and the player will get 10 points.

If the player thinks there is no such group of three patterns exist in the 3 * 3 board, the player can select “No Solution” button. If this decision is correct, the whole board will be refreshed and the player will get 50 points. If the decision is wrong, the player will be deducted 20 points.
