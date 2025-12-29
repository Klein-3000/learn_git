# 基础
## 数据库
```sql
# 创建
use <db_name>

# 查看有哪些数据库
show dbs

# 查看有哪些文档
show collections
```
### 导出与导入
#### mongodump & mongorestore
```sql
# 在当前目录下，创建一个名为`<db>`的目录,为`<db>`的每个集合生成`coll.bson, coll.metadata.json`
mongodump --db <db> --out .

# 导出指定集合
mongodump --db <db> --collections  <collection> --out .

# 导入
mongorestore --db <db> [< path >]{.bson和metadata.json文件所在的目录}
```
###  特点：

- 导出的是 **BSON（Binary JSON）** 格式，保留所有数据类型（如日期、ObjectId、二进制等）
- 支持完整数据库、单个集合、带条件的子集
- **支持索引、用户权限等元数据**（需加 `--oplog` 等参数可实现一致性快照）
- 是**生产环境备份的首选方式**
#### mongoexport & mongoimport
```sql
# 导出为json文件
mongoexport --db <db> --collection <coll> --out <coll>.json

# 导出为csv文件
mongoexport --db <db> --collection <coll> \
    --type=csv \
    --fileds=<filed1>,<filed2>... \
    --out <coll>.csv

# 从json文件导入
mongoimport --db <db> --collection <coll> --file <coll>.json

# 从csv文件导入
mongoimport --db <db> --collection <coll> \
    --type=csv \
    --headline \
    --file <coll>.csv
```

### 特点：

- 导出为 **JSON 或 CSV**，人类可读，便于 Excel 处理或 API 传输
- **不保留 MongoDB 特有类型**（如 `_id` 的 ObjectId 会变成字符串，Date 变成 ISO 字符串）
- **不导出索引、用户、权限等元数据**
- 适合**数据迁移、数据分析、与非 MongoDB 系统交换数据**
## 增--insert
```sql
db.<collection>.insertOne(
    { key : "value", ... }
)

db.<collection>.insertMany([
    { key1 : "value1", ... }
    { key2 : "value2", ... }
])
```
## 删--delete
```sql
db.<collection>.deleteOne(
    { key : "value" }
)

db.<collection>.deleteMany(
    { key : "value" }
)

db.<collection>.drop()
```
## 改--update
```sql
db.<collection>.updateOne(
    [{key : "value"}]{定位要修改的文档},
    [{ $set { {key : "value"} } ]{需要修改的字段}
)
```
> [!attention] 注意
> 不加`$set` 会替换整个文档

## 查--find
```sql
# 查看全部
db.<collection>.find()

# 查看全部，格式化输出
db.<collection>.find().pretty()

# 限定输出个数
db.<collection>.find().limit()

# 排序
db.<collection>.find().sort([{ key : 1 }]{按照`key`字段排序, 1: 升序, -1 :降序})

# 查找指定的内容和(或)输出指定的字段
db.<collection>.find(
 [{ key : "value"}]{过滤条件。可以为空，表示查询全部},
 [{ _id : 0, key1 : 1, key2 : 1}]{指定要返回的字段}
)
```
> [!attention] 注意
> 1 表示包含，0 表示排除；_id 默认包含，若不要需显式设为 0
### 查找指定的内容
```sql

db.<collection>.find(
{ key : "value" }
)
# 大于
db.<collection>.find(
{ key : { $gt : "value"} }
)
# 等于
db.<collection>.find(
{ key : { $eq : "value"} }
)
# 小于
db.<collection>.find(
{ key : { $lt : "value"} }
)
```
### 其他
```sql
# 统计文档数
db.<collectiion>.countDocuments()

```
