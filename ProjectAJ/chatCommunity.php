<?php
session_start();

require_once 'classes/UserLogic2.php';

//エラーメッセージ
$err = [];

//バリデーション

    if(!$user_id = filter_input(INPUT_POST,'user_id')){
        $err["user_id"] = "ユーザIDを記入してください。";
    }
    
    if (!$password = filter_input(INPUT_POST,'password')){
        $err["password"] ='パスワードを記入してください。';
    }
    
    if (count($err)> 0){
        // エラーがあった場合は戻す
        $_SESSION = $err;
        header('Location: loginTop.php');
        return;
    }
    //ログイン成功時の処理
    $result = UserLogic2 :: login($user_id,$password);
    //ログイン失敗時の処理
    if (!$result){
        header('Location: loginTop.php');
        return;
    }

    //　ログインしているか判定し、していなかった ら新規登録画面へ返す
    // $result = UserLogic2 ::checkLogin();

    // if (!$result) {
    // $_SESSION['login_err'] = 'ユーザを登録してログインしてください！';
    // header('Location:  createAccount.php');
    // return;
    // }

    $login_user = $_SESSION['login_user'];

?>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chat Community</title>
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css"
    />
    <link rel="stylesheet" href="styles/chatCommunity.css">
</head>
<body>
    <header>
        <nav class="navbar">
            <ul class="navbar-list">
                <li><a href="#">Back to Top</a></li>
              </ul>
        <div class="profile-dropdown">
            <div onclick="toggle()" class="profile-dropdown-btn">
              <div class="profile-img">
                <i class="fa-solid fa-circle"></i>
              </div>
    
              <span><?php echo $login_user['username']?>
                <i class="fa-solid fa-angle-down"></i>
              </span>
            </div>
    
            <ul class="profile-dropdown-list">
              <li class="profile-dropdown-list-item">
                <a href="#">
                  <i class="fa-regular fa-user"></i>
                  Edit Profile
                </a>
              </li>    
    
              <li class="profile-dropdown-list-item">
                <a href="#">
                  <i class="fa-solid fa-arrow-right-from-bracket"></i>
                  Log out
                </a>
              </li>
            </ul>
          </div>
        </nav>
        <h1>Chat Community</h1>
        <input type="text" id="searchInput" placeholder="探したい言葉を登録" oninput="searchPosts()">
        <button onclick="searchPosts()">検索</button>
        <p id="searchMessage" style="display:none;">検索結果がありません</p>
    </header>    
    <main>
        <section class="post-section">
            <div class="new-post">
                <textarea id="postInput" placeholder="ここに内容を登録"></textarea>
                <button class="post-button" onclick="postMessage()">投稿</button>
            </div>
        </section>
        <section class="feed-section">
            <h2>みんなの話題</h2>
            <div id="postFeed"></div>
        </section>
        <section class="comments-section">
            <h3>コメント</h3>
            <div id="commentsFeed"></div>
        </section>
    </main>
    <script src="./js/ChatCommunity.js"></script>
</body>
</html>