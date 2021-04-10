//
//  ContentView.swift
//  weather-API-SwiftUI
//
//  Created by Abdullah Alnutayfi on 07/04/2021.
//

import SwiftUI

struct ContentView: View {
    init() {
        UITableView.appearance().backgroundColor = UIColor.clear
    }
    @State var nameToExpand = ""
    @State  var cityName = "riyadh"
    @State var showMoreDetails = false
    @StateObject var vm = WeatherViewModel()
    var body: some View {
       
        HStack{
          
        TextField("city name", text: $cityName)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            Button(action: {
                    vm.fetchWeatherData(cityName: cityName)
            }, label: {
                Image(systemName: "magnifyingglass")
                  
                    .padding(8)
                    .background(Color.white)
                    .shadow(color:.black,radius: 10)
                    .cornerRadius(10)
            })
        }.padding(.horizontal)
        
        ZStack{
           
            LinearGradient(gradient: Gradient(colors: [.white,.gray,.blue, .gray,]), startPoint: .top, endPoint: .bottom).opacity(0.50)
            
            List{
                ForEach(vm.weather){ weather in
                    
                    HStack(alignment: .firstTextBaseline){
                        Text("^")
                            .rotationEffect((showMoreDetails && weather.name == nameToExpand) ? Angle.degrees(180) :  Angle.degrees(90) )
                            .onTapGesture {
                                DispatchQueue.main.async {
                                    nameToExpand = weather.name
                                }
                           
                                
                                    if weather.name == nameToExpand{
                                        withAnimation{
                                            showMoreDetails.toggle()
                                            
                                        }
                                    
                                print(weather.name)
                                }
                            }
                    Text(weather.name)
                        .frame(width: 100)
                        Spacer()
                        Text("\((weather.main.temp - 273.15), specifier: "%.0f")°")
                            .shadow(color: .yellow ,radius: 10)
                            .offset(x: -20)
                    ForEach(weather.weather){ w in
                  Spacer()
                        Image(uiImage:UIImage(data: vm.loadImage(ImageUrl: w.icon) ?? Data()) ?? UIImage())
                                .resizable()
                                .frame(width: 30, height: 30)
                            .foregroundColor(.secondary)
                          .shadow(color: .yellow,radius: 10)
                         
                    }
                    }
                    if showMoreDetails == true &&  nameToExpand == weather.name{
                        Rectangle()
                            .fill(LinearGradient(gradient: Gradient(colors: [.white,.gray]), startPoint: .top, endPoint: .bottom))
                            .frame(width: UIScreen.main.bounds.width, height: 140)
                            //.foregroundColor(.orange)
                            
                                                                    
                            .overlay(
                                HStack{
                                VStack(alignment: .leading){
                              
                                //if nameToExpand == weather.name{
                                Text("feels like: \(weather.main.feels_like - 273.15,  specifier: "%.0f")°")
                                Text("temp min: \(weather.main.temp_min,  specifier: "%.0f")°")
                                Text("temp max: \(weather.main.temp_max,  specifier: "%.0f")°")
                                Text("pressure: \(weather.main.pressure)")
                                Text("humidity: \(weather.main.humidity)")
                                    ForEach(weather.weather){ w in
                                        Text("description: \(w.description)")
                                    }
                               // }
                                   
                                }
                                    Spacer()
                                }.padding()
                            )
                            .offset(x: -20)
                    }
                    
                   // Divider()
                
                }.onDelete(perform: { indexSet in
                    vm.weather.remove(atOffsets: indexSet)
                })
                .onTapGesture {
                    print("tapped")
                }
                .listRowBackground( LinearGradient(gradient: Gradient(colors: [.white,.gray,.blue, .gray]), startPoint: .top, endPoint: .bottom).opacity(0.50))
                   
                
               
            //.foregroundColor(.white)
        }//.padding()
            }.edgesIgnoringSafeArea(.bottom)
        .animation(.easeIn)
       
        
   
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
