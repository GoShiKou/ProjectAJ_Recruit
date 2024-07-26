document.addEventListener('DOMContentLoaded', () => {
    const navbar = document.getElementById('navbar');

    window.addEventListener('mousemove', (e) => {
        if (e.clientY < 70) {
            navbar.classList.add('visible');
        } else {
            navbar.classList.remove('visible');
        }
    });

    const modals = document.querySelectorAll('.modal');
    modals.forEach(modal => {
        modal.style.display = 'none';
    });

    document.querySelectorAll('.close').forEach(closeButton => {
        closeButton.addEventListener('click', function () {
            clearErrorsAndFields();
            const modal = this.closest('.modal');
            modal.style.display = 'none';
        });
    });

    document.getElementById("showContent1").addEventListener("click", function (event) {
        event.preventDefault();
        showContentDetails(1);
    });

    document.getElementById("showContent2").addEventListener("click", function (event) {
        event.preventDefault();
        showContentDetails(2);
    });

    document.getElementById("showContent3").addEventListener("click", function (event) {
        event.preventDefault();
        showContentDetails(3);
    });

    document.getElementById("contact_link").addEventListener("click", function (event) {
        event.preventDefault();
        showContentDetails('contact');
    });

    updateMenuItems();
    addMenuEventListeners();

    document.getElementById('language-selector').addEventListener('change', function (event) {
        changeLanguage(this);
    });

    const loginBtn = document.getElementById('loginBtn');
    const loginModal = document.getElementById('loginModal');

    console.log('loginBtn:', loginBtn); // Debugging line
    console.log('loginModal:', loginModal); // Debugging line

    if (loginBtn) {
        loginBtn.addEventListener('click', function () {
            showLogin();
        });
    } else {
        console.error('Login button with id "loginBtn" not found');
    }

    window.addEventListener('click', (event) => {
        if (event.target === loginModal) {
            loginModal.style.display = 'none';
        }
    });

    const chatBtn = document.querySelector('.chat-btn');
    chatBtn.addEventListener('click', function (event) {
        if (!loggedIn) {
            event.preventDefault();
            document.getElementById('loginRequiredModal').style.display = 'flex';
        } else {
            window.location.href = './chatCommunity.html';
        }
    });
});

function updateMenuItems() {
    const menuContainer = document.getElementById('menuContainer');
    menuContainer.innerHTML = '';

    categories.forEach(category => {
        const menuItem = document.createElement('a');
        menuItem.className = 'menu-item';
        menuItem.id = `showContent${category.category_id}`;
        menuItem.href = '#';
        menuItem.innerHTML = `
            <i class="fa-solid ${categoryIcons[category.category_id]}"></i>
            <p style="padding: 1px; font-size: 20px;">${category[selectedLang]}</p>
        `;
        menuContainer.appendChild(menuItem);
    });

    addMenuEventListeners();
}

function addMenuEventListeners() {
    categories.forEach(category => {
        document.getElementById(`showContent${category.category_id}`).addEventListener('click', function (event) {
            event.preventDefault();
            showContentDetails(category.category_id);
        });
    });
}

function showContentDetails(categoryId) {
    const menuContent = document.getElementById('menuContent');
    menuContent.innerHTML = '';

    const filteredSubcategories = subcategories.filter(subcategory => subcategory.category_id == categoryId);
    filteredSubcategories.forEach(subcategory => {
        const contentDetail = document.createElement('div');
        contentDetail.className = 'content-detail';
        contentDetail.innerHTML = `
            <p>${subcategory[selectedLang]}</p>
        `;
        contentDetail.addEventListener('click', () => {
            window.location.href = subcategory.url;
        });
        menuContent.appendChild(contentDetail);
    });

    const details = document.querySelectorAll('.content-detail');
    details.forEach(detail => {
        detail.style.display = 'block';
        detail.style.animation = 'contentFadeIn 0.5s forwards';
    });
}

function changeLanguage(selector) {
    const selectedLanguage = selector.value;
    const urlParams = new URLSearchParams(window.location.search);
    urlParams.set('lang', selectedLanguage);
    window.location.search = urlParams.toString();
}

function checkPasswords() {
    const password = document.getElementById("password").value;
    const confirmPassword = document.getElementById("confirmPassword").value;
    const message = document.getElementById("message");
    if (password) {
        if (password === confirmPassword) {
            message.style.color = "green";
            message.textContent = "パスワードが一致します";
        } else {
            message.style.color = "red";
            message.textContent = "パスワードが一致しません";
        }
    }
}

function showLogin() {
    document.getElementById('loginModal').style.display = 'flex';
}

function closeLogin() {
    document.getElementById('loginModal').style.display = 'none';
}

function showCreateAccount() {
    document.getElementById('createAccountModal').style.display = 'flex';
    document.getElementById('loginModal').style.display = 'none';
}

function closeCreateAccount() {
    document.getElementById('createAccountModal').style.display = 'none';
}

function showAccountConfirm() {
    document.getElementById('accountConfirmModal').style.display = 'flex';
}

function closeAccountConfirm() {
    document.getElementById('accountConfirmModal').style.display = 'none';
}

function showWelcomeModal(username) {
    document.getElementById('welcomeUsername').innerText = username;
    const welcomeModal = document.getElementById('welcomeModal');
    welcomeModal.style.display = 'flex';

    setTimeout(() => {
        welcomeModal.style.display = 'none';
    }, 3000); // 3초 후 모달 닫기
}

function closeWelcomeModal() {
    document.getElementById('welcomeModal').style.display = 'none';
}

function saveAndShowConfirm() {
    const id = document.getElementById('id').value;
    const username = document.getElementById('username').value;
    const password = document.getElementById('password').value;
    const confirmPassword = document.getElementById('confirmPassword').value;
    const email = document.getElementById('email').value;
    const idError = document.getElementById('id-error');
    const usernameError = document.getElementById('username-error');
    const passwordError = document.getElementById('password-error');
    const confirmPasswordError = document.getElementById('confirm-password-error');
    const emailError = document.getElementById('email-error');

    // Clear previous error messages
    idError.textContent = '';
    usernameError.textContent = '';
    passwordError.textContent = '';
    confirmPasswordError.textContent = '';
    emailError.textContent = '';

    let hasError = false;

    if (id === '') {
        idError.textContent = '入力してください。';
        hasError = true;
    } else if (id.length < 3 || id.length > 15) {
        idError.textContent = 'ログインIDは3文字以上、15文字以下で入力してください。';
        hasError = true;
    }

    if (username === '') {
        usernameError.textContent = '入力してください。';
        hasError = true;
    } else if (username.length > 50) {
        usernameError.textContent = 'ユーザー名は最大50文字です。';
        hasError = true;
    }

    if (password === '') {
        passwordError.textContent = '入力してください。';
        hasError = true;
    } else if (password.length < 6 || password.length > 15) {
        passwordError.textContent = 'パスワードは6文字以上、15文字以下で入力してください。';
        hasError = true;
    }

    if (confirmPassword === '') {
        confirmPasswordError.textContent = '入力してください。';
        hasError = true;
    } else if (password !== confirmPassword) {
        confirmPasswordError.textContent = 'パスワードが一致しません。';
        hasError = true;
    }

    if (email === '') {
        emailError.textContent = '入力してください。';
        hasError = true;
    } else if (!validateEmail(email)) {
        emailError.textContent = '有効なメールアドレスを入力してください。';
        hasError = true;
    }

    if (hasError) {
        return;
    }

    // Send data to the server to check for duplicates
    const formData = new FormData();
    formData.append('id', id);
    formData.append('username', username);
    formData.append('password', password);
    formData.append('email', email);

    fetch('user_check.php', {
        method: 'POST',
        body: formData
    })
        .then(response => response.json())
        .then(result => {
            if (result.status === 'success') {
                // Display confirmation modal
                document.getElementById('displayID').innerText = id;
                document.getElementById('displayUsername').innerText = username;
                document.getElementById('createAccountModal').style.display = 'none';
                document.getElementById('accountConfirmModal').style.display = 'flex';

                document.getElementById('accountConfirmModal').querySelector('.submit input').onclick = function () {
                    // Send data to the server to save in the database
                    fetch('user_registration.php', {
                        method: 'POST',
                        body: formData
                    })
                        .then(response => response.json())
                        .then(result => {
                            if (result.status === 'success') {
                                alert('登録が完了しました');
                                document.getElementById('accountConfirmModal').style.display = 'none';
                                clearErrorsAndFields();
                            } else {
                                alert('登録中にエラーが発生しました');
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            alert('登録中にエラーが発生しました');
                        });
                };
            } else if (result.status === 'error' && result.field) {
                if (result.field === 'id') {
                    idError.textContent = result.message;
                } else if (result.field === 'username') {
                    usernameError.textContent = result.message;
                } else if (result.field === 'email') {
                    emailError.textContent = result.message;
                }
            } else {
                alert('登録中にエラーが発生しました');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('登録中にエラーが発生しました');
        });
}

function validateEmail(email) {
    const re = /^[^\s@]+@[^\s@]+$/;
    return re.test(email);
}

function clearErrorsAndFields() {
    document.getElementById('id').value = '';
    document.getElementById('username').value = '';
    document.getElementById('password').value = '';
    document.getElementById('confirmPassword').value = '';
    document.getElementById('email').value = '';
    document.getElementById('id-error').textContent = '';
    document.getElementById('username-error').textContent = '';
    document.getElementById('password-error').textContent = '';
    document.getElementById('confirm-password-error').textContent = '';
    document.getElementById('email-error').textContent = '';
    document.getElementById('message').textContent = '';
}

function handleLogin(event) {
    event.preventDefault();

    const id = document.querySelector('.login_id input').value;
    const password = document.querySelector('.login_pw input').value;

    const idError = document.getElementById('login-id-error');
    const passwordError = document.getElementById('login-password-error');
    if (idError) idError.textContent = '';
    if (passwordError) passwordError.textContent = '';

    const formData = new FormData();
    formData.append('id', id);
    formData.append('password', password);

    fetch('login_check.php', {
        method: 'POST',
        body: formData
    })
        .then(response => response.json())
        .then(result => {
            if (result.status === 'success') {
                showWelcomeModal(result.username);
                setTimeout(() => {
                    closeWelcomeModal();
                    location.reload();
                }, 1200);
            } else {
                if (result.field === 'id') {
                    if (!idError) {
                        const newIdError = document.createElement('span');
                        newIdError.id = 'login-id-error';
                        newIdError.style.color = 'red';
                        document.querySelector('.login_id').appendChild(newIdError);
                    }
                    document.getElementById('login-id-error').textContent = result.message;
                } else if (result.field === 'password') {
                    if (!passwordError) {
                        const newPasswordError = document.createElement('span');
                        newPasswordError.id = 'login-password-error';
                        newPasswordError.style.color = 'red';
                        document.querySelector('.login_pw').appendChild(newPasswordError);
                    }
                    document.getElementById('login-password-error').textContent = result.message;
                } else {
                    alert(result.message);
                }
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('ログイン中にエラーが発生しました');
        });
}

function logout() {
    fetch('logout.php', {
        method: 'POST'
    }).then(response => response.json())
        .then(result => {
            if (result.status === 'success') {
                location.reload();
            }
        });
}

function closeLoginRequiredModal() {
    document.getElementById('loginRequiredModal').style.display = 'none';
}
