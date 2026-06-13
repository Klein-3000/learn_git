# 一、环境变量

| 环境变量                                         | 类型  |
| -------------------------------------------- | --- |
| `RCLONE_CONFIG_[<remote>]{需要指定==远程(资源)==}_*` | 客户端 |
| `RCLONE_*`                                   | 服务端 |


## 1.1 客户端(client)

| 环境变量名称                                      | 作用与说明                                                                                                     | 使用场景/示例                                                                                                                                                                                                                       |
| :------------------------------------------ | :-------------------------------------------------------------------------------------------------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `RCLONE_CONFIG`                             | 自定义配置文件路径。  <br>用于指定 rclone 读取的配置文件位置，替代默认的 `~/.config/rclone/rclone.conf`。                               | 适用于多用户系统或临时测试不同的配置文件。  <br>示例：  <br>`export RCLONE_CONFIG=/path/to/custom/rclone.conf`                                                                                                                                        |
| `RCLONE_CONFIG_PASS`                        | 自动解密配置文件密码。  <br>若 rclone 配置文件开启了加密保护，将此变量设置为对应的密码即可实现自动解密，无需手动输入。                                        | 适用于自动化脚本（如定时备份）或 CI/CD 流水线中，避免交互式输入密码。  <br>示例：  <br>`export RCLONE_CONFIG_PASS=your_encryption_password`                                                                                                                     |
| `RCLONE_CONFIG_<REMOTE_NAME>_<OPTION_NAME>` | **动态注入**特定远程存储的配置参数。  <br>允许通过环境变量覆盖或补充 `rclone.conf` 中的具体配置项。命名规则为：将远程名称和选项名称全部转为大写，并将空格及特殊字符替换为下划线 `_`。 | 适用于将敏感信息（如 Access Key、密码等）从配置文件中剥离，提升安全性；或在运行时临时修改某个远端的参数。  <br>示例（S3 存储）：  <br>`export RCLONE_CONFIG_MYS3_TYPE=s3`  <br>`export RCLONE_CONFIG_MYS3_ACCESS_KEY_ID=XXX`  <br>`export RCLONE_CONFIG_MYS3_SECRET_ACCESS_KEY=XXX` |
### 1.1.1 动态注入
```ini
# rclone.conf
[anime]
type = sftp

```

```bash
# 注入用户 `user`
export RCLONE_CONFIG_[anime]{远程名}_[USER]{注入==用户==}="admin"
# 注入密码 `pass`
export RCLONE_CONFIG__[anime]{远程名}_[PASS]{注入==密码==}="admin"

# 可对 `anime` 进行操作
rclone <subcommand> anime:

```

## 1.2 服务端 (server)
```bash
# 地址和端口一般手动指定(避免多开时,端口占用)
export RCLONE_ADDR=":22"

export RCLONE_USER="verthandi"

export RCLONE_PASS="2v23"


# 启动 `rclone serve`
rclone serve [ sftp | http | webdav ] <remote_name:>
```
