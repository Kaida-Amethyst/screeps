# Objects

> 说明：本文件从 Screeps Arena 官方文档主内容中提取，收录对象、原型、可视化对象以及 arena 全局对象。原始说明保留英文，便于与官方 API 对照。

### ConstructionSite

class extends [GameObject](#GameObject)

game/prototypes/game-object

A site of a structure which is currently under construction. To build a
structure on the construction site, give a worker creep some amount of
energy and perform the [Creep](#Creep).[build](#build) action.

#### ConstructionSite.my

boolean

Whether it is your construction site.

#### ConstructionSite.progress

number

The current construction progress.

#### ConstructionSite.progressTotal

number

The total construction progress needed for the structure to be built.

#### ConstructionSite.structure

[Structure](#Structure)

The structure that will be built (when the construction site is
completed)

#### ConstructionSite.remove

Remove this construction site.


### Creep

class extends [GameObject](#GameObject)

game/prototypes/creep

Creeps are your units. Creeps can move, harvest energy, construct
structures, attack another creeps, and perform other actions. Each creep
consists of up to 50 body parts with the following possible types:

<table class="table_table__lcHSK">
<colgroup>
<col style="width: 33%" />
<col style="width: 33%" />
<col style="width: 33%" />
</colgroup>
<thead>
<tr>
<th>body part</th>
<th>cost</th>
<th>Effect per one body part</th>
</tr>
</thead>
<tbody>
<tr>
<td>[MOVE](#MOVE)</td>
<td>[50](#BODYPART_COST)</td>
<td>Decreases fatigue by 2 points per tick.</td>
</tr>
<tr>
<td>[WORK](#WORK)</td>
<td>[100](#BODYPART_COST)</td>
<td>Harvests 2 energy units from a source per tick.
Builds a structure for 5 energy units per tick.</td>
</tr>
<tr>
<td>[CARRY](#CARRY)</td>
<td>[50](#BODYPART_COST)</td>
<td>Can contain up to 50 resource units.</td>
</tr>
<tr>
<td>[ATTACK](#ATTACK)</td>
<td>[80](#BODYPART_COST)</td>
<td>Attacks another creep/structure with 30 hits per tick in a
short-ranged attack.</td>
</tr>
<tr>
<td>[RANGED_ATTACK](#RANGED_ATTACK)</td>
<td>[150](#BODYPART_COST)</td>
<td>Attacks another single creep/structure with 10 hits per tick in a
long-range attack up to 3 squares long.
Attacks all hostile creeps/structures within 3 squares range with 1-4-10
hits (depending on the range).</td>
</tr>
<tr>
<td>[HEAL](#HEAL)</td>
<td>[250](#BODYPART_COST)</td>
<td>Heals self or another creep restoring 12 hits per tick in short
range or 4 hits per tick at a distance.</td>
</tr>
<tr>
<td>[TOUGH](#TOUGH)</td>
<td>[10](#BODYPART_COST)</td>
<td>No effect, just additional hit points to the creep's body.</td>
</tr>
</tbody>
</table>

#### Creep.body

array

An array describing the creep’s body. Each element contains the
following properties:

|      |        |                                                       |
|------|--------|-------------------------------------------------------|
| type | string | One of the body part types constants.                 |
| hits | number | The remaining amount of hit points of this body part. |

#### Creep.fatigue

number

The movement fatigue indicator. If it is greater than zero, the creep
cannot move.

#### Creep.hits

number

The current amount of hit points of the creep.

#### Creep.hitsMax

number

The maximum amount of hit points of the creep.

#### Creep.my

boolean

Whether it is your creep.

#### Creep.spawning

boolean

Whether this creep is still being spawned.

#### Creep.store

[Store](#Store)

A [Store](#Store) object that
contains cargo of this creep.

#### Creep.attack

Attack another creep, structure, or construction site in a short-ranged
attack. Requires the [ATTACK](#ATTACK) body part.
If the target is inside a rampart, then the rampart is attacked instead.
The target has to be at adjacent square to the creep. This action cannot
be executed on the same tick with [harvest](#harvest),
[build](#build),
[heal](#heal),
[rangedHeal](#rangedHeal).

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
<td>target</td>
<td>[Creep](#Creep)
[Structure](#Structure)
[ConstructionSite](#ConstructionSite)</td>
<td>The target object.</td>
</tr>
</tbody>
</table>

Return one of the following codes:

|  |  |  |
|----|----|----|
| [OK](#OK) | 0 | The operation has been scheduled successfully. |
| [ERR_NOT_OWNER](#ERR_NOT_OWNER) | -1 | You are not the owner of this creep. |
| [ERR_INVALID_TARGET](#ERR_INVALID_TARGET) | -7 | The target is not a valid attackable object. |
| [ERR_NOT_IN_RANGE](#ERR_NOT_IN_RANGE) | -9 | The target is too far away. |
| [ERR_NO_BODYPART](#ERR_NO_BODYPART) | -12 | There are no ATTACK body parts in this creep’s body. |

```
let hostileCreeps = getObjectsByPrototype(Creep).filter(i => !i.my);
let target = creep.findClosestByRange(hostileCreeps);
if (target){
    creep.move(target);
    creep.attack(target);
}
```

#### Creep.build

Build a structure at the target construction site using carried energy.
Requires [WORK](#WORK)
and [CARRY](#CARRY) body parts.
The target has to be within 3 squares range of the creep. This action
cannot be executed on the same tick with [harvest](#harvest),
[attack](#attack),
[heal](#heal),
[rangedHeal](#rangedHeal),
[rangedAttack](#rangedAttack),
[rangedMassAttack](#rangedMassAttack).

| parameter | type | description |
|----|----|----|
| target | [ConstructionSite](#ConstructionSite) | The target construction site to be built. |

Return one of the following codes:

|  |  |  |
|----|----|----|
| [OK](#OK) | 0 | The operation has been scheduled successfully. |
| [ERR_NOT_OWNER](#ERR_NOT_OWNER) | -1 | You are not the owner of this creep. |
| [ERR_NOT_ENOUGH_RESOURCES](#ERR_NOT_ENOUGH_RESOURCES) | -6 | The creep does not have any carried energy. |
| [ERR_INVALID_TARGET](#ERR_INVALID_TARGET) | -7 | The target is not a valid construction site object or the structure cannot be built here (probably because of an obstacle at the same square). |
| [ERR_NOT_IN_RANGE](#ERR_NOT_IN_RANGE) | -9 | The target is too far away. |
| [ERR_FULL](#ERR_FULL) | -8 | There is another construction site at the same location that's further along. |
| [ERR_NO_BODYPART](#ERR_NO_BODYPART) | -12 | There are no WORK body parts in this creep’s body. |

```
let myConstructionSites = getObjectsByPrototype(ConstructionSite).filter(i => i.my);
let target = creep.findClosestByRange(myConstructionSites);
if (target) {
    if (creep.build(target) == ERR_NOT_IN_RANGE) {
        creep.move(target);
    }
}
```

#### Creep.drop

Drop this resource on the ground.

| parameter | type | description |
|----|----|----|
| resourceType | string | One of the RESOURCE\_\* constants. |
| amount (optional) | number | The amount of resource units to be dropped. If omitted, all the available carried amount is used. |

Return one of the following codes:

|  |  |  |
|----|----|----|
| [OK](#OK) | 0 | The operation has been scheduled successfully. |
| [ERR_NOT_OWNER](#ERR_NOT_OWNER) | -1 | You are not the owner of this creep. |
| [ERR_NOT_ENOUGH_RESOURCES](#ERR_NOT_ENOUGH_RESOURCES) | -6 | The creep does not have the given amount of resources. |
| [ERR_INVALID_ARGS](#ERR_INVALID_ARGS) | -10 | The resourceType is not a valid RESOURCE\_\* constant. |

```
creep.drop(RESOURCE_ENERGY);
```

#### Creep.harvest

Harvest energy from the source. Requires the [WORK](#WORK) body part. If
the creep has an empty [CARRY](#CARRY) body part,
the harvested resource is put into it; otherwise it is dropped on the
ground. The target has to be at an adjacent square to the creep. This
action cannot be executed on the same tick with [attack](#attack),
[build](#build),
[heal](#heal),
[rangedHeal](#rangedHeal).

| parameter | type | description |
|----|----|----|
| target | [Source](#Source) | The object to be harvested. |

Return one of the following codes:

|  |  |  |
|----|----|----|
| [OK](#OK) | 0 | The operation has been scheduled successfully. |
| [ERR_NOT_OWNER](#ERR_NOT_OWNER) | -1 | You are not the owner of this creep. |
| [ERR_NOT_ENOUGH_RESOURCES](#ERR_NOT_ENOUGH_RESOURCES) | -6 | The target does not contain any harvestable resource. |
| [ERR_INVALID_TARGET](#ERR_INVALID_TARGET) | -7 | The target is not a valid source object. |
| [ERR_NOT_IN_RANGE](#ERR_NOT_IN_RANGE) | -9 | The target is too far away. |
| [ERR_NO_BODYPART](#ERR_NO_BODYPART) | -12 | There are no WORK body parts in this creep’s body. |

```
let activeSources = getObjectsByPrototype(Source).filter(i => i.energy > 0);
let source = creep.findClosestByRange(activeSources);
if(source){
    if (creep.harvest(source) == ERR_NOT_IN_RANGE) {
        creep.move(source);
    }
}
```

#### Creep.heal

Heal self or another creep. It will restore the target creep’s damaged
body parts function and increase the hits counter. Requires the
[HEAL](#HEAL) body part.
The target has to be at adjacent square to the creep. This action cannot
be executed on the same tick with [harvest](#harvest),
[build](#build),
[attack](#attack),
[rangedHeal](#rangedHeal).

| parameter | type | description |
|----|----|----|
| target | [Creep](#Creep) | The target creep object. |

Return one of the following codes:

|  |  |  |
|----|----|----|
| [OK](#OK) | 0 | The operation has been scheduled successfully. |
| [ERR_NOT_OWNER](#ERR_NOT_OWNER) | -1 | You are not the owner of this creep. |
| [ERR_INVALID_TARGET](#ERR_INVALID_TARGET) | -7 | The target is not a valid creep object. |
| [ERR_NOT_IN_RANGE](#ERR_NOT_IN_RANGE) | -9 | The target is too far away. |
| [ERR_NO_BODYPART](#ERR_NO_BODYPART) | -12 | There are no HEAL body parts in this creep’s body. |

```
let creeps = getObjectsByPrototype(Creep);
let myDamagedCreeps = creeps.filter(i => i.my && i.hits < i.hitsMax);
let target = tower.findClosestByRange(myDamagedCreeps);
if (creep.heal(target) == ERR_NOT_IN_RANGE) {
    creep.moveTo(target);
}
```

#### Creep.move

Move the creep one square in the specified direction. Requires the
[MOVE](#MOVE) body part.

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
<td>direction</td>
<td>number</td>
<td>one of the following constants:<br />
[TOP](#TOP) <a
href="#TOP_RIGHT"
class="link-to_link-to__9yx60 badge_badge__Ib2EW">TOP_RIGHT</a> <a
href="#RIGHT"
class="link-to_link-to__9yx60 badge_badge__Ib2EW">RIGHT</a> <a
href="#BOTTOM_RIGHT"
class="link-to_link-to__9yx60 badge_badge__Ib2EW">BOTTOM_RIGHT</a> <a
href="#BOTTOM"
class="link-to_link-to__9yx60 badge_badge__Ib2EW">BOTTOM</a> <a
href="#BOTTOM_LEFT"
class="link-to_link-to__9yx60 badge_badge__Ib2EW">BOTTOM_LEFT</a> <a
href="#LEFT"
class="link-to_link-to__9yx60 badge_badge__Ib2EW">LEFT</a> <a
href="#TOP_LEFT"
class="link-to_link-to__9yx60 badge_badge__Ib2EW">TOP_LEFT</a> </td>
</tr>
</tbody>
</table>

Return one of the following codes:

|  |  |  |
|----|----|----|
| [OK](#OK) | 0 | The operation has been scheduled successfully. |
| [ERR_NOT_OWNER](#ERR_NOT_OWNER) | -1 | You are not the owner of this creep. |
| [ERR_INVALID_ARGS](#ERR_INVALID_ARGS) | -10 | The provided direction is incorrect. |
| [ERR_TIRED](#ERR_TIRED) | -11 | The fatigue indicator of the creep is non-zero. |
| [ERR_NO_BODYPART](#ERR_NO_BODYPART) | -12 | There are no MOVE body parts in this creep’s body. |

```
creep.move(RIGHT);
```

#### Creep.moveTo

Find the optimal path to the target and move to it. Requires the
[MOVE](#MOVE) body part.

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
<td>target</td>
<td>object</td>
<td>Can be a [GameObject](#GameObject) or any
object containing x and y properties.</td>
</tr>
<tr class="method-arg_method-arg__nKfGw">
<td>opts</td>
<td>object</td>
<td>An object with additional options that are passed to
game/utils
 [findPath](#findPath).</td>
</tr>
</tbody>
</table>

Return one of the following codes:

|  |  |  |
|----|----|----|
| [OK](#OK) | 0 | The operation has been scheduled successfully. |
| [ERR_NOT_OWNER](#ERR_NOT_OWNER) | -1 | You are not the owner of this creep. |
| [ERR_TIRED](#ERR_TIRED) | -11 | The fatigue indicator of the creep is non-zero. |
| [ERR_NO_BODYPART](#ERR_NO_BODYPART) | -12 | There are no MOVE body parts in this creep’s body. |

```
creep1.moveTo(creep2);
creep2.moveTo({x: 50, y: 50});
```

#### Creep.pickup

Pick up an item (a dropped piece of resource). Requires the
[CARRY](#CARRY) body part.
The target has to be at adjacent square to the creep or at the same
square.

| parameter | type | description |
|----|----|----|
| target | [Resource](#Resource) | The target object to be picked up. |

Return one of the following codes:

|  |  |  |
|----|----|----|
| [OK](#OK) | 0 | The operation has been scheduled successfully. |
| [ERR_NOT_OWNER](#ERR_NOT_OWNER) | -1 | You are not the owner of this creep. |
| [ERR_INVALID_TARGET](#ERR_INVALID_TARGET) | -7 | The target is not a valid creep object. |
| [ERR_FULL](#ERR_FULL) | -8 | The creep cannot receive any more resource. |
| [ERR_NOT_IN_RANGE](#ERR_NOT_IN_RANGE) | -9 | The target is too far away. |

```
let resources = getObjectsByPrototype(Resource);
let target = creep.findClosestByRange(resources);
if (target) {
    if (creep.pickup(target) == ERR_NOT_IN_RANGE) {
        creep.moveTo(target);
    }
}
```

#### Creep.pull

Help another creep to follow this creep. The fatigue generated for the
target's move will be added to the creep instead of the target. Requires
the [MOVE](#MOVE) body part.
The target has to be at adjacent square to the creep. The creep must
move elsewhere, and the target must move towards the creep.

| parameter | type | description |
|----|----|----|
| target | [Creep](#Creep) | The target creep. |

Return one of the following codes:

|  |  |  |
|----|----|----|
| [OK](#OK) | 0 | The operation has been scheduled successfully. |
| [ERR_NOT_OWNER](#ERR_NOT_OWNER) | -1 | You are not the owner of this creep. |
| [ERR_INVALID_TARGET](#ERR_INVALID_TARGET) | -7 | The target is not a valid creep object. |
| [ERR_NOT_IN_RANGE](#ERR_NOT_IN_RANGE) | -9 | The target is too far away. |

```
creep1.move(TOP);
creep1.pull(creep2);
creep2.moveTo(creep1);
```

#### Creep.rangedAttack

A ranged attack against another creep or structure. Requires the
[RANGED_ATTACK](#RANGED_ATTACK) body
part. If the target is inside a rampart, the rampart is attacked
instead. The target has to be within 3 squares range of the creep. This
action cannot be executed on the same tick with
[rangedMassAttack](#rangedMassAttack),
[rangedHeal](#rangedHeal),
[build](#build).

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
<td>target</td>
<td>[Creep](#Creep)
[Structure](#Structure)</td>
<td>The target object to be attacked up.</td>
</tr>
</tbody>
</table>

Return one of the following codes:

|  |  |  |
|----|----|----|
| [OK](#OK) | 0 | The operation has been scheduled successfully. |
| [ERR_NOT_OWNER](#ERR_NOT_OWNER) | -1 | You are not the owner of this creep. |
| [ERR_INVALID_TARGET](#ERR_INVALID_TARGET) | -7 | The target is not a valid attackable object. |
| [ERR_NOT_IN_RANGE](#ERR_NOT_IN_RANGE) | -9 | The target is too far away. |
| [ERR_NO_BODYPART](#ERR_NO_BODYPART) | -12 | There are no [RANGED_ATTACK](#RANGED_ATTACK) body parts in this creep’s body. |

```
let hostileCreeps = getObjectsByPrototype(Creep).filter(i => !i.my);
let targets = creep.findInRange(hostileCreeps);
if (targets.length) {
    creep.rangedAttack(targets[0]);
}
```

#### Creep.rangedHeal

Heal another creep at a distance. It will restore the target creep’s
damaged body parts function and increase the hits counter. Requires the
[HEAL](#HEAL) body part.
The target has to be within 3 squares range of the creep. This action
cannot be executed on the same tick with [harvest](#harvest),
[build](#build),
[heal](#heal),
[attack](#attack),
[rangedAttack](#rangedAttack),
[rangedMassAttack](#rangedMassAttack).

| parameter | type | description |
|----|----|----|
| target | [Creep](#Creep) | The target creep object. |

Return one of the following codes:

|  |  |  |
|----|----|----|
| [OK](#OK) | 0 | The operation has been scheduled successfully. |
| [ERR_NOT_OWNER](#ERR_NOT_OWNER) | -1 | You are not the owner of this creep. |
| [ERR_INVALID_TARGET](#ERR_INVALID_TARGET) | -7 | The target is not a valid attackable object. |
| [ERR_NOT_IN_RANGE](#ERR_NOT_IN_RANGE) | -9 | The target is too far away. |
| [ERR_NO_BODYPART](#ERR_NO_BODYPART) | -12 | There are no [HEAL](#HEAL) body parts in this creep’s body. |

```
let creeps = getObjectsByPrototype(Creep);
let myDamagedCreeps = creeps.filter(i => i.my && i.hits < i.hitsMax);
let targets = creep.findInRange(myDamagedCreeps);
if (targets.length) {
    creep.rangedHeal(targets[0]);
}
```

#### Creep.rangedMassAttack

A ranged attack against all hostile creeps or structures within 3
squares range. Requires the [RANGED_ATTACK](#RANGED_ATTACK) body
part. The attack power depends on the range to each target. Friendly
units are not affected. This action cannot be executed on the same tick
with [rangedAttack](#rangedAttack),
[rangedHeal](#rangedHeal),
[build](#build).

Return one of the following codes:

|  |  |  |
|----|----|----|
| [OK](#OK) | 0 | The operation has been scheduled successfully. |
| [ERR_NOT_OWNER](#ERR_NOT_OWNER) | -1 | You are not the owner of this creep. |
| [ERR_NO_BODYPART](#ERR_NO_BODYPART) | -12 | There are no [RANGED_ATTACK](#RANGED_ATTACK) body parts in this creep’s body. |

#### Creep.transfer

Transfer resource from the creep to another object. The target has to be
at adjacent square to the creep.

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
<td>target</td>
<td>[Creep](#Creep)
[Structure](#Structure)</td>
<td>The target object.</td>
</tr>
<tr class="method-arg_method-arg__nKfGw">
<td>resourceType</td>
<td>string</td>
<td>One of the RESOURCE_* constants.</td>
</tr>
<tr class="method-arg_method-arg__nKfGw">
<td>amount (optional)</td>
<td>number</td>
<td>The amount of resources to be transferred. If omitted, all the
available carried amount is used.</td>
</tr>
</tbody>
</table>

Return one of the following codes:

|  |  |  |
|----|----|----|
| [OK](#OK) | 0 | The operation has been scheduled successfully. |
| [ERR_NOT_OWNER](#ERR_NOT_OWNER) | -1 | You are not the owner of this creep. |
| [ERR_NOT_ENOUGH_RESOURCES](#ERR_NOT_ENOUGH_RESOURCES) | -6 | The creep does not have the given amount of resources. |
| [ERR_INVALID_TARGET](#ERR_INVALID_TARGET) | -7 | The target is not a valid object which can contain the specified resource. |
| [ERR_FULL](#ERR_FULL) | -8 | The target cannot receive any more resources. |
| [ERR_NOT_IN_RANGE](#ERR_NOT_IN_RANGE) | -9 | The target is too far away. |
| [ERR_INVALID_ARGS](#ERR_INVALID_ARGS) | -10 | The resourceType is not one of the RESOURCE\_\* constants, or the amount is incorrect. |

```
if (creep.transfer(tower, RESOURCE_ENERGY) == ERR_NOT_IN_RANGE) {
    creep.moveTo(tower);
}
```

#### Creep.withdraw

Withdraw resources from a structure. The target has to be at adjacent
square to the creep. Multiple creeps can withdraw from the same object
in the same tick. Your creeps can withdraw resources from hostile
structures as well, in case if there is no hostile rampart on top of it.

| parameter | type | description |
|----|----|----|
| target | [Structure](#Structure) | The target structure. |
| resourceType | string | One of the RESOURCE\_\* constants. |
| amount (optional) | number | The amount of resources to be transferred. If omitted, all the available carried amount is used. |

Return one of the following codes:

|  |  |  |
|----|----|----|
| [OK](#OK) | 0 | The operation has been scheduled successfully. |
| [ERR_NOT_OWNER](#ERR_NOT_OWNER) | -1 | You are not the owner of this creep. |
| [ERR_NOT_ENOUGH_RESOURCES](#ERR_NOT_ENOUGH_RESOURCES) | -6 | The target does not have the given amount of resources. |
| [ERR_INVALID_TARGET](#ERR_INVALID_TARGET) | -7 | The target is not a valid object which can contain the specified resource. |
| [ERR_FULL](#ERR_FULL) | -8 | The creep's store is full. |
| [ERR_NOT_IN_RANGE](#ERR_NOT_IN_RANGE) | -9 | The target is too far away. |
| [ERR_INVALID_ARGS](#ERR_INVALID_ARGS) | -10 | The resourceType is not one of the RESOURCE\_\* constants, or the amount is incorrect. |

```
if (creep.withdraw(container, RESOURCE_ENERGY) == ERR_NOT_IN_RANGE) {
    creep.moveTo(container);
}
```

### Flag

class extends [GameObject](#GameObject)

game/prototypes/flag

A flag is a game object that control other objects.

#### Flag.my

boolean

Equals to true or false if the flag is owned. Returns undefined if it is
neutral.

### GameObject

class 

game/prototypes/game-object

Basic prototype for game objects. All objects and classes are inherited
from this class.

#### GameObject.controlledBy

[Flag](#Flag)

Returns the flag object that controls this game object.

#### GameObject.exists

boolean

Returns true if this object is live in the game at the moment. Check
this property to verify cached or newly created object instances.

#### GameObject.id

string

The unique ID of this object that you can use in

game/utils

[getObjectById](#getObjectById).

#### GameObject.ticksToDecay

number

If defined, then this object will disappear after this number of ticks.

#### GameObject.x

number

The X coordinate in the room.

#### GameObject.y

number

The Y coordinate in the room.

#### GameObject.findClosestByPath

Find a position with the shortest path from this game object. (See

game/utils

 [findClosestByPath](#findClosestByPath).)

| parameter | type | description |
|----|----|----|
| positions | array | The positions to search among. An array with [GameObject](#GameObject)s or any objects containing x and y properties. |
| opts (optional) | object | An object containing additional pathfinding flags supported by [searchPath](#searchPath) method. |

Returns the closest object from **positions**, or null if there was no
valid positions.

#### GameObject.findClosestByRange

Find a position with the shortest linear distance from this game object.
(See

game/utils

 [findClosestByRange](#findClosestByRange)).

| parameter | type | description |
|----|----|----|
| positions | array | The positions to search among. An array with [GameObject](#GameObject)s or any objects containing x and y properties. |

Returns the closest object from **positions**.

#### GameObject.findInRange

Find all objects in the specified linear range. See

game/utils

 [findInRange](#findInRange).

| parameter | type | description |
|----|----|----|
| positions | array | The positions to search. An array with [GameObject](#GameObject)s or any objects containing x and y properties. |
| range | number | The range distance. |

Returns an array with the objects found.

#### GameObject.findPathTo

Find a path from this object to the given position.

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
<td>pos</td>
<td>object</td>
<td>An object containing <strong>x</strong> and <strong>y</strong>.</td>
</tr>
<tr class="method-arg_method-arg__nKfGw">
<td>opts (optional)</td>
<td>object</td>
<td>An object with additional options that are passed to 
game/utils
 [findPath](#findPath).</td>
</tr>
</tbody>
</table>

Returns the path found as an array of objects containing x and y
properties

```
let path = creep.findPathTo(spawn);
console.log(path.length);
```

#### GameObject.getRangeTo

See

game/utils

 [getRange](#getRange).

| parameter | type   | description                           |
|-----------|--------|---------------------------------------|
| pos       | object | An object containing **x** and **y**. |

### OwnedStructure

class extends [Structure](#Structure)

game/prototypes/owned-structure

The base prototype for a structure that has an owner.

```
import { getObjectsByPrototype } from 'game/utils';
import { Creep, StructureSpawn } from 'game/prototypes';

export function loop() {
    let target = getObjectsByPrototype(StructureSpawn).find(i => !i.my);
}
```

#### OwnedStructure.my

boolean

Returns true for your structure, false for a hostile structure,
undefined for a neutral structure.

### Resource

class extends [GameObject](#GameObject)

game/prototypes/resource

A dropped piece of resource. It will decay after a while if not picked
up. Dropped resource pile decays for ceil(amount/1000) units per tick.

#### Resource.amount

number

The amount of dropped resource.

#### Resource.resourceType

string

One of the RESOURCE\_\* constants.

### Source

class extends [GameObject](#GameObject)

game/prototypes/source

An energy source object. Can be harvested by creeps with a
[WORK](#WORK) body part.

|                     |                    |
|---------------------|--------------------|
| Energy amount       | 1000               |
| Energy regeneration | 10 energy per tick |

#### Source.energy

number

Current amount of energy in the source.

#### Source.energyCapacity

number

The maximum amount of energy in the source.

### Spawning

object 

game/prototypes/spawn

Details of the creep being spawned currently that can be addressed by
the [StructureSpawn.spawning](#spawning)
property.

#### Spawning.creep

[Creep](#Creep)

The creep that being spawned.

#### Spawning.needTime

number

Time needed in total to complete the spawning.

#### Spawning.remainingTime

number

Remaining time to go.

#### Spawning.cancel

Cancel spawning immediately. Energy spent on spawning is not returned.

Return one of the following codes:

|  |  |  |
|----|----|----|
| [OK](#OK) | 0 | The operation has been scheduled successfully. |
| [ERR_NOT_OWNER](#ERR_NOT_OWNER) | -1 | You are not the owner of this spawn. |

### Store

object 

game/prototypes/store

An object that class contain resources in its cargo.

There are two types of stores in the game: general-purpose stores and
limited stores.

- General purpose stores can contain any resource within their capacity
  (e.g. creeps or containers).
- Limited stores can contain only a few types of resources needed for
  that particular object (e.g. spawns, extensions, towers).

You can get specific resources from the store by addressing them as
object properties:

```
console.log(creep.store[RESOURCE_ENERGY]);
```

#### Store.getCapacity

Returns capacity of this store for the specified resource. For a
general-purpose store, it returns total capacity if resource is
undefined.

| parameter | type | description |
|----|----|----|
| resource (optional) | [RESOURCE_ENERGY](#RESOURCE_ENERGY) |  |

```
if (creep.store[RESOURCE_ENERGY] < creep.store.getCapacity()) {
    creep.harvest(source);
}
```

#### Store.getFreeCapacity

Returns free capacity for the store. For a limited store, it returns the
capacity available for the specified resource if resource is defined and
valid for this store.

| parameter | type | description |
|----|----|----|
| resource (optional) | [RESOURCE_ENERGY](#RESOURCE_ENERGY) |  |

```
if (tower.store.getFreeCapacity(RESOURCE_ENERGY) > 0) {
    creep.transfer(tower, RESOURCE_ENERGY);
}
```

#### Store.getUsedCapacity

Returns the capacity used by the specified resource. For a
general-purpose store, it returns total used capacity if resource is
undefined.

| parameter | type | description |
|----|----|----|
| resource (optional) | [RESOURCE_ENERGY](#RESOURCE_ENERGY) |  |

```
if (container.store.getUsedCapacity() == 0) {
    // the container is empty
}
```

### Structure

class extends [GameObject](#GameObject)

game/prototypes/structure

The base prototype object of all structures.

```
import { getObjectsByPrototype } from 'game/utils';
import { Structure } from 'game/prototypes';

export function loop() {
    let structures = getObjectsByPrototype(Structure).filter(i => i.hits < i.hitsMax);
    console.log(structures.length);
}
```

#### Structure.hits

number

The current amount of hit points of the structure.

#### Structure.hitsMax

number

The maximum amount of hit points of the structure.

### StructureContainer

class extends [OwnedStructure](#OwnedStructure)

game/prototypes/container

A small container that can be used to store resources. This is a
walkable structure. All dropped resources automatically goes to the
container at the same tile.

|          |      |
|----------|------|
| capacity | 2000 |
| cost     | 100  |
| hits     | 300  |

#### StructureContainer.store

Store

A [Store](#Store) object that
contains cargo of this structure.

### StructureExtension

class extends [OwnedStructure](#OwnedStructure)

game/prototypes/extension

Contains energy that can be spent on spawning bigger creeps. Extensions
can be placed anywhere, any spawns will be able to use them regardless
of distance.

|          |     |
|----------|-----|
| cost     | 200 |
| hits     | 100 |
| capacity | 100 |

```
let allExtensions = getObjectsByPrototype(StructureExtension);
let myEmptyExtensions = allExtensions.filter(e => e.my && e.store.getUsedCapacity(RESOURCE_ENERGY) == 0)
let closestEmptyExtension = creep.findClosestByRange(myEmptyExtensions);
creep.moveTo(closestEmptyExtension);
```

#### StructureExtension.store

[Store](#Store)

A [Store](#Store) object that
contains cargo of this structure.

### StructureRampart

class extends [OwnedStructure](#OwnedStructure)

game/prototypes/rampart

Blocks movement of hostile creeps, and defends your creeps and
structures on the same position.

|      |       |
|------|-------|
| cost | 200   |
| hits | 10000 |

### StructureRoad

class extends [Structure](#Structure)

game/prototypes/road

Decreases movement cost to 1. Using roads allows creating creeps with
less [MOVE](#MOVE) body parts.

<table class="table_table__lcHSK">
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<tbody>
<tr>
<td>cost</td>
<td><ul>
<li>10 on plain land</li>
<li>50 on swamp</li>
</ul></td>
</tr>
<tr>
<td>hits</td>
<td><ul>
<li>500 on plain land</li>
<li>2500 on swamp</li>
</ul></td>
</tr>
</tbody>
</table>

### StructureSpawn

class extends [OwnedStructure](#OwnedStructure)

game/prototypes/spawn

This structure can create creeps. It also auto-regenerate a little
amount of energy each tick.

|            |                            |
|------------|----------------------------|
| cost       | 3000                       |
| hits       | 3000                       |
| capacity   | 1000                       |
| Spawn time | 3 ticks per each body part |

#### StructureSpawn.directions

array\<number\>

An array with the direction
constants:[TOP](#TOP) [TOP_RIGHT](#TOP_RIGHT) [RIGHT](#RIGHT) [BOTTOM_RIGHT](#BOTTOM_RIGHT) [BOTTOM](#BOTTOM) [BOTTOM_LEFT](#BOTTOM_LEFT) [LEFT](#LEFT) [TOP_LEFT](#TOP_LEFT) 

#### StructureSpawn.spawning

[Spawning](#Spawning)

If the spawn is in process of spawning a new creep, this object will
contain a [Spawning](#Spawning) object,
or null otherwise.

#### StructureSpawn.store

[Store](#Store)

A [Store](#Store) object that
contains cargo of this structure.

#### StructureSpawn.setDirections

Set desired directions where creeps should move when spawned.

| parameter | type | description |
|----|----|----|
| directions | array\<number\> | An array with the direction constants:[TOP](#TOP) [TOP_RIGHT](#TOP_RIGHT) [RIGHT](#RIGHT) [BOTTOM_RIGHT](#BOTTOM_RIGHT) [BOTTOM](#BOTTOM) [BOTTOM_LEFT](#BOTTOM_LEFT) [LEFT](#LEFT) [TOP_LEFT](#TOP_LEFT)  |

Return one of the following codes:

|  |  |  |
|----|----|----|
| [OK](#OK) | 0 | The operation has been scheduled successfully. |
| [ERR_NOT_OWNER](#ERR_NOT_OWNER) | -1 | You are not the owner of this structure. |
| [ERR_INVALID_ARGS](#ERR_INVALID_ARGS) | -10 | The array contains invalid directions. |

```
import { getObjectsByPrototype } from 'game/utils';
import { StructureSpawn } from 'game/prototypes';

export function loop() {
    const mySpawn = getObjectsByPrototype(StructureSpawn).find(s => s.my);
    mySpawn.setDirections([TOP, TOP_RIGHT, RIGHT]);
}
```

#### StructureSpawn.spawnCreep

Start the creep spawning process. The required energy amount can be
withdrawn from all your spawns and extensions in the game.

| parameter | type | description |
|----|----|----|
| body | array\<string\> | An array describing the new creep’s body. Should contain 1 to 50 elements with one of these constants: [WORK](#WORK) [MOVE](#MOVE) [CARRY](#CARRY) [ATTACK](#ATTACK) [RANGED_ATTACK](#RANGED_ATTACK) [HEAL](#HEAL) [TOUGH](#TOUGH) |

Return an object with one of the following properties:

|  |  |  |
|----|----|----|
| error | number | One of the ERR\_\* constants |
| object | [Creep](#Creep) | Instance of the creep being spawned |

  
Possible error codes:

|  |  |  |
|----|----|----|
| [ERR_NOT_OWNER](#ERR_NOT_OWNER) | -1 | You are not the owner of this structure. |
| [ERR_BUSY](#ERR_BUSY) | -4 | The spawn is already in process of spawning another creep. |
| [ERR_NOT_ENOUGH_ENERGY](#ERR_NOT_ENOUGH_ENERGY) | -6 | The spawn and its extensions contain not enough energy to create a creep with the given body. |
| [ERR_INVALID_ARGS](#ERR_INVALID_ARGS) | -10 | Body is not properly described. |

```
import { getObjectsByPrototype } from 'game/utils';
import { StructureSpawn } from 'game/prototypes';

export function loop() {
    const mySpawn = getObjectsByPrototype(StructureSpawn).find(s => s.my);
    const creep = mySpawn.spawnCreep([WORK, CARRY, MOVE]).object;
}
```

### StructureTower

class extends [OwnedStructure](#OwnedStructure)

game/prototypes/tower

Remotely attacks game objects or heals creeps within its range. Its
effectiveness linearly depends on the distance. Each action consumes
energy.

|  |  |
|----|----|
| cost | 1250 |
| hits | 3000 |
| capacity | 10 |
| cooldown | 10 ticks |
| Action maximum range | 20 |
| Energy per action | 10 |
| Attack effectiveness | Starts at 1000 at point-blank range and decreases by 50 for each additional tile |
| Heal effectiveness | Starts at 600 at point-blank range and decreases by 30 for each additional tile |

#### StructureTower.cooldown

number

The remaining amount of ticks while this tower cannot be used.

#### StructureTower.store

[Store](#Store)

A [Store](#Store) object that
contains cargo of this structure.

#### StructureTower.attack

Remotely attack any creep or structure in range.

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
<td>target</td>
<td>[Creep](#Creep)
[Structure](#Structure)</td>
<td>The target object.</td>
</tr>
</tbody>
</table>

Return one of the following codes:

|  |  |  |
|----|----|----|
| [OK](#OK) | 0 | The operation has been scheduled successfully. |
| [ERR_NOT_OWNER](#ERR_NOT_OWNER) | -1 | You are not the owner of this structure. |
| [ERR_NOT_ENOUGH_ENERGY](#ERR_NOT_ENOUGH_ENERGY) | -6 | The tower does not have enough energy. |
| [ERR_INVALID_TARGET](#ERR_INVALID_TARGET) | -7 | The arguments provided are incorrect. |
| [ERR_NOT_IN_RANGE](#ERR_NOT_IN_RANGE) | -9 | The target is not in range. |
| [ERR_TIRED](#ERR_TIRED) | -11 | The tower is still cooling down. |

```
import { getObjectsByPrototype } from 'game/utils';
import { Creep } from 'game/prototypes';
import { TOWER_RANGE } from 'game/constants';

export function loop() {
    let target = tower.findClosestByRange(getObjectsByPrototype(Creep).filter(i => !i.my));
    if (tower.getRangeTo(target) <= TOWER_RANGE) {
        tower.attack(target);
    }
}
```

#### StructureTower.heal

Remotely heal any creep in range.

| parameter | type | description |
|----|----|----|
| target | [Creep](#Creep) | The target creep. |

Return one of the following codes:

|  |  |  |
|----|----|----|
| [OK](#OK) | 0 | The operation has been scheduled successfully. |
| [ERR_NOT_OWNER](#ERR_NOT_OWNER) | -1 | You are not the owner of this structure. |
| [ERR_NOT_ENOUGH_ENERGY](#ERR_NOT_ENOUGH_ENERGY) | -6 | The tower does not have enough energy. |
| [ERR_INVALID_TARGET](#ERR_INVALID_TARGET) | -7 | The arguments provided are incorrect. |
| [ERR_NOT_IN_RANGE](#ERR_NOT_IN_RANGE) | -9 | The target is not in range. |
| [ERR_TIRED](#ERR_TIRED) | -11 | The tower is still cooling down. |

```
let creeps = getObjectsByPrototype(Creep);
let myDamagedCreeps = creeps.filter(i => i.my && i.hits < i.hitsMax);
let target = tower.findClosestByRange(myDamagedCreeps);
if (creep.heal(target) == ERR_NOT_IN_RANGE) {
    creep.moveTo(target);
}
```

### StructureWall

class extends [Structure](#Structure)

game/prototypes/wall

Blocks movement of all creeps.

|      |       |
|------|-------|
| cost | 100   |
| hits | 10000 |

### Visual

class 

game/visual

Visuals provide a way to show various visual debug info in the game. All
draw coordinates are measured in game coordinates and centered to tile
centers, i.e. (10,10) will point to the center of the creep at x:10;
y:10 position. Fractional coordinates are allowed.

#### Visual.layer

number

The layer of visuals in the object.

#### Visual.persistent

boolean

Whether visuals in this object are persistent.

#### Visual.circle

game/visual

Draw a circle.

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
<td>pos</td>
<td>object</td>
<td>The position object of the center. May be
<strong>GameObject</strong> or any object containing x and y
properties.</td>
</tr>
<tr class="method-arg_method-arg__nKfGw">
<td>style (optional)</td>
<td>object</td>
<td>An object with the following properties:
<ul>
<li>radius (number) Circle radius, default is 0.15.</li>
<li>fill (string) Fill color in the following format: #ffffff (hex
triplet). Default is #ffffff.</li>
<li>opacity (number) Opacity value, default is 0.5.</li>
<li>stroke (string) Stroke color in the following format: #ffffff (hex
triplet). Default is #ffffff.</li>
<li>strokeWidth (number) Stroke line width, default is 0.1.</li>
<li>lineStyle (string) Either undefined (solid line), dashed, or dotted.
Default is undefined.</li>
</ul></td>
</tr>
</tbody>
</table>

Returns the [Visual](#Visual) object
itself, so that you can chain calls.

#### Visual.clear

Remove all visuals from the object.

Returns the [Visual](#Visual) object
itself, so that you can chain calls.

#### Visual.constructor

Creates a new empty instance of [Visual](#Visual).

| parameter | type | description |
|----|----|----|
| layer (optional) | number | The layer of visuals in this object. Visuals of higher layer overlaps visuals of lower layer. Default is 0. |
| persistent | boolean | Whether visuals in this object are persistent. Non-persistent visuals are visible during the current tick only. |

```
for(const creep of creeps) {
    if(!creep.hitsVisual) {
        creep.hitsVisual = new Visual(10, true);
    }
    creep.hitsVisual.clear().text(
        creep.hits,
        { x: creep.x, y: creep.y - 0.5 }, // above the creep
        {
            font: '0.5',
            opacity: 0.7,
            backgroundColor: '#808080',
            backgroundPadding: '0.03'
        });
}
```

#### Visual.line

game/visual

Draw a line.

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
<td>pos1</td>
<td>object</td>
<td>The start position object. May be <strong>GameObject</strong> or any
object containing x and y properties.</td>
</tr>
<tr class="method-arg_method-arg__nKfGw">
<td>pos2</td>
<td>object</td>
<td>The finish position object. May be <strong>GameObject</strong> or
any object containing x and y properties.</td>
</tr>
<tr class="method-arg_method-arg__nKfGw">
<td>style (optional)</td>
<td>object</td>
<td>An object with the following properties:
<ul>
<li>width (number) Line width, default is 0.1.</li>
<li>color (string) Line color in the following format: #ffffff (hex
triplet). Default is #ffffff.</li>
<li>opacity (number) Opacity value, default is 0.5.</li>
<li>lineStyle (string) Either undefined (solid line), dashed, or dotted.
Default is undefined.</li>
</ul></td>
</tr>
</tbody>
</table>

Returns the [Visual](#Visual) object
itself, so that you can chain calls.

```
new Visual().line({x: 1, y: 99}, {x: 99, y: 1}, {color: '#ff0000'});
new Visual().line(creep, tower, {lineStyle: 'dashed'});
```

#### Visual.poly

game/visual

Draw a polyline.

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
<td>points</td>
<td>array</td>
<td>An array of points. Every item may be <strong>GameObject</strong> or
any object containing x and y properties.</td>
</tr>
<tr class="method-arg_method-arg__nKfGw">
<td>style (optional)</td>
<td>object</td>
<td>An object with the following properties:
<ul>
<li>fill (string) Fill color in the following format: #ffffff (hex
triplet). Default is #ffffff.</li>
<li>opacity (number) Opacity value, default is 0.5.</li>
<li>stroke (string) Stroke color in the following format: #ffffff (hex
triplet). Default is #ffffff.</li>
<li>strokeWidth (number) Stroke line width, default is 0.1.</li>
<li>lineStyle (string) Either undefined (solid line), dashed, or dotted.
Default is undefined.</li>
</ul></td>
</tr>
</tbody>
</table>

Returns the [Visual](#Visual) object
itself, so that you can chain calls.

#### Visual.rect

game/visual

Draw a rectangle.

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
<td>pos</td>
<td>object</td>
<td>The position object of the top-left corner. May be
<strong>GameObject</strong> or any object containing x and y
properties.</td>
</tr>
<tr class="method-arg_method-arg__nKfGw">
<td>w</td>
<td>number</td>
<td>The width of the rectangle.</td>
</tr>
<tr class="method-arg_method-arg__nKfGw">
<td>h</td>
<td>number</td>
<td>The height of the rectangle.</td>
</tr>
<tr class="method-arg_method-arg__nKfGw">
<td>style (optional)</td>
<td>object</td>
<td>An object with the following properties:
<ul>
<li>fill (string) Fill color in the following format: #ffffff (hex
triplet). Default is #ffffff.</li>
<li>opacity (number) Opacity value, default is 0.5.</li>
<li>stroke (string) Stroke color in the following format: #ffffff (hex
triplet). Default is #ffffff.</li>
<li>strokeWidth (number) Stroke line width, default is 0.1.</li>
<li>lineStyle (string) Either undefined (solid line), dashed, or dotted.
Default is undefined.</li>
</ul></td>
</tr>
</tbody>
</table>

Returns the [Visual](#Visual) object
itself, so that you can chain calls.

#### Visual.size

Get the stored size of all visuals stored in the object.

Returns the size of the visuals in bytes.

#### Visual.text

game/visual

Draw a text label. You can use any valid Unicode characters, including
emoji.

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
<td>text</td>
<td>string</td>
<td>The text message.</td>
</tr>
<tr class="method-arg_method-arg__nKfGw">
<td>pos</td>
<td>object</td>
<td>The position object of the label baseline. May be GameObject or any
object containing x and y properties.</td>
</tr>
<tr class="method-arg_method-arg__nKfGw">
<td>style (optional)</td>
<td>object</td>
<td>An object with the following properties:
<ul>
<li>color (string) Font color in the following format: #ffffff (hex
triplet). Default is #ffffff.</li>
<li>font (number|string) Either a number or a string in one of the
following forms: "0.7" (relative size in game coordinates), "20px"
(absolute size in pixels), "0.7 serif", or "bold italic 1.5 Times New
Roman"</li>
<li>stroke (string) Stroke color in the following format: #ffffff (hex
triplet). default is undefined (no stroke).</li>
<li>strokeWidth (number) Stroke line width, default is 0.15.</li>
<li>backgroundColor (string) Background color in the following format:
#ffffff (hex triplet). Default is undefined (no background). When
background is enabled, text vertical align is set to middle (default is
baseline).</li>
<li>backgroundPadding (number) Background rectangle padding, default is
0.3.</li>
<li>aling (string) Text align, either center, left, or right. Default is
center.</li>
<li>opacity (number) Opacity value, default is 1.</li>
</ul></td>
</tr>
</tbody>
</table>

The [Visual](#Visual) object
itself, so that you can chain calls.

### arenaInfo

object 

game

```
import { arenaInfo } from 'game';
export function loop() {
    console.log(arenaInfo.name);
}
```

#### arenaInfo.cpuTimeLimit

number

CPU wall time execution limit per one tick (except the first tick).

#### arenaInfo.cpuTimeLimitFirstTick

number

CPU wall time limit on the first tick.

#### arenaInfo.level

number

Currently equals to 1 for basic arena and 2 for advanced.

#### arenaInfo.name

string

The name of the arena.

#### arenaInfo.season

string

The name of the season this arena belongs.

#### arenaInfo.ticksLimit

number

Game ticks limit.

### BodyPart

class extends [GameObject](#GameObject)

.../capture_the_flag/basic

A separate part of creep body.  
Step over a BodyPart by a creep to augment the creep with the body part.

#### BodyPart.ticksToDecay

number

The number of ticks until this item disappears.

#### BodyPart.type

string

The type of the body part, one of these constants:

[WORK](#WORK) [MOVE](#MOVE) [CARRY](#CARRY) [ATTACK](#ATTACK) [RANGED_ATTACK](#RANGED_ATTACK) [HEAL](#HEAL) [TOUGH](#TOUGH)

### BonusFlag

class extends [Flag](#Flag)

.../power_split/basic

An object that applies an effect of the specified type to all creeps
belonging to the player who captured it.

#### BonusFlag.bonusType

string

The affected bodypart type (one of the body part types constants)

### AreaEffect

class extends [GameObject](#GameObject)

.../construct_and_control/basic

An object that applies an effect of the specified type to all creeps at
the same tile.

#### AreaEffect.effect

string

One of the following
constants: [EFFECT_SLOWDOWN](#construct_and_control_basic::EFFECT_SLOWDOWN).

### ConstructionBoost

class extends [GameObject](#GameObject)

.../construct_and_control/basic

An object that provides a construction boost effect to the creep that
steps onto this object for 200 ticks.

#### ConstructionBoost.ticksToDecay

number

The number of ticks until this construction boost decays and disappears.

### StructureGoal

class extends [Structure](#Structure)

.../construct_and_control/basic

A structure that needs to be built to win the match.

### AreaEffect

class extends [GameObject](#GameObject)

.../construct_and_control/advanced

An object that applies an effect of the specified type to all creeps at
the same tile.

#### AreaEffect.effect

string

One of the following
constants: [EFFECT_SLOWDOWN](#construct_and_control_advanced::EFFECT_SLOWDOWN).

#### AreaEffect.kind

string

One of the following
constants: [KIND_RED](#construct_and_control_advanced::KIND_RED), [KIND_BLUE](#construct_and_control_advanced::KIND_BLUE), [KIND_GREEN](#construct_and_control_advanced::KIND_GREEN).

### ConstructionBoost

class extends [GameObject](#GameObject)

.../construct_and_control/advanced

An object that provides a construction boost effect to the creep that
steps onto this object for 200 ticks.

#### ConstructionBoost.ticksToDecay

number

The number of ticks until this construction boost decays and disappears.

#### EFFECT_CONSTRUCTION_BOOST

eff_construction_boost

.../construct_and_control/advanced/constants

#### EFFECT_SLOWDOWN

slowdown

.../construct_and_control/advanced/constants

#### KIND_BLUE

blue

.../construct_and_control/advanced/constants

#### KIND_GREEN

green

.../construct_and_control/advanced/constants

#### KIND_RED

red

.../construct_and_control/advanced/constants

### StructureGoal

class extends [Structure](#Structure)

.../construct_and_control/advanced

A structure that needs to be built to win the match.
