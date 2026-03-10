<template>
  <div class="post-job-container">
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
        <el-card class="post-job-card">
          <template #header>
            <div class="card-header">
              <span>发布兼职</span>
            </div>
          </template>
          
          <el-form :model="jobForm" :rules="rules" ref="formRef" label-width="120px">
            <el-form-item label="职位名称" prop="title">
              <el-input v-model="jobForm.title" placeholder="请输入职位名称" />
            </el-form-item>
            
            <el-form-item label="职位描述" prop="description">
              <el-input 
                v-model="jobForm.description" 
                type="textarea" 
                :rows="4"
                placeholder="请详细描述职位内容、工作职责等"
              />
            </el-form-item>
            
            <el-form-item label="工作地点" prop="location">
              <el-input v-model="jobForm.location" placeholder="请输入工作地点" />
            </el-form-item>
            
            <el-form-item label="工作类型" prop="workType">
              <el-radio-group v-model="jobForm.workType">
                <el-radio :label="0">线上</el-radio>
                <el-radio :label="1">线下</el-radio>
              </el-radio-group>
            </el-form-item>
            
            <el-form-item label="薪资类型" prop="salaryType">
              <el-select v-model="jobForm.salaryType" placeholder="请选择薪资类型">
                <el-option label="时薪" :value="0" />
                <el-option label="日薪" :value="1" />
                <el-option label="月薪" :value="2" />
                <el-option label="面议" :value="3" />
              </el-select>
            </el-form-item>
            
            <el-form-item label="薪资金额" prop="salary" v-if="jobForm.salaryType !== 3">
              <el-input-number 
                v-model="jobForm.salary" 
                :min="0" 
                :precision="2"
                :step="10"
                controls-position="right"
              />
              <span style="margin-left: 10px">元</span>
            </el-form-item>
            
            <el-form-item label="工作时间" prop="workTime">
              <el-input 
                v-model="jobForm.workTime" 
                placeholder="例如：周一至周五 9:00-18:00"
              />
            </el-form-item>
            
            <el-form-item label="招聘人数" prop="recruitCount">
              <el-input-number 
                v-model="jobForm.recruitCount" 
                :min="1" 
                :max="100"
                controls-position="right"
              />
            </el-form-item>
            
            <el-form-item label="职位要求" prop="requirements">
              <el-input 
                v-model="jobForm.requirements" 
                type="textarea" 
                :rows="4"
                placeholder="请输入对申请者的要求"
              />
            </el-form-item>
            
            <el-form-item>
              <el-button type="primary" @click="handleSubmit" :loading="submitting">
                提交发布
              </el-button>
              <el-button @click="$router.back()">取消</el-button>
            </el-form-item>
          </el-form>
        </el-card>
      </el-main>
    </el-container>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { postJob } from '../api'

const router = useRouter()
const formRef = ref()
const submitting = ref(false)

const jobForm = reactive({
  title: '',
  description: '',
  location: '',
  workType: 1,
  salaryType: 0,
  salary: 0,
  workTime: '',
  recruitCount: 1,
  requirements: ''
})

const rules = {
  title: [{ required: true, message: '请输入职位名称', trigger: 'blur' }],
  description: [{ required: true, message: '请输入职位描述', trigger: 'blur' }],
  location: [{ required: true, message: '请输入工作地点', trigger: 'blur' }],
  workType: [{ required: true, message: '请选择工作类型', trigger: 'change' }],
  salaryType: [{ required: true, message: '请选择薪资类型', trigger: 'change' }],
  salary: [{ required: true, message: '请输入薪资金额', trigger: 'blur' }],
  workTime: [{ required: true, message: '请输入工作时间', trigger: 'blur' }],
  recruitCount: [{ required: true, message: '请输入招聘人数', trigger: 'blur' }],
  requirements: [{ required: true, message: '请输入职位要求', trigger: 'blur' }]
}

const handleSubmit = async () => {
  try {
    await formRef.value.validate()
    submitting.value = true
    await postJob(jobForm)
    ElMessage.success('发布成功，请等待审核')
    router.push('/jobs')
  } catch (error) {
    console.error('发布失败', error)
  } finally {
    submitting.value = false
  }
}

onMounted(() => {
  const userInfo = JSON.parse(localStorage.getItem('userInfo') || 'null')
  if (!userInfo) {
    ElMessage.warning('请先登录')
    router.push('/login')
    return
  }
  if (userInfo.userType !== 1) {
    ElMessage.warning('只有企业用户可以发布兼职')
    router.push('/')
    return
  }
})
</script>

<style scoped>
.post-job-container {
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
  max-width: 1000px;
  margin: 20px auto;
  padding: 0 20px;
}

.card-header {
  font-size: 18px;
  font-weight: bold;
}

.post-job-card {
  padding: 20px;
}
</style>
