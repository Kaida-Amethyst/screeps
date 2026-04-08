# Utils

> 说明：本文件收录 `game/utils` 模块的函数说明。原始说明保留英文，便于与官方 API 对照。

#### createConstructionSite

game/utils

Create new [ConstructionSite](#ConstructionSite)
at the specified location.

| parameter | type | description |
|----|----|----|
| position | object | An object with x and y properties. |
| prototype | class | A prototype that extends [Structure](#Structure). |

Returns an object with one of the following properties:

|  |  |  |
|----|----|----|
| error | number | one of the ERR\_\* constants |
| object | [ConstructionSite](#ConstructionSite) | the instance of [ConstructionSite](#ConstructionSite) created by this call |

Possible error codes:

|  |  |  |
|----|----|----|
| [ERR_INVALID_ARGS](#ERR_INVALID_ARGS) | -10 | The location or the structure prototype is incorrect. |
| [ERR_INVALID_TARGET](#ERR_INVALID_TARGET) | -7 | The structure cannot be placed at the specified location. |
| [ERR_FULL](#ERR_FULL) | -8 | You have too many construction sites. The maximum number of construction sites per player is 10. |

#### findClosestByPath

game/utils

Find a position with the shortest path from the given position.

| parameter | type | description |
|----|----|----|
| fromPos | object | The position to search from. May be [GameObject](#GameObject) or any object containing x and y properties. |
| positions | array | The positions to search among. An array with [GameObject](#GameObject)s or any objects containing x and y properties. |
| opts (optional) | object | An object containing additional pathfinding flags supported by **searchPath** method. |

The closest object if found, null otherwise.

```
let targets = getObjectsByPrototype(Creep).filter(c => !c.my);
let closestTarget = findClosestByPath(creep, targets);
creep.moveTo(closestTarget);
creep.attack(closestTarget);
```

#### findClosestByRange

game/utils

Find a position with the shortest linear distance from the given
position.

| parameter | type | description |
|----|----|----|
| fromPos | object | The position to search from. May be [GameObject](#GameObject) or any object containing x and y properties. |
| positions | array | The positions to search among. An array with [GameObject](#GameObject)s or any objects containing x and y properties. |

Returns the closest object from **positions**, or null if there was no
valid positions.

```
let targets = getObjectsByPrototype(Creep).filter(c => !c.my);
let closestTarget = findClosestByRange(tower, targets);
tower.attack(closestTarget);
```

#### findInRange

game/utils

Find all objects in the specified linear range.

| parameter | type | description |
|----|----|----|
| fromPos | object | The origin position. May be [GameObject](#GameObject) or any object containing x and y properties. |
| positions | array | The positions to search. An array with [GameObject](#GameObject)s or any objects containing x and y properties. |
| range | number | The range distance. |

Returns an array with the objects found.

```
let targets = getObjectsByPrototype(Creep).filter(c => !c.my);
let targetsInRange = findInRange(creep, targets, 3);
if (targetsInRange.length >= 3) {
    creep.rangedMassAttack();
} else if (targetsInRange.length > 0) {
    creep.rangedAttack(targetsInRange[0]);
}
```

#### findPath

game/utils

Find an optimal path between fromPos and toPos. Unlike
[searchPath](#searchPath),
findPath avoid all obstacles by default (unless costMatrix is
specified).

<table class="table_table__lcHSK table_table--args__FE7Wo">
<colgroup>
<col style="width: 33%" />
<col style="width: 33%" />
<col style="width: 33%" />
</colgroup>
<thead>
<tr>
<th>parameter</th>
<th>type</th>
<th>description</th>
</tr>
</thead>
<tbody>
<tr class="method-arg_method-arg__nKfGw">
<td>fromPos</td>
<td>object</td>
<td>The start position. May be [GameObject](#GameObject) or any
object containing x and y properties.</td>
</tr>
<tr class="method-arg_method-arg__nKfGw">
<td>toPos</td>
<td>object</td>
<td>The target position. May be [GameObject](#GameObject) or any
object containing x and y properties.</td>
</tr>
<tr class="method-arg_method-arg__nKfGw">
<td>opts (optional)</td>
<td>object</td>
<td>An object containing additional pathfinding flags:
<ul>
<li>ignore array (objects which should not be treated as obstacles
during the search)</li>
<li>Any options supported by [searchPath](#searchPath)
method</li>
</ul></td>
</tr>
</tbody>
</table>

Returns the path found as an array of objects containing x and y
properties

#### getCpuTime

game/utils

Get CPU wall time elapsed in the current tick in nanoseconds.

```
import { getCpuTime } from 'game/utils';
import { arenaInfo } from 'game';
export function loop() {
    if( arenaInfo.cpuTimeLimit - getCpuTime() < 1000000) {
        // Less than 1 ms left before timeout!
    }
}
```

#### getDirection

game/utils

Get linear direction by differences of x and y.

| parameter | type   | description                     |
|-----------|--------|---------------------------------|
| dx        | number | The difference of X coordinate. |
| dy        | number | The difference of Y coordinate. |

Returns a number representing one of the direction constants.

```
let pos = path.findIndex(p => p.x == creep.x && p.y == creep.y);
let direction = getDirection(path[pos+1].x-path[pos].x, path[pos+1].y-path[pos].y);
creep.move(direction);
```

#### getHeapStatistics

game/utils

Use this method to get heap statistics for your virtual machine. The
return value is almost identical to the Node.js function
v8.getHeapStatistics. This function returns one additional property:
externally_allocated_size which is the total amount of currently
allocated memory which is not included in the v8 heap but counts against
this isolate's memory limit. ArrayBuffer instances over a certain size
are externally allocated and will be counted here.

```
import { getHeapStatistics } from 'game/utils';

export function loop() {
    let heap = getHeapStatistics();
    console.log(`Used ${heap.total_heap_size} / ${heap.heap_size_limit}`);
}
```

#### getObjectById

game/utils

Get an object with the specified unique ID.

| parameter | type | description |
|----|----|----|
| id | string | The id property of the needed object. See [GameObject](#GameObject) prototype. |

```
import { getObjectById } from 'game/utils';
export function loop() {
    runCreep(myCreep.id);
}
function runCreep(id) {
    let creep = getObjectById(id);
    creep.move(RIGHT);
}
```

#### getObjects

game/utils

Get all game objects in the game.

Returns an array of [GameObject](#GameObject).

#### getObjectsByPrototype

game/utils

Get all objects in the game with the specified prototype, for example,
all creeps.

| parameter | type | description |
|----|----|----|
| prototype | class | A prototype that extends [GameObject](#GameObject). |

Returns an array of [GameObject](#GameObject) of the
given prototype.

```
import { getObjectsByPrototype } from 'game/utils';
import { Creep } from 'game/prototypes';

export function loop() {
    const creeps = getObjectsByPrototype(Creep);

    creeps.forEach(function(myCreep) {
        runCreep(myCreep);
    });
}

function runCreep(creep) {
    if(creep.my) {
        creep.move(RIGHT);
    }
}
```

#### getRange

game/utils

Get linear range between two objects. **a** and **b** may be any object
containing x and y properties.

| parameter | type | description |
|----|----|----|
| a | object | The first of two objects. May be [GameObject](#GameObject) or any object containing x and y properties. |
| b | object | The second of two objects. May be [GameObject](#GameObject) or any object containing x and y properties. |

Returns a number of squares between two objects.

```
let range = getRange(creep, target);
if(range <= 3) {
    creep.rangedAttack(target);
}
```

#### getTerrainAt

game/utils

Get an integer representation of the terrain at the given position.

| parameter | type   | description                                              |
|-----------|--------|----------------------------------------------------------|
| pos       | object | The position as an object containing x and y properties. |

Returns [TERRAIN_WALL](#TERRAIN_WALL),[TERRAIN_SWAMP](#TERRAIN_SWAMP),
or[TERRAIN_PLAIN](#TERRAIN_PLAIN).

```
let matrix = new CostMatrix;
// Fill CostMatrix with full-speed terrain costs for future analysis:
for(let y = 0; y < 100; y++) {
    for(let x = 0; x < 100; x++) {
        let tile = getTerrainAt({x: x, y: y});
        let weight =
            tile === TERRAIN_WALL  ? 255 : // wall  => unwalkable
            tile === TERRAIN_SWAMP ?   5 : // swamp => weight:  5
                                            1 ; // plain => weight:  1
        matrix.set(x, y, weight);
    }
}
```

#### getTicks

game/utils

The number of ticks passed from the start of the current game.

```
import { getTicks } from 'game';
export function loop() {
    console.log(getTicks());
}
```

#### searchPath

