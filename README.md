# First_App


Это приложение для тренировок, которое использует базу данных Realm и содержит основные паттерны проектирования, а также верстку только за счет кода.

## Функциональность
- Просмотр списка упражнений.
- Добавление / удаление новых упражнений в базу данных.
- Старт тренировки, включая выбор списка упражнений и отображение таймера с обратным отсчетом до окончания тренировки.
- Сохранение результатов тренировки в базе данных для последующего просмотра.

## Использованные технологии
- База данных Realm для хранения информации об упражнениях и результатах тренировки.
- Основные паттерны проектирования используются, чтобы сделать код более читаемым, поддерживаемым и расширяемым.
- Верстка только за счет кода с использованием фреймворка Autolayout.

## Установка
- Скачайте или клонируйте репозиторий.
- Откройте файл проекта `First_App.xcodeproj` в Xcode.
- Установите Realm через CocoaPods.
- Синхронизируйте проект в Xcode.

## Использование
- Запустите приложение на симуляторе или устройстве.
- Нажмите на кнопку с изображением в правом верхнем углу на главной странице, чтобы просмотреть список добавленных упражнений.
- Нажмите на кнопку 'Add Workout', чтобы добавить новое упражнение в базу данных.
- Нажмите на кнопку 'Start', чтобы начать выбранную тренировку.
- Когда тренировка закончится, результаты будут сохранены в базе данных и можно просмотреть их в списке результатов.

