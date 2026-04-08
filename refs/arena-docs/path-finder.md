# Path Finder

> 说明：本文件收录 `game/path-finder` 模块的说明，包括 `CostMatrix` 和 `searchPath`。原始说明保留英文，便于与官方 API 对照。

### CostMatrix

class 

game/path-finder

Container for custom navigation cost data. If a non-0 value is found in
the CostMatrix then that value will be used instead of the default
terrain cost.

#### CostMatrix.clone

Copy this [CostMatrix](#CostMatrix) into a
new [CostMatrix](#CostMatrix) with
the same data and return new [CostMatrix](#CostMatrix)

#### CostMatrix.constructor

Creates a new [CostMatrix](#CostMatrix)
containing 0's for all positions.

```
import { CostMatrix } from 'game/path-finder';

export function loop() {
    let costs = new CostMatrix;
}
```

#### CostMatrix.get

Get the cost of a position in this [CostMatrix](#CostMatrix).

| parameter | type   | description                |
|-----------|--------|----------------------------|
| x         | number | The X position in the game |
| y         | number | The Y position in the game |

#### CostMatrix.set

Set the cost of a position in this [CostMatrix](#CostMatrix).

| parameter | type | description |
|----|----|----|
| x | number | The X position in the game |
| y | number | The Y position in the game |
| cost | number | Cost of this position. Must be a whole number. A cost of 0 will use the terrain cost for that tile. A cost greater than or equal to 255 will be treated as unwalkable. |

```
import { CostMatrix } from 'game/path-finder';

export function loop() {
    let costs = new CostMatrix;
    costs.set(constructionSite.x, constructionSite.y, 10); // avoid walking over a construction site
}
```


game/path-finder

Find an optimal path between origin and goal. Note that searchPath
without costMatrix specified (see below) uses terrain data only.

| parameter       | type   | description |
|-----------------|--------|-------------|
| origin          | object | See below   |
| goal            | object | See below   |
| opts (optional) | object | See below   |

A goal is either an object containing x and y properties or an object as
defined below.

If more than one goal is supplied (as an array of goals) then the
cheapest path found out of all the goals will be returned.

| property | type | description |
|----|----|----|
| pos | object | an object containing x and y properties |
| range | number | range to pos before the goal is considered reached. The default is 0 |

  

opts is an object containing additional pathfinding flags:

| property | type | description |
|----|----|----|
| costMatrix | CostMatrix | Custom navigation cost data |
| plainCost | number | Cost for walking on plain positions. The default is 2 |
| swampCost | number | Cost for walking on swamp positions. The default is 10 |
| flee | boolean | Instead of searching for a path to the goals this will search for a path away from the goals. The cheapest path that is out of range of every goal will be returned. The default is false |
| maxOps | number | The maximum allowed pathfinding operations. The default value is 50000 |
| maxCost | number | The maximum allowed cost of the path returned. The default is Infinity |
| heuristicWeight | number | Weight from 1 to 9 to apply to the heuristic in the A\* formula F = G + weight \* H. The default value is 1.2 |

Returns an object containing the following properties:

|  |  |  |
|----|----|----|
| path | array | The path found as an array of objects containing x and y properties |
| ops | number | Total number of operations performed before this path was calculated |
| cost | number | The total cost of the path as derived from plainCost, swampCost, and given CostMatrix instance |
| incomplete | boolean | If the pathfinder fails to find a complete path, this will be true |

```
import { searchPath } from 'game/path-finder';
import { getObjectsByPrototype } from 'game/utils';

export function loop() {
    let target = getObjectsByPrototype(StructureSpawn).find(i => !i.my);
    let creep = getObjectsByPrototype(Creep).find(i => i.my);

    let ret = searchPath(creep, target);
    console.log(ret.cost); // total cost
    console.log(ret.path.length); // tiles count
}
```

