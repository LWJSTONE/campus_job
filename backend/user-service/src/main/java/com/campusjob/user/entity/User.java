package com.campusjob.user.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 用户实体类
 * @author campus-job
 */
@Data
@TableName("user")
public class User {
    
    /**
     * 用户ID
     */
    @TableId(type = IdType.AUTO)
    private Long id;
    
    /**
     * 用户名
     */
    private String username;
    
    /**
     * 密码
     */
    private String password;
    
    /**
     * 真实姓名
     */
    private String realName;
    
    /**
     * 手机号
     */
    private String phone;
    
    /**
     * 邮箱
     */
    private String email;
    
    /**
     * 用户类型：0-学生，1-企业
     */
    private Integer userType;
    
    /**
     * 学校名称（学生）
     */
    private String school;
    
    /**
     * 专业（学生）
     */
    private String major;
    
    /**
     * 年级（学生）
     */
    private String grade;
    
    /**
     * 公司名称（企业）
     */
    private String company;
    
    /**
     * 营业执照（企业）
     */
    private String license;
    
    /**
     * 头像
     */
    private String avatar;
    
    /**
     * 状态：0-正常，1-禁用
     */
    private Integer status;
    
    /**
     * 创建时间
     */
    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;
    
    /**
     * 更新时间
     */
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;
    
    /**
     * 逻辑删除标记：0-未删除，1-已删除
     */
    @TableLogic
    private Integer deleted;
}
