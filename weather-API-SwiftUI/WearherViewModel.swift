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
     
        let API_KEY = ""
        let API_URL = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(API_KEY)"
        
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
                    print(response)
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
    func loadImage(ImageUrl: String) -> Data?{
        print("----- \(ImageUrl)")
       let imURL = "https://openweathermap.org/img/wn/\(ImageUrl)@2x.png"
        print(imURL)
        guard let url = URL(string: imURL) else {return Data()}
        if let data = try? Data(contentsOf: url){
            return data
        }
        return nil
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
    let humidity : Int
    let feels_like : Double
    let temp_min : Double
    let temp_max : Double
    let pressure : Int
}


struct Weather: Codable, Identifiable {
    
   
    let id : Int
    let icon : String
    let description : String
    /*
    var icon:String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-mmm-yyyy hh:mm:ss.s a"
        let stringDate = formatter.string(from: date)
        print(stringDate)
        switch id {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return stringDate.contains("AM") ?  "sun.max" : "moon.stars"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    */
}
