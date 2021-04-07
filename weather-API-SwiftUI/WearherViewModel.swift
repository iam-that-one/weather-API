//
//  WearherViewModel.swift
//  weather-API-SwiftUI
//
//  Created by Abdullah Alnutayfi on 07/04/2021.
//

import Foundation

class WeatherViewModel: ObservableObject{
    @Published var weather = [WeatherData]()
    
    
    func fetchWeatherData(cityName: String){
        
        let API_KEY = "866847902dae7817cfda96a6c8990b35"
        let API_URL = "https://api.openweathermap.org/data/2.5/weather?q=Riyadh&appid=\(API_KEY)"
        
        guard let url = URL(string: API_URL)else{
            print("Invalid URL . . . ")
            return
        }
        let request = URLRequest(url: url)
        let decoder = JSONDecoder()
      let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
      
            if let data = data{
                do{
                let response = try decoder.decode(WeatherData.self, from: data)
                    DispatchQueue.main.async {
                        self.weather.append(WeatherData(name: response.name, main: response.main, weather: response.weather))
                    }
                
                    
                   print(response)
                }catch{
                    print(error.localizedDescription)
                }
            }
            print(error?.localizedDescription as Any)
        }
    dataTask.resume()
    }
}



struct WeatherData : Codable, Identifiable{
    let name :String
    let main : Main
    let weather : [Weather]
    var id : String{
        name
    }
}

struct Main :Codable{
    let temp : Double
}

struct Weather: Codable, Identifiable {
    let id : Int
}
