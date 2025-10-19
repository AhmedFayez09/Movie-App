# 🎬 Movie App (Flutter)

A Flutter application that displays popular and searched movies using **TMDB API**.  
It supports **pagination**, **search**, and **detailed movie view with Hero animation**.

---

## 🚀 Features

- 🔥 Fetch popular movies with pagination  
- 🔍 Search for movies by title  
- 🧭 View detailed information about each movie  
- 💫 Smooth Hero animation transition  
- 🌗 Responsive and modern UI  

---

## 🛠️ Setup Instructions

### 1. Clone the repository


git clone https://github.com/AhmedFayez09/Movie-App
cd movie_app

### 2. Add your TMDB API key

open file lib/src/core/network/api_constants.dart
 or you make store it in .env file

### 3. Install dependencies you need such
 State Management
  flutter_bloc: ^9.1.1
  bloc: ^9.1.0
 Network
  dio: ^5.9.0
  freezed: ^3.2.3
  freezed_annotation: ^3.1.0
 Cache Image
  cached_network_image: ^3.4.1
 Environment Variables
  flutter_dotenv: ^6.0.0

flutter pub get


### 4. flutter run





## 🏗️ Architecture Overview


lib/
├── src/
│   ├── core/
│   │   ├── config/
│   │   ├── network/
│   │   ├── widgets/
│   ├── features/
│   │   ├── home/
│   │   │   ├── logic / (repositories & models)
│   │   │   ├── presentation/ (manager & screens & widgets)


