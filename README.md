# Chat App 💬

A modern, real-time cross-platform chat application built with **Flutter** and **Firebase**.  
Designed with scalable architecture and clean UI to support private messaging across Android, iOS, Web, Windows, macOS, and Linux.

---

## 🚀 Overview

Chat App is a real-time messaging application that enables users to communicate instantly using Firebase services.  
The project demonstrates:

- Authentication flow
- Firestore real-time database integration
- Clean state management
- Cross-platform Flutter deployment

This repository serves as both a functional chat application and a learning reference for building scalable Flutter + Firebase apps.

---

## ✨ Features

- 🔐 Firebase Authentication (Email/Password)
- 💬 Real-time 1-to-1 messaging
- ☁️ Cloud Firestore integration
- 📱 Responsive UI (Mobile & Web)
- 🔄 Stream-based message updates
- 🧩 Modular project structure
- 🖥 Multi-platform support

---

## 🛠 Tech Stack

| Technology | Purpose |
|------------|----------|
| **Flutter** | Cross-platform UI framework |
| **Dart** | Programming language |
| **Firebase Auth** | User authentication |
| **Cloud Firestore** | Real-time database |
| **Provider / State Management** | App state handling |

---

## 📂 Project Structure

lib/
│
├── data/
│ ├── models/ # Chat & user models
│ ├── services/ # Firebase services & repositories
│
├── pages/ # UI Screens
│
├── widgets/ # Reusable UI components
│
└── main.dart # App entry point


## Other platform-specific folders:

android/
ios/
web/
windows/
macos/
linux/


---

## ⚙️ Installation & Setup

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/Aditya073/chat_app.git
cd chat_app
flutter pub get
dart pub global activate flutterfire_cli
flutterfire configure
flutter run
