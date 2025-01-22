# UalaChallenge

Welcome to **UalaChallenge**, a SwiftUI application designed to showcase advanced UI testing, data management, and seamless user interactions. This project serves as a testament to my proficiency in SwiftUI, Combine, and UI Testing, aiming to secure a new opportunity in software development.

## Table of Contents

[Download the Challenge Instructions](https://github.com/EngineeringLatamAvenga/manuel_alvarez_ios_challenge/blob/main/Mobile%20Challenge%20-%20v0.5%20(1).pdf)

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

## Search Functionality

The search bar in **UalaChallenge** is a fundamental feature that allows users to efficiently filter the list of cities. Below is a detailed explanation of how the search filter is managed in the `CitiesViewModel`, including the use of a dictionary to enhance efficiency.

### **Handling the Search Filter in `CitiesViewModel.swift`**

The `CitiesViewModel` is responsible for managing the business logic related to fetching, storing, and filtering city data. The search functionality is implemented as follows:

1. **Fetching and Storing Data:**

    - **Description:**
        - Cities are fetched asynchronously from a data source (e.g., a server) and stored in the `cities` array.
        - A dictionary named `cityIndex` is created to map the first letter of each city's name to an array of cities starting with that letter. This is achieved by iterating through each city and grouping them based on their first letter.

2. **Implementing the Search Filter:**

    - **Description:**
        - `applyFilter()` checks if the `searchText` is empty. If it is, all cities are displayed. If not, it calls `filterCities(with:)` with the current search text.
        - `filterCities(with:)` performs an asynchronous search using the provided prefix and updates the `filteredCities` array with the results.

3. **Optimizing with a Dictionary (`cityIndex`):**

    Using a dictionary to index cities by the first letter of their names significantly improves the efficiency of the search functionality. Here's how and why this optimization is implemented:

    ### **Why Use a Dictionary for Filtering Cities?**

    - **Search Efficiency:**
        - Without an index, each search operation would require iterating through the entire list of cities, which can be time-consuming, especially with a large dataset.
        - By using a dictionary that maps the first letter to corresponding cities, the search space is considerably reduced. For example, searching for cities starting with "B" only requires looking up the cities under the key `'b'` in the dictionary.

    - **Constant Time Access:**
        - Dictionaries in Swift provide constant time complexity \(O(1)\) for accessing elements by key, making search operations faster.


## Summary

The implementation of the search filter in `CitiesViewModel` leverages a dictionary (`cityIndex`) to map the first letter of each city's name to an array of corresponding cities. This optimization enhances search efficiency by reducing the number of comparisons needed during filtering, providing a scalable and maintainable solution that ensures a smooth and responsive user experience even with large datasets.

---