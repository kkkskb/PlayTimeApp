//
//  ContentView.swift
//  PlayTime
//
//  Created by Kusakabe Koki on 2023/03/16.
//

import SwiftUI

struct Player:Identifiable{
    var id = UUID()
    var number: String
    var name: String
    var flag: Bool = false
    @ObservedObject var timer:TimerModel = TimerModel(count: 0)
}

class PlayerModel:ObservableObject{
    @Published var people:[Player]
    
    init(){
        self.people = [
            Player(number: "02", name: "坂本 飛鳥"),
            Player(number: "05", name: "関根 拓真"),
            Player(number: "07", name: "田村 郁也"),
            Player(number: "09", name: "松尾 昂太郎"),
            Player(number: "10", name: "小川 大介"),
            Player(number: "19", name: "石井 洸一"),
            Player(number: "25", name: "掛谷 修造"),
            Player(number: "37", name: "清水 太一"),
            Player(number: "41", name: "林 宏季"),
            Player(number: "51", name: "日下部 洸希"),
            Player(number: "55", name: "渡部 巧巳"),
            Player(number: "81", name: "松川 隆太"),
            Player(number: "??", name: "渡辺 大翔")]
    }  
}



//スタートストップボタン
struct StartStopButton: View {
    @Binding var isCounting: Bool
    @ObservedObject var playerModel: PlayerModel
    @ObservedObject var gameTimer: TimerModel
    
    
    var body: some View {
        Button(action: {
            isCounting.toggle()
            if isCounting {
                gameTimer.countDownStart()
                for i in playerModel.people.indices{
                    if playerModel.people[i].flag {
                        playerModel.people[i].timer.start()
                    }
                }
            }else {
                gameTimer.stop()
                for i in playerModel.people.indices{
                    playerModel.people[i].timer.stop()
                }
            }
        }, label: {
            HStack {
                Spacer()
                Image(systemName: (isCounting) ?  "pause.fill" : "arrowtriangle.forward.fill" )
                    .imageScale(.small)
                    .foregroundColor(Color(UIColor.label))
                    .font(.system(size: 60))
                Spacer()
            }
            .padding()
            
        }).buttonStyle(BorderlessButtonStyle())
    }
}

// minusボタン
struct MinusButton: View {
    @ObservedObject var playerModel:PlayerModel
    @ObservedObject var gameTimer: TimerModel

    
    var body: some View {
        Button(action: {
            gameTimer.minus(num: 5)
            for i in playerModel.people.indices{
                if playerModel.people[i].flag {
                    playerModel.people[i].timer.plus(num: 5)
                }
            }
        }, label: {
            Image(systemName: "gobackward.5")
                .imageScale(.small)
                .foregroundColor(Color(UIColor.label))
                .font(.system(size: 30))
        }).buttonStyle(BorderlessButtonStyle())
    }
}

// plusボタン
struct PlusButton: View {
    @ObservedObject var playerModel:PlayerModel
    @ObservedObject var gameTimer: TimerModel
    
    var body: some View {
        Button(action: {
            gameTimer.plus(num: 5)
            for i in playerModel.people.indices{
                if playerModel.people[i].flag {
                    playerModel.people[i].timer.minus(num: 5)
                }
            }
        }, label: {
            Image(systemName: "goforward.5")
                .imageScale(.small)
                .foregroundColor(Color(UIColor.label))
                .font(.system(size: 30))
        }).buttonStyle(BorderlessButtonStyle())
    }
}

//コピーボタン
struct CopyButton: View {
    let playerModel:PlayerModel

    var body: some View {
        Button(action: {
            // playerModelのpeopleをクリップボードにコピー
            let pasteboard = UIPasteboard.general
            var str:String = ""
            for i in playerModel.people.indices{
                // 名前を強制的に7文字に満たす
                var name = playerModel.people[i].name
                if name.count < 6 {
                    for _ in 0..<(6 - name.count){
                        name += "  "
                    }
                }
                str += "#" + String(playerModel.people[i].number) + " " + name + " " + String(playerModel.people[i].timer.getMMSS()) + "\n"
            }
            pasteboard.string = str
            // クリップボードにコピーしたことをウィンドウで通知する
            let scenes = UIApplication.shared.connectedScenes
            let windowScene = scenes.first as? UIWindowScene
            let window = windowScene?.windows.first
            let alert = UIAlertController(title: "コピーしました", message: nil, preferredStyle: .alert)
            window?.rootViewController?.present(alert, animated: true, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                alert.dismiss(animated: true, completion: nil)
            }
                }, label: {
            Image(systemName: "doc.on.doc")
                .imageScale(.small)
                .foregroundColor(Color(UIColor.label))
                .font(.system(size: 30))
        }).buttonStyle(BorderlessButtonStyle())
    }
}

// gameTimer.count=600に戻すリセットボタンを作成
struct ResetButton: View {
    @ObservedObject var gameTimer: TimerModel
    
    var body: some View {
        Button(action: {
            gameTimer.reset(num: 600)
        }, label: {
            Image(systemName: "arrow.counterclockwise")
                .imageScale(.small)
                .foregroundColor(Color(UIColor.label))
                .font(.system(size: 30))
        }).buttonStyle(BorderlessButtonStyle())
    }
}


struct GetMMSSView: View {
    @Binding var isCounting: Bool
    var player: Player
    @ObservedObject var timer: TimerModel
    
    var body: some View {
        
        if player.flag && isCounting {
            // 文字の背景を緑にして、文字を白にする
            Text(String(timer.getMMSS()))
                .foregroundColor(Color(UIColor.systemBackground))
                .frame(width:55,height:25)
                .background(Color(UIColor.systemGreen))
                .cornerRadius(5)
        }else {
            Text(String(timer.getMMSS()))
                .foregroundColor(Color(UIColor.label))
        }
    }
}

struct GetGameTimeMMSSView: View {
    @Binding var isCounting: Bool
    @ObservedObject var gameTimer: TimerModel = TimerModel(count: 600)
    
    var body: some View {

        if isCounting {
            Text(String(gameTimer.getMMSS()))
                .font(.custom("DSEG14Classic-Regular", size: 40))
                .foregroundColor(Color(UIColor.label))
                .frame(maxWidth: .infinity,alignment: .center)
                .underline(color: .green)
//                .foregroundColor(Color(UIColor.systemBackground))
//                .background(Color(UIColor.systemGreen))
//                .cornerRadius(5)
//                .frame(maxWidth: .infinity,maxHeight: 100,alignment: .center)
        }else{
            Text(String(gameTimer.getMMSS()))
                .font(.custom("DSEG14Classic-Regular", size: 40))
                .foregroundColor(Color(UIColor.label))
                .frame(maxWidth: .infinity,alignment: .center)
        }

        
    }
}


struct PlayerListView: View {
    @ObservedObject var playerModel:PlayerModel = PlayerModel()
    @State var isCounting: Bool = false
    @ObservedObject var gameTimer: TimerModel = TimerModel(count: 600)
    
    var body: some View {
        NavigationStack(){
            List{
                Section(){
                    ForEach(playerModel.people.indices, id: \.self){ num in
                        HStack{
                            Button(action: {
                                playerModel.people[num].flag.toggle()
                                
                            }
                                ,label: {
                                Image(systemName: (playerModel.people[num].flag) ? "checkmark.circle.fill" : "circle")
                                    .imageScale(.small)
                                    .foregroundColor((playerModel.people[num].flag) ? .green : .gray)
                                    .font(.system(size: 30))
                            })//.buttonStyle(BorderlessButtonStyle())
                            Text("#"+String(playerModel.people[num].number))
                            Text(playerModel.people[num].name)
                            Spacer()
                            
                            GetMMSSView(isCounting: $isCounting,player: playerModel.people[num], timer: playerModel.people[num].timer)
                        }
                    }.listStyle(SidebarListStyle())
                }
                Section(){
                    VStack {
                        HStack {
                            Spacer(minLength: 40)
                            GetGameTimeMMSSView(isCounting: $isCounting, gameTimer: gameTimer)
                            ResetButton(gameTimer: gameTimer)
                            Spacer()
                        }
                        HStack{
                            Spacer()
                            MinusButton(playerModel: playerModel,gameTimer: gameTimer)
                            Spacer()
                            StartStopButton(isCounting: $isCounting,playerModel: playerModel,gameTimer: gameTimer)
                            Spacer()
                            PlusButton(playerModel: playerModel,gameTimer: gameTimer)
                            Spacer()
                        }
                    }
                }
                
            }
            .navigationTitle("北海道大学(リバ)")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: CopyButton(playerModel: playerModel))
        }
        
    }
}

struct PlayerListView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerListView()
    }
}
