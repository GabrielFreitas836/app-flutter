# 📱 App Flutter - Catálogo Interativo de Produtos

## 📋 Sumário

- [📝 Descrição do Projeto](#-descrição-do-projeto)
- [🏗️ Arquitetura](#️-arquitetura)
- [🛠️ Ferramentas Utilizadas](#-ferramentas-utilizadas)
- [📁 Estrutura de Pastas](#-estrutura-de-pastas)

---

## 📝 Descrição do Projeto

O **App Flutter** é um catálogo interativo de produtos desenvolvido como projeto avaliativo. A aplicação oferece uma experiência completa de navegação e visualização de produtos através de uma interface intuitiva e responsiva.

### Funcionalidades Principais

- ✅ Catálogo de produtos interativo
- ✅ Autenticação e gerenciamento de usuários
- ✅ Visualização detalhada de produtos
- ✅ Persistência de dados locais
- ✅ Integração com API REST

---

## 🏗️ Arquitetura

O projeto segue uma arquitetura **MVP (Model-View-Presenter)** tanto no frontend quanto no backend, garantindo separação de responsabilidades e facilitando a manutenção do código.

### Frontend (Flutter) - MVP Pattern

A camada de apresentação utiliza o padrão MVP com arquitetura baseada em componentes:

```
View (Widgets) 
    ↓
Presenter/Provider (Lógica de Negócios)
    ↓
Model (Camada de Dados)
```

### Backend (Node.js) - MVP com Controller como Presenter

A API segue o padrão MVP onde o **Controller atua como Presenter**, sendo responsável por:

```
Requisição HTTP
    ↓
  Rota
    ↓
Controller (Presenter)
    ├─ Processa a requisição
    ├─ Coordena Services
    ├─ Formata a resposta
    ↓
Service (Lógica de Negócios)
    ├─ Implementa regras de negócio
    ├─ Coordena Models
    ↓
Model (Acesso de Dados)
    ├─ Acessa o banco de dados
    ├─ Valida integridade de dados
    ↓
Resposta HTTP
```

**Por que o Controller é um Presenter?**
- Traduz requisições HTTP em ações de negócio
- Formata dados para apresentação (JSON)
- Orquestra a comunicação entre Services e Models
- Não contém lógica de negócio, apenas orquestração

---

## 🛠️ Ferramentas Utilizadas

### Frontend (Flutter)

| Ferramenta | Versão | Descrição |
|-----------|--------|-----------|
| **Flutter** | ^3.11.4 | Framework para desenvolvimento multiplataforma |
| **Provider** | ^6.1.5+1 | Gerenciamento de estado e injeção de dependência |
| **HTTP** | ^1.6.0 | Cliente HTTP para requisições à API |
| **Shared Preferences** | ^2.5.5 | Armazenamento local de dados simples |
| **Material Design** | - | Sistema de design Google |

### Backend (Node.js)

| Ferramenta | Versão | Descrição |
|-----------|--------|-----------|
| **Express** | ^5.2.1 | Framework web para Node.js |
| **MySQL2** | ^3.22.3 | Driver MySQL para Node.js |
| **Knex** | ^3.2.10 | Query builder SQL |
| **JWT** | ^9.0.3 | Autenticação com tokens |
| **CORS** | ^2.8.6 | Middleware para CORS |
| **Dotenv** | ^17.4.2 | Gerenciamento de variáveis de ambiente |

---

## 📁 Estrutura de Pastas

### Frontend (app_flutter)

```
app_flutter/
├── lib/
│   ├── main.dart
│   └── src/
│       ├── models/
│       │   ├── product_model_a.dart
│       │   ├── product_model_b.dart
│       │   └── user_model.dart
│       │
│       ├── pages/
│       │   ├── catalog_page.dart
│       │   ├── login_page.dart
│       │   ├── orcamento_page.dart
│       │   └── signup_page.dart
│       │
│       ├── providers/
│       │   ├── product_provider.dart
│       │   └── user_provider.dart
│       │
│       ├── services/
│       │   ├── auth_token.dart
│       │   ├── product_service_a.dart
│       │   ├── product_service_b.dart
│       │   └── user_service.dart
│       │
│       └── widgets/
│           ├── double_card.dart
│           ├── my_elevated_button.dart
│           └── my_text_form_field.dart
│
├── pubspec.yaml
└── app_flutter.dart

```

### Backend (app_flutterAPI)

```
app_flutterAPI/
├── node_modules/
│
├── src/
│   ├── controllers/
│   │   ├── productController.js
│   │   └── userController.js
│   │
│   ├── data/
│   │   └── connection.js
│   │
│   ├── middlewares/
│   │   └── authUser.js
│   │
│   ├── models/
│   │   ├── productModel.js
│   │   └── userModel.js
│   │
│   ├── routes/
│   │   └── routes.js
│   │
│   ├── services/
│   │   ├── auth/
│   │   │   └── token.js
│   │   │
│   │   ├── productServices.js
│   │   └── userServices.js
│   │
│   └── api.js
│
├── .env
├── .gitignore
├── package-lock.json
├── package.json
└── server.js
```

### Fluxo de Dados

```
Requisição HTTP
    ↓
routes/ (Define endpoint e middleware)
    ↓
controllers/ (Presenter - processa e orquestra)
    ↓
services/ (Business Logic - regras de negócio)
    ↓
models/ (Data Access - acesso ao banco)
    ↓
database (MySQL)
    ↓
models/ (Formata dados)
    ↓
services/ (Processa resultado)
    ↓
controllers/ (Formata resposta HTTP)
    ↓
Resposta JSON
```

---

**Desenvolvido por:** Gabriel Freitas  
**Projeto:** Avaliativo de Desenvolvimento em Flutter
