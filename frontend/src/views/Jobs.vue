<template>
  <div class="jobs-container">
    <el-container>
      <el-header>
        <div class="header-content">
          <div class="logo" @click="$router.push('/')">校园兼职平台</div>
          <div class="nav">
            <el-button type="primary" @click="$router.push('/post-job')" v-if="userInfo?.userType === 1">
              发布兼职
            </el-button>
            <el-dropdown v-if="userInfo" trigger="click">
              <span class="user-info">
                <el-avatar :size="32" :src="userInfo.avatar">{{ userInfo.realName?.[0] }}</el-avatar>
                <span>{{ userInfo.realName }}</span>
              </span>
              <template #dropdown>
                <el-dropdown-menu>
                  <el-dropdown-item @click="$router.push('/profile')">个人中心</el-dropdown-item>
                  <el-dropdown-item @click="$router.push('/my-applications')">我的申请</el-dropdown-item>
                  <el-dropdown-item divided @click="handleLogout">退出登录</el-dropdown-item>
                </el-dropdown-menu>
              </template>
            </el-dropdown>
            <div v-else>
              <el-button type="primary" @click="$router.push('/login')">登录</el-button>
              <el-button @click="$router.push('/register')">注册</el-button>
            </div>
          </div>
        </div>
      </el-header>
      
      <el-main>
        <div class="filter-bar">
          <el-row :gutter="20">
            <el-col :span="6">
              <el-select v-model="filter.workType" placeholder="工作类型" clearable @change="loadJobs">
                <el-option label="全部" :value="null" />
                <el-option label="线上" :value="0" />
                <el-option label="线下" :value="1" />
              </el-select>
            </el-col>
            <el-col :span="6">
              <el-select v-model="filter.salaryType" placeholder="薪资类型" clearable @change="loadJobs">
                <el-option label="全部" :value="null" />
                <el-option label="时薪" :value="0" />
                <el-option label="日薪" :value="1" />
                <el-option label="月薪" :value="2" />
                <el-option label="面议" :value="3" />
              </el-select>
            </el-col>
            <el-col :span="12">
              <el-input 
                v-model="filter.keyword" 
                placeholder="搜索职位名称、公司名称" 
                @keyup.enter="loadJobs"
              >
                <template #append>
                  <el-button :icon="Search" @click="loadJobs" />
                </template>
              </el-input>
            </el-col>
          </el-row>
        </div>
        
        <div class="job-list">
          <el-card v-for="job in jobList" :key="job.id" class="job-card" @click="$router.push(`/job/${job.id}`)">
            <div class="job-header">
              <h3>{{ job.title }}</h3>
              <span class="salary">{{ formatSalary(job) }}</span>
            </div>
            <div class="job-info">
              <el-tag size="small">{{ job.workType === 0 ? '线上' : '线下' }}</el-tag>
              <span>{{ job.location }}</span>
            </div>
            <div class="job-footer">
              <span class="company">{{ job.companyName }}</span>
              <span class="time">{{ formatDate(job.createTime) }}</span>
            </div>
          </el-card>
        </div>
        
        <div class="pagination">
          <el-pagination
            v-model:current-page="pagination.page"
            v-model:page-size="pagination.size"
            :total="pagination.total"
            layout="total, prev, pager, next"
            @current-change="loadJobs"
          />
        </div>
      </el-main>
    </el-container>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { Search } from '@element-plus/icons-vue'
import { getJobs } from '../api'

const router = useRouter()

const userInfo = ref(JSON.parse(localStorage.getItem('userInfo') || 'null'))

const filter = reactive({
  workType: null as number | null,
  salaryType: null as number | null,
  keyword: ''
})

const pagination = reactive({
  page: 1,
  size: 10,
  total: 0
})

const jobList = ref<any[]>([])

const formatSalary = (job: any) => {
  if (job.salaryType === 3) {
    return '薪资面议'
  }
  const typeMap = ['时薪', '日薪', '月薪']
  return `${typeMap[job.salaryType]}：${job.salary}元`
}

const formatDate = (date: string) => {
  return new Date(date).toLocaleDateString()
}

const loadJobs = async () => {
  try {
    const data = await getJobs({
      ...filter,
      page: pagination.page,
      size: pagination.size
    })
    jobList.value = data.list || []
    pagination.total = data.total || 0
  } catch (error) {
    console.error('加载兼职列表失败', error)
  }
}

const handleLogout = () => {
  localStorage.removeItem('token')
  localStorage.removeItem('userInfo')
  userInfo.value = null
  ElMessage.success('已退出登录')
  router.push('/login')
}

onMounted(() => {
  loadJobs()
})
</script>

<style scoped>
.jobs-container {
  min-height: 100vh;
  background: #f5f7fa;
}

.el-header {
  background: #fff;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  display: flex;
  align-items: center;
  padding: 0 20px;
}

.header-content {
  width: 100%;
  max-width: 1200px;
  margin: 0 auto;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.logo {
  font-size: 24px;
  font-weight: bold;
  color: #409eff;
  cursor: pointer;
}

.nav {
  display: flex;
  gap: 10px;
  align-items: center;
}

.user-info {
  display: flex;
  align-items: center;
  gap: 10px;
  cursor: pointer;
}

.el-main {
  max-width: 1200px;
  margin: 20px auto;
  padding: 0 20px;
}

.filter-bar {
  background: #fff;
  padding: 20px;
  border-radius: 8px;
  margin-bottom: 20px;
}

.job-list {
  display: grid;
  gap: 15px;
}

.job-card {
  cursor: pointer;
  transition: box-shadow 0.3s;
}

.job-card:hover {
  box-shadow: 0 4px 12px rgba(0,0,0,0.15);
}

.job-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 10px;
}

.job-header h3 {
  margin: 0;
  color: #333;
}

.salary {
  color: #f56c6c;
  font-weight: bold;
  font-size: 18px;
}

.job-info {
  display: flex;
  align-items: center;
  gap: 15px;
  color: #666;
  margin-bottom: 10px;
}

.job-footer {
  display: flex;
  justify-content: space-between;
  color: #999;
  font-size: 14px;
}

.pagination {
  margin-top: 20px;
  text-align: center;
}
</style>
