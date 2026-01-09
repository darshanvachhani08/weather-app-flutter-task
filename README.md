# Weather Gravity 🌤️

A Flutter weather application built with **Clean Architecture**, **Bloc**, and *
*Google Maps**. This project is designed to be highly scalable, maintainable, and visually stunning.

---

## 🏗️ Architecture

The project strictly follows **Clean Architecture** (Domain-Driven Design) to ensure separation of
concerns and testability.

### Layered Structure

- **`lib/core/`**: Shared reality of the app.
    - **Smart Widgets**: High-level wrappers (`SmartText`, `SmartColumn`, `SmartAppbar`) that unify
      UI styles and simplify layout development.
    - **Theming**: Centralized control via `ThemeCubit` for dynamic Dark/Light modes.
    - **Networking**: Configured Dio client with clean interceptors for localization and error
      handling.
- **`lib/features/weather/`**: The core domain of the application.
    - **Domain Layer**: Contains **Entities** (Models independent of API), **Use Cases** (Single
      business actions), and **Repository Interfaces**.
    - **Data Layer**: Contains **Model DTOs** (JSON serialization), **Repository Implementations**,
      and **Data Sources** (Remote/Local).
    - **Presentation Layer**: UI state management using **Bloc/Cubit**, feature-specific widgets,
      and main pages.

---

## 📂 File Structure Overview

```text
lib/
├── core/                  # Shared utilities, themes, and "Smart Widgets"
│   ├── constants/         # App-wide constants (colors, dimens)
│   ├── network/           # API clients and network info
│   ├── theme/             # ThemeCubit and style definitions
│   └── widgets/           # Smart Widget library (SmartText, SmartColumn, etc.)
├── features/
│   └── weather/           
│       ├── data/          # Models, Repositories (Impl), Data Sources
│       ├── domain/        # Entities, Use Cases, Repository (Contracts)
│       └── presentation/  # BLoC, Pages, and UI Widgets
├── injection_container.dart # Dependency Injection setup (GetIt)
├── l10n/                  # Localization (EN, AR, HI)
├── main.dart              # Entry point
└── router/                # Navigation (GoRouter)
```

---

## 🔄 App Workflow & Logic

The application follows a predictable data flow pattern:

1. **Initialization**: On startup, dependencies are registered in `GetIt`. The `AppRouter` (
   GoRouter) points to the `SplashScreen`.
2. **Location Detection**: The app attempts to fetch the user's GPS coordinates using the
   `LocationService`.
3. **Data Request**:
    - The UI triggers an event (e.g., `FetchWeatherEvent`).
    - The `WeatherBloc` calls the relevant **Use Case**.
    - The **Repository** determines if it should fetch from the API (Remote) or Cache (Local) based
      on connectivity.
4. **State Management**:
    - **Loading**: UI shows sleek shimmer effects.
    - **Success**: Data is transformed into **Entities** and the UI updates with the `WeatherLoaded`
      state.
    - **Error**: Functional error handling (dartz `Either`) returns a `Failure`, which the UI
      displays as a user-friendly message.
5. **Interactive Map**: Users can navigate to the `MapPage` to see global weather patterns using
   Google Maps tile overlays.

---

## 🚀 Getting Started

### 1. Prerequisites

- Flutter SDK (Latest Stable)
- OpenWeatherMap API Key

### 2. Setup

1. Create a `.env` file in the root.
2. Add your keys:

   ```env
   OPENWEATHER_API_KEY=your_key_here
   GOOGLE_MAPS_API_KEY=YOUR_GOOGLE_MAPS_API_KEY_HERE
   ```

3. Run `flutter pub get`
4. Run `flutter run`

---

## 🛠️ Key Features

- **Smart Components**: Standardized UI development through our "Smart Widget" pattern.
- **Offline Support**: Automatic caching of the last viewed weather.
- **Localization**: Full support for English, Arabic, and Hindi.
- **Premium UI**: Dark mode support, smooth transitions, and count-up text animations.
- **Clean API**: Repository pattern with functional error handling for zero-crash stability.

---

## 🤝 Instructions for Developers

- **Adding a Feature**: Always start by defining the **Entity** in the domain layer. Never let API
  Models leak into the UI.
- **UI Changes**: Modify `lib/core/widgets/` to apply design changes globally.
- **State Management**: Use `Bloc` for complex logic (Weather) and `Cubit` for simple state (
  Theme/Locale).

#