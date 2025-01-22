# UalaChallenge

Welcome to **UalaChallenge**, a SwiftUI application designed to showcase advanced UI testing, data management, and seamless user interactions. This project serves as a testament to my proficiency in SwiftUI, Combine, and UI Testing, aiming to secure a new opportunity in software development.

## Table of Contents

- [Features](#features)
- [Architecture](#architecture)
- [Getting Started](#getting-started)
- [Search Functionality](#search-functionality)


## Features

- **City Listing:** Browse through a comprehensive list of cities fetched from a server.
- **Favorites Management:** Mark cities as favorites for quick access. The app use Swift Data
- **Search Bar:** Efficiently search and filter cities in real-time.
- **Detailed Views:** Access detailed information and maps for each city.
- **UI Testing:** Robust UI tests ensuring reliability and performance. You need to setup the region on the simulator as Argentina, else the test fails for the region styles. On the other hand, the pdf with the challenge said that I receive an Information view, but I do not receive this file, for this reason, a create a new one.
- **Unit Testing:** Robust UI tests ensuring reliability and performance.

## Architecture

UalaChallenge is built using the **MVVM (Model-View-ViewModel)** architecture, ensuring a clear separation of concerns and enhancing testability.

- **Model:** Defines the data structures, including `City` and `Favorite`.
- **ViewModel:** Manages data fetching, filtering, and business logic using `CitiesViewModel`.
- **View:** SwiftUI views like `CityListScreen` and `MapDetailScreen` handle the UI rendering.

## Getting Started

### Prerequisites

- Xcode 16.2 or later
- Swift 6 or later


### Installation

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/EngineeringLatamAvenga/manuel_alvarez_ios_challenge
   ```

2. **Navigate to the Project Directory:**

   ```bash
   cd UalaChallenge
   ```

3. **Open the project on XCode or use the terminal:**

   ```bash
   open UalaChallenge.xcodeproj
   ```
