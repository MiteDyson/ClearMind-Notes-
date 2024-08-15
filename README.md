
# Clearmind App - Mood-Based Customization Feature

This repository contains the implementation of a dynamic mood-based customization feature for the **Clearmind App**, a mental health application designed to enhance user experience through personalized journaling. This feature allows users to tag their journal entries with specific moods, which in turn dynamically alters the background color of the journal entry page. Additionally, journal entries are categorized by mood, enabling efficient analysis and review of thoughts.


## Demo

[Demo Video](demo-video.mp4)
-

## Mood Screens

### Home Screen
![Home Screen](https://github.com/user-attachments/assets/7a99f323-69e9-41eb-865e-731542f617e1)


### List Entries
![List Entries](https://github.com/user-attachments/assets/9d9cf0ca-0fb0-4724-9e70-1047dee2f735)


### Filter Screen
![Filter Screen](https://github.com/user-attachments/assets/6fcea229-3510-46f8-a875-ee3572744649)



## Features

### 1. Mood Tagging
- **Tag Journal Entries:** Users can tag their journal entries with one of three moods: Happy, Sad, or Neutral.
- **Mood Storage:** Each mood tag is stored alongside the journal entry in the local database for future reference.

### 2. Dynamic Background Color
- **Mood-Based Customization:** The background color of the journal entry page changes according to the tagged mood:
  - **Happy:** Yellow
  - **Sad:** Blue
  - **Neutral:** Gray

### 3. Mood-Based Note Storage
- **Categorized Entries:** Journal entries are categorized by mood, allowing users to filter and analyze mood-related data efficiently.



## Setup Instructions

### 1. Clone the Repository
```bash
git clone https://github.com/your-username/clearmind-mood-feature.git
cd clearmind-app
```

### 2. Set Up the Project
- Open the project in **Visual Studio Code** or your preferred IDE.
- Ensure you have the necessary **Flutter SDKs** and dependencies installed.

### 3. Run the Application
- Connect a physical device or start an emulator.
- Click on the "Run" button in your IDE to launch the application.


## Usage

### 1. Tagging Entries
- Navigate to the **Journal Entry Page**.
- Enter your thoughts and select a mood tag (**Happy, Sad, Neutral**).
- Save the entry to see the background color change according to the selected mood.

### 2. Viewing Entries
- Navigate to the **Journal Entry List** to view all entries.
- Filter entries by mood to focus on specific emotional states.
  
---
