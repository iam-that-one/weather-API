//
//  ContentView.swift
//  weather-API-SwiftUI
//
//  Created by Abdullah Alnutayfi on 07/04/2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = WeatherViewModel()
    var body: some View {
        VStack{
            List{
                ForEach(vm.weather){ weather in
                    HStack(spacing: 50){
                    Text(weather.name)
                        Text("\(weather.main.temp, specifier: "%.2f")")
                    ForEach(weather.weather){ w in
                        if w.id == 800{
                            Image(systemName: "smoke")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                        
                    }
                    }
                }
            }
        }.onAppear{vm.fetchWeatherData(cityName: "")}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
