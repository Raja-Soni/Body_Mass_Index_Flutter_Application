# Body_Mass_Index_Flutter_Application

Built a Flutter-based mobile app in Android Studio to calculate Body Mass Index (BMI) from user inputs (weight in kg, height in feet and inches), displaying results with categories like Underweight, Healthy, Overweight, or Obese, accompanied by relevant images.

Created a reusable CustomTextField widget with customizable styling (colors, borders, icons) to ensure consistent numeric input fields across the app.

Designed an animated splash screen with color transitions (red, green, blue), a custom logo, and dynamic RichText styling, transitioning to the main screen after 3 seconds using Future.delayed.

Implemented input validation using try-catch to handle non-numeric inputs and enforce constraints (e.g., weight > 2), showing clear error messages in a dynamic UI with AnimatedContainer.

Enhanced responsiveness with SingleChildScrollView and managed image assets (e.g., logo, category images) via pubspec.yaml for seamless integration.

