//
//  ContentView.swift
//  GetImages
//
//  Created by Alessio Roberto on 08/08/2019.
//  Copyright © 2019 Alessio Roberto. All rights reserved.
//

import Tangerine
import SwiftUI

struct ListView: View {
    private let viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        List(viewModel.getLits()) { element in
            CellRow(title: element.title, fetcher: element.fetcher)
        }
    }
}

struct CellRow: View {
    private var title: String

    @ObservedObject private var fetcher: ImageFetcher

    init(title: String, fetcher: ImageFetcher) {
        self.title = title
        self.fetcher = fetcher
    }

    var body: some View {
        HStack {
            Text(title)
                .padding(8)
            Spacer()
            fetcher.image.map {
                Image(uiImage: $0)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .onAppear(perform: fetcher.refresh)
    }
}

struct Element: Identifiable {
    var id = UUID()
    var name: String
    var thumb: String
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(viewModel: ViewModel())
    }
}
#endif
