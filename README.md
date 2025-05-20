# Digit in Noise Test Application

This project implements a **Digit in Noise Test** as part of a technical assessment for the hearX group. 
It uses SwiftUI and follows the **MVVM architecture**, ensuring separation of concerns and modularity.

## Assessment Requirements

### Key Features:
1. **Home Screen**:
   - "Start Test" button to initiate the test.
   - "View Results" button to access past test results.

2. **Test Screen**:
   - Play a triplet of random digits with background noise.
   - Validate user input and adjust test difficulty based on correctness.
   - Handle 10 rounds of testing.

3. **Results Screen**:
   - Display previous test results sorted by score (descending).

### Additional Requirements:
- **API Integration**:
  - POST test results to an external API before displaying the final score.
- **Local Storage**:
  - Persist test results locally for offline access.
- **Unit Tests**:
  - Comprehensive test coverage for the ViewModel and all Views.

---

## Code Structure

### Models
- `TestResult`: Represents a single test result, including the score and date.

### ViewModel
- **`TestScreenViewModel`**:
  - Manages the logic for the test, including:
    - Generating random triplets.
    - Adjusting test difficulty.
    - Playing audio files (digits and noise).
  - Handles POST API calls to upload results.
  - Saves and retrieves results from local storage using `UserDefaults`.

### Views
1. **HomeScreenView**:
   - Navigation links to the Test Screen and Results Screen.

2. **TestScreenView**:
   - Displays test progress and accepts user input.
   - Provides "Exit Test" and "Submit" buttons.

3. **ResultsScreenView**:
   - Lists all past test results sorted by score.
   - Formats dates using `DateFormatter`.

---

## Implementation Details

### Features
1. **Digit and Noise Playback**:
   - Uses `AVAudioPlayer` to sequentially play noise and digits with delays.
2. **Dynamic Difficulty**:
   - Increases or decreases difficulty based on user input correctness.
3. **Persistent Results**:
   - Results are saved in `UserDefaults` and reloaded when the app launches.
4. **API Integration**:
   - Results are POSTed to an external server before finalizing the test.
5. **Navigation**:
   - SwiftUI `NavigationLink` and `sheet` are used for navigation and modals.

---

## Running the Application

### Prerequisites
- Xcode 14.0 or later
- iOS 15.0 or later

### Steps
1. Clone the repository.
2. Open the project in Xcode.
3. Select a simulator or connected device.
4. Build and run the project.

---

## Testing

### Unit Tests
- Comprehensive tests are provided for:
  - **ViewModel Logic**: Ensuring correctness of triplet generation, score updates, and API calls.
  - **UI Components**: Verifying the presence and behavior of buttons, navigation links, and sheets.

### Running Tests
1. Open the project in Xcode.
2. Press `Cmd + U` to execute all tests.
3. View the results in the **Test Navigator**.

---

## Future Enhancements
- Improve audio playback performance for lower latency.
- Add more detailed analytics for test results.
- Include multi-language support for accessibility.

---

## Acknowledgements
This project was created as part of a technical assessment for hearX. Special thanks to the reviewers for their time and feedback.

---

## Contact
For questions or support, please reach out to **Varsana Maharaj** at `varsana.maharaj@gmail.com`.
