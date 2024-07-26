<?php

$dsn = "xxxxxxxxxxxxxxxxxx"; // 自身のDBの設定を入力

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    try {
        // $db = new PDO($dsn, "root", "root"); 
        $db = new PDO($dsn, "sys2se_24_chatecc", "Db7TUvZIi");
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        $id = $_POST['id'];
        $username = $_POST['username'];
        $password = password_hash($_POST['password'], PASSWORD_BCRYPT);
        $email = $_POST['email'];

        $query = "INSERT INTO users (user_id, username, password, email) VALUES (:id, :username, :password, :email)";
        $stmt = $db->prepare($query);
        $stmt->bindParam(':id', $id);
        $stmt->bindParam(':username', $username);
        $stmt->bindParam(':password', $password);
        $stmt->bindParam(':email', $email);

        if ($stmt->execute()) {
            echo json_encode(['status' => 'success']);
        } else {
            echo json_encode(['status' => 'error', 'message' => '登録中にエラーが発生しました']);
        }
    } catch (PDOException $e) {
        echo json_encode(['status' => 'error', 'message' => 'データベース接続エラー: ' . $e->getMessage()]);
    }
}

?>
