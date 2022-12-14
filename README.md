# Лабораторна робота **№3** (Операційні системи)
<br>

## Виконав студент **3** курсу **ІПЗ 1.2** - **Зубанич І.М**
<br>

## **Тема:** Docker.
<br>

### **Хід роботи**
### **1)** Зтягнути готовий образ **wordpress** з **DockerHub** та розгорнути за допомогою нього сайт із безкоштовною темою, використовуючи готовий `docker-compose.yml`.
<br>

Cтворив файл `docker-compose.yml` та скопіював до нього весь вміст із завдання лабораторної роботи №3.
![screenshot](/assets/Screenshot_1.png)

<br>

Прописав команду `sudo docker-compose up -d` яка створює та запускає контейнери для сервісів, які були прописані в `docker-compose.yml`.
![screenshot](/assets/Screenshot_2.png)

<br>

Далі переходжу до **http://localhost:8080** та створюю профіль на **WordPress** і авторизовуюсь.
![screenshot](/assets/Screenshot_3.png)

<br>

Після чого, переходжу з адмін-панелі до **http://localhost:8080** де вже є готовий сайт.
![screenshot](/assets/Screenshot_4.png)

<br>

### **2) Docker Compose**.
**Docker-compose** - інструмент у вигляді конфігураційного файлу, завдяки якому є можливість керувати відразу двома і більше сервісами (контейнерами), тобто створювати, запускати, видаляти контейнери для сервісів.<br>

**Переваги YML**:
- yml-конфігурацію легко зрозуміти

- можна використовувати для налаштування (від передачі даних до зберігання проміжних даних)

**Недоліки YML**:
- у програмах, які використовують XML/JSON, складно перейти на YML конфігурацію   

- надто чутливий синтаксис. Якщо неправильно вставити/пропустити пробіл під час відступу, тоді код може перестати працювати.

- YML є досить складним для розробки, оскільки в ньому існує багато способів представлення даних і створення ієрархії

<br>

**Docker'om-compose** варто скористатися, якщо додаток містить декілька сервісів. При написанні конфігураційного файлу ми вказуємо, які саме образи нам потрібно зтягнути з **DockerHub** і на основі них вже створити та запустити контейнери. До прикладу, в першому пункті завдання, для того, щоб розгорнути сайт на **WordPress**, мені необхідно було зтягнути декілька образів (сам вордпресс та БД mysql), після чого, запустити створені контейнери. Із використанням `Docker-compose.yml` мені було достатньо всього лише ввести дві команди, після чого сайт успішно запустився.

<br>

### **3)** Cтворення HTML-сторінки та занесення її в **Docker Image**. Залити даний **Docker Image** на **Docker Hub**.

<br>

Створюю `Dockerfile`, `index.html` та `style.css` у каталозі **lab3**:
![screenshot](/assets/Screenshot_6.png)

Вигляд HTML-сторінки:
![screenshot](/assets/Screenshot_5.png)

<br>

Надаю дозвіл для читання файлів `index.html` та `style.css`.
![screenshot](/assets/Screenshot_7.png)

<br>

Після чого, вказую в `Dockerfile` що потрібно взяти образ `nginx:alpine` (за допомогою якого запускатиметься html-сторінка в контейнері) та шлях до каталогу, в який необхідно скопіювати `index.html` та `style.css`.
![screenshot](/assets/Screenshot_8.png)

<br>

Далі складаю образ, вказуючи заголовок та тег образу, і шлях, де знаходиться прописаний мною конфігураційний `Dockerfile`.
![screenshot](/assets/Screenshot_9.png)

<br>

Створив за запустив **docker container** на основі попередньо створеного образу на внутрішньому порті **80**, зовнішньому **8086**.
![screenshot](/assets/Screenshot_10.png)

<br>

Перейшов до **http://localhost:8086**, де побачив свою HTML-сторінку.
![screenshot](/assets/Screenshot_11.png)

<br>

Переконавшись, що все працює, заливаю даний образ на **DockerHub**, попередньо залогінившись.
![screenshot](/assets/Screenshot_12.png)

<br>

![screenshot](/assets/Screenshot_13.png)

<br>

**Docker image** на **DockerHub**:
![screenshot](/assets/Screenshot_14.png)

<br>

### **4)** Скачати Docker Image когось із групи і розвернути в себе контейнер з HTML сторінкою на порті 8086 ззовні.

Перейшов до наданого репозиторію Гобоною Владиславом Михайловичем та зтягнув його **docker image**.
![screenshot](/assets/Screenshot_15.png)
![screenshot](/assets/Screenshot_16.png)

<br>

Створив за запустив **docker container** на основі створеного Владиславом образу на внутрішньому порті **80**, зовнішньому **8086**. 
![screenshot](/assets/Screenshot_17.png)

<br>

Перейшов до **http://localhost:8086**, де побачив HTML-сторінку Владислава.
![screenshot](/assets/Screenshot_18.png)


### **Висновки:**
Протягом виконання Лабораторної роботи №3 з ОС я познайомився з концепцією Docker`а, його основними поняттями та також отримав базові навички роботи з ним.<br>Основні досягнення, які я здобув, виконуючи цю лабораторну роботу:
- зрозумів, що таке docker image і для чого він потрібен
- зрозумів, що таке docker container
- освоїв базові команди для роботи з docker images & containers
- зрозумів, що таке docker-compose і яка його основна роль 