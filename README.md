# Feedback Challenge

Projeto desenvolvido em Ruby on Rails, com o objetivo de consultar os feedbacks de funcionários.

---

## 🚀 Tecnologias

- Ruby 3.2
- Rails 7
- PostgreSQL
- Docker + Docker Compose

---

## ⚙️ Como rodar o projeto

### 1. Clone o repositório

```bash
git clone git@darwin:darwinssilva/feedback-challenge.git
cd feedback-challenge
```

### 2. Construa os containers

```bash
docker compose build
```

### 3. Instale o Rails (na primeira vez)
```bash
docker compose run web rails new . --force --no-deps --database=postgresql
```
Altere config/database.yml para usar host: db

### 2. Suba os containers

```bash
docker compose up
```

## 🗃️ Banco de dados

### 1. Acesse o container

```bash
docker compose exec web bash
```

### 1. Agora dentro do bash:

```bash
rails db:create
rails db:migrate
rails db:seed
```