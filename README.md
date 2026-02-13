# In Porto

**Explore Porto like never before.**

> **Under Development**: This project is currently under active development and is not yet finished. Features may change, and you may encounter bugs. Current releases are considered **beta** versions.

In Porto is a modern, feature-rich Flutter application designed to help users navigate and explore the city of Porto, Portugal. Whether you're a local or a visitor, the app provides real-time information about public transport stops, map-based exploration, and personalized settings to enhance your journey.

## Features

- **Interactive Map**: Explore Porto with a high-performance map featuring stops and real-time user location.
- **Stops & Departures**: Access detailed information about public transport stops (Metro, Bus) and upcoming departures.
- **Theming**: Full support for Light and Dark modes.
- **Localization**: Multilingual support (English and Portuguese).
- **Personalized Favorites**: Save your most-used stops for quick access.
- **Customizable Settings**: Manage appearance, language, and app preferences.
- **Deep Linking**: Seamlessly scan bus QR Codes to be redirected to the app.

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Dart](https://dart.dev/get-dart)

### Installation

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/pedroafmonteiro/in-porto.git
    cd in-porto
    ```

2.  **Install dependencies**:
    ```bash
    flutter pub get
    ```

3.  **Run the app**:
    ```bash
    flutter run
    ```

## Project Structure

```text
lib/
├── l10n/           # Localization (ARB files and generated code)
├── model/          # Data models and entities
├── service/        # External service integrations
├── theme.dart      # Global app theme and styles
├── view/           # UI Screens and components
├── viewmodel/      # Business logic and state handling
└── utils.dart      # Helper functions and extensions
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request or open an issue for any bugs or feature requests.
