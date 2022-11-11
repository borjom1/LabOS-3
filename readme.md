# Лабораторна робота **№6** (Операційні системи)
<br>

## Виконав студент **3** курсу **ІПЗ 1.2** - **Зубанич І.М**
<br>

## **Тема:** Використання GitHub Actions.
<br>

### **Завдання:**
>1) Ознайомитись із поняттями CI/CD та GitHub Actions.
>2) Задеплоїти проект на EC2 або VPS за допомогою GitHub Actions.
>3) Ознайомитись із github pipelines та використати їх для реалізації CI/CD.

<br>

### **Хід роботи:**

>**1) Теоретична частина**

**CI/CD** - це одна з практик розробки ПЗ шляхом комбінування безперервної інтеграції, доставки та розгортання додатку.

![screenshot](/assets/Screenshot_1.png)

<br>

**GitHub Actions** — це CI/CD платформа, метою якої є значно полеглити процес CI/CD розробки ПЗ за допомогою автоматизації збірки, тестування та розгортання.

<br>

>**2) Практична частина. Деплой проекту на EC2 з GitHub Actions**

Діаграма, яка чудово ілюструє суть практичної частини.

![screenshot](/assets/diagram.jpg)

<br>

1) Я вирішив задеплоїти проект на **Spring Boot**, тому для початку створю сам проект і залию його на GitHub. Даний проект міститиме один контроллер по енд-поінту `/`, де буде відображатися сторінка з повідомленням.

<br>

**DemoController.java**
```java
@RestController
@RequestMapping("/")
public class DemoController {

    @GetMapping("/")
    public String first() {
        return "Hello from Spring Boot!";
    }
}
```

2) Створюю ЕС2 інстенс на AWS.

![screenshot](/assets/Screenshot_2.png)

<br>

![screenshot](/assets/Screenshot_3.png)

<br>

![screenshot](/assets/Screenshot_4.png)

<br>

Інстенс створено.

![screenshot](/assets/Screenshot_5.png)

<br>

Підключаюся до віддаленої віртуальної машини.
`ssh -i "sb_key.pem" ubuntu@ec2-54-93-100-27.eu-central-1.compute.amazonaws.com`

Результат:

![screenshot](/assets/Screenshot_6.png)

<br>

Після чого, залітаю у свій репозиторій із Spring Boot-ом на **GitHub -> Settings -> Actions -> Runners** і клікаю на **New self-hosted runner**

![screenshot](/assets/Screenshot_7.png)

<br>

Далі прописую всі виділені команди на інстенсі.  

![screenshot](/assets/Screenshot_8.png)

<br>

Результат:

![screenshot](/assets/Screenshot_9.png)

<br>

Потім прописую `sudo ./svc.sh install` та `sudo ./svc.sh start`

![screenshot](/assets/Screenshot_10.png)

<br>

Після цього створюю **Git Action workflow** / **CI/CD pipeline**.

![screenshot](/assets/Screenshot_11.png)

<br>

![screenshot](/assets/Screenshot_12.png)

<br>

Редагую файл *maven.yml*: видаляю івент на пулл, змінюю версію Java з 11-ї на 17-ту та вказую, що хостинг беру на себе.

<br>

**maven.yml**

```yml
name: Java CI with Maven

on:
  push:
    branches: [ "lab6" ]

jobs:
  build:

    runs-on: self-hosted

    steps:
    - uses: actions/checkout@v3
    - name: Set up JDK 17
      uses: actions/setup-java@v3
      with:
        java-version: '17'
        distribution: 'temurin'
        cache: maven
    - name: Build with Maven
      run: mvn -B package --file pom.xml

    - name: Update dependency graph
      uses: advanced-security/maven-dependency-submission-action@571e99aab1055c2e71a1e2309b9691de18d6b7d6

```

<br>

Після цього повертаюся в налаштування репозиторію, переходжу до вкладки на скріні нижче

![screenshot](/assets/Screenshot_13.png)

<br>

та включаю **Dependency Graph**, якщо воно вимкнене.

![screenshot](/assets/Screenshot_14.png)

<br>

Оновлюємо базу даних із доступними пакетами.
`sudo apt update`

Вставнолюємо Maven та Java.
`sudo apt install maven openjdk-17-jre openjdk-17-jdk`

Результат:

![screenshot](/assets/Screenshot_15.png)

![screenshot](/assets/Screenshot_16.png)

<br>


Так як у мене 17-а Java, прийдеться установлювати Maven вручну.

`cd /tmp`

`wget https://dlcdn.apache.org/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.tar.gz`

`tar xvf apache-maven-3.8.6-bin.tar.gz`

`cd /usr/share/maven`

`sudo rm -r ./*`

`sudo cp -r /tmp/apache-maven-3.8.6/* .`

<br>

Результат:

![screenshot](/assets/Screenshot_17.png)

![screenshot](/assets/Screenshot_18.png)

<br>

Після успішного встановлення Maven йду до вкладки Actions, де знову проганяю CI/CD pipeline:

![screenshot](/assets/Screenshot_19.png)

![screenshot](/assets/Screenshot_20.png)


<br>

Супер, все збілдилося.

![screenshot](/assets/Screenshot_21.png)

<br>


Далі нам потрібно дістати jar-файл, який відповідає за запуск Spring Boot проекта та знаходиться за наступним шляхом: `/home/ubuntu/actions-runner/_work/LabOS-3/LabOS-3/target/demo-0.0.1-SNAPSHOT.jar`

Знайшовци цей файл, летимо дописувати в **maven.yml** автоматизацію запуску проекта. Після чого, **maven.yml** виглядає ось так:

```yml
name: Java CI with Maven

on:
  push:
    branches: [ "lab6" ]

jobs:
  build:

    runs-on: self-hosted

    steps:
    - uses: actions/checkout@v3
    - name: Set up JDK 17
      uses: actions/setup-java@v3
      with:
        java-version: '17'
        distribution: 'temurin'
        cache: maven
    - name: Build with Maven
      run: mvn -B package --file pom.xml
    - name: Execute Jar file
      run: sudo kill -9 `sudo lsof -t -i:80` & sudo java -jar /home/ubuntu/actions-runner/_work/LabOS-3/LabOS-3/target/demo-0.0.1-SNAPSHOT.jar &

    - name: Update dependency graph
      uses: advanced-security/maven-dependency-submission-action@571e99aab1055c2e71a1e2309b9691de18d6b7d6
```

<br>

Вказую 80-й порт, на якому повинен запуститися сервер Spring Boot проекту в **application.properties**.

```properties
server.port=80
```

<br>

Перевіряємо, чи проект збілдився:

![screenshot](/assets/Screenshot_22.png)

<br>

Переходимо на `http://52.59.224.85/` і бачимо, що проект успішно розгорнутий:

![screenshot](/assets/Screenshot_23.png)

<br>

Тепер, для прикладу додам ще один **end-point** до **DemoController.java** задля того, щоб точно впевнитися, що після push нових змін до репозиторію, автоматично відбудеться збірка та запуск проекту з усіма нововведеннями. 


**DemoController.java**
```java
@RestController
@RequestMapping("/")
public class DemoController {

    @GetMapping("/")
    public String first() {
        return "Hello from Spring Boot!";
    }

    // щойно доданий end-point
    @GetMapping("/lab")
    public String second() {
        return "Lab 6 was successfully done!";
    }
}
```

<br>

Запушив зміни, після чого запустився **forkflow** (maven.yml).

![screenshot](/assets/Screenshot_24.png)

<br>

Переходимо на щойно доданий раут `http://52.59.224.85/lab` і бачимо результат:

![screenshot](/assets/Screenshot_25.png)

<br>

**Висновки:** теоретично та практично ознайомився з GitHub Actions та CI/CD та навчився деплоїти проект на EC2 за допомогою них. 