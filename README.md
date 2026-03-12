# Spinner Date Picker

A customizable **iOS-style spinner date picker widget for Flutter**.

This package provides a simple and lightweight dialog that allows users to select a date using scrollable wheels for **month, day, and year**.

---

## ✨ Features

* iOS-style **spinner date selection**
* Fully **customizable button**
* Configurable **year range**
* Supports **custom date formats**
* Lightweight and easy to integrate
* Works on **Android, iOS, Web, Windows, macOS, and Linux**

---

## 📦 Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  spinner_date_picker: ^0.0.1
```

Then run:

```bash
flutter pub get
```

---

## 🚀 Usage

Import the package:

```dart
import 'package:spinner_date_picker/spinner_date_picker.dart';
```

Basic example:

```dart
CustomSpinnerDatePickerWidget(
  onDateSelected: (date) {
    print(date);
  },
)
```

---

## 🧩 Full Example

```dart
CustomSpinnerDatePickerWidget(
  initialDate: DateTime.now(),
  yearStart: 1990,
  yearEnd: 2050,
  buttonText: "Select Date",
  onDateSelected: (date) {
    print("Selected Date: $date");
  },
)
```

---

## ⚙️ Parameters

| Parameter      | Type                | Description                  |
| -------------- | ------------------- | ---------------------------- |
| width          | double?             | Width of widget              |
| height         | double?             | Height of widget             |
| initialDate    | DateTime?           | Initial selected date        |
| onDateSelected | Function(DateTime)? | Callback when date selected  |
| buttonText     | String              | Button label                 |
| buttonColor    | Color?              | Button color                 |
| textStyle      | TextStyle?          | Style for selected date text |
| dateFormat     | String?             | Date display format          |
| yearStart      | int                 | Starting year                |
| yearEnd        | int                 | Ending year                  |

---

## 📷 Screenshots


Example:

```
### Date Picker Button
![Spinner Picker](/assets/screenshots/date_picker.png)
<p align="center">
  <img src="ass" width="300">
</p>
### Spinner Dialog
![Spinner Dialog](/
screenshots/home_page.png)
```

---

## 📂 Example App

See the `/example` folder for a full runnable Flutter example.

---

## 📜 License

This project is licensed under the MIT License.
