let commentIdCounter = 0;
const MAX_LENGTH = 100; // Maximum length of post content before truncation

let mediaRecorder;
let audioChunks = [];
let audioBlob = null;
let audioURL = null;
let timer;
let seconds = 0;

function toggleRecording() {
    const recordButton = document.getElementById('recordButton');
    const deleteButton = document.getElementById('deleteButton');
    const audioPreview = document.getElementById('audioPreview');
    
    if (mediaRecorder && mediaRecorder.state === 'recording') {
        mediaRecorder.stop();
        recordButton.innerHTML = '🎤 録音';
        deleteButton.disabled = false;
        deleteButton.classList.add('enabled');
        clearInterval(timer);
        seconds = 0; // リセット
    } else {
        startRecording();
        recordButton.innerHTML = 'ストップ <span id="timer">00:00</span>';
        deleteButton.disabled = true;
        deleteButton.classList.remove('enabled');
        audioPreview.style.display = 'none';
        seconds = 0;
        timer = setInterval(() => {
            seconds++;
            const minutes = Math.floor(seconds / 60);
            const displaySeconds = seconds % 60;
            const timerDisplay = document.getElementById('timer');
            if (timerDisplay) {
                timerDisplay.textContent = `${String(minutes).padStart(2, '0')}:${String(displaySeconds).padStart(2, '0')}`;
            }
        }, 1000);
    }
}

function startRecording() {
    navigator.mediaDevices.getUserMedia({ audio: true })
        .then(stream => {
            mediaRecorder = new MediaRecorder(stream);
            mediaRecorder.ondataavailable = event => {
                audioChunks.push(event.data);
            };
            mediaRecorder.onstop = () => {
                audioBlob = new Blob(audioChunks, { type: 'audio/mp3' });
                audioChunks = [];
                audioURL = URL.createObjectURL(audioBlob);
                const audioPreview = document.getElementById('audioPreview');
                audioPreview.src = audioURL;
                audioPreview.style.display = 'block';
                clearInterval(timer); // Stop the timer when recording stops
            };
            mediaRecorder.start();
        })
        .catch(error => console.error('Error accessing microphone:', error));
}

function deleteAudio() {
    audioBlob = null;
    audioURL = null;
    const deleteButton = document.getElementById('deleteButton');
    const audioPreview = document.getElementById('audioPreview');
    deleteButton.disabled = true;
    deleteButton.classList.remove('enabled');
    audioPreview.style.display = 'none';
    const recordButton = document.getElementById('recordButton');
    recordButton.innerHTML = '🎤 録音';
}

function handleFileUpload(event) {
    const file = event.target.files[0];
    if (file) {
        const reader = new FileReader();
        reader.onload = function(e) {
            const imagePreview = document.getElementById('imagePreview');
            imagePreview.src = e.target.result;
            imagePreview.style.display = 'block';
        };
        reader.readAsDataURL(file);
    }
}

async function postMessage() {
    const postInput = document.getElementById('postInput');
    const postText = postInput.value.trim();

    if (postText === '' && !audioBlob && !document.getElementById('imagePreview').src) return; // Ensure there's either text, audio, or image

    const postData = {
        content: postText,
        likes: 0,
        audioSrc: audioBlob ? await uploadAudioFile(audioBlob) : null,
        imageSrc: document.getElementById('imagePreview').src,
        comments: []
    };

    const response = await fetch('http://localhost:3001/api/posts', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(postData)
    });

    const newPost = await response.json();
    addPostToFeed(newPost);
    postInput.value = '';
    document.getElementById('imagePreview').src = ''; // Reset image preview
    deleteAudio();
}

function addPostToFeed(postData) {
    const post = document.createElement('div');
    post.className = 'post';
    post.id = postData._id;

    let audioElement = '';
    if (postData.audioSrc) {
        audioElement = `<audio controls src="${postData.audioSrc}"></audio>`;
    }

    let imageElement = '';
    if (postData.imageSrc) {
        imageElement = `<img src="${postData.imageSrc}" alt="Uploaded Image" style="max-width: 100%; margin-top: 10px;">`;
    }

    post.innerHTML = `
        <div class="content" id="${postData._id}-content">${postData.content}</div>
        ${audioElement}
        ${imageElement}
        <div class="actions">
            <button class="action-button" id="${postData._id}-like-button" onclick="toggleLike('${postData._id}', 'post')">いいね <span id="${postData._id}-likes">${postData.likes}</span></button>
            <button class="action-button" onclick="toggleComments('${postData._id}')">コメント <span id="${postData._id}-comment-count">${postData.comments.length}</span></button>
            <button class="action-button" onclick="deletePost('${postData._id}')">削除</button>
        </div>
        <div class="comments" id="${postData._id}-comments" style="display: none;">
            <textarea placeholder="コメントを書く..."></textarea>
            <button class="action-button" onclick="addComment('${postData._id}')">コメントを追加</button>
            <div class="commentsFeed" id="${postData._id}-commentsFeed"></div>
        </div>
    `;

    document.getElementById('postFeed').prepend(post);
}

async function uploadAudioFile(audioBlob) {
    const formData = new FormData();
    formData.append('audio', audioBlob, `audio-${Date.now()}.mp3`);

    const response = await fetch('http://localhost:3001/upload', {
        method: 'POST',
        body: formData
    });

    const data = await response.json();
    return data.filePath;
}

async function loadPostsFromServer() {
    const response = await fetch('http://localhost:3001/api/posts');
    const posts = await response.json();
    const postFeed = document.getElementById('postFeed');
    postFeed.innerHTML = '';

    posts.forEach(postData => {
        addPostToFeed(postData);
    });
}

function toggleComments(postId) {
    const commentsSection = document.getElementById(`${postId}-comments`);
    commentsSection.style.display = commentsSection.style.display === 'none' || commentsSection.style.display === '' ? 'block' : 'none';
}

function addComment(postId) {
    const commentText = document.querySelector(`#${postId}-comments textarea`).value.trim();
    if (commentText === '') return;

    const commentId = `comment-${commentIdCounter++}`;
    const comment = document.createElement('div');
    comment.className = 'comment';
    comment.id = commentId;
    comment.innerHTML = `
        <p>${commentText}</p>
        <button class="action-button" onclick="toggleLike('${commentId}', 'comment')">いいね <span id="${commentId}-likes">0</span></button>
        <button class="action-button" onclick="deleteComment('${postId}', '${commentId}')">削除</button>
    `;

    document.getElementById(`${postId}-commentsFeed`).appendChild(comment);
    document.querySelector(`#${postId}-comments textarea`).value = '';

    const commentCountSpan = document.getElementById(`${postId}-comment-count`);
    commentCountSpan.textContent = parseInt(commentCountSpan.textContent) + 1;
}

function deletePost(postId) {
    document.getElementById(postId).remove();
}

function deleteComment(postId, commentId) {
    document.getElementById(commentId).remove();
    const commentCountSpan = document.getElementById(`${postId}-comment-count`);
    commentCountSpan.textContent = parseInt(commentCountSpan.textContent) - 1;
}

function toggleLike(id, type) {
    const likeButton = document.getElementById(`${id}-like-button`);
    const likesSpan = document.getElementById(`${id}-likes`);
    let likes = parseInt(likesSpan.textContent);

    if (likeButton.classList.contains('liked')) {
        likes--;
        likeButton.classList.remove('liked');
    } else {
        likes++;
        likeButton.classList.add('liked');
    }

    likesSpan.textContent = likes;
}

function searchPosts() {
    const searchInput = document.getElementById('searchInput').value.toLowerCase();
    const posts = document.querySelectorAll('.post');
    let found = false;
    
    posts.forEach(post => {
        const postContent = post.querySelector('.content').textContent.toLowerCase();
        post.style.display = postContent.includes(searchInput) ? 'block' : 'none';
        found = found || postContent.includes(searchInput);
    });

    document.getElementById('searchMessage').style.display = found ? 'none' : 'block';
}

function updatePopularPosts() {
    const posts = Array.from(document.querySelectorAll('.post'));
    const popularPostsContainer = document.getElementById('popularPosts');
    popularPostsContainer.innerHTML = '';

    posts.sort((a, b) => {
        const likesA = parseInt(a.querySelector('.action-button span').textContent);
        const likesB = parseInt(b.querySelector('.action-button span').textContent);
        return likesB - likesA;
    });

    posts.slice(0, 5).forEach(post => {
        const postId = post.id;
        const content = post.querySelector('.content').textContent;
        const likes = post.querySelector('.action-button span').textContent;
        const postSummary = document.createElement('div');
        postSummary.className = 'popular-post-summary';
        postSummary.innerHTML = `
            <p>${content}</p>
            <p>いいね: ${likes}</p>
        `;
        popularPostsContainer.appendChild(postSummary);
    });
}

window.onload = function() {
    loadPostsFromServer();
}
