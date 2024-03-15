# Skincare Routine Tracker App

## Overview
This repository contains the source code for a mobile application designed to help users track their daily skincare routines. The app leverages Firebase Firestore for data storage and Firebase Authentication for user management. Users are authenticated anonymously upon app installation, allowing for a seamless onboarding experience while ensuring user data is securely managed.

### Key Components

- **Users Collection**: Stores documents for each user, with data such as email, name, streaks, and a subcollection for skincare routines.
- **SkincareRoutines Subcollection**: Contains documents for each day's routine, detailing which steps were completed, when they were completed, and links to images for each step.

## Authentication and User Data Management

Upon installing the app, users undergo anonymous authentication, creating a unique user session without requiring manual sign-up. This user session is linked to a `userID`, which indexes their data in the Firestore database.

## Operational Limits

- **Daily Routine Logging**: Users can log their skincare routine once per day. Attempting to log the routine more than once in the same day will update the existing entry for that day.
- **Streak Tracking**: The app tracks the number of consecutive days a user completes their skincare routine. Missing a day resets the current streak count, while the longest streak achieved is preserved.

## Streak Management

Streaks are managed by incrementing the `currentStreak` field for each consecutive day a user completes their routine, with the app automatically resetting this count if a day is missed. The `longestStreak` field records the user's highest consecutive daily completion count.

## Getting Started

To build and run this app:

1. Clone this repository.
2. Open the project in your preferred Flutter development environment.
3. Ensure Firebase is set up for your project as per the Firebase documentation.
4. Run the app on your device or emulator.

For more information on Firebase setup, please refer to the [Firebase documentation](https://firebase.google.com/docs).

## Screens

<img width="2160" alt="Screenshot 2024-03-15 at 12 50 20 PM" src="https://github.com/JhaNviSadhu/urban_culture/assets/63531297/5cabe222-42a4-4e9b-aabd-49d28145b697">
<img width="2160" alt="Screenshot 2024-03-15 at 12 51 28 PM" src="https://github.com/JhaNviSadhu/urban_culture/assets/63531297/7eb45c79-5cfe-411d-805e-6d1f0b15f5f3">
<img width="2160" alt="Screenshot 2024-03-15 at 12 51 51 PM" src="https://github.com/JhaNviSadhu/urban_culture/assets/63531297/cf4c873f-060b-463a-b0b8-5432b072c1ce">

## Video Links



## Git Commit Conventions

```dart
- 🎉 :tada: initial commit 🎉
- 🚀 :rocket: [Add] when implementing a new feature
- 🔨 :hammer: [Fix] when fixing a bug or issue
- 🎨 :art: [Refactor] when refactor/improving code
- 🚧 :construction: [WIP]
- 📝 :pencil: [Minor] Some small updates
```
