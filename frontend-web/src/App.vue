<template>
  <div class="app-container">
    <!-- Navigation -->
    <header class="navbar">
      <div class="nav-content">
        <div class="logo">
          <i class="fa-solid fa-plane-up brand-icon"></i>
          <span class="brand-text">tigerair <small>Taiwan</small></span>
        </div>
        <div class="nav-actions">
          <a href="#" class="nav-link">預訂航班</a>
          <a href="#" class="nav-link">管理行程</a>
          <a href="#" class="nav-link">航班動態</a>
          <span class="divider"></span>
          <div class="auth-section">
            <template v-if="token">
              <div class="user-badge">
                <i class="fa-solid fa-circle-check user-icon"></i>
                <span class="user-role">系統管理員</span>
                <button @click="logout" class="icon-btn logout-btn" title="登出">
                  <i class="fa-solid fa-arrow-right-from-bracket"></i>
                </button>
              </div>
            </template>
            <button v-else @click="login" class="btn btn-primary login-btn">
              <i class="fa-solid fa-user-lock"></i> 管理員登入
            </button>
          </div>
        </div>
      </div>
    </header>

    <!-- Hero Section -->
    <section class="hero-section">
      <div class="hero-bg"></div>
      <div class="hero-content">
        <h1 class="hero-title">準備好你的下一趟冒險了嗎？</h1>
        <p class="hero-subtitle">全台最大低成本航空，帶你探索每一個心動的目的地</p>
        
        <!-- Mock Search Bar -->
        <div class="search-widget">
          <div class="search-field">
            <i class="fa-solid fa-location-dot"></i>
            <div class="field-info">
              <label>出發地</label>
              <strong>台北 (TPE)</strong>
            </div>
          </div>
          <div class="exchange-icon">
            <i class="fa-solid fa-arrow-right-arrow-left"></i>
          </div>
          <div class="search-field">
            <i class="fa-solid fa-map-location-dot"></i>
            <div class="field-info">
              <label>目的地</label>
              <input type="text" placeholder="探索世界" class="mock-input"/>
            </div>
          </div>
          <button class="btn btn-search">
            <i class="fa-solid fa-magnifying-glass"></i> 搜尋航班
          </button>
        </div>
      </div>
    </section>

    <!-- Main Content -->
    <main class="main-content">
      <div class="section-header">
        <h2 class="section-title">今日特惠與最新航班</h2>
        <span class="section-badge">Live Updates</span>
      </div>
      
      <!-- Loading State -->
      <div v-if="loading" class="loading-state">
        <div class="spinner"></div>
        <p>正在為您同步最新航班資訊...</p>
      </div>
      
      <!-- Flight Grid -->
      <div class="flight-grid" v-else>
        <div class="flight-card" v-for="flight in flights" :key="flight.id">
          <!-- Card Header -->
          <div class="card-header">
            <div class="flight-meta">
              <img src="https://upload.wikimedia.org/wikipedia/commons/e/e0/Tigerair_Taiwan_logo.svg" alt="logo" class="airline-logo" onerror="this.style.display='none'"/>
              <div class="meta-texts">
                <h4>{{ flight.flight_number }}</h4>
                <span>Tigerair Taiwan</span>
              </div>
            </div>
            <div :class="['status-badge', flight.status === 'On Time' ? 'status-green' : 'status-red']">
              <i :class="flight.status === 'On Time' ? 'fa-solid fa-check-circle' : 'fa-solid fa-triangle-exclamation'"></i>
              {{ flight.status }}
            </div>
          </div>
          
          <!-- Route Info -->
          <div class="route-info">
            <div class="port">
              <h2>{{ flight.origin }}</h2>
              <span class="time">10:30</span>
            </div>
            <div class="flight-path">
              <span class="duration">2h 45m</span>
              <div class="path-line">
                <i class="fa-solid fa-plane"></i>
              </div>
              <span class="type">直飛</span>
            </div>
            <div class="port text-right">
              <h2>{{ flight.destination }}</h2>
              <span class="time">13:15</span>
            </div>
          </div>
          
          <!-- Card Footer -->
          <div class="card-footer">
            <div class="price-box">
              <small>單程起</small>
              <div class="price-val">TWD <span>{{ flight.price.toLocaleString() }}</span></div>
            </div>
            <button class="btn btn-book" @click="book(flight.id)">
              立即預訂 <i class="fa-solid fa-chevron-right arrow-icon"></i>
            </button>
          </div>
        </div>
      </div>
    </main>
    
    <!-- Footer -->
    <footer class="app-footer">
      <div class="footer-content">
        <p>© 2026 Tigerair Taiwan Booking System - Showcase Project</p>
      </div>
    </footer>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'

const flights = ref([])
const loading = ref(true)
const token = ref(localStorage.getItem('token') || '')

const fetchFlights = async () => {
  try {
    const res = await fetch('http://localhost:3000/api/flights')
    const data = await res.json()
    // 預防資料為空
    flights.value = Array.isArray(data) ? data : []
  } catch (error) {
    console.error('API Error', error)
    // 放入假資料供預覽 (如果後端沒開也展示出漂亮的 UI)
    flights.value = [
      { id: 1, flight_number: 'IT230', origin: 'TPE', destination: 'NRT', status: 'On Time', price: 4500 },
      { id: 2, flight_number: 'IT288', origin: 'TPE', destination: 'KIX', status: 'On Time', price: 3800 },
      { id: 3, flight_number: 'IT505', origin: 'TPE', destination: 'DMK', status: 'Delayed', price: 2999 },
    ]
  } finally {
    setTimeout(() => { loading.value = false; }, 800) // 假裝 Loading 展示動畫
  }
}

const login = async () => {
    try {
        const res = await fetch('http://localhost:3000/api/auth/login', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ username: 'admin', password: 'admin123' })
        })
        const data = await res.json()
        if (data.token) {
            token.value = data.token
            localStorage.setItem('token', data.token)
            alert('歡迎回來，系統管理員！Token 已核發。')
        } else {
            // mock success if backend is down for UI showcase
            throw new Error('Fallback')
        }
    } catch(e) {
        // Mock if backend not running
        token.value = "mock_token_for_presentation"
        localStorage.setItem('token', token.value)
        alert('開發環境提示：目前後端可能未啟動，已自動進入 Mock 管理員模式供展示使用。')
    }
}

const logout = () => {
  token.value = ''
  localStorage.removeItem('token')
}

const book = async (id) => {
    if (!token.value) {
        alert('請先於右上角進行管理員登入！')
        return
    }
    try {
        const res = await fetch('http://localhost:3000/api/bookings', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${token.value}`
            },
            body: JSON.stringify({ flightId: id })
        })
        if (!res.ok) throw new Error()
        const data = await res.json()
        alert(data.message)
    } catch(e) {
        alert('✨ 成功加入訂位序列！(Mock 成功訊息)')
    }
}

onMounted(() => {
  fetchFlights()
})
</script>

<style>
/* Global Resets & Fonts */
:root {
  --primary: #f6b000;
  --primary-hover: #df9e00;
  --bg-color: #f8fafc;
  --text-main: #0f172a;
  --text-muted: #64748b;
  --card-bg: #ffffff;
  --radius-lg: 16px;
  --radius-xl: 24px;
}
* {
  box-sizing: border-box;
  font-family: 'Outfit', 'Noto Sans TC', sans-serif;
}
body {
  margin: 0;
  background-color: var(--bg-color);
  color: var(--text-main);
  -webkit-font-smoothing: antialiased;
}

/* Base Buttons */
.btn {
  border: none;
  cursor: pointer;
  border-radius: 8px;
  font-weight: 600;
  transition: all 0.3s ease;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
}
.btn-primary {
  background: var(--text-main);
  color: var(--primary);
  padding: 0.6rem 1.2rem;
}
.btn-primary:hover {
  background: #000;
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(0,0,0,0.15);
}

/* Navbar */
.navbar {
  position: sticky;
  top: 0;
  z-index: 100;
  background: rgba(255, 255, 255, 0.85);
  backdrop-filter: blur(12px);
  border-bottom: 1px solid rgba(0,0,0,0.05);
}
.nav-content {
  max-width: 1200px;
  margin: 0 auto;
  padding: 1rem 2rem;
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.logo {
  display: flex;
  align-items: center;
  gap: 12px;
  font-size: 1.6rem;
  font-weight: 800;
  color: var(--text-main);
}
.brand-icon {
  color: var(--primary);
  transform: rotate(45deg);
  font-size: 1.8rem;
}
.logo small {
  font-size: 0.9rem;
  font-weight: 600;
  color: var(--text-muted);
}
.nav-actions {
  display: flex;
  align-items: center;
  gap: 24px;
}
.nav-link {
  text-decoration: none;
  color: var(--text-main);
  font-weight: 500;
  font-size: 0.95rem;
  transition: color 0.2s;
}
.nav-link:hover {
  color: var(--primary-hover);
}
.divider {
  width: 1px;
  height: 24px;
  background: #e2e8f0;
}
.user-badge {
  display: flex;
  align-items: center;
  gap: 10px;
  background: #ecfdf5;
  color: #059669;
  padding: 0.4rem 1rem;
  border-radius: 20px;
  font-weight: 600;
  font-size: 0.9rem;
}
.icon-btn {
  background: transparent;
  border: none;
  color: currentColor;
  cursor: pointer;
  padding: 4px;
  opacity: 0.6;
  transition: opacity 0.2s;
}
.icon-btn:hover { opacity: 1; }

/* Hero Section */
.hero-section {
  position: relative;
  padding: 5rem 2rem;
  display: flex;
  justify-content: center;
  overflow: hidden;
  background: var(--text-main);
}
.hero-bg {
  position: absolute;
  top: 0; left: 0; right: 0; bottom: 0;
  background: linear-gradient(135deg, rgba(15,23,42,0.95) 0%, rgba(15,23,42,0.8) 100%),
              url('https://images.unsplash.com/photo-1436491865332-7a61a109cc05?q=80&w=2000&auto=format&fit=crop');
  background-size: cover;
  background-position: center;
  z-index: 1;
}
.hero-content {
  position: relative;
  z-index: 2;
  text-align: center;
  max-width: 900px;
  width: 100%;
}
.hero-title {
  color: #fff;
  font-size: 3.5rem;
  font-weight: 800;
  margin-bottom: 1rem;
  line-height: 1.2;
}
.hero-subtitle {
  color: #cbd5e1;
  font-size: 1.25rem;
  margin-bottom: 3rem;
}

/* Search Widget */
.search-widget {
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(20px);
  padding: 1.2rem;
  border-radius: var(--radius-xl);
  display: flex;
  align-items: center;
  gap: 16px;
  box-shadow: 0 20px 40px rgba(0,0,0,0.2);
}
.search-field {
  flex: 1;
  display: flex;
  align-items: center;
  gap: 16px;
  padding: 0.8rem 1.2rem;
  background: #f1f5f9;
  border-radius: 16px;
  transition: background 0.3s;
}
.search-field:hover {
  background: #e2e8f0;
}
.search-field i {
  font-size: 1.4rem;
  color: var(--text-muted);
}
.field-info {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
}
.field-info label {
  font-size: 0.75rem;
  color: var(--text-muted);
  font-weight: 600;
  text-transform: uppercase;
  margin-bottom: 4px;
}
.field-info strong {
  font-size: 1.2rem;
  color: var(--text-main);
  font-weight: 800;
}
.mock-input {
  border: none;
  background: transparent;
  font-size: 1.2rem;
  font-weight: 800;
  color: var(--text-main);
  outline: none;
  width: 100%;
}
.mock-input::placeholder {
  color: #94a3b8;
}
.exchange-icon {
  background: white;
  width: 40px;
  height: 40px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: var(--primary);
  box-shadow: 0 4px 10px rgba(0,0,0,0.08);
  cursor: pointer;
  transition: transform 0.3s;
}
.exchange-icon:hover { transform: rotate(180deg); }
.btn-search {
  background: var(--primary);
  color: var(--text-main);
  padding: 0 2rem;
  height: 64px;
  border-radius: 16px;
  font-size: 1.1rem;
}
.btn-search:hover {
  background: var(--primary-hover);
}

/* Main Content */
.main-content {
  max-width: 1200px;
  margin: 0 auto;
  padding: 4rem 2rem;
}
.section-header {
  display: flex;
  align-items: center;
  gap: 16px;
  margin-bottom: 2rem;
}
.section-title {
  font-size: 1.8rem;
  font-weight: 800;
  margin: 0;
}
.section-badge {
  background: #fee2e2;
  color: #dc2626;
  padding: 4px 12px;
  border-radius: 12px;
  font-size: 0.8rem;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 1px;
}

/* Loading State */
.loading-state {
  text-align: center;
  padding: 4rem 0;
  color: var(--text-muted);
}
.spinner {
  width: 40px;
  height: 40px;
  border: 4px solid #f1f5f9;
  border-top: 4px solid var(--primary);
  border-radius: 50%;
  margin: 0 auto 1rem;
  animation: spin 1s linear infinite;
}
@keyframes spin { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }

/* Flight Grid */
.flight-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
  gap: 24px;
}
.flight-card {
  background: var(--card-bg);
  border-radius: var(--radius-xl);
  padding: 1.8rem;
  box-shadow: 0 10px 30px rgba(0,0,0,0.03);
  transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
  border: 1px solid rgba(0,0,0,0.04);
  position: relative;
  overflow: hidden;
}
.flight-card::before {
  content: '';
  position: absolute;
  top: 0; left: 0; width: 4px; height: 100%;
  background: var(--primary);
  opacity: 0;
  transition: opacity 0.3s;
}
.flight-card:hover {
  transform: translateY(-8px);
  box-shadow: 0 20px 40px rgba(0,0,0,0.08);
}
.flight-card:hover::before { opacity: 1; }

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 1.5rem;
}
.flight-meta {
  display: flex;
  align-items: center;
  gap: 12px;
}
.airline-logo {
  height: 24px;
}
.meta-texts h4 {
  margin: 0;
  font-size: 1.2rem;
  font-weight: 800;
}
.meta-texts span {
  font-size: 0.8rem;
  color: var(--text-muted);
}
.status-badge {
  display: flex;
  align-items: center;
  gap: 6px;
  padding: 4px 10px;
  border-radius: 12px;
  font-size: 0.75rem;
  font-weight: 700;
  text-transform: uppercase;
}
.status-green { background: #dcfce7; color: #15803d; }
.status-red { background: #fee2e2; color: #b91c1c; }

.route-info {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 2rem;
  background: #f8fafc;
  padding: 1.2rem;
  border-radius: 16px;
}
.port h2 {
  margin: 0 0 4px 0;
  font-size: 2rem;
  font-weight: 800;
  color: var(--text-main);
  letter-spacing: -1px;
}
.port .time {
  font-size: 0.9rem;
  color: var(--text-muted);
  font-weight: 500;
}
.text-right { text-align: right; }
.flight-path {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 0 1rem;
}
.duration {
  font-size: 0.75rem;
  color: var(--text-muted);
  font-weight: 600;
  margin-bottom: 4px;
}
.path-line {
  width: 100%;
  height: 2px;
  background: linear-gradient(90deg, transparent, #cbd5e1, transparent);
  position: relative;
  display: flex;
  justify-content: center;
  align-items: center;
}
.path-line i {
  color: var(--primary);
  font-size: 1.2rem;
}
.type {
  font-size: 0.75rem;
  color: var(--primary);
  font-weight: 700;
  margin-top: 4px;
  background: rgba(246, 176, 0, 0.1);
  padding: 2px 8px;
  border-radius: 8px;
}

.card-footer {
  display: flex;
  justify-content: space-between;
  align-items: flex-end;
  border-top: 1px dashed #e2e8f0;
  padding-top: 1.5rem;
}
.price-box small {
  display: block;
  font-size: 0.8rem;
  color: var(--text-muted);
  font-weight: 500;
  margin-bottom: 4px;
}
.price-val {
  font-size: 1rem;
  color: var(--text-main);
  font-weight: 600;
}
.price-val span {
  font-size: 1.8rem;
  font-weight: 900;
  color: #ef4444;
}
.btn-book {
  background: #1e293b;
  color: #fff;
  padding: 0.8rem 1.4rem;
}
.btn-book:hover {
  background: var(--primary);
  color: #000;
}
.btn-book .arrow-icon {
  transition: transform 0.2s;
}
.btn-book:hover .arrow-icon {
  transform: translateX(4px);
}

/* Footer */
.app-footer {
  background: #0f172a;
  color: #94a3b8;
  padding: 2rem;
  text-align: center;
  margin-top: 4rem;
}
.footer-content {
  font-size: 0.9rem;
}

/* Responsive */
@media (max-width: 768px) {
  .hero-title { font-size: 2.5rem; }
  .search-widget { flex-direction: column; }
  .exchange-icon { transform: rotate(90px); margin: -10px 0; z-index: 10; }
  .exchange-icon:hover { transform: rotate(90deg) scale(1.1); }
  .btn-search { width: 100%; }
}
</style>
