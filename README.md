# SwiftUI Timer App

This simple SwiftUI app demonstrates a countdown timer with the following features:

- A 1-minute countdown displayed in a SwiftUI view.
- Start, pause, and stop buttons to control the timer.
- An animated ring around the timer text reflecting the time left.
- System notifications when the timer ends, even when the app is in the background.


## Demo Video link
[Video Link] https://drive.google.com/file/d/1vZMHK6bxb93h8QeOgjo9PvoM0C2VSOkb/view?usp=sharing

## How to Use

1. Clone or download the repository.
2. Open the Xcode project file (`Timer.xcodeproj`) in Xcode.
3. Run the app on a simulator.
4. The app displays a 1-minute countdown timer with start, pause, and stop buttons.
5. Tap the "Start" button to begin the countdown. Tap "Pause" to pause and resume. Tap "Stop" to reset the timer.
6. The animated ring around the timer text shows the time left.

## Implementation Details

- The app uses SwiftUI for the user interface.
- The timer logic is implemented in the `CountdownViewModel` class, which is observable and handles updates to the timer.
- The Circle view is used for the animated ring around the timer text.
- Local notifications are triggered when the timer ends, it shows when the app is in the background.

## Dependencies

- This app relies on SwiftUI and Combine for the UI and timer logic.
