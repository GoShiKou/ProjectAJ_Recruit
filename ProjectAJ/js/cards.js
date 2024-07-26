// 詳細を見るボタンにイベントリスナーを追加
const buttons = document.querySelectorAll('.card-button');
buttons.forEach(button => {
    button.addEventListener('click', showDetails);
});

function showDetails(event) {
    event.preventDefault();
    const button = event.target;
    const title = button.getAttribute('data-title');
    const content = button.getAttribute('data-content');
    
    const dialog = document.getElementById('infoDialog');
    
    // ダイアログの内容を設定
    dialog.querySelector('h3').textContent = title;
    dialog.querySelector('p').innerHTML = content;
    
    // ダイアログを表示
    dialog.showModal();
}

document.addEventListener('DOMContentLoaded', function() {
    const dialog = document.getElementById('infoDialog');
    const closeBtn = document.getElementById('closeBtn');

    // 閉じるボタンをクリックしたときの処理
    closeBtn.addEventListener('click', function() {
        closeDialog();
    });

    // ダイアログの外側をクリックしたときの処理
    dialog.addEventListener('click', function(event) {
        if (event.target === dialog) {
            closeDialog();
        }
    });

    // ダイアログを閉じる関数
    function closeDialog() {
        dialog.classList.add('closing');
        dialog.addEventListener('animationend', () => {
            dialog.classList.remove('closing');
            dialog.close();
        }, { once: true });
    }
});
