//
//  TimerModel.swift
//  PlayTime
//
//  Created by Kusakabe Koki on 2023/03/18.
//

import Foundation
import Combine

class TimerModel: ObservableObject{
    @Published var count: Int = 0
    @Published var timer: AnyCancellable!

    func start(_ interval: Double = 1.0){
        print("start timer!")

        if let _timer = timer{
            _timer.cancel()
        }

        timer = Timer.publish(every: interval, on: .main, in: .common)
            .autoconnect()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: ({_ in
                self.count += 1
            }))
//        print("timer loading!")
    }
    
    func stop(){
//        print("stop timer!")
        timer?.cancel()
        timer = nil
    }
    
    func getMMSS() -> String{
        let mm = count / 60
        let ss = count % 60
        
        // print("getMMSS()")
        
        return String(format: "%02d:%02d", mm, ss)
    }

    func minus(num: Int){
        count -= num
    }

    func plus(num: Int){
        count += num
    }

}


