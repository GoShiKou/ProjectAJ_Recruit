function showContent(buttonNumber) {
    var content1 = document.getElementById("content1");
    var content2 = document.getElementById("content2");
    
    if (buttonNumber === 1) {
        content1.style.display = "block";
        content2.style.display = "none";
        } else {
        content1.style.display = "none";
        content2.style.display = "block";
        }
    }