//
//  AlbumObject.swift
//  Prog8DHC0015Sp22
//
//  Created by Dimitri Chaber on 3/24/22.
//

import UIKit

class AlbumObject: NSObject, Codable {
    var title: String = ""
    var artist: String = ""
    var year: String = ""
    var label: String = ""
    var review: String = ""
    var tracks: [TrackObject] = []
    var cover: Data?

}
