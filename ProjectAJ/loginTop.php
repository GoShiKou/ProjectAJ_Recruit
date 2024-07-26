<?php
session_start();

$err = $_SESSION;

//セッションを消す
$_SESSION = array();
session_destroy();

$login_err = isset($_SESSION['login_err']) ? $_SESSION ['login_err'] : null;
unset($_SESSION['login_err']);

?>



<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="styles/loginTop.css">
    <title>ログイン</title>
</head>
<body>
    <div class="wrap">
        <div class="login">
            <h2>Log-in</h2>
            <?php if (isset($login_err)): ?>
                <p><?php echo $login_err;?></p>
                <?php endif;?>
            <?php if (isset($err['msg'])): ?>
                        <p class="err"><?php echo $err ['msg'];?></p>
                    <?php endif;?>
            <div class="login_id">
                <h4>User ID</h4>
                <form action="chatCommunity.php" method="POST" autocomplete="off">
                <input type="id" name="user_id" id="user_id" placeholder="ID" autocomplete="off" value="">
                    <?php if (isset($err['user_id'])): ?>
                        <p class="err"><?php echo $err ['user_id'];?></p>
                    <?php endif;?>
            </div>
            <div class="login_pw">
                <h4>Password</h4>
                <input type="password" name="password" id="password" placeholder="Password" autocomplete="off">
                    <?php if (isset($err['password'])): ?>
                        <p class="err"><?php echo $err ['password'];?></p>
                    <?php endif;?>
            </div>
            <div class="login_etc">
                <div class="checkbox">
                    <input type="checkbox" name="" id=""> ログイン状態を保持
                </div>
                <div class="forgot_pw">
                    <a href="">パスワード忘れた方はこちら</a>
                </div>
            </div>  
            <div id="create_account">
                <a href="createAccount.php">アカウント生成</a>
            </div>
            <div class="submit">
                <input type="submit" value="submit">
            </div>
            </form>
        </div>
    </div>
</body>
</html>
