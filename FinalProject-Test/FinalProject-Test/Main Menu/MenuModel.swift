//
//  MenuModel.swift
//  FinalProject-Test
//
//  Created by Михаил Зайцев on 10.04.2022.
//

import UIKit

enum routeVC: Int {
    case touch, rgb, bwg, contrast, mainSpeaker, frontSpeaker, headphones, wifi, cellular, bluetooth, location, camera, flash, ambiLight, accelerometer, distanсe, authorization, compass
}

struct MenuModel {
    let testName: String
    let testImage: UIImage
}
