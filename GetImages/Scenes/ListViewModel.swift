//
//  ListViewModel.swift
//  GetImages
//
//  Created by Alessio Roberto on 08/08/2019.
//  Copyright © 2019 Alessio Roberto. All rights reserved.
//

import Combine
import Tangerine
import SwiftUI

struct CellRowElement: Identifiable {
    var id = UUID()
    var title: String
    var fetcher: ImageFetcher
}

struct ViewModel {

    @ObservedObject var manager: FakeNetworkLayer
    
    func getLits() -> [CellRowElement] {
        
        return manager.elements.map { (element) -> CellRowElement in
            return CellRowElement(title: element.name,
                                  fetcher: ImageFetcher(url: URL(string: element.thumb)!))
        }
    }
}

protocol NetworkLayer: class {
    func getData()
}

final class FakeNetworkLayer: NetworkLayer, ObservableObject {
    var objectWillChange = PassthroughSubject<Void, Never>()
    
    let elements: [Element] = [
        Element(name: "A", thumb: "https://www.strongertogether.coop/sites/default/files/Tangerines.jpg"),
        Element(name: "B", thumb: "https://www.strongertogether.coop/sites/default/files/Tangerines.jpg"),
    ]
    
    init() {
        getData()
    }
    
    func getData() {
        objectWillChange.send()
    }
    
}
