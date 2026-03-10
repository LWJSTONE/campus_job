<template>
  <div class="job-detail-container">
    <el-container>
      <el-header>
        <div class="header-content">
          <div class="logo" @click="$router.push('/')">校园兼职平台</div>
          <div class="nav">
            <el-button @click="$router.back()">返回</el-button>
          </div>
        </div>
      </el-header>
      
      <el-main v-if="jobDetail">
        <el-card class="detail-card">
          <div class="job-header">
            <h1>{{ jobDetail.title }}</h1>
            <div class="salary">{{ formatSalary(jobDetail) }}</div>
          </div>
          
          <el-divider />
          
          <div class="job-info">
            <el-row :gutter="20">
              <el-col :span="8">
                <div class="info-item">
                  <span class="label">公司：</span>
                  <span>{{ jobDetail.companyName }}</span>
                </div>
              </el-col>
              <el-col :span="8">
                <div class="info-item">
                  <span class="label">工作类型：</span>
                  <el-tag size="small">{{ jobDetail.workType === 0 ? '线上' : '线下' }}</el-tag>
                </div>
              </el-col>
              <el-col :span="8">
                <div class="info-item">
                  <span class="label">招聘人数：</span>
                  <span>{{ jobDetail.recruitCount }}人</span>
                </div>
              </el-col>
            </el-row>
            
            <el-row :gutter="20" style="margin-top: 20px">
              <el-col :span="8">
                <div class="info-item">
                  <span class="label">工作地点：</span>
                  <span>{{ jobDetail.location }}</span>
                </div>
              </el-col>
              <el-col :span="8">
                <div class="info-item">
                  <span class="label">工作时间：</span>
                  <span>{{ jobDetail.workTime }}</span>
                </div>
              </el-col>
              <el-col :span="8">
                <div class="info-item">
                  <span class="label">发布时间：</span>
                  <span>{{ formatDate(jobDetail.createTime) }}</span>
                </div>
              </el-col>
            </el-row>
          </div>
          
          <el-divider />
          
          <div class="job-description">
            <h2>职位描述</h2>
            <p>{{ jobDetail.description }}</p>
          </div>
          
          <div class="job-requirements">
            <h2>职位要求</h2>
            <p>{{ jobDetail.requirements }}</p>
          </div>
          
          <el-divider />
          
          <div class="job-contact">
            <h2>联系方式</h2>
            <p><span class="label">电话：</span>{{ jobDetail.companyPhone }}</p>
            <p><span class="label">邮箱：</span>{{ jobDetail.companyEmail }}</p>
          </div>
          
          <div class="apply-section">
            <el-button type="primary" size="large" @click="showApplyDialog" v-if="!hasApplied">
              申请该职位
            </el-button>
            <el-button size="large" disabled v-else>
              已申请
            </el-button>
          </div>
        </el-card>
      </el-main>
      
      <el-main v-else>
        <el-empty description="加载中..." />
      </el-main>
    </el-container>
    
    <!-- 申请对话框 -->
    <el-dialog v-model="applyDialogVisible" title="申请职位" width="500px">
      <el-form :model="applyForm" :rules="applyRules" ref="applyFormRef">
        <el-form-item label="个人简历" prop="resume">
          <el-input 
            v-model="applyForm.resume" 
            type="textarea" 
            :rows="6"
            placeholder="请简述您的个人情况和相关经验"
          />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="applyDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="handleApply">提交申请</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { getJobDetail, applyJob } from '../api'

const route = useRoute()
const router = useRouter()

const jobDetail = ref<any>(null)
const hasApplied = ref(false)
const applyDialogVisible = ref(false)
const applyFormRef = ref()

const applyForm = reactive({
  jobId: 0,
  resume: ''
})

const applyRules = {
  resume: [{ required: true, message: '请填写个人简历', trigger: 'blur' }]
}

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

const loadJobDetail = async () => {
  try {
    const id = Number(route.params.id)
    jobDetail.value = await getJobDetail(id)
    applyForm.jobId = id
  } catch (error) {
    console.error('加载职位详情失败', error)
    ElMessage.error('加载失败')
  }
}

const showApplyDialog = () => {
  const userInfo = JSON.parse(localStorage.getItem('userInfo') || 'null')
  if (!userInfo) {
    ElMessage.warning('请先登录')
    router.push('/login')
    return
  }
  if (userInfo.userType !== 0) {
    ElMessage.warning('只有学生可以申请职位')
    return
  }
  applyDialogVisible.value = true
}

const handleApply = async () => {
  try {
    await applyFormRef.value.validate()
    await applyJob(applyForm)
    ElMessage.success('申请成功')
    hasApplied.value = true
    applyDialogVisible.value = false
  } catch (error) {
    console.error('申请失败', error)
  }
}

onMounted(() => {
  loadJobDetail()
})
</script>

<style scoped>
.job-detail-container {
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

.detail-card {
  padding: 30px;
}

.job-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.job-header h1 {
  margin: 0;
  color: #333;
}

.salary {
  color: #f56c6c;
  font-weight: bold;
  font-size: 32px;
}

.job-info .info-item {
  margin-bottom: 15px;
  color: #666;
}

.job-info .label {
  color: #999;
  margin-right: 5px;
}

.job-description,
.job-requirements,
.job-contact {
  margin: 30px 0;
}

.job-description h2,
.job-requirements h2,
.job-contact h2 {
  color: #333;
  margin-bottom: 15px;
}

.job-description p,
.job-requirements p,
.job-contact p {
  color: #666;
  line-height: 1.8;
  margin: 10px 0;
}

.job-contact .label {
  color: #999;
  margin-right: 5px;
}

.apply-section {
  margin-top: 40px;
  text-align: center;
}
</style>
