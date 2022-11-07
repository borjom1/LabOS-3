# Лабораторна робота **№5** (Операційні системи)
<br>

## Виконав студент **3** курсу **ІПЗ 1.2** - **Зубанич І.М**
<br>

## **Тема:** Деплой проекту на AWS EC2.
<br>

### **Завдання:**
>1) Зареєструватись на AWS.
>2) Створити інстенс ЕС2.
>3) Задеплоїти проект і скинути посилання у звіт для можливості перегляду.

<br>

### **Хід роботи:**

Створення інстенсу EC2:

Система інстенсу - Ubuntu

![screenshot](/assets/Screenshot_1.png)

<br>

Тип інстенсу залишив за замовчуванням

![screenshot](/assets/Screenshot_2.png)

<br>

Створив SSH-ключ для авторизації (автоматично завантажився файл **key.pem**)

![screenshot](/assets/Screenshot_3.png)

<br>

Встановив вхідний трафік на 80-ий порт.

![screenshot](/assets/Screenshot_4.png)

<br>

Успішне створення та запуск інстенсу.

![screenshot](/assets/Screenshot_5.png)

<br>

Далі переходжу до вкладки "Connect" -> "SSH Client"

![screenshot](/assets/Screenshot_6.png)

<br>

Змінюю дозвіл файлу із SSH-ключем на 400-й:
`sudo chmod 400 key.pem `

Після чого, пробую підключатися до віддаленої віртуальної машини за допомогою команди:

`ssh -i "key.pem" ubuntu@ec2-3-121-188-36.eu-central-1.compute.amazonaws.com`

Результат:

![screenshot](/assets/Screenshot_7.png)

<br>

Далі на віртуальній машині прописую наступні команди (оновлюю **Firewall** та встановлюю **Apache HTTP Server**).

`sudo apt update` <br>
`sudo apt upgrade` <br>
`sudo apt install apache2` <br>
`sudo ufw allow in "Apache Full"` <br>
`sudo systemctl restart apache2` <br>

Далі вихожу з віддаленої машини і відправляю їй архів із html-сторінкою по 22-му порту:

`scp -i key.pem -r ../../lab5/index.zip ubuntu@ec2-3-121-188-36.eu-central-1.compute.amazonaws.com:~/`

Результат:

![screenshot](/assets/Screenshot_8.png)

<br>

Повертаюся на віддалену машину, де розпаковую отриманий архів.

![screenshot](/assets/Screenshot_9.png)

<br>

Перезаписую файл index.html, отриманий з архіву з тим, який знаходиться за шляхом **/var/www/html/index.html**

`sudo mv -i index.html /var/www/html/index.html`

Далі переходжу за адресом `http://3.121.188.36/`, де можна побачити імпортовану сторінку:

![screenshot](/assets/Screenshot_10.png)

<br>

**Висновки:**
На даній лабораторній роботі я ознайомився з набагато простішим способом створення ресурсів (ec2 інстенсів). 