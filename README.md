# 🚀 snippet_gen

A lightweight Dart CLI tool to quickly generate:

- ✅ Provider architecture (Controller + Provider + Repository + Models)
- ✅ BLoC architecture (Bloc + Event + State + Repository + Models)
- ✅ Dart models from JSON (with nested class support + safe parsing)

---

## ✨ Features

- 🔹 Generate full **Provider-based backend structure**
- 🔹 Generate full **BLoC-based architecture**
- 🔹 Generate **Dart models from JSON**
- 🔹 Supports **nested objects → nested classes**
- 🔹 Built-in support for **safe parsing (ParsingHelper)**
- 🔹 Optional **abstract repository generation**
- 🔹 Clean folder structure aligned with scalable apps

---

## 📦 Installation

Add it locally or run directly:

```bash
dart run snippet_gen <command>
```

---

## ⚙️ Usage

### 1️⃣ Generate Provider Resource

```bash
dart run snippet_gen generate provider <EntityName>
```

Example:

```bash
dart run snippet_gen generate provider User
```

---

### 2️⃣ Generate Provider Resource with Abstract Repository

```bash
dart run snippet_gen generate provider <EntityName> --abstract
```

Example:

```bash
dart run snippet_gen generate provider User --abstract
```

✔ Generates repository methods with TODOs instead of API implementation

---

### 3️⃣ Generate BLoC Resource

```bash
dart run snippet_gen generate bloc <EntityName>
```

Example:

```bash
dart run snippet_gen generate bloc User
```

---

### 4️⃣ Generate BLoC Resource with Abstract Repository

```bash
dart run snippet_gen generate bloc <EntityName> --abstract
```

---

### 5️⃣ Generate Model from JSON

```bash
dart run snippet_gen model <json_file_path> <ClassName>
```

Example:

```bash
dart run snippet_gen model lib/model/user.json User
```

✔ Output:

- Generates `.dart` file next to JSON file
- Supports nested objects → multiple classes
- Uses safe parsing via `ParsingHelper`

---

## 🧠 Example JSON

```json
{
  "user_id": "123",
  "phone": "999999999",
  "is_active": true,
  "hobbies": {
    "music": ["listening", "singing"]
  }
}
```

---

## ✅ Generated Output (Simplified)

```dart
class User {
  final String? userId;
  final bool? isActive;
  final Hobbies? hobbies;
}
```

```dart
class Hobbies {
  final List<String>? music;
}
```

---

## ⚠️ Important Notes

### 🔸 Argument Order Matters

Correct:

```bash
dart run snippet_gen generate provider User --abstract
```

Incorrect:

```bash
dart run snippet_gen generate provider --abstract User ❌
```

---

### 🔸 ParsingHelper Dependency

Generated models rely on your parsing helper:

```dart
import 'package:your_project/utils/parsing_helper.dart';
```

Make sure:

- The file exists
- `intl` package is added (if using DateTime parsing)

```yaml
dependencies:
  intl: ^0.19.0
```

---

## 📁 Generated Structure

### Provider

```
lib/backend/user/
├── user_controller.dart
├── user_provider.dart
├── user_repository.dart
```

### Provider Models

```
lib/backend/user/model
├── user_model.dart
├── create_user_request_dto.dart
├── update_user_request_dto.dart
├── user_response_dto.dart
```

### BLoC

```
lib/blocs/user/
├── user_bloc.dart
├── user_event.dart
├── user_state.dart
├── user_repository.dart
```

### Bloc Models

```
lib/bloc/user/model
├── user_model.dart
├── create_user_request_dto.dart
├── update_user_request_dto.dart
├── user_response_dto.dart
```

## 💬 Contributing

PRs are welcome. Keep it simple, readable, and scalable.

---

## 📄 License

MIT License
