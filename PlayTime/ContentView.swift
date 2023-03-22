//
//  ContentView.swift
//  PlayTime
//
//  Created by Kusakabe Koki on 2023/03/16.
//

import SwiftUI

struct Player:Identifiable{
    var id = UUID()
    var number: Int
    var name: String
    var flag: Bool = false
    @ObservedObject var timer = TimerModel()

    //    init(number:Int , name:String , flags:Bool){
//        self.number = number
//        self.name = name
//        self.flags = flags
//    }
}

class PlayerModel:ObservableObject{
    @Published var people:[Player]
    
    init(){
        self.people = [
            Player(number: 2, name: "坂本 飛鳥"),
            Player(number: 5, name: "関根 拓真"),
            Player(number: 7, name: "田村 郁也"),
            Player(number: 9, name: "松尾 昂太郎"),
            Player(number: 10, name: "小川 大介"),
            Player(number: 19, name: "石井 洸一"),
            Player(number: 25, name: "掛谷 修造"),
            Player(number: 37, name: "清水 太一"),
            Player(number: 41, name: "林 宏季"),
            Player(number: 51, name: "日下部 洸希"),
            Player(number: 55, name: "渡部 巧巳"),
            Player(number: 81, name: "松川 隆太")]
        
    }
}
//ボタンclass
struct FloatingButton: View {
    @State var isCounting = false
    @ObservedObject var players:PlayerModel

    
    var body: some View {
        Button(action: {
            isCounting.toggle()
                if isCounting {
                    for i in players.people.indices{
                        if players.people[i].flag {
                            players.people[i].timer.start()
                        }
                    }
                }else {
                    for i in players.people.indices{
                        players.people[i].timer.stop()
                    }
                }
        }, label: {
            HStack {
                Spacer()
                Image(systemName: "stopwatch")
                    .imageScale(.small)
                    .foregroundColor((isCounting) ? .white : .black)
                    .font(.system(size: 30))
                Text((isCounting) ? "Tap to Stop" : "Tap to Start")
                    .foregroundColor((isCounting) ? .white : .black)
                .shadow(radius: 10)
                Spacer()
            }
            .padding()

        }).listRowBackground((isCounting) ? Color.black : Color.white)
    }
}



struct PlayerListView: View {
    @ObservedObject var playerModel:PlayerModel = PlayerModel()

    
    var body: some View {
        VStack{
            List{
                Section(header: Text("北海道大学(リバ)").font(.title)){
                    ForEach(playerModel.people.indices, id: \.self){ num in
                        HStack{
                            Text("#"+String(playerModel.people[num].number))
                            Text(playerModel.people[num].name)
                            Spacer()
                            Text(String(playerModel.people[num].timer.getMMSS()))
                 
                            
                            Button(String(playerModel.people[num].flag)){
                                playerModel.people[num].flag.toggle()
                            }.buttonStyle(BorderlessButtonStyle())
                            
                        }
                    }.listStyle(SidebarListStyle())
                }
                FloatingButton(players: playerModel)
                
            }
            
            
        }
    }
}

struct ContentView: View {
    var body: some View {
        PlayerListView()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
