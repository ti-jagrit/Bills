🧾 Billing System
The Billing System is a full-featured eCommerce and inventory management platform built with Spring Boot. It allows users to log in, search for products, add items to a cart, and complete purchases through integrated payment gateways like eSewa and Khalti.

🔐 Technologies Used
Spring Boot (MVC architecture)

Spring Security (with OAuth2 integration)

JPA/Hibernate for ORM

JSP Pages for the frontend (view layer)

MySQL as the database

👥 User Features
🔑 Login and secure authentication (OAuth2-based)

🛒 Browse and search products

➕ Add products to the cart

💳 Checkout using:

eSewa

Khalti

🛠️ Admin Features
🏢 Manage company details

📦 Stock management:

View current stock

Generate stock reports

🧾 Generate and manage bills

📁 Manage products and categories

📑 Assign and manage tasks

✅ Accept/Reject customer orders

📂 Project Structure
css
Copy
Edit
billing-system/
├── src/
│   ├── main/
│   │   ├── java/com/example/billingsystem/
│   │   ├── resources/
│   │   │   └── application.properties
│   └── webapp/
│       └── WEB-INF/
│           └── jsp/
│               └── *.jsp
├── pom.xml
└── README.md
