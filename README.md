# Сайт кафедры РИС

## Запуск

Сайт лучше всего разрабатывать под Linux и Mac OS X. Запускайте в Windows только
на свой страх и риск — а лучше поставьте Ubuntu в виртуальную машину.

1. Для контролем за изменениями вам потребуется Git. Например, в Ubuntu его
   можно установить с помощью:
   
        apt-get install git
   
2. Настройте Git указав своё имя и адрес эл. почты. Например:
   
        git config --global user.name "Ivan Ivanov"
        git config --global user.email ivanov@example.com
   
3. Скопируйте исходный код сайта себе на компьютер в нужную папку:
   
        git clone git@github.com:spbstu-dis/dis.spbstu.ru.git

4. Установите Ruby 1.9. Например, в Ubuntu:
   
        apt-get install ruby-1.9.1 ruby1.9.1-dev
   
5. Установите гем Bundler, для контроля зависимостей и установки библиотек.
   Например, в Ubuntu:
   
        sudo gem1.9.1 install bundler
   
6. Установите базу данных MongoDB (см. <http://mongodb.org/downloads>). Для
   Ubuntu надо добавить сторонний репозиторий:
   
        sudo apt-add-repository 'http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen'
        sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
        sudo apt-get update
        sudo apt-get install mongodb-10gen
   
7. Установите все необходимые библиотеки. Для этого выполните команду в папке
   сайта:
   
        bundle install --path=.bundle
   
8. Создайте файл настроек MongoDB:
   
        bundle exec rails generate mongoid:config
   
9. Запустите встроенный веб-сервер:
   
        bundle exec thin start
   
10. Откройте в браузере <http://localhost:3000>.
