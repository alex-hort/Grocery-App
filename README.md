# 🛒 Grocery App — Full Stack iOS Application

A full-stack grocery management application built with **SwiftUI, Vapor and PostgreSQL**, designed to demonstrate how a native iOS application can communicate with a custom backend through REST APIs.

The project implements user authentication, grocery categories, grocery items, persistent data storage and protected API endpoints using **JWT authentication**.

> 🚧 **Project Status:** Completed as a full-stack development project.
> ☁️ Cloud deployment was explored during the learning process but was not included in the final version of this project.

---

## 📱 Overview

**Grocery App** is a native iOS application that allows authenticated users to manage their grocery categories and items through a dedicated backend API.

The project was developed to gain practical experience building a complete application ecosystem, from the **iOS interface** to the **server-side API and relational database**.

The application follows a client-server architecture:

```text
┌─────────────────────────────┐
│         iOS App             │
│          SwiftUI            │
│                             │
│  • Authentication           │
│  • Grocery Categories       │
│  • Grocery Items            │
│  • Navigation               │
│  • Error Handling           │
└──────────────┬──────────────┘
               │
               │ REST API / JSON
               ▼
┌─────────────────────────────┐
│        Vapor Backend        │
│           Swift             │
│                             │
│  • Routes                   │
│  • Controllers              │
│  • Middleware               │
│  • JWT Authentication       │
│  • DTOs                     │
│  • Business Logic           │
└──────────────┬──────────────┘
               │
               │ Fluent ORM
               ▼
┌─────────────────────────────┐
│        PostgreSQL           │
│                             │
│  • Users                    │
│  • Grocery Categories       │
│  • Grocery Items            │
└─────────────────────────────┘
```

---

## ✨ Features

### 🔐 Authentication

* User registration
* User login
* JWT-based authentication
* Protected API routes
* Authentication middleware
* Secure request headers
* Sign out functionality
* User-specific data

### 🗂️ Grocery Categories

Authenticated users can:

* Create grocery categories
* View their categories
* Delete categories
* Associate categories with the authenticated user
* Navigate between category and detail screens

### 🛒 Grocery Items

Users can:

* Add grocery items
* Associate items with categories
* View grocery items
* Delete grocery items
* Retrieve data from the backend

### 🌐 API Communication

The iOS application communicates with the Vapor backend through RESTful endpoints using:

* HTTP requests
* JSON encoding/decoding
* Request DTOs
* Response DTOs
* Authentication headers
* Generic HTTP client
* Error handling

---

# 🧰 Technologies

## Frontend — iOS

| Technology                          | Purpose                                        |
| ----------------------------------- | ---------------------------------------------- |
| **Swift**                           | Main programming language                      |
| **SwiftUI**                         | Native user interface                          |
| **MVVM / Application Architecture** | Separation of UI and application logic         |
| **URLSession / HTTP Client**        | API communication                              |
| **Codable**                         | JSON serialization                             |
| **UserDefaults**                    | Local persistence of required user information |
| **Xcode**                           | Development environment                        |

## Backend

| Technology     | Purpose                                 |
| -------------- | --------------------------------------- |
| **Swift**      | Server-side programming                 |
| **Vapor**      | Backend framework                       |
| **Fluent**     | ORM                                     |
| **JWT**        | Authentication                          |
| **REST API**   | Client-server communication             |
| **DTOs**       | Data transfer between client and server |
| **Middleware** | Request authentication and processing   |

## Database

| Technology                   | Purpose                    |
| ---------------------------- | -------------------------- |
| **PostgreSQL**               | Relational database        |
| **Fluent PostgreSQL Driver** | Database integration       |
| **Migrations**               | Database schema management |

## Development Tools

* Xcode
* Swift Package Manager
* PostgreSQL
* Postman
* Beekeeper Studio
* Git
* GitHub

---

# 🏗️ Project Architecture

The project is divided into two main applications:

```text
GroceryApp/
│
├── iOS Client
│   ├── Views
│   ├── Models
│   ├── ViewModels
│   ├── Networking
│   ├── Authentication
│   └── Navigation
│
└── Vapor Server
    ├── Controllers
    ├── Models
    ├── DTOs
    ├── Middleware
    ├── Migrations
    ├── Routes
    └── Configuration
```

This separation allows the frontend and backend to evolve independently while communicating through a well-defined REST API.

---

# 🔑 Authentication Flow

The application uses **JWT authentication** to protect resources.

```text
User
 │
 ▼
Login / Register
 │
 ▼
SwiftUI Client
 │
 ▼
Vapor API
 │
 ▼
Validate Credentials
 │
 ▼
Generate JWT
 │
 ▼
Return Token
 │
 ▼
iOS Client
 │
 ▼
Authenticated Requests
 │
 ▼
JWT Middleware
 │
 ▼
Protected Resource
```

Authenticated requests include the JWT token in the HTTP authorization header.

This architecture allows the backend to determine which resources belong to the currently authenticated user.

---

# 🗄️ Database Structure

The PostgreSQL database contains the main entities required by the application.

```text
┌──────────────┐
│    Users     │
├──────────────┤
│ id           │
│ name         │
│ email        │
│ password     │
└──────┬───────┘
       │
       │ 1:N
       ▼
┌──────────────────────┐
│ Grocery Categories   │
├──────────────────────┤
│ id                   │
│ title                │
│ user_id              │
└──────────┬───────────┘
           │
           │ 1:N
           ▼
┌──────────────────────┐
│    Grocery Items     │
├──────────────────────┤
│ id                   │
│ name                 │
│ category_id          │
└──────────────────────┘
```

Database migrations are used to create and modify the database schema in a controlled and reproducible way.

---

# 🔌 REST API

The Vapor backend exposes RESTful endpoints for authentication and grocery management.

### Authentication

```http
POST /users
POST /login
```

### Grocery Categories

```http
POST /grocery-categories
GET /grocery-categories
DELETE /grocery-categories/:id
```

### Grocery Items

```http
POST /grocery-items
GET /grocery-items
DELETE /grocery-items/:id
```

Protected endpoints require a valid JWT authentication token.

---

# 📸 Screenshots

## Authentication

<!-- Add your screenshots here -->

| Login             | Register          |
| ----------------- | ----------------- |
| 📷 Add screenshot | 📷 Add screenshot |

---

## Grocery Categories

<!-- Add your screenshots here -->

| Categories        | Add Category      |
| ----------------- | ----------------- |
| 📷 Add screenshot | 📷 Add screenshot |

---

## Grocery Items

<!-- Add your screenshots here -->

| Grocery Detail    | Add Item          |
| ----------------- | ----------------- |
| 📷 Add screenshot | 📷 Add screenshot |

---

## 🧪 API Testing

The backend API was tested using **Postman** to verify:

* User registration
* User login
* JWT authentication
* Grocery category creation
* Grocery category retrieval
* Grocery category deletion
* Grocery item creation
* Grocery item retrieval
* Grocery item deletion
* Protected endpoints

Example workflow:

```text
Postman
   │
   ▼
Vapor REST API
   │
   ▼
Authentication Middleware
   │
   ▼
Controller
   │
   ▼
Fluent ORM
   │
   ▼
PostgreSQL
```

---

# 🧠 Key Concepts Demonstrated

This project focuses on practical full-stack development concepts including:

* Native iOS development with SwiftUI
* Client-server architecture
* Server-side Swift
* REST API design
* HTTP communication
* JSON serialization
* JWT authentication
* Authentication middleware
* MVC concepts
* DTO pattern
* ORM with Fluent
* PostgreSQL relational databases
* Database migrations
* CRUD operations
* Error handling
* Programmatic navigation
* Separation of concerns
* Reusable networking components
* Shared models between application layers

---

# 🚀 What I Learned

Building this application helped me understand how a native iOS application can be connected to a custom backend instead of relying exclusively on Backend-as-a-Service solutions.

The project provided practical experience with:

1. Designing REST APIs with Vapor.
2. Building server-side applications using Swift.
3. Connecting Vapor to PostgreSQL through Fluent.
4. Implementing JWT-based authentication.
5. Protecting endpoints with middleware.
6. Building reusable networking logic in SwiftUI.
7. Handling JSON requests and responses.
8. Structuring data using DTOs.
9. Managing relational data with PostgreSQL.
10. Connecting all these components into a complete full-stack application.

---

# 🛠️ Running the Project

## Requirements

Before running the project, make sure you have:

* macOS
* Xcode
* Swift
* PostgreSQL
* Swift Package Manager
* Git

---

## 1. Clone the repository

```bash
git clone https://github.com/YOUR_USERNAME/YOUR_REPOSITORY.git
cd YOUR_REPOSITORY
```

---

## 2. Configure PostgreSQL

Create a PostgreSQL database for the Vapor backend.

Example:

```text
Database: grocerydb
```

Update the backend configuration with your local PostgreSQL credentials.

> ⚠️ Never commit real database passwords, JWT secrets or other sensitive credentials to GitHub.

---

## 3. Run the Vapor backend

Navigate to the server project:

```bash
cd Server
```

Then run:

```bash
swift run
```

The Vapor server will start locally and expose the API used by the iOS application.

---

## 4. Run the iOS application

Open the SwiftUI project in Xcode:

```text
GroceryApp.xcodeproj
```

Select an iOS Simulator or connected device and press:

```text
⌘ + R
```

Make sure the API base URL configured in the application points to your local Vapor server.

---

# 🔒 Security Considerations

This project implements authentication using JWT tokens.

For a production environment, additional security measures would be recommended, including:

* HTTPS
* Secure secret management
* Keychain-based token storage
* Environment variables
* Production database configuration
* Input validation
* Rate limiting
* Secure password policies
* Production logging and monitoring

The current project is primarily focused on demonstrating the architecture and implementation of a full-stack Swift application.

---

# 📚 Project Context

This project was developed as a practical exercise in **Full Stack iOS Development**, combining Apple's native development ecosystem with server-side Swift technologies.

The implementation covers the complete path from:

```text
SwiftUI Interface
       ↓
Networking Layer
       ↓
REST API
       ↓
Vapor Controllers
       ↓
Authentication Middleware
       ↓
Fluent ORM
       ↓
PostgreSQL
```

Rather than treating the iOS application and backend as isolated projects, the goal was to understand how they work together as a complete software system.

---

# 👨‍💻 Author

**Alexis Horteales Espinosa**

Computer Engineering Student
iOS & Full Stack Developer

### Technologies I work with

```text
Swift • SwiftUI • UIKit
React • React Native • TypeScript
Node.js • Vapor
PostgreSQL • Firebase
AWS • Google Cloud
Docker • Git • REST APIs
```

---

## ⭐ If you find this project interesting

Feel free to explore the repository, review the architecture and check out the implementation.

**Built with Swift, SwiftUI, Vapor and PostgreSQL.**
