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

### 4. Suba os containers

```bash
docker compose up
```

## 🗃️ Banco de dados

### 1. Acesse o container

```bash
docker compose exec web bash
```

### 2. Agora dentro do bash:

```bash
rails db:create
rails db:migrate
rails db:seed
```

## 🧪 Testes Automatizados

Este projeto utiliza RSpec com FactoryBot, DatabaseCleaner e Kaminari para paginação.

### Rodando os testes
Acesse o container do Rails:

```bash
docker compose exec web bash
```

### Execute os testes com o banco de teste correto:

```bash
RAILS_ENV=test bundle exec rspec
```

## 📘 Documentação da API (Swagger)

Este projeto utiliza o Swagger (via rswag) para gerar e visualizar a documentação da API.

### Acessando o Swagger UI
Após iniciar a aplicação, você pode acessar a interface do Swagger em:


```bash
http://localhost:3000/api-docs
```

### Gerando a Documentação com Specs

```bash
docker compose exec web rake rswag:specs:swaggerize
```

## Task Checklist

[x] Task 1: Create a Basic Database
[] Task 2: Create a Basic Dashboard
[x] Task 3: Create a Test Suite
[x] Task 4: Create a Docker Compose Setup
[] Task 5: Exploratory Data Analysis
[] Task 6: Data Visualization - Company Level
[] Task 7: Data Visualization - Area Level
[] Task 8: Data Visualization - Employee Level
[x] Task 9: Build a Simple API
[] Task 10: Sentiment Analysis
[] Task 11: Report Generation
[] Task 12: Creative Exploration

