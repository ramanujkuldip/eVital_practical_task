
# eVital_practical_task

This Flutter application is built using Flutter 3.29.0 and GetX for state management. The app follows the task description provided by the interviewer and implements the required functionalities effectively.

Prerequisites:
 - Install Flutter 3.29.0
 - Install Dart
 - Install dependencies by running: flutter pub get

Features and Implementation:
1. Splash Screen: Designed with creativity and UI enhancements.
2. Login Screen:
     - takes two input fields: mobile number and password.
     - Validations added for text fields
     - UTM Details are displayed below the login button.
     - How to Test Deep Link for UTM Extraction:
           1. Copy the following deep link: kuldeeplink://open?utm_source=google&utm_medium=google_page&utm_campaign=google_campaign
           2. Click on the link, and you will be able to select a link. When you click on the link, a pop-up will appear asking you to continue opening the app.
           3. The app will launch, and UTM details will appear below the Login button.
3. Home Page:
    - Displays a list of 43 records.
    - Used local storage for store list and update rupees.
    - Implements Pagination (20 records per scroll load).
    - Rupee Stock (0 to 100) -> If rupees are below 50 then its indicated with red and if above 50 the its indicated with green color.
    - Filtering Options: The list can be filtered by Name, Phone, or City.
    - You see a button on the right side of a search field. On clicking that button a dialog box will open for the list of cities. you can apply a filter using select cites.

4. Dialog Box for Rupee Update:
   - Clicking a row opens a dialog to update the Rupee value.
   - The updated Rupee value is reflected immediately in the list.

Note:
1. A video demonstration is attached for reference.
2. The release APK is also included for testing.
