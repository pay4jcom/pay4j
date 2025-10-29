- - -
## 系统简介

[![码云Gitee](https://gitee.com/pay4j/pay4j/badge/star.svg?theme=blue)](https://gitee.com/pay4j/pay4j)
[![GitHub](https://img.shields.io/github/stars/pay4jcom/pay4j?style=social&label=Stars)](https://github.com/pay4jcom/pay4j)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](https://gitee.com/dromara/pay4j-Vue-Plus/blob/5.X/LICENSE)
[![使用IntelliJ IDEA开发维护](https://img.shields.io/badge/IntelliJ%20IDEA-提供支持-blue.svg)](https://www.jetbrains.com/?from=pay4j)
<br>
[![pay4jcom](https://img.shields.io/badge/pay4j_Vue_Plus-5.5.1-success.svg)](https://gitee.com/pay4j/pay4j)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.4-blue.svg)]()
[![JDK-17](https://img.shields.io/badge/JDK-17-green.svg)]()
[![JDK-21](https://img.shields.io/badge/JDK-21-green.svg)]()

> Pay4j 是重写 XXPay支付项目 针对 `分布式集群与多租户` 场景全方位升级(不兼容原框架) 
> 多租户支付管理系统 重写XXPay所有功能 集成 支付宝，微信 支付，查询，回调，进件，分账等功能， 定期更新，支付中台，三方支持系统，四方支付系统。

> 项目代码、文档 均开源免费可商用 遵循开源协议在项目中保留开源协议文件即可<br>
活到老写到老 为兴趣而开源 为学习而开源 为让大家真正可以学到技术而开源

> 系统演示: [传送门](https://doc.pay4j.com/#/common/demo_system)

> 官方前端项目地址: [gitee](https://gitee.com/pay4j/pay4j-ui) - [github](https://github.com/pay4jcom/pay4j-ui) <br>

> 文档地址: [pay4j-doc](https://doc.pay4j.com)

## 赞助商

期待赞助
1

[如何成为赞助商 加群联系作者详谈 每日PV2500-3000 IP1700-2500](https://pay4j.com/#/common/add_group)


## 本框架业务功能与版本说明

| 业务     | 功能说明                                                                 | 开源版 | 商业版              |
|--------|----------------------------------------------------------------------|-----|------------------|
| 租户管理   | 系统内租户的管理 如:租户套餐、过期时间、用户数量、企业信息等                                      | 支持  | 支持                |
| 租户套餐管理 | 系统内租户所能使用的套餐管理 如:套餐内所包含的菜单等                                          | 支持  | 支持                |
| 客户端管理  | 系统内对接的所有客户端管理 如: pc端、小程序端等<br>支持动态授权登录方式 如: 短信登录、密码登录等 支持动态控制token时效 | 支持  | 支持                |
| 用户管理   | 用户的管理配置 如:新增用户、分配用户所属部门、角色、岗位等                                       | 支持  | 支持               |
| 部门管理   | 配置系统组织机构（公司、部门、小组） 树结构展现支持数据权限                                       | 支持  | 支持               |
| 岗位管理   | 配置系统用户所属担任职务                                                         | 支持  | 支持               |
| 菜单管理   | 配置系统菜单、操作权限、按钮权限标识等                                                  | 支持  | 支持               |
| 角色管理   | 角色菜单权限分配、设置角色按机构进行数据范围权限划分                                           | 支持  | 支持               |
| 字典管理   | 对系统中经常使用的一些较为固定的数据进行维护                                               | 支持  | 支持               |
| 参数管理   | 对系统动态配置常用参数                                                          | 支持  | 支持               |
| 通知公告   | 系统通知公告信息发布维护                                                         | 支持  | 支持               |
| 操作日志   | 系统正常操作日志记录和查询 系统异常信息日志记录和查询                                          | 支持  | 支持               |
| 登录日志   | 系统登录日志记录查询包含登录异常                                                     | 支持  | 支持               |
| 文件管理   | 系统文件展示、上传、下载、删除等管理                                                   | 支持  | 支持                |
| 文件配置管理 | 系统文件上传、下载所需要的配置信息动态添加、修改、删除等管理                                       | 支持  | 支持                |
| 在线用户管理 | 已登录系统的在线用户信息监控与强制踢出操作                                                | 支持  | 支持               |
| 定时任务   | 运行报表、任务管理(添加、修改、删除)、日志管理、执行器管理等                                      | 支持  | 支持       |
| 代码生成   | 多数据源前后端代码的生成（java、html、xml、sql）支持CRUD下载                              | 支持  | 支持          |
| 系统接口   | 根据业务代码自动生成相关的api接口文档                                                 | 支持  | 支持               |
| 服务监控   | 监视集群系统CPU、内存、磁盘、堆栈、在线日志、Spring相关配置等                                  | 支持  | 支持 |
| 缓存监控   | 对系统的缓存信息查询，命令统计等。                                                    | 支持  | 支持               |
| 使用案例   | 系统的一些功能案例                                                            | 支持  | 支持              |

## 参考文档

使用框架前请仔细阅读文档重点注意事项
<br>
>[初始化项目 必看](https://doc.pay4j.com/#/pay4j-vue-plus/quickstart/init)
>>[https://doc.pay4j.com/#/pay4j/quickstart/init](https://doc.pay4j.com/#/pay4j/quickstart/init)
>
>
>[部署项目 必看](https://doc.pay4j.com/#/pay4j/quickstart/deploy)
>>[https://doc.pay4j.com/#/pay4j/quickstart/deploy](https://doc.pay4j.com/#/pay4j/quickstart/deploy)
>
>[如何加群](https://doc.pay4j.com/#/common/add_group)
>>[https://doc.pay4j.com/#/common/add_group](https://doc.pay4j.com/#/common/add_group)
>
>[参考文档 Wiki](https://doc.pay4j.com)
>>[https://doc.pay4j.com](https://doc.pay4j.com)

## 软件架构图

![部署架构图](https://foruda.gitee.com/images/1678981882624240692/ae2a3f3e_1766278.png "部署架构图.png")

## 如何参与贡献

[参与贡献的方式 https://doc.pay4j.com/#/common/contribution](https://doc.pay4j.com/#/common/contribution)


## 演示图例













