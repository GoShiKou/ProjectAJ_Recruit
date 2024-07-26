-- phpMyAdmin SQL Dump
-- version 5.2.1-1.el9
-- https://www.phpmyadmin.net/
--
-- ホスト: localhost
-- 生成日時: 2024 年 7 月 26 日 15:48
-- サーバのバージョン： 8.0.36
-- PHP のバージョン: 8.2.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- データベース: `sys2se_24_chatecc`
--

-- --------------------------------------------------------

--
-- テーブルの構造 `category`
--

CREATE TABLE `category` (
  `category_id` int NOT NULL,
  `JP` varchar(100) NOT NULL,
  `CH` varchar(100) NOT NULL,
  `BUR` varchar(100) NOT NULL,
  `KR` varchar(100) NOT NULL,
  `EN` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- テーブルのデータのダンプ `category`
--

INSERT INTO `category` (`category_id`, `JP`, `CH`, `BUR`, `KR`, `EN`) VALUES
(1, '生活', '生活', 'လူမှုရေး', '생활', 'Life'),
(2, '窓口業務', '窗口業務', 'ကောင်တာဝန်ဆောင်မှု', '창구업무', 'Counter'),
(3, 'トラブル', '麻煩/困難', 'အထွေထွေပြဿနာများ ', '문제발생', 'Trouble');

-- --------------------------------------------------------

--
-- テーブルの構造 `comments`
--

CREATE TABLE `comments` (
  `comment_id` int NOT NULL,
  `post_id` int NOT NULL,
  `user_key` int NOT NULL,
  `content` text NOT NULL,
  `date_created` datetime DEFAULT CURRENT_TIMESTAMP,
  `date_changed` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `contents`
--

CREATE TABLE `contents` (
  `content_id` int NOT NULL,
  `category_id` int DEFAULT NULL,
  `subcategory_id` int DEFAULT NULL,
  `lang` varchar(2) DEFAULT NULL,
  `content` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `detail_img`
--

CREATE TABLE `detail_img` (
  `img_id` int NOT NULL,
  `title_id` int DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `languages`
--

CREATE TABLE `languages` (
  `language_id` int NOT NULL,
  `language` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- テーブルのデータのダンプ `languages`
--

INSERT INTO `languages` (`language_id`, `language`) VALUES
(1, 'Japanese'),
(2, 'Chinese'),
(3, 'Burmese'),
(4, 'Korean'),
(5, 'English');

-- --------------------------------------------------------

--
-- テーブルの構造 `likes`
--

CREATE TABLE `likes` (
  `like_id` int NOT NULL,
  `post_id` int NOT NULL,
  `user_key` int NOT NULL,
  `date_created` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `posts`
--

CREATE TABLE `posts` (
  `post_id` int NOT NULL,
  `user_key` int NOT NULL,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `date_created` datetime DEFAULT CURRENT_TIMESTAMP,
  `date_changed` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `shares`
--

CREATE TABLE `shares` (
  `share_id` int NOT NULL,
  `post_id` int NOT NULL,
  `user_key` int NOT NULL,
  `date_created` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `subcategory`
--

CREATE TABLE `subcategory` (
  `subcategory_id` int NOT NULL,
  `category_id` int NOT NULL,
  `JP` varchar(100) NOT NULL,
  `CH` varchar(100) NOT NULL,
  `BUR` varchar(100) NOT NULL,
  `KR` varchar(100) NOT NULL,
  `EN` varchar(100) NOT NULL,
  `url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- テーブルのデータのダンプ `subcategory`
--

INSERT INTO `subcategory` (`subcategory_id`, `category_id`, `JP`, `CH`, `BUR`, `KR`, `EN`, `url`) VALUES
(1, 1, '料理', '料理', 'ဟင်းလျာများ', '요리', 'Cooking', 'https://click.ecc.ac.jp/~sys2se_24_chatecc/ProjectAJ/Cooking.php'),
(2, 1, '買い物', '購物', 'စျေးဝယ်စရာများ', '쇼핑', 'Shopping', 'https://click.ecc.ac.jp/~sys2se_24_chatecc/ProjectAJ/Shopping.php'),
(3, 1, '健康', '健康', 'ကျန်းမာရေး', '건강', 'Health', 'https://click.ecc.ac.jp/~sys2se_24_chatecc/ProjectAJ/Health.php'),
(4, 2, '銀行', '銀行', 'ဘဏ်လုပ်ငန်းများ', '은행', 'Bank', 'https://click.ecc.ac.jp/~sys2se_24_chatecc/ProjectAJ/Bank.php'),
(5, 2, '病院', '醫院', 'ဆေးရုံဆေးခန်းဆိုင်ရာ', '병원', 'Hospital', 'https://click.ecc.ac.jp/~sys2se_24_chatecc/ProjectAJ/Hospital.php'),
(6, 2, '役所', '市政署', 'ရပ်ကွက်ရုံး', '관공서', 'Government Office', 'https://click.ecc.ac.jp/~sys2se_24_chatecc/ProjectAJ/Government%20Office.php'),
(7, 3, '暴行', '暴力', 'ပြစ်မှုဆိုင်ရာ', '폭행', 'Violence', 'https://click.ecc.ac.jp/~sys2se_24_chatecc/ProjectAJ/Violence.php'),
(8, 3, '交通事故', '交通意外', 'ယာဉ်စည်းကမ်းဆိုင်ရာ', '교통사고', 'Traffic Accident', 'https://click.ecc.ac.jp/~sys2se_24_chatecc/ProjectAJ/Traffic%20Accident.php'),
(9, 3, 'ハラスメント', '職場騷擾', 'အတင်းအကျပ်ခိုင်းစေခြင်း', '직장 내 괴롭힘', 'Harassment', 'https://click.ecc.ac.jp/~sys2se_24_chatecc/ProjectAJ/Harassment.php');

-- --------------------------------------------------------

--
-- テーブルの構造 `title`
--

CREATE TABLE `title` (
  `title_id` int NOT NULL,
  `subcategory_id` int NOT NULL,
  `JP` varchar(100) NOT NULL,
  `CH` varchar(100) NOT NULL,
  `BUR` varchar(100) NOT NULL,
  `KR` varchar(100) NOT NULL,
  `EN` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- テーブルのデータのダンプ `title`
--

INSERT INTO `title` (`title_id`, `subcategory_id`, `JP`, `CH`, `BUR`, `KR`, `EN`) VALUES
(1, 1, '日本のスーパーで外国食材を買うには？', '如何在日本的超市買外國食材?', '  ဂျပန်မှာ ကုန်တိုက်တွေမှာ နိုင်ငံခြားမှ အစားအသောက်များကို ဘယ်လို ဝယ်လို့ရမလဲ? ', '일본의 슈퍼에서 외국의 식재료를 사려면 어떻게 해야하나요?? ', 'How to buy foreign ingredients at Japanese supermarkets?'),
(2, 1, '日本で外国のレシピを再現するには？', '在日本如何重現外國的食譜? ', 'ဂျပန်မှာ နိုင်ငံခြား အစားအသောက် ချက်ပြုတ်နည်းကို ဘယ်လို ပြန်လုပ်လို့ရမလဲ? ', '일본에서 외국의 레시피를 재현하려면 어떻게 해야하나요?? ', 'How to recreate foreign recipes in Japan?'),
(3, 1, '日本の料理教室で学ぶには？', '如何在日本學習烹飪課程? ', 'ဂျပန်မှာ အချက်အပြုတ် သင်တန်းတွေမှာ ဘယ်လို လေ့လာရမလဲ? ', '일본의 요리교실에서 배우려면 어떻게 해야하나요? ', 'How to take cooking classes in Japan?'),
(4, 1, '日本の調味料を使った簡単な料理は？', '如何用日本的調味料做出簡單的料理? ', 'ဂျပန်မှာ သုံးတဲ့ အာဟာရ အဆီအနှစ်တွေ သုံးပြီး ဘယ်လို ရိုးရှင်းတဲ့ အစားအသောက် တွေ ချက်ပြုတ်လို့ရမလဲ? ', '일본의 조미료를 사용한 간단한 요리는 뭐가있나요? ', 'What are some simple dishes using Japanese seasonings?'),
(5, 1, '日本の季節ごとの食材を使った料理は？', '使用日本四季食材的料理有哪些? ', 'ဂျပန်မှာ ရာသီပေါ် အစားအသောက် သုံးပြီး ဘယ်လို အစားအသောက် တွေ ချက်ပြုတ်လို့ရမလဲ? ', '일본의 제철식재료를 사용한 요리는 뭐가있나요? ', 'What are dishes made with seasonal ingredients in Japan?'),
(6, 2, '日本のネットショッピングはどう利用しますか？', '如何使用日本的網購? ', 'ဂျပန်မှာ အွန်လိုင်းစျေးဝယ်ခြင်းကို ဘယ်လို သုံးမလဲ? ', '일본의 인터넷쇼핑은 어떻게 이용하나요? ', 'How to use online shopping in Japan?'),
(7, 2, '日本のフリーマーケットや中古品店で買い物をするには？', '如何在日本的跳蚤市場或二手商店購物? ', 'ဂျပန်မှာ လက်လီရောင်းချ ဈေးနှင့် အဟောင်းစျေးမှာ ဘယ်လို စျေးဝယ်မလဲ? ', '일본의 중고물품은 어떻게 사나요? ', 'How to shop at flea markets or secondhand stores in Japan?'),
(8, 2, '日本のスーパーで節約する方法は？', '在日本超市省錢的方法? ', 'ဂျပန်မှာ ကုန်တိုက်တွေမှာ ဘယ်လို  အသုံးစရိတ်ချွေတာပြီး စျေးဝယ်ကြမလဲ? ', '일본의 슈퍼에서 절약을할수있는 방법은 뭐가있나요? ', 'How to save money at supermarkets in Japan?'),
(9, 2, '日本ではどんな百貨店がありますか？', '在日本有哪些百貨店? ', 'ဂျပန်မှာ စတိုးဆိုင်ကြီးတွေမှာ စျေးဝယ်ရတာ ဘယ်လိုလဲ? ', '일본에는 어떤 백화점이 있나요? ', 'What department stores are there in Japan?'),
(10, 2, '日本のアウトレットモールはどこにありますか？', '日本的哪裡有outlet?', 'ဂျပန်မှာ Outlet ကုန်စျေးတွေ ဘယ်မှာရှိလဲ? ', '일본의 아울렛은 어디에 있나요? ', 'Where are the outlet malls in Japan?'),
(11, 3, '日本で病院に行くにはどうすればいいですか？', '若在日本要去醫院該怎麼辦? ', 'ဂျပန်မှာ ဆေးရုံကို ဘယ်လို သွားရမလဲ? ', '일본에서 병원을 가려면 어떻게 해야하나요? ', 'How do I go to a hospital in Japan?'),
(12, 3, '日本の薬局で薬を購入するには？', '在日本的藥局購買藥品的方法? ', 'ဂျပန်မှာ ဆေးဆိုင်တွေမှာ ဆေးဘယ်လို ဝယ်ရမလဲ? ', '일본의 약국에서 약을 사려면 어떻게 해야하나요? ', 'How to purchase medicine at a pharmacy in Japan?'),
(13, 3, '日本の健康診断はどのように受けられますか？', '如何在日本進行健康檢查? ', 'ဂျပန်မှာ ကျန်းမာရေး စစ်ဆေးမှု ဘယ်လို လုပ်ဆောင်ရမလဲ? ', '일본에서 건강검진은 어떻게 해야 받을수있나요? ', 'How can I get a health checkup in Japan?'),
(14, 3, '日本の予防接種はどうやって受けるのですか？', '如何在日本接踵疫苗? ', 'ဂျပန်မှာ ကာကွယ်ဆေး ထိုးရန် ဘယ်လို လုပ်ရမလဲ? ', '일본에서 예방접종은 어떻게 해야 받을수있나요? ', 'How do you receive vaccinations in Japan?'),
(15, 3, '日本で健康保険に加入するには？', '如何加入日本的健康保險? ', 'ဂျပန်မှာ ကျန်းမာရေး အာမခံ ဝင်ဖို့ ဘယ်လို လုပ်ရမလဲ?', '일본에서 건강보험에 가입하려면 어떻게 해야하나요? ', 'To enroll in health insurance in Japan, what do I need to do?'),
(16, 4, '口座を作るには何が必要ですか？', '在日本開戶需要準備什麼? ', 'ဘဏ်အကောင့် ဖွင့်ဖို့ ဘာတွေ လိုအပ်လဲ? ', '계좌를 만들기위해서 뭐가 필요한가요? ', 'What do I need to create an account?'),
(17, 4, '口座を作るにはどんな条件がありますか？', '日本開戶需要什麼條件? ', 'ဘဏ်အကောင့် ဖွင့်ဖို့ ဘယ်လိုအခြေအနေ တွေ လိုအပ်လဲ? ', '계좌를 만들려면 어떤 조건이 있나요? ', 'What are the conditions for opening an account?'),
(18, 4, 'どこの銀行で開設した方がいいですか？', '日本哪家銀行開戶比較好? ', 'ဘယ်ဘဏ်မှာ အကောင့် ဖွင့်ရမလဲ? ', '어느은행에서 계좌를 개설하는게 좋을까요? ', 'Which bank is best for opening an account?'),
(19, 4, '銀行口座は二つ以上作れないんですか?', '在日本可以辦理兩個以上的戶頭嗎? ', 'ဘဏ်အကောင့်တွေ နှစ်ခုထက်ပို ဖွင့်လို့ မရဘူးလား? ', '계좌는 두개이상 만들수 없나요? ', 'Can''t you have more than one bank account?'),
(20, 4, '帰国する時は口座はどうすればいいですか？', '回國時該怎麼處理銀行帳戶呢? ', 'နိုင်ငံပြန်တဲ့အချိန်မှာ ဘဏ်အကောင့်ကို ဘယ်လိုလုပ်ရမလဲ? ', '귀국할때 계좌는 어떻게 해야하나요? ', 'How should I handle my bank account when I return home?'),
(21, 5, '外国人が病院を受診するには何が必要ですか？', '歪國人在日本醫院受診需要準備什麼? ', 'နိုင်ငံခြားသားတွေ ဆေးရုံသွားဖို့ ဘာတွေ လိုအပ်လဲ? ', '외국인이 병원에서 진찰받으려면 무엇이 필요한가요? ', 'What is needed for foreigners to visit a hospital?'),
(22, 5, '外国人の診察を拒否できますか？', '外國人就診會被拒絕嗎? ', 'နိုင်ငံခြားသားတွေ ဆေးစစ်ခြင်းကို ငြင်းပယ်လို့ ရလား? ', '외국인의 진찰을 거부하는 경우가 있나요? ', 'Will foreigners be denied medical treatment?'),
(23, 5, '外国人は医療保険が適用されますか？', '外國人適用醫療保險嗎? ', 'နိုင်ငံခြားသားတွေ ကျန်းမာရေး အာမခံ အကျုံးဝင်လား? ', '외국인은 의료보험이 적용되나요? ', 'Are foreigners eligible for health insurance?'),
(24, 5, '日本の保険なしだと医療費はいくらになりますか？', '如果沒有日本的健保，醫療費用會是多少? ', 'ဂျပန်မှာ အာမခံ မပါဘူးဆိုရင် ဆေးကုန်ကျစရိတ် ဘယ်လောက်ဖြစ်မလဲ? ', '일본에서 보험에 가입되어있지 않다면 의료비는 얼마나 되나요? ', 'How much does medical care cost without insurance in Japan?'),
(25, 5, '診察料はどこも同じですか？', '掛號費在不論哪家醫院都是一樣的嗎?', 'ဆေးရုံအများစုမှာ ဆေးစစ်ခကျသင့်ငွေက တူညီပါသလား? ', '진찰료는 병원마다 다 같나요? ', 'Are consultation fees the same everywhere?'),
(26, 6, '外国人が転入するには何が必要ですか？', '外國人入住日本需要準備什麼? ', 'နိုင်ငံခြားသားများ ဂျပန်တွင် အိမ်ပြောင်းရွေ့ရန် ဘာတွေ လိုအပ်လဲ?', '외국인이 전입을하기위해 필요한것은 뭐가있나요?', 'What is required for foreigners to move in?'),
(27, 6, '在留更新はどこで申請するのですか？', '在留卡的更新在哪辦理?', 'နေထိုင်ခွင့်သက်တမ်းတိုးဖို့ ဘယ်မှာ လျှောက်ထားရမလဲ?', '재류갱신은 어디서 신청하나요?', 'Where do I apply for a visa renewal?'),
(28, 6, '外国籍でもマイナンバーカードは取得できますか？', '外國籍的人也可以取得個人編號卡嗎? ', 'နိုင်ငံခြားသားတွေ My Numberကဒ် ရရှိနိုင်ပါသလား? ', '외국적이여도 마이넘버카드를 취득할수있나요? ', 'Can foreigners obtain a My Number card?'),
(29, 6, '在留カードを紛失したらどうすればいいですか？', '若遺失在留卡應該如何處理?', 'နေထိုင်ခွင့်ကတ်ကို ပျောက်ဆုံးသွားရင် ဘာလုပ်ရမလဲ', '재류카드를 잃어버렸을떄', 'If you lose your residence card, what should you do?'),
(30, 6, '外国人のマイナンバーカードの取得は義務ですか？', '外國人有義務取得個人編號卡嗎?', 'နိုင်ငံခြားသားတွေအနေနဲ့ My Number ကဒ်မဖြစ်မနေ ယူရန် ဥပဒေပြဠာန်းရှိပါသလား', '외국인의 마이넘버카드의 취득은 의무적인가요?', 'Is it mandatory for foreigners to obtain a My Number card?'),
(31, 7, '暴行を受けた際に警察に通報するには？', '若遭遇暴行該如何報警? ', 'အကြမ်းဖက်ခံရရင် ရဲကိုဘယ်လိုတိုင်ကြားရမလဲ? ', '폭행을 당했을때 경찰한테 어떻게 신고하나요? ', 'To report an assault to the police, what should I do?'),
(32, 7, '医療機関で診断書を取得するには？', '如何在醫療機構取得診斷書? ', 'ဆေးရုံကနေဆရာဝန်ညွှန်ကြားချက်စာရယူဖို့ ဘာလုပ်ရမလဲ? ', '의료기관에서 진단서를 취득하려면 어떻게 해야하나요? ', 'How can I obtain a medical certificate from a medical institution?'),
(33, 7, '弁護士に相談する方法は?', '向律師諮詢的方法?', 'ရှေ့နေတွေဆီမှာ တိုင်ကြားဖို့ ဘာလုပ်ရမလဲ?', '변호사와 상담하려면 어떻게 해야하나요? ', 'How to consult with a lawyer?'),
(34, 7, '大使館または領事館のサポートを受けるには？', '如何在大使館或領事館取得支援? ', 'သံရုံး သို့မဟုတ် အထွေထွေသံရုံးရဲ့ အကူအညီကို ဘယ်လိုရယူမလဲ? ', '대사관,영사관에게 도움을 받으려면 어떻게 해야하나요? ', 'How can I receive support from an embassy or consulate?'),
(35, 7, '証拠を保存する方法は？', '保存證據的方法有哪些?', 'အထောက်အထားတွေကို ဘယ်လိုသိမ်းဆည်းမလဲ?', '증거를 보존하는 방법은 어떤게 있을까요?', 'How to preserve evidence?'),
(36, 8, '交通事故を起こした際に警察に通報するには？', '遭遇交通意外時該如何報警?', 'ယာဉ်မတော်တဆမှုတစ်ခုဖြစ်ခဲ့ရင် ရဲကိုဘယ်လို တိုင်ကြားရမလဲ?', '교통사고를 일으켰을때에 어떻게 경찰에게 신고하나요?', 'How to report a traffic accident to the police?'),
(37, 8, '医療機関で診察を受けるには？', '如何到醫療機構檢查? ', 'ဆေးရုံမှာ စစ်ဆေးခွင့်ရဖို့ ဘာလုပ်ရမလဲ? ', '의료기관에서 진찰을 받으려면 어떻게 해야하나요?', 'How to receive medical treatment at a healthcare facility?'),
(38, 8, '保険会社に連絡するには？', '該如何聯絡保險公司?', 'အာမခံကုမ္ပဏီကို ဘယ်လိုဆက်သွယ်မလဲ?', '보험회사에게 연락하려면 어떻게 해야하나요?', 'How can I contact an insurance company?'),
(39, 8, '目撃者の連絡先を確保するには？', '如何確保目擊證人的聯絡資料?', 'မျက်မြင်သက်သေတွေရဲ့ ဆက်သွယ်ရန်လိပ်စာကို ဘယ်လိုရမလဲ?', '목격자의 연락처를 확보하려면 어떻게 해야하나요?', 'How to secure the contact information of eyewitnesses?'),
(40, 8, '事故現場の証拠を保存するには？', '如何保存事故現在的證據?', 'မတော်တဆမှုဖြစ်ပွားရာနေရာက အထောက်အထားတွေကို ဘယ်လို သိမ်းဆည်းမလဲ?', '사고현장의 증거를 보전하려면 어떻게 해야하나요?', 'How to preserve evidence at an accident scene?'),
(41, 9, 'ハラスメントの種類と定義は何ですか？', '職場騷擾的類型和定義是什麼?', 'နှောင့်ယှက်မှု(Harassment )အမျိုးအစားများနှင့် အဓိပ္ပာယ်များက ဘာတွေများလဲ?', '직장내 괴롭힘에는 종류가 있고 정확하게 무엇인가요?', 'What are the types and definitions of harassment?'),
(42, 9, 'ハラスメントを受けた場合の初期対応はどうすればいいですか？', '若受到職場騷擾時該如何應對?', 'နှောင့်ယှက်မှုခံရသောအခါ စတင်ပြုလုပ်သင့်သည့် အရေးယူမှုများက ဘာတွေလဲ?', '직장내 괴롭힘을 당했을시 초기대응은 어떻게 해야하나요?', 'If you experience harassment, what should you do for initial response?'),
(43, 9, '職場での対応方法はどうすればいいですか？', '應如何應對職場的情況?', 'အလုပ်ခွင်တွင် နှောင့်ယှက်ခံရလျှင် ကိုယ့်ကိုကိုယ် ဘယ်လို ပြန်လည်ကာကွယ်ရမလဲ?', '장 내에서의 대응방법은 어떻게 해야하나요?', 'How should I handle the situation at work?'),
(44, 9, '性のハラスメント（セクシャルハラスメント）に関する基準と対応方法は？', '關於職場性騷擾的基準與對應方法?', 'လိင်မှုဆိုင်ရာနှောင့်ယှက်မှုနှင့်ပတ်သက်၍  တုန့်ပြန်ဆောင်ရွက်ရမည့် နည်းလမ်းများက ဘာတွေလဲ?', '성희롱에 관한 기준과 대응방법은 무엇이 있나요?', 'The criteria and response methods for sexual harassment are?'),
(45, 9, 'セクシャルハラスメントの具体例', '性騷擾的例子', 'လိင်မှုဆိုင်ရာနှောင့်ယှက်မှု၏ တိကျသည့် ဥပမာများက ဘာတွေလဲ?', '성희롱의 예시', 'Examples of sexual harassment');

-- --------------------------------------------------------

--
-- テーブルの構造 `translations`
--

CREATE TABLE `translations` (
  `id` int NOT NULL,
  `key_name` varchar(255) NOT NULL,
  `JP` varchar(255) DEFAULT NULL,
  `CH` varchar(255) DEFAULT NULL,
  `BUR` varchar(255) DEFAULT NULL,
  `KR` varchar(255) DEFAULT NULL,
  `EN` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- テーブルのデータのダンプ `translations`
--

INSERT INTO `translations` (`id`, `key_name`, `JP`, `CH`, `BUR`, `KR`, `EN`) VALUES
(1, 'contact', 'お問い合わせ', '聯繫我們', 'ဆက်သွယ်ရန်', '문의하기', 'Contact Us'),
(2, 'detail', '詳細を見る', '查看詳細資料', 'အသေးစိတ်ကြည့်ရန်', '자세히 보기', 'Click Here For More Info! ');

-- --------------------------------------------------------

--
-- テーブルの構造 `users`
--

CREATE TABLE `users` (
  `key` int NOT NULL,
  `user_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `profile_picture` varchar(255) DEFAULT 'default.png'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- テーブルのデータのダンプ `users`
--

INSERT INTO `users` (`key`, `user_id`, `username`, `email`, `password`, `profile_picture`) VALUES
(40, 'hiro', 'hiro', 'hiro@gmail.com', '$2y$10$5s86m0MXk4.5069yMJjshu4ROWq9nQds4T4Jcq3Y5yJ5CjqSy7hK6', 'default.png'),
(41, 'hui', 'hui', 'yin_omz@yahoo.co.jp', '$2y$10$jdPcOCcYh5RyMpUpLlQk8uYtsXaFqetirYcE/tcx8FwRs4L.iq0ki', '008.jpg'),
(43, 'asds', 'aasdadas', 'tqsdsa@ad.co.lr', '$2y$10$iKzdcflPyKFxZAQ4eM99CuBopM5gvVsZUBUdYRff/ZkiLosCKuhk6', 'default.png'),
(44, 'dage', 'asd123', 'asd2@sc.o.kr', '$2y$10$0ANDJHSRswkkAij3H8fNtOFkhFOHYZPFZaqeNZZWU0.4SfX9okoDK', 'default.png'),
(45, '5454', '5454', 'hiro5454@gmail.com', '$2y$10$mw5JVMQ21/bCqdZH4Ra5/.k.m9AqPSKkOJDJJ5aoSVlRZb79kVAx6', 'default.png'),
(46, 'asdsad', 'qsd2131', 'sesd@das.co.kr', '$2y$10$Le1gOhH5rLO0jsuJoSL3yuxDf2F9N3GstETJsZlT0StSqO670ggfm', 'default.png'),
(47, 'sqh', 'sqh', 'qwer@cxx.com', '$2y$10$334jMcRw5/fbgs05PIoshewoGjRZ5XuTXMBlv9fyJtbnbfC/sRhq6', 'default.png');

--
-- ダンプしたテーブルのインデックス
--

--
-- テーブルのインデックス `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`category_id`);

--
-- テーブルのインデックス `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`comment_id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `user_key` (`user_key`);

--
-- テーブルのインデックス `contents`
--
ALTER TABLE `contents`
  ADD PRIMARY KEY (`content_id`);

--
-- テーブルのインデックス `detail_img`
--
ALTER TABLE `detail_img`
  ADD PRIMARY KEY (`img_id`),
  ADD KEY `title_id` (`title_id`);

--
-- テーブルのインデックス `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`language_id`);

--
-- テーブルのインデックス `likes`
--
ALTER TABLE `likes`
  ADD PRIMARY KEY (`like_id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `user_key` (`user_key`);

--
-- テーブルのインデックス `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`post_id`),
  ADD KEY `user_key` (`user_key`);

--
-- テーブルのインデックス `shares`
--
ALTER TABLE `shares`
  ADD PRIMARY KEY (`share_id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `user_key` (`user_key`);

--
-- テーブルのインデックス `subcategory`
--
ALTER TABLE `subcategory`
  ADD PRIMARY KEY (`subcategory_id`),
  ADD KEY `FK_category_id` (`category_id`);

--
-- テーブルのインデックス `title`
--
ALTER TABLE `title`
  ADD PRIMARY KEY (`title_id`),
  ADD KEY `FK_subcategory_id` (`subcategory_id`);

--
-- テーブルのインデックス `translations`
--
ALTER TABLE `translations`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`key`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- ダンプしたテーブルの AUTO_INCREMENT
--

--
-- テーブルの AUTO_INCREMENT `comments`
--
ALTER TABLE `comments`
  MODIFY `comment_id` int NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `contents`
--
ALTER TABLE `contents`
  MODIFY `content_id` int NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `likes`
--
ALTER TABLE `likes`
  MODIFY `like_id` int NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `posts`
--
ALTER TABLE `posts`
  MODIFY `post_id` int NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `shares`
--
ALTER TABLE `shares`
  MODIFY `share_id` int NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `translations`
--
ALTER TABLE `translations`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- テーブルの AUTO_INCREMENT `users`
--
ALTER TABLE `users`
  MODIFY `key` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- ダンプしたテーブルの制約
--

--
-- テーブルの制約 `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`user_key`) REFERENCES `users` (`key`) ON DELETE CASCADE;

--
-- テーブルの制約 `detail_img`
--
ALTER TABLE `detail_img`
  ADD CONSTRAINT `detail_img_ibfk_1` FOREIGN KEY (`title_id`) REFERENCES `title` (`title_id`);

--
-- テーブルの制約 `likes`
--
ALTER TABLE `likes`
  ADD CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `likes_ibfk_2` FOREIGN KEY (`user_key`) REFERENCES `users` (`key`) ON DELETE CASCADE;

--
-- テーブルの制約 `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`user_key`) REFERENCES `users` (`key`) ON DELETE CASCADE;

--
-- テーブルの制約 `shares`
--
ALTER TABLE `shares`
  ADD CONSTRAINT `shares_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `shares_ibfk_2` FOREIGN KEY (`user_key`) REFERENCES `users` (`key`) ON DELETE CASCADE;

--
-- テーブルの制約 `subcategory`
--
ALTER TABLE `subcategory`
  ADD CONSTRAINT `FK_CategoryID` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`);

--
-- テーブルの制約 `title`
--
ALTER TABLE `title`
  ADD CONSTRAINT `FK_subcategory_id` FOREIGN KEY (`subcategory_id`) REFERENCES `subcategory` (`subcategory_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
