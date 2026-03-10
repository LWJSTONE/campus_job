import request from '../utils/request'

// 用户登录
export const login = (data: any) => {
  return request({
    url: '/auth/login',
    method: 'post',
    data
  })
}

// 用户注册
export const register = (data: any) => {
  return request({
    url: '/auth/register',
    method: 'post',
    data
  })
}

// 获取用户信息
export const getUserInfo = () => {
  return request({
    url: '/user/info',
    method: 'get'
  })
}

// 获取兼职列表
export const getJobs = (params: any) => {
  return request({
    url: '/job/list',
    method: 'get',
    params
  })
}

// 获取兼职详情
export const getJobDetail = (id: number) => {
  return request({
    url: `/job/${id}`,
    method: 'get'
  })
}

// 申请兼职
export const applyJob = (data: any) => {
  return request({
    url: '/application/apply',
    method: 'post',
    data
  })
}

// 获取我的申请列表
export const getMyApplications = () => {
  return request({
    url: '/application/my',
    method: 'get'
  })
}

// 发布兼职
export const postJob = (data: any) => {
  return request({
    url: '/job/post',
    method: 'post',
    data
  })
}
