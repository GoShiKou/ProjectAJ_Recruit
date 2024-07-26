<?php

$dsn = "xxxxxxxxxxxxxxxxxx"; // 自身のDBの設定を入力


$selectedLang = 'JP';
if (isset($_GET['lang'])) {
    $selectedLang = $_GET['lang'];
}

try {
    $db = new PDO($dsn, "sys2se_24_chatecc", "Db7TUvZIi");
    $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    $query = "SELECT * FROM category";

    $stmt = $db->prepare($query);
    $stmt->execute();
    $categories = $stmt->fetchAll(PDO::FETCH_ASSOC);


    $translationQuery = "SELECT $selectedLang FROM translations WHERE key_name = 'contact'";
    $translationStmt = $db->prepare($translationQuery);
    $translationStmt->execute();
    $contactTranslation = $translationStmt->fetchColumn();

    $subcategoryQuery = "SELECT * FROM subcategory";

    $subcategoryStmt = $db->prepare($subcategoryQuery);
    $subcategoryStmt->execute();
    $subcategories = $subcategoryStmt->fetchAll(PDO::FETCH_ASSOC);
} catch (PDOException $e) {
    echo "データベース接続エラー：" . $e->getMessage();
    exit;
}

?>
<!DOCTYPE html>
<html lang="ja">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ChatECC</title>
    <link rel="stylesheet" href="styles/newProjectAj.css">
</head>

<body>
    <header>
        <form method="GET" id="language-form">
            <select id="language-selector" name="lang" onchange="document.getElementById('language-form').submit()">
                <option value="JP" <?php echo $selectedLang === 'JP' ? 'selected' : ''; ?>>日本語</option>
                <option value="CH" <?php echo $selectedLang === 'CH' ? 'selected' : ''; ?>>中文</option>
                <option value="BUR" <?php echo $selectedLang === 'BUR' ? 'selected' : ''; ?>>မြန်မာစာ</option>
                <option value="KR" <?php echo $selectedLang === 'KR' ? 'selected' : ''; ?>>한국어</option>
                <option value="EN" <?php echo $selectedLang === 'EN' ? 'selected' : ''; ?>>English</option>
            </select>
        </form>
        <div class="user-info">
            <img src="<?php echo $userPhoto; ?>" alt="User Photo" class="user-photo">
            <span class="username"><?php echo htmlspecialchars($username, ENT_QUOTES, 'UTF-8'); ?></span>
        </div>
    </header>

    <form id="search-form" action="/search" method="GET">
        <input type="text" id="searchInput" name="query" placeholder="検索" class="search-input">
        <button type="submit" class="search-button">検索</button>
    </form>

    <nav class="hozitinal-nav">
        <ul>
            <?php foreach ($categories as $index => $category) : ?>
                <li id="showContent<?php echo $index + 1; ?>">
                    <?php echo htmlspecialchars($category[$selectedLang], ENT_QUOTES, 'UTF-8'); ?>
                </li>
            <?php endforeach; ?>
            <li id="contact_link"><?php echo htmlspecialchars($contactTranslation, ENT_QUOTES, 'UTF-8'); ?></li>
            <a href='./chatCommunity.html'>
                <button>
                    Chat Community
                </button>
            </a>
        </ul>
    </nav>

    <div id="main-content">
        <div id="button-container" class="button-container"></div>
        <div id="content1" class="content-section"></div>
        <div id="content2" class="content-section"></div>
        <div id="content3" class="content-section"></div>
    </div>

    <section id="cards-section" class="cards-section">
        <div class="card">
            <h3>生活</h3>
            <p>生活に関する情報を提供します。役立つヒントやアドバイスをここで見つけてください。</p>
        </div>
        <div class="card">
            <h3>窓口</h3>
            <p>各種窓口へのアクセス方法や連絡先情報を提供します。</p>
        </div>
        <div class="card">
            <h3>トラブル</h3>
            <p>トラブルシューティングガイドとサポートを提供します。</p>
        </div>
        <div class="card">
            <h3>Chat Community</h3>
            <p>困ってることについて相談できサポートを提供します</p>
        </div>
    </section>

    <footer>
        <p>&copy; 2024 外国人向けガイド</p>
        <ul>
            <li><a href="privacy.html">プライバシーポリシー</a></li>
            <li><a href="https://www.facebook.com">Facebook</a></li>
            <li><a href="https://www.twitter.com">Twitter</a></li>
        </ul>
    </footer>
    <script>
        const categories = <?php echo json_encode($categories); ?>;
        const subcategories = <?php echo json_encode($subcategories); ?>;
        const selectedLang = "<?php echo $selectedLang; ?>";

        document.getElementById('main-content').addEventListener('click', function(event) {
            if (!event.target.closest('#button-container')) {
                event.preventDefault();
            }
        });
    </script>
    <script src="js/projectAj.js"></script>
</body>

</html>