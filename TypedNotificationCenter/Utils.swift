//
//  Utils.swift
//  TypedNotificationCenter
//
//  Created by Ashish Badak on 19/05/21.
//

import UIKit

extension UIButton {
    static func getButton(title: String) -> UIButton {
        let button: UIButton = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}


struct Constants {
    enum ButtonTitles {
        static var lordCommander: String { "Be The Lord Commander" }
        static var fightWar: String { "Fight The Great War" }
        static var killDany: String { "Kill Dany" }
        static var exploreNight: String { "Explore The Long Night" }
        static var reset: String { "Start the Game Of Thrones again" }
    }
    
    enum ScreenTitles {
        static var home: String { "Winterfell" }
        static var wall: String { "The Wall" }
        static var capital: String { "Kings Landing" }
        static var realNorth: String { "The Real North" }
    }
    
    enum Quotes {
        static var night: String { "The Night is Dark & Full of Terrors..." }
        static var ygritteCatchPhrase: String { "You Know Nothing" }
    }
}
