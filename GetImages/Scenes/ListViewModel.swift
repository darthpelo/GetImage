//
//  ListViewModel.swift
//  GetImages
//
//  Created by Alessio Roberto on 08/08/2019.
//  Copyright © 2019 Alessio Roberto. All rights reserved.
//

import Tangerine
import SwiftUI

struct CellRowElement: Identifiable {
    var id = UUID()
    var title: String
    var fetcher: ImageFetcher
}

struct ViewModel {
    private let elements: [Element] = [
        Element(name: "A", thumb: "https://www.strongertogether.coop/sites/default/files/Tangerines.jpg"),
        Element(name: "B", thumb: "https://www.strongertogether.coop/sites/default/files/Tangerines.jpg"),
    ]

    func getLits() -> [CellRowElement] {
        return elements.map { (element) -> CellRowElement in
            return CellRowElement(title: element.name,
                                  fetcher: ImageFetcher(url: URL(string: element.thumb)!))
        }
    }
}
