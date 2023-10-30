import SwiftUI

struct ContentView: View {
    @State private var dessertMeals: [Meal] = []
    @State private var selectedMeal: Meal?
    
    var body: some View {
        NavigationView {
            List(dessertMeals, id: \.idMeal) { meal in
                NavigationLink(destination: MealDetailView(meal: meal)) {
                    HStack {
                        AsyncImage(url: URL(string:meal.strMealThumb)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(width: 80, height: 80)
                            case .success(let image):
                                image
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .cornerRadius(10)
                            case .failure:
                                Image(systemName: "photo")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .cornerRadius(10)
                            @unknown default:
                                EmptyView()
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            Text(meal.strMeal)
                                .font(.headline)
                        
                        }
                    }
                }
            }
            .onAppear {
                fetchDessertMeals()
            }
            .navigationTitle("Dessert Meals")
        }
    }
    
    func fetchDessertMeals() {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(MealListResponse.self, from: data)
                    dessertMeals = response.meals.compactMap { $0 }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            } else if let error = error {
                print("Error fetching data: \(error)")
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
