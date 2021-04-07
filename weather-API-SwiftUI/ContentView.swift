//
//  ContentView.swift
//  weather-API-SwiftUI
//
//  Created by Abdullah Alnutayfi on 07/04/2021.
//

import SwiftUI

struct ContentView: View {
    @State  var cityName = ""
    @StateObject var vm = WeatherViewModel()
    var body: some View {
        ZStack{
           // LinearGradient(gradient: Gradient(colors: [.orange,.gray, .blue,.gray]), startPoint: .top, endPoint: .bottom)
            LinearGradient(gradient: Gradient(colors: [.white,.gray,.blue, .gray,]), startPoint: .top, endPoint: .bottom).opacity(0.50)
        VStack{
         
                ForEach(vm.weather){ weather in
                    HStack(){
                    Text(weather.name)
                        .frame(width: 100)
                        Spacer()
                        Text("\((weather.main.temp - 273.15), specifier: "%.0f")°")
                    ForEach(weather.weather){ w in
                  Spacer()
                        Image(systemName: w.icon)
                                .resizable()
                                .frame(width: 30, height: 30)
                           
                        
                        
                    }
                       
                    }
                    Divider()
                }.listRowBackground( LinearGradient(gradient: Gradient(colors: [.purple, .blue,]), startPoint: .top, endPoint: .bottom))
                Spacer()
            .foregroundColor(.white)
            HStack{
                Spacer()
              
            TextField("city name", text: $cityName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {vm.fetchWeatherData(cityName: cityName)}, label: {
                    Image(systemName: "magnifyingglass")
                        .padding(8)
                        .background(Color.white)
                        .cornerRadius(10)
                
                })
               // Spacer()
            }.padding(.bottom)
            
           
        }.padding()
        }.edgesIgnoringSafeArea(.bottom)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
