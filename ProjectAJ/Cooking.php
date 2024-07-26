<?php

$dsn = "mysql:host=localhost;dbname=sys2se_24_chatecc;charset=utf8mb4";

$selectedLang = 'JP';
if (isset($_GET['lang'])) {
    $selectedLang = $_GET['lang'];
}

try {
    $db = new PDO($dsn, "sys2se_24_chatecc", "Db7TUvZIi");
    $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    $query = "SELECT * FROM title WHERE subcategory_id = 1";
    $stmt = $db->prepare($query);
    $stmt->execute();
    $titles = $stmt->fetchAll(PDO::FETCH_ASSOC);

    $translationQuery = "SELECT $selectedLang FROM translations WHERE key_name = 'detail'";
    $translationStmt = $db->prepare($translationQuery);
    $translationStmt->execute();
    $contactTranslation = $translationStmt->fetchColumn();
} catch (PDOException $e) {
    echo "データベース接続エラー：" . $e->getMessage();
    exit;
}

// var_dump($titles);

$langMap = [
    'JP' => 'JP',
    'CH' => 'CH',
    'BUR' => 'BUR',
    'KR' => 'KR',
    'EN' => 'EN',
];

$currentLang = $langMap[$selectedLang] ?? 'JP';

// ファイルパスを定義
$fileBasePath = './detailInfo/01/';

?>
<!DOCTYPE html>
<html lang="ja">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>外国人向け情報ガイド</title>
    <link rel="stylesheet" href="./styles/detail.css">
    <script src="js/projectAjKwon.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
</head>

<body>
    <nav class="nav-container" id="navbar" style="color: white; font-weight: bold;">
        <div class="nav-item" style="flex-grow: 2; font-size: 20px;">料理のための情報ガイド</div>
        <div class="nav-item" style="flex-grow: 2; font-size: 20px;">日本での料理に関する情報をカードスタイルで提供</div>

        <div class="nav-item" style="margin-right: 40px;">
            <form method="GET" onchange="this.submit()">
                <select id="language-selector" name="lang">
                    <option value="JP" <?php echo $selectedLang === 'JP' ? 'selected' : ''; ?>>日本語</option>
                    <option value="CH" <?php echo $selectedLang === 'CH' ? 'selected' : ''; ?>>中文</option>
                    <option value="BUR" <?php echo $selectedLang === 'BUR' ? 'selected' : ''; ?>>မြန်မာစာ</option>
                    <option value="KR" <?php echo $selectedLang === 'KR' ? 'selected' : ''; ?>>한국어</option>
                    <option value="EN" <?php echo $selectedLang === 'EN' ? 'selected' : ''; ?>>English</option>
                </select>
            </form>
        </div>
    </nav>
    <div>

        <main id="card-container">
            <?php foreach ($titles as $title) : ?>
                <?php
                // ファイルパスを生成
                $detailFilePath = $fileBasePath . $title['title_id'] . "_$selectedLang.txt";

                // 画像ファイルのパスを生成
                $imageFilePath = './detail_img/01/' . $title['title_id'] . '.jpg';

                // ファイルの内容を読み込む
                $detailContent = "";
                if (file_exists($detailFilePath)) {
                    $detailContent = file_get_contents($detailFilePath);
                    // 改行を<br>タグに変換
                    $detailContent = nl2br($detailContent);
                } else {
                    $detailContent = "詳細内容が見つかりません。";
                }
                ?>
                <div class="card">
                    <img src="<?php echo $imageFilePath; ?>" alt="<?php echo htmlspecialchars($title[$currentLang]); ?>">
                    <div class="card-content">
                        <h3><?php echo htmlspecialchars($title[$currentLang]); ?></h3>
                    </div>
                    <a href="#" class="card-button" data-title="<?php echo htmlspecialchars($title[$currentLang]); ?>" data-content="<?php echo htmlspecialchars($detailContent); ?>">
                        <?php echo htmlspecialchars($contactTranslation, ENT_QUOTES, 'UTF-8'); ?>
                    </a>
                </div>
            <?php endforeach; ?>
        </main>

        <div id="detailed-card-container"></div>

        <dialog id="infoDialog">
            <div>
                <h3>タイトル</h3>
                <p>内容</p>
                <i id="closeBtn" class="material-icons">close</i>
            </div>
        </dialog>

        <script src="./js/cards.js"></script>

    </div>

</body>

</html>