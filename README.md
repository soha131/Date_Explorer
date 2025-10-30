# 🌴 Date Explorer App

An interactive Flutter application that allows users to **explore various types of dates** categorized by type, origin, and taste — with **AI-powered image recognition** to identify date types from photos.

---

## 🧭 Overview

**Date Explorer** is designed to help users learn more about different varieties of dates.  
You can browse through categorized lists, view detailed information about each type, and even use the **AI identification feature** — just upload a photo of a date, and the app will recognize its type for you!

---

## ✨ Key Features

- 📚 **Browse Categories:** Explore dates by region, color, or sweetness level.  
- 🔍 **AI Recognition:** Upload or capture a photo to identify the date variety instantly.  
- 🧾 **Detailed Information:** View origin, nutritional facts, and fun facts for each date.  

---

## 🧠 AI Integration

The app uses a **machine learning model** trained to recognize various types of dates from images.  
The AI model is integrated with the Flutter app via a backend API (or locally using TensorFlow Lite).

**Tech Stack for AI:**
- Python (for model training)
- TensorFlow / PyTorch
- FastAPI / Flask (for API integration)

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|-------------|
| **Frontend** | Flutter (Dart) |
| **State Management** | Bloc / Cubit |


---

## 📸 Screenshots

> _Add your app screenshots here when ready_

Example sections:
```
📱 Splash Screen – logo & application name  
📸 Upload_image Screen – Upload Photo &  Full Information 
```

---

## 🚀 Getting Started

### 1. Clone the Repository
```bash
git clone https://github.com/soha131/dates_app.git
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Run the App
```bash
flutter run
```

> Make sure your environment is set up with Flutter SDK.

---

## 🧩 Folder Structure

```
lib/
├── main.dart
├──  splash_screen.dart
├──  upload_image_screen.dart
├──  dates_model.dart
├──  service.dart
├── cubit/
│   └── dates_cubit.dart
└── ├── dates_state.dart
```

---


## 📅 Future Enhancements

- 🏝️ Add 3D date models for visual learning.  
- 🔊 Integrate voice assistant for learning.  
- 🌍 Support more languages.  
- 📊 Add user analytics for favorites and trends.

---

## 🤝 Contributing

Contributions are welcome!  
Please open an issue or submit a pull request to help improve the project.

---

## 📄 License

This project is licensed under the **MIT License** — feel free to use and modify it.

---

