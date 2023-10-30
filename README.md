# Fetch_Recruitment_Project

## Overview

The Meal App provides a list of meals in the Dessert category, sorted alphabetically, and allows users to view detailed information about each meal, including its name, instructions, and ingredients/measurements.

## Features

- Display a list of meals in the Dessert category on the home page, sorted alphabetically.
- When a user selects a meal, the app shows a detailed view, which includes:
  - Meal name
  - Instructions
  - Ingredients/measurements

## API Endpoints

The app utilizes the following two endpoints for retrieving meal data from TheMealDB API:

1. **List of Meals in the Dessert Category**
   - Endpoint: [https://themealdb.com/api/json/v1/1/filter.php?c=Dessert](https://themealdb.com/api/json/v1/1/filter.php?c=Dessert)
   - Description: This endpoint is used to fetch the list of meals in the Dessert category.

2. **Meal Details by ID**
   - Endpoint: [https://themealdb.com/api/json/v1/1/lookup.php?i=MEAL_ID](https://themealdb.com/api/json/v1/1/lookup.php?i=MEAL_ID)
   - Description: This endpoint is used to fetch detailed meal information by its ID. Replace `MEAL_ID` with the specific meal's ID to get the details.

## Usage

To use the Meal App, follow these steps:

1. Install the app on your device.
2. Open the app and browse the list of Dessert category meals.
3. Select a meal to view its detailed information, including name, instructions, and ingredients/measurements.

Enjoy exploring delicious dessert recipes with the Meal App!

