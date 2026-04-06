# Calculator App

A simple calculator app that can perform basic arithmetic calculations (addition, subtraction, multiplication, and division).

## Description

Users can use the calculator to perform addition, subtraction, multiplication, and division operations with whole numbers or decimal numbers.

## Getting Started

1. Make sure you have Xcode 26.1 or greater installed.
2. Open CalculatorApp.xcodeproj.
3. Build and run the CalculatorApp scheme.

After running the app, you should see the calculator as shown below.

![Calculator App](https://i.postimg.cc/sgKZ5X57/Calculator-App.png)

You can then begin using the calculator to perform arithmetic operations.

## Technical Details

### Tech Stack

The app is implemented in Swift using UIKit, with the views and buttons created programmatically. It also makes use of NSExpression to calculate the results of arithmetic operations.

### Architecture

This app uses the MVVM (Model-View-ViewModel) architecture.

* Model - Contains the data structures for the app.
* View - Displays what the user sees on the screen and accepts any user interaction (such as pressing a button, enabling/disabling a toggle, and editing a text field).
* ViewModel - Contains data from the model that is used for the view, as well as business logic related to the view.

## Project Structure

* CalculatorApp - The main project directory.
    * Model - Contains files related to the model/app data.
    * View - Contains source code files related to the views in the app.
    * ViewModel - Contains the view model source code files.

## Testing

This app also contains unit tests to test the view and view model. The unit tests are located inside the CalculatorAppTests folder. To run the unit tests, first switch to the CalculatorAppTests scheme. Then, you can run the unit tests by pressing Command+U or selecting Product > Test. Additionally, you can run each unit test or unit test class individually.

## Example Usage

![Addition](https://i.postimg.cc/RV5fB2MN/addition.gif)

![Subtraction](https://i.postimg.cc/wBGybGWr/subtraction.gif)

![Multiplication](https://i.postimg.cc/Dw7XWs48/multiplication.gif)

![Division](https://i.postimg.cc/SxVzcscM/division.gif)

![Division with decimal result](https://i.postimg.cc/YCtW4gL0/division-with-decimal-result.gif)

![Division by 0](https://i.postimg.cc/dVnTG1Gs/division-by-0.gif)