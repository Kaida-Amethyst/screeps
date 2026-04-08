# 动作返回值与错误建模

本文档记录正式版 Screeps Arena binding 的错误处理设计。

## 总体结论

- 不再把显式 `ActionResult` 当作第一层正式接口
- 正式版优先采用：
  - `suberror`
  - `raise`
  - `try?`
  - `try!`
  - `try/catch`
- `raw` 继续保留原始返回值形状
- `api` 负责把原始错误码转换成 MoonBit 错误类型

## 分层职责

### `raw`

`raw` 忠实保留 JS 返回值：

- 原始 `Int` 错误码
- 原始 `{ object?, error? }` 结果对象

`raw` 不负责高层错误语义整理。

### `model`

`model` 不负责错误码解释。

### `api`

`api` 负责：

- 把原始错误码映射成 `suberror`
- 把对象创建类结果整理成“成功返回对象，失败 raise 错误”

## 核心错误类型

第一阶段建议采用一个共享错误类型：

```moonbit
pub suberror ActionError {
  NotOwner
  Busy
  NotEnoughEnergy
  NotEnoughResources
  InvalidTarget
  Full
  NotInRange
  InvalidArgs
  Tired
  NoBodyPart
  UnknownRawError(Int)
}
```

这样做的目标是：

- 足够统一
- 足够可模式匹配
- 足够适合第一阶段实现

当前不建议一开始就为每个动作单独定义一套 error 类型。

## 正式 API 风格

动作方法默认采用：

- 成功时返回正常值
- 失败时 `raise ActionError`

例如：

```moonbit
pub fn OwnedCreep::harvest(self, target : Source) -> Unit raise ActionError
pub fn OwnedCreep::attack(self, target : EnemyCreep) -> Unit raise ActionError
pub fn OwnedCreep::move_to[T : MoveTarget](self, target : T) -> Unit raise ActionError

pub fn OwnedSpawn::spawn(
  self,
  body : Array[BodyPartKind]
) -> OwnedCreep raise ActionError

pub fn create_construction_site(...) -> ConstructionSite raise ActionError
```

## 调用侧处理方式

### 1. 向上传递

```moonbit
fn run_worker(...) -> Unit raise ActionError {
  creep.harvest(source)
}
```

### 2. 使用 `try?` 转成 `Result`

```moonbit
match try? creep.harvest(source) {
  Ok(_) => ()
  Err(NotInRange) => try!(creep.move_to(source))
  Err(_) => ()
}
```

### 3. 使用 `try/catch`

适合更复杂的局部恢复逻辑。

### 4. 使用 `try!`

适合调用方明确认为这里绝不会失败的场合。

## 不同类型失败的处理原则

### 1. 游戏规则失败

使用 `raise ActionError`。

例如：

- `ERR_NOT_IN_RANGE`
- `ERR_BUSY`
- `ERR_NOT_ENOUGH_ENERGY`

### 2. 正常“没找到”

使用 `Option`。

例如：

- `find_closest(...) -> T?`
- `object_by_id(...) -> T?`

### 3. 成功时返回对象的动作

成功直接返回对象，失败 `raise ActionError`。

例如：

- `spawn(...) -> OwnedCreep raise ActionError`
- `create_construction_site(...) -> ConstructionSite raise ActionError`

### 4. FFI / wrapper / 宿主环境异常

不混入 `ActionError`。

这类错误属于更一般的运行时或宿主环境错误，例如：

- wrapper 没有注入所需 helper
- host glue 失效
- 运行时状态与约定不一致

## 为什么第一阶段不优先做专用错误类型

当前不建议一开始就做：

- `MoveError`
- `HarvestError`
- `SpawnError`

原因：

- 类型数量膨胀过快
- 文档与维护成本明显增加
- 对第一阶段直播和 bot 开发的收益不够大

第一阶段更优先的是：

- 统一错误映射
- 统一处理模式
- 先让 API 风格稳定下来

## 当前结论

- 正式版第一阶段以 `suberror ActionError` 为核心
- 动作方法默认 `raise ActionError`
- 查询类“不存在”使用 `Option`
- 需要分支判断时使用 `try?`
- 认为不该失败时使用 `try!`
