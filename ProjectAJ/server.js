const express = require('express');
const multer = require('multer');
const path = require('path');
const fs = require('fs');
const mongoose = require('mongoose');

const app = express();
const port = 3001;

// `uploads` フォルダが存在しない場合に作成する
const uploadDir = path.join(__dirname, 'uploads');
if (!fs.existsSync(uploadDir)) {
    fs.mkdirSync(uploadDir);
}

app.use(express.static('public'));
app.use(express.json());

// MongoDB接続設定
mongoose.connect('mongodb://localhost/chat-community', {
  useNewUrlParser: true,
  useUnifiedTopology: true
});

// スキーマ定義
const postSchema = new mongoose.Schema({
  content: String,
  likes: Number,
  audioSrc: String,
  imageSrc: String,
  comments: [
    {
      content: String,
      likes: Number
    }
  ]
});

const Post = mongoose.model('Post', postSchema);

const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, 'uploads/');
    },
    filename: function (req, file, cb) {
        const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
        cb(null, file.fieldname + '-' + uniqueSuffix + path.extname(file.originalname));
    }
});

const upload = multer({ storage: storage });

app.post('/upload', upload.single('audio'), (req, res) => {
    if (!req.file) {
        return res.status(400).json({ error: 'No file uploaded' });
    }
    res.status(200).json({ filePath: `uploads/${req.file.filename}` });
});

// 投稿取得 API
app.get('/api/posts', async (req, res) => {
  const posts = await Post.find();
  res.json(posts);
});

// 投稿追加 API
app.post('/api/posts', async (req, res) => {
  const newPost = new Post(req.body);
  await newPost.save();
  res.json(newPost);
});

app.listen(port, () => {
    console.log(`Server is running at http://localhost:${port}`);
});
