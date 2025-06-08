# IM Flutter SDK

A modular Flutter SDK for instant messaging applications, inspired by Rust's sandcat-sdk architecture.

## Architecture

The SDK follows a clean architecture approach with clearly defined layers:

```
lib/sdk/
    ├── models/         # Data models using Dart features
    ├── repositories/   # Data access layer
    ├── services/       # Business logic
    ├── utils/          # Utility classes
    ├── storage/        # Local storage
    ├── network/        # Network requests
    ├── providers/      # State management (Riverpod)
    └── sdk.dart        # SDK entry point
```

## Setup

1. Add the SDK to your project
   - Include it as a local dependency or publish it to a private repository

2. Initialize the SDK
   ```dart
   import 'package:im/sdk/sdk.dart';
   
   void main() async {
     // Initialize the SDK before running the app
     await IMSDK().initialize(
       config: IMSdkConfig(
         baseUrl: 'https://your-api-base-url.com/api',
         enableLogging: true,
       ),
     );
     
     // Run your app wrapped with the SDK providers
     runApp(
       IMSDK().wrapWithProviders(
         child: MyApp(),
       ),
     );
   }
   ```

3. Generate required code files
   - Run the code generator to create the necessary files:
   ```
   flutter pub run build_runner build --delete-conflicting-outputs
   ```
   - This will generate files like `database.g.dart` required by Drift

## Usage Examples

### Authentication

```dart
// Login
final result = await IMSDK().auth.login('user@example.com', 'password');
result.fold(
  (user) => print('Logged in as ${user.name}'),
  (error) => print('Login failed: ${error.message}'),
);

// Get current user
final currentUserResult = await IMSDK().auth.getCurrentUser();
currentUserResult.fold(
  (user) => user != null 
      ? print('Current user: ${user.name}') 
      : print('No user logged in'),
  (error) => print('Error: ${error.message}'),
);

// Monitor authentication state
IMSDK().auth.authStateChanges().listen((user) {
  if (user != null) {
    print('User logged in: ${user.name}');
  } else {
    print('User logged out');
  }
});
```

### Chat Management

```dart
// Get all chats
final chatsResult = await IMSDK().chats.getAllChats();
chatsResult.fold(
  (chats) => print('Found ${chats.length} chats'),
  (error) => print('Error: ${error.message}'),
);

// Create a private chat
final newChatResult = await IMSDK().chats.createPrivateChat('user123');
newChatResult.fold(
  (chat) => print('Created chat with ID: ${chat.id}'),
  (error) => print('Error: ${error.message}'),
);

// Watch for chat updates
IMSDK().chats.watchChat('chat123').listen((chat) {
  if (chat != null) {
    print('Chat updated: ${chat.name}');
  } else {
    print('Chat deleted or not found');
  }
});
```

### Messaging

```dart
// Send a text message
final messageResult = await IMSDK().messages.sendTextMessage(
  'chat123',
  'Hello, world!',
);
messageResult.fold(
  (message) => print('Message sent with ID: ${message.id}'),
  (error) => print('Error: ${error.message}'),
);

// Get messages for a chat
final messagesResult = await IMSDK().messages.getMessagesForChat('chat123');
messagesResult.fold(
  (messages) => print('Found ${messages.length} messages'),
  (error) => print('Error: ${error.message}'),
);

// Watch for new messages
IMSDK().messages.watchNewMessages().listen((message) {
  print('New message: ${message.text}');
});
```

### Using Riverpod Providers

The SDK includes Riverpod providers for easy state management:

```dart
// In a ConsumerWidget
class ChatScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(chatStateProvider);
    final messageState = ref.watch(messageStateProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(chatState.currentChat?.name ?? 'Chat'),
      ),
      body: ListView.builder(
        itemCount: messageState.currentChatMessages.length,
        itemBuilder: (context, index) {
          final message = messageState.currentChatMessages[index];
          return ListTile(
            title: Text(message.text ?? ''),
            subtitle: Text(message.senderId),
          );
        },
      ),
    );
  }
}
```

## Database Generation

The SDK uses Drift for local database storage. To generate the required database code files, run:

```
dart run generate.dart
```

or manually:

```
flutter pub run build_runner build --delete-conflicting-outputs
```

## Features

- User authentication and management
- Chat creation and management
- Messaging with various types (text, image, file)
- Offline data storage
- Real-time updates using streams
- Robust error handling with Result type
- State management with Riverpod
- Network requests with Dio
- Secure storage for sensitive data 