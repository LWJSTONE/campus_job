import { createRouter, createWebHistory } from 'vue-router'

const routes = [
  {
    path: '/',
    name: 'Home',
    component: () => import('../views/Home.vue'),
    meta: { title: '首页' }
  },
  {
    path: '/login',
    name: 'Login',
    component: () => import('../views/Login.vue'),
    meta: { title: '登录' }
  },
  {
    path: '/register',
    name: 'Register',
    component: () => import('../views/Register.vue'),
    meta: { title: '注册' }
  },
  {
    path: '/jobs',
    name: 'Jobs',
    component: () => import('../views/Jobs.vue'),
    meta: { title: '兼职列表' }
  },
  {
    path: '/job/:id',
    name: 'JobDetail',
    component: () => import('../views/JobDetail.vue'),
    meta: { title: '兼职详情' }
  },
  {
    path: '/profile',
    name: 'Profile',
    component: () => import('../views/Profile.vue'),
    meta: { title: '个人中心' }
  },
  {
    path: '/my-applications',
    name: 'MyApplications',
    component: () => import('../views/MyApplications.vue'),
    meta: { title: '我的申请' }
  },
  {
    path: '/post-job',
    name: 'PostJob',
    component: () => import('../views/PostJob.vue'),
    meta: { title: '发布兼职' }
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

router.beforeEach((to, from, next) => {
  document.title = to.meta.title as string || '校园兼职平台'
  next()
})

export default router
