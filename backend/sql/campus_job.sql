-- 校园兼职平台数据库初始化脚本
-- 创建时间：2024-01-01

-- 创建数据库
CREATE DATABASE IF NOT EXISTS campus_job DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE campus_job;

-- 用户表
CREATE TABLE `user` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '用户ID',
    `username` VARCHAR(50) NOT NULL COMMENT '用户名',
    `password` VARCHAR(255) NOT NULL COMMENT '密码（加密）',
    `real_name` VARCHAR(50) COMMENT '真实姓名',
    `phone` VARCHAR(20) COMMENT '手机号',
    `email` VARCHAR(100) COMMENT '邮箱',
    `user_type` TINYINT NOT NULL DEFAULT 0 COMMENT '用户类型：0-学生，1-企业',
    `school` VARCHAR(100) COMMENT '学校名称（学生）',
    `major` VARCHAR(100) COMMENT '专业（学生）',
    `grade` VARCHAR(20) COMMENT '年级（学生）',
    `company` VARCHAR(100) COMMENT '公司名称（企业）',
    `license` VARCHAR(255) COMMENT '营业执照（企业）',
    `avatar` VARCHAR(255) COMMENT '头像',
    `status` TINYINT NOT NULL DEFAULT 0 COMMENT '状态：0-正常，1-禁用',
    `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '逻辑删除：0-未删除，1-已删除',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_username` (`username`),
    KEY `idx_user_type` (`user_type`),
    KEY `idx_phone` (`phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- 兼职信息表
CREATE TABLE `job` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '兼职ID',
    `company_id` BIGINT NOT NULL COMMENT '发布企业ID',
    `title` VARCHAR(100) NOT NULL COMMENT '职位名称',
    `description` TEXT NOT NULL COMMENT '职位描述',
    `location` VARCHAR(255) NOT NULL COMMENT '工作地点',
    `work_type` TINYINT NOT NULL DEFAULT 1 COMMENT '工作类型：0-线上，1-线下',
    `salary_type` TINYINT NOT NULL DEFAULT 0 COMMENT '薪资类型：0-时薪，1-日薪，2-月薪，3-面议',
    `salary` DECIMAL(10,2) COMMENT '薪资金额',
    `work_time` VARCHAR(255) COMMENT '工作时间',
    `recruit_count` INT NOT NULL DEFAULT 1 COMMENT '招聘人数',
    `hired_count` INT NOT NULL DEFAULT 0 COMMENT '已招聘人数',
    `requirements` TEXT COMMENT '职位要求',
    `status` TINYINT NOT NULL DEFAULT 0 COMMENT '状态：0-审核中，1-已发布，2-已下架',
    `view_count` INT NOT NULL DEFAULT 0 COMMENT '浏览次数',
    `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '逻辑删除：0-未删除，1-已删除',
    PRIMARY KEY (`id`),
    KEY `idx_company_id` (`company_id`),
    KEY `idx_status` (`status`),
    KEY `idx_work_type` (`work_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='兼职信息表';

-- 兼职申请表
CREATE TABLE `application` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '申请ID',
    `job_id` BIGINT NOT NULL COMMENT '兼职ID',
    `student_id` BIGINT NOT NULL COMMENT '学生ID',
    `company_id` BIGINT NOT NULL COMMENT '企业ID',
    `resume` TEXT COMMENT '简历内容',
    `apply_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '申请时间',
    `status` TINYINT NOT NULL DEFAULT 0 COMMENT '状态：0-待审核，1-已通过，2-已拒绝',
    `review_time` DATETIME COMMENT '审核时间',
    `review_comment` VARCHAR(255) COMMENT '审核意见',
    `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '逻辑删除：0-未删除，1-已删除',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_job_student` (`job_id`, `student_id`),
    KEY `idx_student_id` (`student_id`),
    KEY `idx_company_id` (`company_id`),
    KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='兼职申请表';

-- 消息表
CREATE TABLE `message` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '消息ID',
    `sender_id` BIGINT NOT NULL COMMENT '发送者ID',
    `receiver_id` BIGINT NOT NULL COMMENT '接收者ID',
    `job_id` BIGINT COMMENT '关联兼职ID',
    `content` TEXT NOT NULL COMMENT '消息内容',
    `is_read` TINYINT NOT NULL DEFAULT 0 COMMENT '是否已读：0-未读，1-已读',
    `read_time` DATETIME COMMENT '阅读时间',
    `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '逻辑删除：0-未删除，1-已删除',
    PRIMARY KEY (`id`),
    KEY `idx_sender_id` (`sender_id`),
    KEY `idx_receiver_id` (`receiver_id`),
    KEY `idx_job_id` (`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='消息表';

-- 插入测试数据
-- 插入管理员用户
INSERT INTO `user` (`username`, `password`, `real_name`, `user_type`, `status`) VALUES 
('admin', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVKIUi', '管理员', 2, 0);

-- 插入测试学生
INSERT INTO `user` (`username`, `password`, `real_name`, `phone`, `email`, `user_type`, `school`, `major`, `grade`, `status`) VALUES 
('student1', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVKIUi', '张三', '13800138001', 'student1@example.com', 0, '清华大学', '计算机科学与技术', '大二', 0),
('student2', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVKIUi', '李四', '13800138002', 'student2@example.com', 0, '北京大学', '软件工程', '大三', 0);

-- 插入测试企业
INSERT INTO `user` (`username`, `password`, `real_name`, `phone`, `email`, `user_type`, `company`, `status`) VALUES 
('company1', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVKIUi', '公司1', '13900139001', 'company1@example.com', 1, '科技公司', 0),
('company2', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVKIUi', '公司2', '13900139002', 'company2@example.com', 1, '教育机构', 0);

-- 插入测试兼职信息
INSERT INTO `job` (`company_id`, `title`, `description`, `location`, `work_type`, `salary_type`, `salary`, `work_time`, `recruit_count`, `requirements`, `status`) VALUES 
(4, 'Java开发实习生', '负责公司核心业务系统的开发与维护', '北京市海淀区', 1, 0, 50.00, '周一至周五 9:00-18:00', 3, '熟悉Java基础，了解Spring框架', 1),
(5, '助教', '协助讲师完成教学任务，批改作业', '上海市浦东新区', 1, 1, 200.00, '周末 9:00-17:00', 2, '良好的沟通能力，有教学经验优先', 1);

-- 插入测试申请记录
INSERT INTO `application` (`job_id`, `student_id`, `company_id`, `resume`, `status`) VALUES 
(1, 3, 4, '熟练掌握Java、Python，有Spring Boot项目经验', 0),
(2, 4, 5, '热爱教育，有助教工作经验', 0);

-- 插入测试消息
INSERT INTO `message` (`sender_id`, `receiver_id`, `job_id`, `content`, `is_read`) VALUES 
(4, 3, 1, '您好，看到您申请了Java开发实习生岗位，请方便时联系我。', 0),
(3, 4, 1, '收到，我会尽快联系您。', 1);

-- 创建视图：兼职详情视图
CREATE OR REPLACE VIEW `v_job_detail` AS
SELECT 
    j.id,
    j.title,
    j.description,
    j.location,
    j.work_type,
    j.salary_type,
    j.salary,
    j.work_time,
    j.recruit_count,
    j.hired_count,
    j.requirements,
    j.status,
    j.view_count,
    j.create_time,
    u.real_name AS company_name,
    u.phone AS company_phone,
    u.email AS company_email
FROM job j
LEFT JOIN user u ON j.company_id = u.id
WHERE j.deleted = 0;

-- 创建视图：用户统计视图
CREATE OR REPLACE VIEW `v_user_stats` AS
SELECT 
    user_type,
    COUNT(*) AS total_count,
    SUM(CASE WHEN status = 0 THEN 1 ELSE 0 END) AS active_count,
    SUM(CASE WHEN status = 1 THEN 1 ELSE 0 END) AS disabled_count
FROM user
WHERE deleted = 0
GROUP BY user_type;
