package com.campusjob.job.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 兼职信息实体类
 * @author campus-job
 */
@Data
@TableName("job")
public class Job {
    
    /**
     * 兼职ID
     */
    @TableId(type = IdType.AUTO)
    private Long id;
    
    /**
     * 发布企业ID
     */
    private Long companyId;
    
    /**
     * 职位名称
     */
    private String title;
    
    /**
     * 职位描述
     */
    private String description;
    
    /**
     * 工作地点
     */
    private String location;
    
    /**
     * 工作类型：0-线上，1-线下
     */
    private Integer workType;
    
    /**
     * 薪资类型：0-时薪，1-日薪，2-月薪，3-面议
     */
    private Integer salaryType;
    
    /**
     * 薪资金额
     */
    private BigDecimal salary;
    
    /**
     * 工作时间
     */
    private String workTime;
    
    /**
     * 招聘人数
     */
    private Integer recruitCount;
    
    /**
     * 已招聘人数
     */
    private Integer hiredCount;
    
    /**
     * 职位要求
     */
    private String requirements;
    
    /**
     * 职位状态：0-审核中，1-已发布，2-已下架
     */
    private Integer status;
    
    /**
     * 浏览次数
     */
    private Integer viewCount;
    
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
