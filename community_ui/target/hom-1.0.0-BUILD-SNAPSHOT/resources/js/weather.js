
    $(document).ready(function() {
        $.ajax({
            url: 'https://api.openweathermap.org/data/2.5/weather?q=Suwon&appid=326651fb6b9048542d6794ce07aba48f&units=metric',
            method: 'GET',
            success: function(data) {
                $('.temperature').text(data.main.temp + ' °C');
                $('.place').text(data.name);
                $('.description').text(data.weather[0].description);
            },
            error: function() {
                $('.weather-info').html('<p>날씨 정보를 가져오는 데 실패했습니다.</p>');
            }
        });

            // Replace 'YOUR_API_KEY' with your actual OpenWeatherMap API key
        const button = document.querySelector('.button');
        const iconSection = document.querySelector('.icon');

        button.addEventListener('click', () => {
            console.log(button);
            const getWeather = (lat, lon) => {
                fetch(`https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=326651fb6b9048542d6794ce07aba48f&units=metric`)
                    .then((response) => response.json())
                    .then((json) => {
                        const icon = json.weather[0].icon;
                        const iconURL = `http://openweathermap.org/img/wn/${icon}@2x.png`;

                        iconSection.setAttribute('src', iconURL);
                    })
                    .catch((error) => {
                        console.error('Error fetching weather data:', error);
                    });
            }

            // Example coordinates for Suwon

            iconSection.setAttribute('alt', 'Weather Icon');
            iconSection.setAttribute('class', 'icon');
            iconSection.setAttribute('src', 'http://openweathermap.org/img/wn/10d@2x.png');
    });

});
