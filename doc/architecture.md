# 总体分层

本文档记录正式版 Screeps Arena binding 的总体分层与各层职责。

## 当前结论

正式版 binding 采用四层结构：

- `raw`
- `model`
- `api`
- `wrapper`

## 各层职责

### `raw`

职责：

- 只做忠实 FFI
- 尽量贴近 JS / Arena 原始 API
- 暴露原始 extern type、原始方法、原始错误码、原始常量

不负责：

- MoonBit 风格抽象
- 业务策略
- 过度包装

关键原则：

- `raw` 的目标是“正确映射”，不是“好用”

### `model`

职责：

- 把 JS live object 包装成 MoonBit wrapper
- 承载对象语义
- 提供 live getter、轻量构造、typed view 转换

不负责：

- bot 策略
- 复杂便捷 helper

关键原则：

- `model` 的目标是“对象是什么”

### `api`

职责：

- 提供更 MoonBit 风格的接口
- 放 trait、ADT、结果类型、统一命名、便捷查询
- 尽量让 bot 层不直接碰 raw 风格接口

不负责：

- JS 宿主 glue
- 直播专用脚本逻辑

关键原则：

- `api` 的目标是“怎么好用地用”

### `wrapper`

职责：

- 保留 `main.mjs`
- 负责 MoonBit 暂时不擅长的 host glue
- 处理 class token、特殊 JS glue、运行时桥接

不负责：

- bot 业务逻辑
- MoonBit 内部对象建模

关键原则：

- `wrapper` 是正式架构的一部分，不视为临时脏补丁

## 各层关系

- `raw` 和 `model` 共同构成绑定层
- `api` 是对外使用层
- `wrapper` 是宿主适配层
- `main/`、tutorial 代码、bot 代码属于 binding 的使用方，不属于 binding 本体

## 目录方向

当前项目还是单文件形态：

- `raw.mbt`
- `api.mbt`

正式版建议逐步演进到更清晰的目录结构，例如：

- `raw/`
- `model/`
- `api/`
- 根目录 `main.mjs`
- `main/` 作为示例或入口包

## 为什么需要 `model` 层

如果只有 `raw + api`，高层代码会同时承担两件事：

- 包装 JS live object
- 设计 MoonBit 风格接口

这两个职责混在一起，后续很容易失控。

加入 `model` 层之后：

- `raw` 负责“怎么连上”
- `model` 负责“对象是什么”
- `api` 负责“怎么好用地用”

这样更适合长期维护，也更适合多人和 AI 协作开发。
