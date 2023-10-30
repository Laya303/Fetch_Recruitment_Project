import SwiftUI

struct MealDetailView: View {
    var meal: Meal
    @State private var mealDetail: MealDetail?
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 20) {
                    // Display the meal image
                    AsyncImage(url: URL(string: meal.strMealThumb)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: geometry.size.width, height: geometry.size.height / 3) // Adjust the height as needed
                        case .success(let image):
                            image
                                .resizable()
                                .frame(width: geometry.size.width, height: geometry.size.height / 3) // Adjust the height as needed
                                .cornerRadius(10)
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .frame(width: geometry.size.width, height: geometry.size.height / 3) // Adjust the height as needed
                                .cornerRadius(10)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    
                    
                    // Display the meal name
                    Text(mealDetail?.strMeal ?? "")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    // Display meal category and area
                    HStack(spacing: 20) {
                        Text("Category: \(mealDetail?.strCategory ?? "N/A")")
                            .font(.footnote)
                        Text("Area: \(mealDetail?.strArea ?? "N/A")")
                            .font(.footnote)
                    }
                    
                    // Display meal instructions
                    HStack(spacing: 20) {
                        Text("Instructions")
                            .font(.title2)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    
                    Text(mealDetail?.strInstructions ?? "No instructions available.")
                        .font(.body)

                    HStack(spacing: 20) {
                        Text("Ingredients")
                            .font(.title2)
                            .fontWeight(.bold)
                        Spacer()
                    }.padding(.top,8)
                    
                    // Display the list of ingredients
                    if let ingredients = mealDetail?.dynamicIngredients {
                        let filteredIngredients = ingredients.filter { !$0.key.isEmpty }
                        
                        ScrollView {
                            VStack(spacing: 0) {
                                ForEach(filteredIngredients.sorted(by: { $0.key < $1.key }), id: \.key) { ingredient in
                                    VStack{
                                        HStack {
                                            Text(ingredient.key)
                                                .font(.body)
                                                .fontWeight(.bold)
                                            Spacer()
                                            Text(ingredient.value)
                                                .font(.body)
                                        }.padding(.bottom,8).padding(.top,8)
                                        Divider()
                                    }
                                }
                            }
                        }
                       
                    }

                    
                    // Display a link to the source
                    if let sourceURL = URL(string: mealDetail?.strSource ?? "") {
                        Link("Source", destination: sourceURL)
                            .font(.subheadline)
                    }
                }
            }
        }.padding(.horizontal)
        .onAppear {
            fetchMealDetails()
        }
    }
    
    
    func fetchMealDetails() {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(meal.idMeal)") else { return }
        URLSession.shared.dataTask(with: url) { data, r, error in
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(MealDetailResponse.self, from: data)
                    mealDetail = response.meals.first as? MealDetail
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            } else if let error = error {
                print("Error fetching data: \(error)")
            }
        }.resume()
    }
}

struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailView(meal: Meal(idMeal: "52772", strMeal: "Cheesecake",strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg"))
    }
}
