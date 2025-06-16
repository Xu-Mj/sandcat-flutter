# Sandcat Flutter

A Flutter client application for the Sandcat instant messaging platform.

## Overview

Sandcat Flutter is a modern, cross-platform messaging client that connects to the Sandcat backend service. It provides a clean and intuitive interface for messaging while maintaining high performance and reliability.

## Architecture

The application follows a clean architecture approach with clearly defined layers:

```
lib/
├── core/                 # Core functionality and utilities
│   ├── db/               # Database and data persistence
│   ├── di/               # Dependency injection
│   ├── message/          # Message handling and processing
│   ├── network/          # Network communication
│   ├── protos/           # Protocol buffer definitions
│   └── services/         # Core services
│
├── ui/                   # User interface
│   ├── auth/             # Authentication screens
│   ├── chat/             # Chat functionality
│   │   ├── data/         # Data layer implementation
│   │   ├── domain/       # Business logic and models
│   │   └── presentation/ # UI components and screens  
│   ├── settings/         # App settings
│   └── utils/            # UI utilities
│
└── main.dart             # Application entry point
```

## Setup and Development

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio / Visual Studio Code
- A running Sandcat backend server

### Getting Started

1. Clone the repository
   ```
   git clone https://github.com/yourusername/sandcat-flutter.git
   cd sandcat-flutter
   ```

2. Install dependencies
   ```
   flutter pub get
   ```

3. Generate necessary files
   ```
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. Configure the application
   - Open `lib/core/config/app_config.dart`
   - Set the appropriate server URL and other configuration parameters

5. Run the application
   ```
   flutter run
   ```

## Features

- **User Authentication**: Secure login, registration, and account management
- **Conversations**: One-on-one and group chat support
- **Message Types**: Text, images, and files
- **Real-time Messaging**: Instant delivery with WebSocket connection
- **Offline Support**: Store and sync messages when coming back online
- **Message Status**: Sending, sent, delivered, and read receipts
- **Notifications**: Push notifications for new messages
- **Media Sharing**: Send and receive images and files
- **Profile Management**: Update profile information and settings

## Message Architecture

The message handling system is designed with a three-layer approach:

1. **Protocol Layer**: Handles raw communication with the Sandcat server using Protocol Buffers
2. **Domain Layer**: Processes and transforms protocol messages into application models
3. **Presentation Layer**: Displays messages and handles user interactions

### Message Flow

```
Server <--> WebSocket <--> Protocol Layer <--> Domain Layer <--> UI
                                          <--> Database
```

## Database Structure

The application uses Drift (formerly Moor) for local database storage with the following main tables:

- **Messages**: Stores all messages with their metadata
- **Chats**: Manages conversation information
- **Users**: Caches user information
- **Attachments**: Tracks media and file attachments

## Development Guidelines

- Follow the existing architecture pattern
- Use proper dependency injection with `get_it`
- Write tests for new functionality
- Format code using `flutter format`
- Run tests before submitting PR: `flutter test`

## Troubleshooting

- **WebSocket Connection Issues**: Ensure the Sandcat server is running and accessible
- **Database Errors**: Try clearing the app data or reinstalling
- **Build Errors**: Run `flutter clean` followed by `flutter pub get`

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Open a Pull Request 