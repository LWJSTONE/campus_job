<template>
  <div class="home-container">
    <el-container>
      <el-header>
        <div class="header-content">
          <div class="logo">校园兼职平台</div>
          <div class="nav">
            <el-button type="primary" @click="$router.push('/login')">登录</el-button>
            <el-button @click="$router.push('/register')">注册</el-button>
          </div>
        </div>
      </el-header>
      
      <el-main>
        <div class="banner">
          <h1>欢迎来到校园兼职平台</h1>
          <p>为学生提供优质兼职机会，为企业找到优秀人才</p>
          <el-button type="primary" size="large" @click="$router.push('/jobs')">
            查看兼职岗位
          </el-button>
        </div>
        
        <div class="features">
          <el-row :gutter="20">
            <el-col :span="8">
              <div class="feature-card">
                <el-icon><User /></el-icon>
                <h3>海量岗位</h3>
                <p>精选优质兼职岗位，满足不同需求</p>
              </div>
            </el-col>
            <el-col :span="8">
              <div class="feature-card">
                <el-icon><Shield /></el-icon>
                <h3>安全可靠</h3>
                <p>严格审核企业资质，保障学生权益</p>
              </div>
            </el-col>
            <el-col :span="8">
              <div class="feature-card">
                <el-icon><TrendCharts /></el-icon>
                <h3>智能匹配</h3>
                <p>根据个人情况推荐最合适的岗位</p>
              </div>
            </el-col>
          </el-row>
        </div>
      </el-main>
      
      <el-footer>
        <div class="footer-content">
          <p>&copy; 2024 校园兼职平台 版权所有</p>
        </div>
      </el-footer>
    </el-container>
  </div>
</template>

<script setup lang="ts">
import { User, Shield, TrendCharts } from '@element-plus/icons-vue'
</script>

<style scoped>
.home-container {
  min-height: 100vh;
}

.el-header {
  background: #fff;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 20px;
}

.header-content {
  width: 100%;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.logo {
  font-size: 24px;
  font-weight: bold;
  color: #409eff;
}

.el-main {
  padding: 0;
}

.banner {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: #fff;
  text-align: center;
  padding: 100px 20px;
}

.banner h1 {
  font-size: 48px;
  margin-bottom: 20px;
}

.banner p {
  font-size: 20px;
  margin-bottom: 40px;
  opacity: 0.9;
}

.features {
  padding: 80px 20px;
  max-width: 1200px;
  margin: 0 auto;
}

.feature-card {
  text-align: center;
  padding: 40px;
  background: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 12px rgba(0,0,0,0.1);
  transition: transform 0.3s;
}

.feature-card:hover {
  transform: translateY(-5px);
}

.feature-card .el-icon {
  font-size: 48px;
  color: #409eff;
  margin-bottom: 20px;
}

.feature-card h3 {
  margin-bottom: 10px;
  font-size: 20px;
}

.el-footer {
  background: #333;
  color: #fff;
  text-align: center;
  padding: 20px;
}
</style>
