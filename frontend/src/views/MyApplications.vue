<template>
  <div class="my-applications-container">
    <el-container>
      <el-header>
        <div class="header-content">
          <div class="logo" @click="$router.push('/')">校园兼职平台</div>
          <div class="nav">
            <el-button @click="$router.back()">返回</el-button>
          </div>
        </div>
      </el-header>
      
      <el-main>
        <el-card>
          <template #header>
            <div class="card-header">
              <span>我的申请</span>
            </div>
          </template>
          
          <el-table :data="applicationList" style="width: 100%" v-loading="loading">
            <el-table-column prop="jobTitle" label="职位名称" width="200" />
            <el-table-column prop="companyName" label="公司名称" width="200" />
            <el-table-column prop="resume" label="简历内容" show-overflow-tooltip />
            <el-table-column prop="status" label="状态" width="120">
              <template #default="{ row }">
                <el-tag v-if="row.status === 0" type="warning">待审核</el-tag>
                <el-tag v-else-if="row.status === 1" type="success">已通过</el-tag>
                <el-tag v-else-if="row.status === 2" type="danger">已拒绝</el-tag>
              </template>
            </el-table-column>
            <el-table-column prop="applyTime" label="申请时间" width="180">
              <template #default="{ row }">
                {{ formatDate(row.applyTime) }}
              </template>
            </el-table-column>
            <el-table-column prop="reviewComment" label="审核意见" show-overflow-tooltip />
            <el-table-column label="操作" width="120" fixed="right">
              <template #default="{ row }">
                <el-button link type="primary" @click="viewJobDetail(row.jobId)">
                  查看职位
                </el-button>
              </template>
            </el-table-column>
          </el-table>
          
          <el-empty v-if="!loading && applicationList.length === 0" description="暂无申请记录" />
        </el-card>
      </el-main>
    </el-container>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { getMyApplications } from '../api'

const router = useRouter()

const applicationList = ref<any[]>([])
const loading = ref(false)

const formatDate = (date: string) => {
  return new Date(date).toLocaleString()
}

const loadApplications = async () => {
  loading.value = true
  try {
    const data = await getMyApplications()
    applicationList.value = data || []
  } catch (error) {
    console.error('加载申请列表失败', error)
    ElMessage.error('加载失败')
  } finally {
    loading.value = false
  }
}

const viewJobDetail = (jobId: number) => {
  router.push(`/job/${jobId}`)
}

onMounted(() => {
  loadApplications()
})
</script>

<style scoped>
.my-applications-container {
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

.el-main {
  max-width: 1200px;
  margin: 20px auto;
  padding: 0 20px;
}

.card-header {
  font-size: 18px;
  font-weight: bold;
}
</style>
