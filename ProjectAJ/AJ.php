<?php
session_start();

// Database connection details
$dsn = "xxxxxxxxxxxxxxxxxx"; // 自身のDBの設定を入力

$selectedLang = 'JP';
if (isset($_GET['lang'])) {
    $selectedLang = $_GET['lang'];
    switch ($selectedLang) {
        case 'ja':
            $selectedLang = 'JP';
            break;
        case 'ko':
            $selectedLang = 'KR';
            break;
        case 'my':
            $selectedLang = 'BUR';
            break;
        case 'zh-TW':
            $selectedLang = 'CH';
            break;
        case 'en':
            $selectedLang = 'EN';
            break;
        default:
            $selectedLang = 'JP';
            break;
    }
}

try {
    // Database connection
    $db = new PDO($dsn, "sys2se_24_chatecc", "Db7TUvZIi");
    $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Fetch categories
    $query = "SELECT * FROM category";
    $stmt = $db->prepare($query);
    $stmt->execute();
    $categories = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Fetch translations
    $translationQuery = "SELECT $selectedLang FROM translations WHERE key_name = 'contact'";
    $translationStmt = $db->prepare($translationQuery);
    $translationStmt->execute();
    $contactTranslation = $translationStmt->fetchColumn();

    // Fetch subcategories
    $subcategoryQuery = "SELECT * FROM subcategory";
    $subcategoryStmt = $db->prepare($subcategoryQuery);
    $subcategoryStmt->execute();
    $subcategories = $subcategoryStmt->fetchAll(PDO::FETCH_ASSOC);
} catch (PDOException $e) {
    echo "データベース接続エラー：" . $e->getMessage();
    exit;
}

$categoryIcons = [
    1 => 'fa-house-user',
    2 => 'fa-building-columns',
    3 => 'fa-exclamation',
    'contact' => 'fa-headset'
];

if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['action'])) {
    if ($_POST['action'] == 'register') {
        try {
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
                echo "success";
            } else {
                echo "error";
            }
        } catch (PDOException $e) {
            echo "データベース接続エラー:" . $e->getMessage();
        }
    } elseif ($_POST['action'] == 'login') {
        try {
            $id = $_POST['id'];
            $password = $_POST['password'];

            $query = "SELECT * FROM users WHERE user_id = :id";
            $stmt = $db->prepare($query);
            $stmt->bindParam(':id', $id);
            $stmt->execute();
            $user = $stmt->fetch(PDO::FETCH_ASSOC);

            if ($user && password_verify($password, $user['password'])) {
                $_SESSION['username'] = $user['username'];
                echo json_encode(['status' => 'success', 'username' => $user['username']]);
            } else {
                echo json_encode(['status' => 'error', 'message' => 'Invalid ID or Password']);
            }
        } catch (PDOException $e) {
            echo json_encode(['status' => 'error', 'message' => 'データベース接続エラー: ' . $e->getMessage()]);
        }
    }
}

$loggedIn = isset($_SESSION['username']) ? true : false;

?>

<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ChatECC</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="styles/newProjectAjKwon.css">
    <script src="js/loadNationalities.js" defer></script>
    <script>
        const categories = <?php echo json_encode($categories); ?>;
        const subcategories = <?php echo json_encode($subcategories); ?>;
        const selectedLang = '<?php echo $selectedLang; ?>';
        const loggedIn = <?php echo json_encode($loggedIn); ?>;
    </script>
    <script src="js/projectAjKwon.js" defer></script>
</head>
<body>
    <div class="username">
        <?php if (isset($_SESSION['username'])) : ?>
            <div class="username-text">
                ようこそ, <?php echo htmlspecialchars($_SESSION['username']); ?>さん
            </div>
        <?php endif; ?>
    </div>
    <nav class="nav-container" id="navbar" style="color: white; font-weight: bold;">
        <div class="nav-item" style="flex-grow: 2; font-size: 30px;">Japan Needs</div>
        <div class="nav-item">
            <a href="./chatCommunity1.html" class="chat-btn"><button>Community</button></a>
        </div>
        <div class="nav-item" style="margin-right: 40px;">
            <form method="GET" onchange="this.submit()">
                <select id="language-selector" name="lang">
                    <option value="ja" <?php echo $selectedLang == 'JP' ? 'selected' : ''; ?>>日本語</option>
                    <option value="ko" <?php echo $selectedLang == 'KR' ? 'selected' : ''; ?>>한국어</option>
                    <option value="my" <?php echo $selectedLang == 'BUR' ? 'selected' : ''; ?>>မြန်မာစာ</option>
                    <option value="zh-TW" <?php echo $selectedLang == 'CH' ? 'selected' : ''; ?>>中文</option>
                    <option value="en" <?php echo $selectedLang == 'EN' ? 'selected' : ''; ?>>English</option>
                </select>
            </form>
        </div>
    </nav>
    <div class="background-container">
        <header>
            <div class="user_container" id="userContainer">
                <div class="user-item">
                    <?php if (isset($_SESSION['username'])) : ?>
                        <button id="logoutBtn" onclick="logout()">Log out</button>
                    <?php else : ?>
                        <button id="loginBtn" onclick="showLogin()">Log in</button>
                    <?php endif; ?>
                </div>
            </div>
            <div style="height: 200px; padding: 30px; text-align: center; align-items: center; margin-top: 60px;">
                <h1 style="font-size: 65px; color: tomato;">Japan Needs</h1>
            </div>
            <div class="search-container">
                <form id="search-form" action="/search" method="GET">
                    <input type="text" id="searchInput" name="query" placeholder="Enter information you are looking for." class="search-input">
                    <button type="submit" class="search-button">Search</button>
                </form>
            </div>
        </header>

        <div class="menu-container" id="menuContainer">
            <?php foreach($categories as $category) : ?>
                <a class="menu-item" id="showContent<?php echo $category['category_id']; ?>" href="#">
                    <i class="fa-solid <?php echo $categoryIcons[$category['category_id']]; ?>"></i>
                    <p style="padding: 1px; font-size: 20px;"><?php echo $category[$selectedLang]; ?></p>
                </a>
            <?php endforeach; ?>
        </div>

        <div class="menu-content" id="menuContent"></div>

        <div id="loginModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeLogin()">&times;</span>
                <div class="login">
                    <h1 style="text-align: center; color:tomato; font-size: 50px;">Log-in</h1>
                    <div class="login_id">
                        <h4>ID</h4>
                        <form autocomplete="off">
                            <input type="id" name="id" id="loginId" placeholder="ID" autocomplete="off">
                        </form>
                    </div>
                    <div class="login_pw">
                        <h4>Password</h4>
                        <input type="password" name="password" id="loginPassword" placeholder="Password" autocomplete="off">
                    </div>
                    <div class="login_etc">
                        <div class="checkbox">
                            <input type="checkbox" name="remember" id="remember"> ログイン状態を保持
                        </div>
                        <div class="forgot_pw">
                            <a href="">パスワード忘れた方はこちら</a>
                        </div>
                    </div>  
                    <div class="submit">
                        <input type="submit" value="Log In" onclick="handleLogin(event)">
                    </div>
                    <div id="create_account">
                        <a href="javascript:void(0)" onclick="showCreateAccount()" style="color: tomato;">アカウント生成</a>
                    </div>
                </div>
            </div>
        </div>

        <div id="createAccountModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeCreateAccount()">&times;</span>
                <div class="user_input">
                    <h3 style="text-align: center; color:tomato; font-size: 50px; padding: 0; margin: 0;">Create Account</h3>
                    <div class="input_id">
                        <h4>Login ID <span class="error-message" id="id-error"></span></h4>
                        <form autocomplete="off">
                            <input type="text" name="id" id="id" placeholder="3文字以上、15文字以下で入力してください" autocomplete="off">
                        </form>
                    </div>
                    <div class="input_name">
                        <h4>User Name <span class="error-message" id="username-error"></span></h4>
                        <form autocomplete="off">
                            <input type="text" name="username" id="username" placeholder="最大50文字入力してください" autocomplete="off">
                        </form>
                    </div>
                    <div class="input_pw">
                        <h4>Password <span class="error-message" id="password-error"></span></h4>
                        <form autocomplete="off">
                            <input type="password" name="password" id="password" placeholder="6文字以上、15文字以下で入力してください。" autocomplete="off" onkeyup="checkPasswords()">
                        </form>
                    </div>
                    <div class="input_pw">
                        <h4>Confirm Password <span class="error-message" id="confirm-password-error"></span></h4>
                        <form autocomplete="off">
                            <input type="password" name="confirmPassword" id="confirmPassword" placeholder="もう一度パスワードを入力してください" autocomplete="off" onkeyup="checkPasswords()">
                        </form>
                        <span id="message"></span>
                    </div>
                    <div class="input_email">
                        <h4>Email <span class="error-message" id="email-error"></span></h4>
                        <form autocomplete="off">
                            <input type="email" name="email" id="email" placeholder="emailを入力してください" autocomplete="off">
                        </form>
                    </div>
                    <div class="submit">
                        <input type="button" value="submit" onclick="saveAndShowConfirm()">
                    </div>
                </div>
            </div>
        </div>

        <div id="accountConfirmModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeAccountConfirm()">&times;</span>
                <div class="user_input">
                    <h2>Account Confirm</h2>
                    <h4>ID : <span id="displayID"></span></h4>
                    <h4>User Name : <span id="displayUsername"></span></h4>
                    <div class="submit">
                        <input type="submit" value="submit">
                    </div>
                </div>
            </div>
        </div>

        <div id="welcomeModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeWelcomeModal()">&times;</span>
                <div class="welcome-message" style="text-align: center; font-weight: bold; color: tomato;">
                    <h2>ようこそ, <span id="welcomeUsername"></span>さん</h2>
                </div>
            </div>
        </div>

        <div id="loginRequiredModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeLoginRequiredModal()">&times;</span>
                <div class="message">
                    <h2>ログインが必要です</h2>
                    <p>この機能を利用するにはログインが必要です。</p>
                </div>
            </div>
        </div>

        <footer>
            <a href="privacy.html"><i class="fa-solid fa-shield-halved" style="font-size: 50px;"></i></a>
            <a href="https://www.facebook.com"><i class="fa-brands fa-facebook" style="font-size: 50px;"></i></a>
            <a href="https://www.twitter.com"><i class="fa-brands fa-x-twitter" style="font-size: 50px;"></i></a>
            <div class="footer_border">
                <p>&copy; 2024 ECCcomp SE2A chat ecc ProjectAj Hc Gs Ym Ku Kd</p>
            </div>
        </footer>
    </div>
    <script src="js/projectAjKwon.js" defer></script>
</body>
</html>
