document.getElementById('loginForm').addEventListener('submit', function(event) {
    event.preventDefault();
    
    var username = document.getElementById('username').value;
    var password = document.getElementById('password').value;

    // ここでログインの処理を実行する

    if (username === 'example_user' && password === 'password123') {
        // ログイン成功時の処理
        document.getElementById('message').innerText = 'ログインに成功しました！';
        document.getElementById('message').style.color = 'green';
    } else {
        // ログイン失敗時の処理
        document.getElementById('message').innerText = 'ユーザー名またはパスワードが間違っています。';
        document.getElementById('message').style.color = 'red';
    }
});
