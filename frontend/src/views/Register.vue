<template>
  <div class="register-container">
    <el-card class="register-card">
      <h2>用户注册</h2>
      <el-form :model="registerForm" :rules="rules" ref="formRef">
        <el-form-item prop="username">
          <el-input 
            v-model="registerForm.username" 
            placeholder="请输入用户名"
            prefix-icon="User"
          />
        </el-form-item>
        <el-form-item prop="password">
          <el-input 
            v-model="registerForm.password" 
            type="password" 
            placeholder="请输入密码"
            prefix-icon="Lock"
            show-password
          />
        </el-form-item>
        <el-form-item prop="confirmPassword">
          <el-input 
            v-model="registerForm.confirmPassword" 
            type="password" 
            placeholder="请确认密码"
            prefix-icon="Lock"
            show-password
          />
        </el-form-item>
        <el-form-item prop="userType">
          <el-radio-group v-model="registerForm.userType">
            <el-radio :label="0">学生</el-radio>
            <el-radio :label="1">企业</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item v-if="registerForm.userType === 0" prop="realName">
          <el-input v-model="registerForm.realName" placeholder="请输入真实姓名" />
        </el-form-item>
        <el-form-item v-if="registerForm.userType === 0" prop="school">
          <el-input v-model="registerForm.school" placeholder="请输入学校名称" />
        </el-form-item>
        <el-form-item v-if="registerForm.userType === 1" prop="company">
          <el-input v-model="registerForm.company" placeholder="请输入公司名称" />
        </el-form-item>
        <el-form-item prop="phone">
          <el-input 
            v-model="registerForm.phone" 
            placeholder="请输入手机号"
            prefix-icon="Phone"
          />
        </el-form-item>
        <el-form-item prop="email">
          <el-input 
            v-model="registerForm.email" 
            placeholder="请输入邮箱"
            prefix-icon="Message"
          />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleRegister" style="width: 100%">
            注册
          </el-button>
        </el-form-item>
      </el-form>
      <div class="footer">
        已有账号？<el-link type="primary" @click="$router.push('/login')">立即登录</el-link>
      </div>
    </el-card>
  </div>
</template>

<script setup lang="ts">
import { reactive, ref } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { register } from '../api'

const router = useRouter()
const formRef = ref()

const registerForm = reactive({
  username: '',
  password: '',
  confirmPassword: '',
  userType: 0,
  realName: '',
  school: '',
  company: '',
  phone: '',
  email: ''
})

const validatePassword = (rule: any, value: any, callback: any) => {
  if (value !== registerForm.password) {
    callback(new Error('两次输入密码不一致'))
  } else {
    callback()
  }
}

const rules = {
  username: [{ required: true, message: '请输入用户名', trigger: 'blur' }],
  password: [
    { required: true, message: '请输入密码', trigger: 'blur' },
    { min: 6, message: '密码长度不能少于6位', trigger: 'blur' }
  ],
  confirmPassword: [
    { required: true, message: '请确认密码', trigger: 'blur' },
    { validator: validatePassword, trigger: 'blur' }
  ],
  userType: [{ required: true, message: '请选择用户类型', trigger: 'change' }],
  realName: [{ required: true, message: '请输入真实姓名', trigger: 'blur' }],
  school: [{ required: true, message: '请输入学校名称', trigger: 'blur' }],
  company: [{ required: true, message: '请输入公司名称', trigger: 'blur' }],
  phone: [
    { required: true, message: '请输入手机号', trigger: 'blur' },
    { pattern: /^1[3-9]\d{9}$/, message: '请输入正确的手机号', trigger: 'blur' }
  ],
  email: [
    { required: true, message: '请输入邮箱', trigger: 'blur' },
    { type: 'email', message: '请输入正确的邮箱地址', trigger: 'blur' }
  ]
}

const handleRegister = async () => {
  try {
    await formRef.value.validate()
    await register(registerForm)
    ElMessage.success('注册成功，请登录')
    router.push('/login')
  } catch (error) {
    console.error('注册失败', error)
  }
}
</script>

<style scoped>
.register-container {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  padding: 20px;
}

.register-card {
  width: 450px;
  padding: 20px;
}

.register-card h2 {
  text-align: center;
  margin-bottom: 30px;
  color: #333;
}

.footer {
  text-align: center;
  margin-top: 20px;
  color: #666;
}
</style>
