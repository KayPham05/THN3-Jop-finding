# 🎬 Movie Ticket App

A premium, modern Flutter application for browsing movies and booking cinema tickets. Built with Clean Architecture and professional design standards.

---

## ✨ Features

### 1. Movie Exploration
- **Discover**: Browse trending and now-playing movies from TMDB.
- **Details**: View rich movie information, ratings, and synopses.
- **Premium UI**: Immersive posters and smooth transitions.

### 2. Smart Booking System
- **Showtimes**: Browse available schedules for your favorite movies.
- **Interactive Seat Selection**:
    - High-fidelity cinema screen visualization.
    - Real-time seat toggling with distinct visual states (Available, Selected, Booked).
    - Glowing amber yellow highlights for selections.
- **Ticket Management**: Keep track of your bookings in the "My Tickets" section.

### 3. Professional Theme System
- **Dynamic Modes**: Full support for both **Light** and **Dark** modes.
- **Premium Aesthetics**: Glassmorphism, smooth gradients, and Material 3 design.
- **Responsive**: Adapts perfectly to various screen sizes.

---

## 🛠 Tech Stack

- **Framework**: [Flutter](https://flutter.dev/)
- **Architecture**: **Clean Architecture** (Separation of Concerns: Data, Domain, Presentation)
- **State Management**: [Flutter BLoC](https://pub.dev/packages/flutter_bloc)
- **Navigation**: [GoRouter](https://pub.dev/packages/go_router)
- **Dependency Injection**: [GetIt](https://pub.dev/packages/get_it) & [Injectable](https://pub.dev/packages/injectable)
- **API**: [TMDB API](https://www.themoviedb.org/documentation/api)
- **Local Storage**: (Optional) For persisting tickets.

---

## 🚀 Getting Started

### 1. Prerequisites
- Flutter SDK (latest stable version)
- A TMDB API Key (Get one [here](https://www.themoviedb.org/settings/api))

### 2. Setup API Key
The project uses `dart-define` for environment variables. You have two options:

#### Option A: Hardcode (Quick Test)
Modify `lib/core/config/app_env.dart`:
```dart
static const String tmdbApiKey = 'YOUR_API_KEY_HERE';
```

#### Option B: Command Line (Recommended)
Run the app with the following command:
```bash
flutter run --dart-define=TMDB_API_KEY=YOUR_API_KEY_HERE
```

### 3. Installation
```bash
git clone https://github.com/your-username/movie_ticket_app.git
cd movie_ticket_app
flutter pub get
flutter run
```

---

## 📂 Project Structure

```text
lib/
├── core/               # Shared logic, theme, config, di
├── features/
│   ├── movies/         # Movie browsing & details
│   │   ├── data/       # Repositories & Datasources
│   │   ├── domain/     # Entities & Usecases
│   │   └── presentation/# Bloc & UI Pages
│   └── booking/        # Seat selection & ticket management
└── main.dart           # App entry point
```

---

## 🎨 UI/UX Highlights

- **Custom Painters**: Used for the curved cinema screen.
- **Haptic Feedback**: Subtle feedback during seat selection.
- **Dynamic Color Schemes**: Using Material 3 color roles for consistency.

---

Developed with ❤️ by Khanh Tran.
