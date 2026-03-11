<div align="center">
  <img src="https://upload.wikimedia.org/wikipedia/commons/e/e0/Tigerair_Taiwan_logo.svg" alt="Tigerair Taiwan Logo" width="300"/>

  # ✈️ Taiwan Tigerair | Modern Flight Booking System

  **A Premium, Full-Stack Flight Booking SPA & Cross-Platform Application Concept**  
  *Specially designed and developed for the "Web & Mobile Application Specialist" position at Tigerair Taiwan.*
  
  [![Vue.js](https://img.shields.io/badge/Vue.js-3.0-4FC08D?style=for-the-badge&logo=vue.js)](https://vuejs.org/)
  [![Node.js](https://img.shields.io/badge/Node.js-Backend-339933?style=for-the-badge&logo=node.js)](https://nodejs.org/)
  [![Flutter](https://img.shields.io/badge/Flutter-Mobile-02569B?style=for-the-badge&logo=flutter)](https://flutter.dev/)
  [![UI/UX](https://img.shields.io/badge/UI/UX-Glassmorphism-f6b000?style=for-the-badge)](#)
</div>

---

## 🌟 專案亮點 (Project Highlights)

本專案是為展現對 **台灣虎航 (Tigerair Taiwan)** 品牌的高黏著度與技術熱忱所打造的全端系統展示原型。
結合了現代化 Web 開發體驗、極致的視覺設計以及穩健的 API 基礎架構。

- 🎨 **頂級視覺與 UX 體驗**：導入 Glassmorphism (玻璃擬態) 設計，配合虎航專屬黃黑配色，實作流暢的微互動動畫與懸停效果。
- ⚡ **前後端分離架構**：前端使用 `Vue.js` (Vite) 打造 SPA 單頁應用；後端使用 `Node.js + Express` 提供 RESTful API，並實作 JWT 身分驗證機制。
- 📱 **跨平台行動端 (Flutter)**：具備 Flutter / Dart 的移動端開發基礎設施，展現一端多用的跨平台系統建置能力。
- 🛠 **高併發與壓力測試**：內建 Artillery 腳本 (`load-test.yml`)，模擬搶票時段的高併發連線情境。

---

## 📸 介面預覽 (UI Preview)

*(可於本地啟動前端伺服器進行完整的美感互動體驗，支援無後端 Mock 模式展示)*

<div align="center">
  <img src="https://images.unsplash.com/photo-1436491865332-7a61a109cc05?q=80&w=1000&auto=format&fit=crop" width="100%" alt="Hero Image Preview" style="border-radius: 12px; margin-bottom: 20px;" />
  <p><i>▲ 具備現代感的高質感橫幅背景與搜尋元件，提供直覺的訂位操作體驗。</i></p>
</div>

---

## 🛠 技術棧 (Tech Stack)

### Frontend (Web)
- **Framework**: `Vue.js 3` (Composition API)
- **Build Tool**: `Vite` (極速開發啟動)
- **Styling**: Vanilla CSS3, CSS Variables, Glassmorphism UI
- **Typography & Icons**: Google Fonts (Outfit, Noto Sans TC), FontAwesome 6

### Backend (API)
- **Runtime**: `Node.js`
- **Framework**: `Express.js`
- **Database**: `MySQL` (支援無資料庫 Mock 模式)
- **Security & Testing**: `JWT` (JSON Web Tokens) Auth, `Artillery` Load Testing

### Mobile (Cross-Platform)
- **Framework**: `Flutter`
- **Language**: `Dart`

---

## 🚀 快速啟動 (Quick Start)

### 1. 啟動絕美前端 (Vue.js)
只需三步，即可在本地預覽這個充滿設計感的航班介面：
```bash
# 進入前端目錄
cd frontend-web

# 安裝相依套件
npm install

# 啟動開發伺服器
npm run dev
```
> 預設運行於 `http://localhost:5173/`。即使沒有啟動後端，畫面仍會自動載入高質感的預設 Mock 資料庫供您預覽全貌。

### 2. 啟動後端 API (Node.js)
```bash
# 進入後端目錄
cd backend

# 安裝套件並啟動伺服器
npm install
npm start
```
> 後端運行於 `http://localhost:3000/`，實作了航班查詢、登入核發 JWT Token 以及模擬的安全訂位 API。

---

## 🧠 給招募主管的話

您好，我是**陳羿良**。

這個專案是我帶著對貴公司「Web & Mobile Application Specialist」職缺的極大熱情所實作的。從深色質感的玻璃面板設計，到模擬安全憑證的 API 連線與架構，我都盡力詮釋我能為虎航帶來的價值。

我擁有強烈的極客精神與解決問題的能力。希望能有機會進入面試階段，向您詳細報告我的學習歷程與技術發展潛力！

<div align="center">
  <br/>
  <b>Made with 💛 for Tigerair Taiwan</b>
</div>
