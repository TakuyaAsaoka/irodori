//
//  EventInfo.swift
//  irodori
//
//  Created by AsaokaTakuya on 2025/09/27.
//

import Foundation

struct EventInfo: Identifiable {
  let id = UUID()
  let title: String
  let imageName: String
  let time: String
  let description: String
}

let events: [EventInfo] = [
  EventInfo(title: "Sunset Sound Festival", imageName: "SunsetSoundFestival", time: "9:00~22:00", description: "A lively outdoor music festival featuring live bands, DJs, and food trucks, where you can enjoy great music and vibrant vibes as the sun sets."),
  EventInfo(title: "Taste of America Food Fair", imageName: "TasteOfAmericaFoodFair", time: "11:00~21:00", description: "A lively festival showcasing classic American foods, drinks, and flavors, with food stalls, music, and fun activities for all."),
  EventInfo(title: "Summer Slam Basketball Tournament", imageName: "SummerSlamBasketballTournament", time: "10:00~20:00", description: "An exciting basketball tournament featuring regional teams, fast-paced games, and fun activities for spectators throughout the day.11")
]
