document.addEventListener('DOMContentLoaded', () => {
    console.log('Document loaded');
    fetch('../Form/Forum/User/nationalities.html')
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.text();
        })
        .then(data => {
            console.log('Nationalities loaded:', data);
            document.getElementById('nationality').innerHTML = data;
        })
        .catch(error => console.error('Error loading nationalities:', error));
});

