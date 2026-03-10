package com.campusjob.common.result;

/**
 * 统一返回状态码
 * @author campus-job
 */
public interface ResultCode {
    
    /**
     * 成功
     */
    Integer SUCCESS = 200;
    
    /**
     * 失败
     */
    Integer ERROR = 500;
    
    /**
     * 参数错误
     */
    Integer PARAM_ERROR = 400;
    
    /**
     * 未授权
     */
    Integer UNAUTHORIZED = 401;
    
    /**
     * 禁止访问
     */
    Integer FORBIDDEN = 403;
    
    /**
     * 资源不存在
     */
    Integer NOT_FOUND = 404;
    
    /**
     * 用户名或密码错误
     */
    Integer LOGIN_ERROR = 1001;
    
    /**
     * Token无效或已过期
     */
    Integer TOKEN_INVALID = 1002;
    
    /**
     * 用户已存在
     */
    Integer USER_EXISTS = 1003;
    
    /**
     * 用户不存在
     */
    Integer USER_NOT_FOUND = 1004;
    
    /**
     * 兼职信息不存在
     */
    Integer JOB_NOT_FOUND = 2001;
    
    /**
     * 兼职申请已存在
     */
    Integer APPLICATION_EXISTS = 3001;
}
