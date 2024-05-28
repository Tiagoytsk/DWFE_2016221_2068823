use projeto_final;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    tipo INT
);

CREATE TABLE tweets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    content VARCHAR(280) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE followers (
    user_id INT NOT NULL,
    follower_id INT NOT NULL,
    PRIMARY KEY (user_id, follower_id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (follower_id) REFERENCES users(id)
);

CREATE TABLE likes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    tweet_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (tweet_id) REFERENCES tweets(id)
);

INSERT INTO users (username, password, email, tipo) VALUES ('username', 'password', 'email@example.com', 1);

INSERT INTO tweets (user_id, content) VALUES (1, 'This is a tweet');

INSERT INTO followers (user_id, follower_id) VALUES (1, 2);

/*Obtem todos os tweets*/

SELECT t.* 
FROM tweets t
JOIN followers f ON f.user_id = t.user_id
WHERE f.follower_id = 1
ORDER BY t.created_at DESC;

/*Obtenha todos os tweets de
 um user específico junto 
 com os detalhes do user*/

SELECT users.*, tweets.*
FROM users
INNER JOIN tweets ON users.id = tweets.user_id
WHERE users.id = 1;

/*Obtem todos os seguidores
 de um user específico junto
 com os seus detalhes*/

SELECT users.*, followers.*
FROM users
INNER JOIN followers ON users.id = followers.follower_id
WHERE followers.user_id = 1;

/*Obtem todos os users que um 
users específico está seguindo 
junto com os seus detalhes*/

SELECT users.*, followers.*
FROM users
INNER JOIN followers ON users.id = followers.user_id
WHERE followers.follower_id = 1;

/*Obtenha todos os tweets que um user 
específico gostou, juntamente com os detalhes do tweet*/

SELECT users.*, likes.*, tweets.*
FROM users
INNER JOIN likes ON users.id = likes.user_id
INNER JOIN tweets ON likes.tweet_id = tweets.id
WHERE users.id = 1;

/*Obtem todos os users que
 gostaram de um tweet específico
 junto com os seus detalhes*/

SELECT users.*, likes.*
FROM users
INNER JOIN likes ON users.id = likes.user_id
WHERE likes.tweet_id = 1;

/*Obtenhem todos 
os tweets de um user que 
um user específico está seguindo*/

SELECT users.*, tweets.*
FROM users
INNER JOIN followers ON users.id = followers.user_id
INNER JOIN tweets ON followers.user_id = tweets.user_id
WHERE followers.follower_id = 1
ORDER BY tweets.created_at DESC;

INSERT INTO likes (user_id, tweet_id) VALUES (1, 1);

SELECT * FROM users;

UPDATE users SET username = 'newusername' WHERE id = 1;

DELETE FROM users WHERE id = 1;

SELECT * FROM tweets;

UPDATE tweets SET content = 'new content' WHERE id = 1;

DELETE FROM tweets WHERE id = 1;


