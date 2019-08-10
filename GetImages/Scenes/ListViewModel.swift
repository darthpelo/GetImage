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

final class ViewModel: ObservableObject {

    @ObservedObject private var manager = FakeNetworkLayer()
    var objectWillChange = PassthroughSubject<Void, Never>()
    var list: [CellRowElement] = []
    
    private func getLits() -> [CellRowElement] {
        return manager.elements.map { (element) -> CellRowElement in
            return CellRowElement(title: element.name,
                                  fetcher: ImageFetcher(url: URL(string: element.thumb)!))
        }
    }

    func addElement() {
        manager.getData()
        list = getLits()
        objectWillChange.send()
    }
}

protocol NetworkLayer: class {
    func getData()
}

final class FakeNetworkLayer: NetworkLayer, ObservableObject {
    var objectWillChange = PassthroughSubject<Void, Never>()
    
    var elements: [Element] = [
        Element(name: "A", thumb: "https://www.strongertogether.coop/sites/default/files/Tangerines.jpg"),
        Element(name: "B", thumb: "https://www.strongertogether.coop/sites/default/files/Tangerines.jpg"),
    ]
    
    func getData() {
        let random = Int.random(in: Range(uncheckedBounds: (0, 100)))
        elements.append(Element(name: "\(random)",
                                thumb: "https://www.strongertogether.coop/sites/default/files/Tangerines.jpg"))
        objectWillChange.send()
    }
    
}
