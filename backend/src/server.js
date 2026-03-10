const express = require('express');
const cors = require('cors');
const jwt = require('jsonwebtoken');
require('dotenv').config();
const db = require('./config/db');

const app = express();
app.use(cors());
app.use(express.json());

// Auth Middleware
const authenticateToken = (req, res, next) => {
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1];
    if (!token) return res.sendStatus(401);

    jwt.verify(token, process.env.JWT_SECRET, (err, user) => {
        if (err) return res.sendStatus(403);
        req.user = user;
        next();
    });
};

// 登入 API
app.post('/api/auth/login', (req, res) => {
    const { username, password } = req.body;
    if (username === 'admin' && password === 'admin123') {
        const token = jwt.sign({ username }, process.env.JWT_SECRET, { expiresIn: '1h' });
        res.json({ token });
    } else {
        res.status(401).json({ error: '帳號或密碼錯誤' });
    }
});

// 取得航班 API (模擬資料，因為一開始沒有安裝資料庫)
app.get('/api/flights', async (req, res) => {
    try {
        res.json([
            { id: 1, flight_number: 'IT201', origin: 'TPE', destination: 'NRT', price: 4500, status: 'On Time' },
            { id: 2, flight_number: 'IT212', origin: 'TPE', destination: 'KIX', price: 3800, status: 'Delayed' },
            { id: 3, flight_number: 'IT303', origin: 'KHH', destination: 'MFM', price: 2100, status: 'On Time' },
            { id: 4, flight_number: 'IT505', origin: 'TPE', destination: 'BKK', price: 5200, status: 'On Time' }
        ]);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// 訂位 API (需要驗證 Token)
app.post('/api/bookings', authenticateToken, (req, res) => {
    const { flightId } = req.body;
    res.json({ message: `Successfully booked flight ${flightId} for user ${req.user.username}` });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
