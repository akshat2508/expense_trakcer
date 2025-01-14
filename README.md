# Expense Tracker Application

## Overview
The **Expense Tracker** application is a simple Flutter-based app designed to help users manage their daily expenses. It provides an intuitive interface to add, view, and analyze expenses through charts. 

---

## Features
- Add new expenses with details.
- View a list of all added expenses.
- Analyze spending through visual charts.
- Interactive UI with real-time updates.

---

## Directory Structure
The project consists of the following files:

### 1. `main.dart`
- Entry point of the Flutter application.
- Sets up the application and renders the main widget.

### 2. `expenses.dart`
- Contains the main widget that manages the state and structure of the application.
- Hosts other widgets like expense lists and charts.

### 3. `new_expense.dart`
- Provides the user interface for adding new expenses.
- Includes form fields for entering expense details such as title, amount, and date.

### 4. `expense.dart`
- Defines the data model for an expense.
- Each expense object includes attributes like title, amount, and date.

### 5. `expenses_list.dart`
- Displays a scrollable list of expenses.
- Each item is rendered using the `expense_item.dart` widget.

### 6. `expense_item.dart`
- Represents an individual expense item in the list.
- Formats and displays expense details, including title, amount, and date.

### 7. `chart.dart`
- Displays a bar chart summarizing weekly expenses.
- Uses data from the list of expenses to calculate totals for each day of the week.

### 8. `chart_bar.dart`
- A subcomponent of the `chart.dart` widget.
- Represents a single bar in the chart, showing the relative spending for a specific day.

---

## How to Run

### Prerequisites
1. Ensure you have Flutter installed on your system. [Install Flutter](https://docs.flutter.dev/get-started/install)
2. Set up an emulator or connect a physical device for testing.

### Steps to Run the Application
1. Clone this repository to your local machine:
   ```bash
   git clone https://github.com/akshat2508/expense_tracker.git
   ```
2. Navigate to the project directory:
   ```bash
   cd akshat2508-expense_tracker
   ```
3. Get the required dependencies:
   ```bash
   flutter pub get
   ```
4. Run the application:
   ```bash
   flutter run
   ```

---

## Download the APK
Download the application using the link below:

[Download APK](https://drive.google.com/file/d/14T5Kz9elzty76IxO7zKa_m663MWmYjPr/view?usp=sharing)

---

## Contribution
Contributions are welcome! To contribute:
1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Commit your changes and submit a pull request.


---

## Contact
For queries or support, reach out at: [akshatpaul2006@gmail.com](mailto:akshatpaul2006@gmail.com)

