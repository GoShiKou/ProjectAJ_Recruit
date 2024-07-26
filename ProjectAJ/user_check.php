<?php

$dsn = "xxxxxxxxxxxxxxxxxx"; // 自身のDBの設定を入力

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    try {
        // $db = new PDO($dsn, "root", "root"); 
        $db = new PDO($dsn, "sys2se_24_chatecc", "Db7TUvZIi");
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        $id = $_POST['id'];
        $username = $_POST['username'];
        $email = $_POST['email'];

        $checkQuery = "SELECT * FROM users WHERE user_id = :id OR username = :username OR email = :email";
        $checkStmt = $db->prepare($checkQuery);
        $checkStmt->bindParam(':id', $id);
        $checkStmt->bindParam(':username', $username);
        $checkStmt->bindParam(':email', $email);
        $checkStmt->execute();
        $existingUser = $checkStmt->fetch(PDO::FETCH_ASSOC);

        if ($existingUser) {
            if ($existingUser['user_id'] == $id) {
                echo json_encode(['status' => 'error', 'field' => 'id', 'message' => 'このIDは既に存在します。']);
            } elseif ($existingUser['username'] == $username) {
                echo json_encode(['status' => 'error', 'field' => 'username', 'message' => 'このユーザー名は既に存在します。']);
            } elseif ($existingUser['email'] == $email) {
                echo json_encode(['status' => 'error', 'field' => 'email', 'message' => 'このメールアドレスは既に存在します。']);
            }
        } else {
            echo json_encode(['status' => 'success']);
        }
    } catch (PDOException $e) {
        echo json_encode(['status' => 'error', 'message' => 'データベース接続エラー: ' . $e->getMessage()]);
    }
}
?>
