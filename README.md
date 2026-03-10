# 校园兼职网站 - Campus Job Platform

## 项目介绍

这是一个基于 Spring Cloud 微服务架构的校园兼职信息服务平台，旨在为高校学生和企业/商家提供一个安全、高效、透明的兼职信息对接平台。

### 主要功能
- 用户管理（学生、企业、管理员三种角色）
- 兼职信息发布与管理
- 兼职申请与审核
- 在线沟通与评价
- 智能推荐（基于协同过滤算法）
- 实时消息通知
- 数据统计与分析

## 技术栈

### 后端技术栈
- **Spring Boot 3.2.x** - 核心框架
- **Spring Cloud 2023.x** - 微服务框架
  - Spring Cloud Gateway - API网关
  - Spring Cloud OpenFeign - 服务调用
  - Spring Cloud LoadBalancer - 负载均衡
  - Spring Cloud Config - 配置中心
  - Spring Cloud Netflix Eureka - 服务注册与发现
- **Spring Security + JWT** - 安全认证
- **MyBatis Plus** - ORM框架
- **MySQL 8.0** - 关系型数据库
- **Redis 7.x** - 缓存与会话管理
- **RabbitMQ** - 消息队列
- **Sentinel** - 流量控制与熔断降级

### 前端技术栈
- **Vue 3.4+** - 前端框架
- **TypeScript** - 类型安全
- **Vite 5.x** - 构建工具
- **Element Plus** - UI组件库
- **Pinia** - 状态管理
- **Vue Router 4.x** - 路由管理
- **Axios** - HTTP客户端

### 部署技术栈
- **Docker & Docker Compose** - 容器化部署
- **Nginx** - 反向代理

## 项目结构

```
campus_job/
├── backend/                    # 后端微服务
│   ├── gateway/                # 网关服务
│   ├── eureka-server/          # 服务注册中心
│   ├── config-server/          # 配置中心
│   ├── auth-service/           # 认证服务
│   ├── user-service/           # 用户服务
│   ├── job-service/            # 兼职服务
│   ├── application-service/     # 申请服务
│   ├── message-service/        # 消息服务
│   ├── common/                 # 公共模块
│   └── Dockerfile             # Docker构建文件
├── frontend/                  # 前端项目
│   ├── src/
│   ├── public/
│   └── package.json
├── docs/                     # 文档目录
│   ├── API文档.md
│   ├── 架构设计.md
│   └── 部署教程.md
├── deploy/                    # 部署配置
│   ├── docker-compose.yml
│   └── nginx.conf
└── README.md                  # 项目说明
```

## 快速开始（面向零基础小白）

### 前置要求

在开始之前，请确保你的环境已经安装以下软件：

1. **JDK 17+** (Java开发工具包)
   - 下载地址：https://www.oracle.com/java/technologies/downloads/
   - 验证安装：在命令行输入 `java -version`

2. **Maven 3.8+** (项目构建工具)
   - 下载地址：https://maven.apache.org/download.cgi
   - 验证安装：在命令行输入 `mvn -version`

3. **Node.js 18+** (JavaScript运行环境)
   - 下载地址：https://nodejs.org/
   - 验证安装：在命令行输入 `node -v` 和 `npm -v`

4. **MySQL 8.0+** (数据库)
   - 下载地址：https://dev.mysql.com/downloads/mysql/
   - 推荐使用 MySQL Community Server

5. **Redis 7.x** (缓存)
   - Windows: https://github.com/microsoftarchive/redis/releases
   - Linux/Mac: 使用包管理器安装

6. **Git** (版本控制)
   - 下载地址：https://git-scm.com/downloads
   - 验证安装：在命令行输入 `git --version`

7. **Docker & Docker Compose** (容器化部署)
   - 下载地址：https://docs.docker.com/get-docker/
   - 验证安装：在命令行输入 `docker --version` 和 `docker-compose --version`

### 一、克隆项目

```bash
git clone https://github.com/LWJSTONE/campus_job.git
cd campus_job
```

### 二、数据库初始化

1. 创建数据库
```bash
mysql -u root -p
# 在MySQL命令行中执行
CREATE DATABASE campus_job CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
exit;
```

2. 导入数据库脚本
```bash
mysql -u root -p campus_job < docs/database/schema.sql
mysql -u root -p campus_job < docs/database/init_data.sql
```

### 三、后端启动（使用Docker Compose）

如果你已经安装了Docker，这是最简单的方式：

```bash
# 启动所有服务（包括数据库、Redis、消息队列等）
cd deploy
docker-compose up -d

# 查看服务状态
docker-compose ps

# 查看日志
docker-compose logs -f
```

**注意**：如果你想手动启动后端服务（不使用Docker），请参考 `docs/部署教程.md` 中的详细步骤。

### 四、前端启动

```bash
cd frontend

# 安装依赖
npm install

# 启动开发服务器
npm run dev

# 浏览器访问
# 默认地址: http://localhost:5173
```

### 五、访问系统

- **前端地址**: http://localhost:5173
- **网关地址**: http://localhost:10000
- **Eureka控制台**: http://localhost:8761
- **配置中心**: http://localhost:8888

### 默认账号

| 角色 | 用户名 | 密码 |
|------|--------|------|
| 管理员 | admin | admin123 |
| 学生用户 | student | student123 |
| 企业用户 | company | company123 |

## 开发文档

详细的开发文档请参考 `docs/` 目录：

- [API接口文档](docs/API文档.md) - 所有后端接口说明
- [架构设计文档](docs/架构设计.md) - 系统架构与技术细节
- [部署教程](docs/部署教程.md) - 详细的部署步骤（零基础友好）
- [开发指南](docs/开发指南.md) - 开发环境配置与规范

## 系统架构图

```
┌─────────────────────────────────────────────────────────────┐
│                      用户浏览器                           │
└────────────────────┬────────────────────────────────────────┘
                     │
┌────────────────────▼────────────────────────────────────────┐
│               Spring Cloud Gateway                       │
│              (API网关/统一入口/权限控制)                  │
└────────┬───────────────────────────────────┬─────────────┘
         │                                   │
    ┌────▼────┐    ┌──────────┬──────────┐  │
    │  Eureka │    │   Nacos   │  Config  │  │
    │ Server  │    │  (服务注册)│  (配置)  │  │
    └─────────┘    └──────────┴──────────┘  │
                                        │
    ┌───────────────────┬───────────────────┤
    │                   │                   │
┌───▼────────┐   ┌───▼────────┐   ┌───▼────────┐
│ Auth Service│   │ User Service│   │ Job Service │
│ (认证服务)  │   │ (用户服务)   │   │ (兼职服务)   │
└────────────┘   └────────────┘   └────────────┘
                                         │
    ┌──────────────────┬───────────────────┤
    │                  │                   │
┌───▼────────┐  ┌───▼────────┐   ┌───▼────────┐
│Application  │  │  Message   │   │ Statistics │
│  Service   │  │  Service   │   │  Service   │
│(申请服务)    │  │ (消息服务)   │   │ (统计服务)   │
└────────────┘  └────────────┘   └────────────┘
        │              │               │
        └──────────────┼───────────────┘
                       │
              ┌────────▼────────┐
              │    MySQL 8.0    │
              │     数据库       │
              └─────────────────┘
                       │
              ┌────────▼────────┐
              │    Redis        │
              │   (缓存/会话)   │
              └─────────────────┘
```

## 核心功能模块

### 1. 用户认证与授权
- 基于JWT的无状态认证
- 支持学生、企业、管理员三种角色
- 手机号/邮箱验证码登录
- OAuth2.0第三方登录（可选）

### 2. 兼职信息管理
- 企业发布兼职岗位
- 管理员审核兼职信息
- 兼职分类与搜索
- 兼职推荐（协同过滤算法）

### 3. 申请与审核
- 学生在线申请兼职
- 企业审核申请
- 申请状态跟踪

### 4. 消息通知
- 系统公告
- 申请状态通知
- 即时聊天（WebSocket）

### 5. 数据统计
- 兼职数据统计
- 用户行为分析
- 可视化展示

## 技术亮点

1. **微服务架构**：基于Spring Cloud，服务独立部署，易于扩展
2. **前后端分离**：Vue3 + Spring Boot，职责清晰
3. **容器化部署**：Docker + Docker Compose，一键启动
4. **高可用设计**：服务注册、负载均衡、熔断降级
5. **缓存优化**：Redis缓存热点数据，提升性能
6. **安全认证**：JWT + Spring Security，安全可靠
7. **智能推荐**：协同过滤算法，提升用户体验

## 性能指标

- **系统响应时间**：< 500ms (95%请求)
- **并发用户数**：支持1000+并发
- **系统可用性**：99.9%+
- **数据一致性**：最终一致性

## 常见问题

### Q1: 启动时数据库连接失败
A: 请检查MySQL服务是否启动，用户名密码是否正确，数据库是否已创建。

### Q2: Redis连接失败
A: 请检查Redis服务是否运行，默认端口6379。

### Q3: Eureka服务注册失败
A: 请先启动Eureka Server，等待服务完全启动后再启动其他微服务。

### Q4: 前端访问后端接口跨域
A: 网关服务已配置CORS，确保网关服务正常运行。

### Q5: Docker Compose启动失败
A: 检查Docker服务是否启动，端口是否被占用。

## 联系方式

- 项目地址：https://github.com/LWJSTONE/campus_job
- 问题反馈：提交Issue
- 技术交流：欢迎Pull Request

## 许可证

本项目采用 MIT 许可证。详见 [LICENSE](LICENSE) 文件。

## 致谢

感谢所有为校园兼职平台项目做出贡献的开发者！

---

**注意事项**：
1. 首次部署请仔细阅读部署教程
2. 生产环境部署请修改默认密码
3. 定期备份数据库
4. 关注系统日志，及时处理异常
