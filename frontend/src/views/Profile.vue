<template>
  <div class="profile-container">
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
        <el-card class="profile-card">
          <template #header>
            <div class="card-header">
              <span>个人中心</span>
              <el-button type="primary" @click="editDialogVisible = true">
                编辑资料
              </el-button>
            </div>
          </template>
          
          <div class="profile-info">
            <el-row :gutter="40">
              <el-col :span="8">
                <div class="avatar-section">
                  <el-avatar :size="120" :src="userInfo?.avatar">
                    {{ userInfo?.realName?.[0] }}
                  </el-avatar>
                </div>
              </el-col>
              <el-col :span="16">
                <div class="info-list">
                  <div class="info-item">
                    <span class="label">用户名：</span>
                    <span>{{ userInfo?.username }}</span>
                  </div>
                  <div class="info-item">
                    <span class="label">真实姓名：</span>
                    <span>{{ userInfo?.realName }}</span>
                  </div>
                  <div class="info-item">
                    <span class="label">用户类型：</span>
                    <el-tag>{{ userInfo?.userType === 0 ? '学生' : '企业' }}</el-tag>
                  </div>
                  <div class="info-item">
                    <span class="label">手机号：</span>
                    <span>{{ userInfo?.phone }}</span>
                  </div>
                  <div class="info-item">
                    <span class="label">邮箱：</span>
                    <span>{{ userInfo?.email }}</span>
                  </div>
                  <div class="info-item" v-if="userInfo?.userType === 0">
                    <span class="label">学校：</span>
                    <span>{{ userInfo?.school }}</span>
                  </div>
                  <div class="info-item" v-if="userInfo?.userType === 0">
                    <span class="label">专业：</span>
                    <span>{{ userInfo?.major }}</span>
                  </div>
                  <div class="info-item" v-if="userInfo?.userType === 0">
                    <span class="label">年级：</span>
                    <span>{{ userInfo?.grade }}</span>
                  </div>
                  <div class="info-item" v-if="userInfo?.userType === 1">
                    <span class="label">公司：</span>
                    <span>{{ userInfo?.company }}</span>
                  </div>
                </div>
              </el-col>
            </el-row>
          </div>
        </el-card>
      </el-main>
    </el-container>
    
    <!-- 编辑对话框 -->
    <el-dialog v-model="editDialogVisible" title="编辑资料" width="500px">
      <el-form :model="editForm" label-width="100px">
        <el-form-item label="真实姓名">
          <el-input v-model="editForm.realName" />
        </el-form-item>
        <el-form-item label="手机号">
          <el-input v-model="editForm.phone" />
        </el-form-item>
        <el-form-item label="邮箱">
          <el-input v-model="editForm.email" />
        </el-form-item>
        <el-form-item label="学校" v-if="userInfo?.userType === 0">
          <el-input v-model="editForm.school" />
        </el-form-item>
        <el-form-item label="专业" v-if="userInfo?.userType === 0">
          <el-input v-model="editForm.major" />
        </el-form-item>
        <el-form-item label="年级" v-if="userInfo?.userType === 0">
          <el-input v-model="editForm.grade" />
        </el-form-item>
        <el-form-item label="公司" v-if="userInfo?.userType === 1">
          <el-input v-model="editForm.company" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="editDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="handleUpdate">保存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'

const router = useRouter()

const userInfo = ref(JSON.parse(localStorage.getItem('userInfo') || 'null'))
const editDialogVisible = ref(false)

const editForm = reactive({
  realName: '',
  phone: '',
  email: '',
  school: '',
  major: '',
  grade: '',
  company: ''
})

onMounted(() => {
  if (!userInfo.value) {
    router.push('/login')
    return
  }
  
  editForm.realName = userInfo.value.realName || ''
  editForm.phone = userInfo.value.phone || ''
  editForm.email = userInfo.value.email || ''
  editForm.school = userInfo.value.school || ''
  editForm.major = userInfo.value.major || ''
  editForm.grade = userInfo.value.grade || ''
  editForm.company = userInfo.value.company || ''
})

const handleUpdate = () => {
  ElMessage.success('资料更新成功')
  editDialogVisible.value = false
}
</script>

<style scoped>
.profile-container {
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
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.avatar-section {
  text-align: center;
  padding: 20px;
}

.info-list {
  padding: 20px 0;
}

.info-item {
  margin-bottom: 20px;
  color: #666;
  font-size: 16px;
}

.info-item .label {
  color: #999;
  margin-right: 10px;
  display: inline-block;
  width: 100px;
}
</style>
