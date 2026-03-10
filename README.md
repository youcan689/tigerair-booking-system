# 台灣虎航 Tigerair - 全端訂票微型系統 (GitHub 作品集用)

這是一個完整對應「網頁與 APP 開發」職缺技術棧的示範專案。包含 Node.js 後端 API、Vue.js 響應式前端、Flutter 跨平台手機 App、以及 GitHub Actions CI/CD 流程。

## 📁 專案架構

```text
tigerair-booking-system/
│
├── backend/                  # 後端 (Node.js + Express + JWT)
│   ├── src/server.js         # API 進入點與路由
│   ├── src/config/db.js      # MySQL 連線設定
│   ├── load-test.yml         # Artillery 壓力測試設定檔
│   └── package.json          
│
├── frontend-web/             # 網頁端 (Vue.js 3 + Vite)
│   ├── src/App.vue           # 響應式 UI 元件
│   ├── src/main.js           
│   └── package.json          
│
├── frontend-app/             # 行動端 (Flutter + Dart)
│   ├── lib/main.dart         # iOS / Android 共用 UI 介面
│   └── pubspec.yaml          
│
└── .github/workflows/        # CI/CD (GitHub Actions)
    └── ci.yml
```

---

## 🚀 步驟教戰指引 (Tutorial)

身為有 Java 背景的開發者，跟著這份攻略就能將這個專案啟動！

### 第一步：啟動後端 API (Node.js)
1. 開啟終端機 (Terminal / CMD)。
2. 進入後端資料夾：`cd backend`。
3. (**第一次需執行**) 安裝套件（同 Maven）：`npm install`。
4. 啟動伺服器：`npm start` 或 `node src/server.js`。
5. *成功後，後端會在 `http://localhost:3000` 運行，提供認證與航班 API。*

*(備註：為了讓你順利跑起來，後端的 `server.js` 裡已經把 MySQL 的邏輯註解掉並提供模擬的 JSON 資料。如果你後續打算接上資料庫，請編輯 `.env` 及 `src/server.js`)*

### 第二步：啟動響應式網頁前端 (Vue.js)
1. 開啟 **另外一個** 終端機視窗。
2. 進入前端資料夾：`cd frontend-web`。
3. (**第一次需執行**) 安裝套件：`npm install`。
4. 啟動 Vue 開發測試伺服器：`npm run dev`。
5. *成功後，終端機會顯示一個網址 (例如 `http://localhost:5173`)，點擊即可開啟虎航的訂票網頁版！你可以嘗試縮放瀏覽器視窗，看看它怎麼自動變成手機排版 (響應式)*。

### 第三步：開啟手機端 App (Flutter)
如果你電腦上有安裝 Flutter SDK 與手機模擬器：
1. 進入 App 資料夾：`cd frontend-app`。
2. 下載依賴套件：`flutter pub get`。
3. 執行 App：`flutter run`。
4. *它會跑在你的 Android 或 iOS 模擬器上。Dart 程式碼幾乎跟 Java 沒兩樣，可以去看看 `lib/main.dart`。*

*(備註：若尚未安裝 Flutter SDK，可先閱讀裡面的 Dart 語法，熟悉後再去官網下載 SDK。)*

### 第四步：職缺必備 - 負載壓力測試實踐
「能處理搶票」是航空公司專員的重要技能。
1. 確認你的後端 API 有啟動 (第一步)。
2. 在後端資料夾執行全域安裝壓測工具：`npm install -g artillery`。
3. 根據我準備好的腳本發動攻擊：`artillery run load-test.yml`。
4. *看著終端機顯示伺服器如何在 100 連線下存活，這就是你在面試時可以展現的能耐！*

### 第五步：推送到 GitHub 與 CI/CD
1. 在這個總資料夾 `tigerair-booking-system` 建立 Git 版控：`git init`。
2. `git add .` 等指令推上你的遠端 GitHub。
3. 點開你 GitHub 的 `Actions` 頁籤，你會看到 `.github/workflows/ci.yml` 正在自動幫你建置專案，這就是 CI/CD。

---

> 開發心法：你原本熟悉的 Java Spring Boot, Hibernate 架構，概念都能 100% 轉移到這套 Node + Vue + Flutter 上面。勇敢把它加上你的 GitHub 作品集吧，祝面試順利！
