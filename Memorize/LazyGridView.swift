//
//  LazyGridView.swift
//  Memorize
//
//  Created by Roman on 2/9/23.
//

import SwiftUI

struct LazyGridView: View {
    let data = (1...100).map{"Item \($0)"}
    let columns = [
        GridItem(.flexible())
    ]
    var body: some View {
        ScrollView{
            LazyVGrid(columns: columns, spacing: 20){
                ForEach(data, id: \.self){
                    item in
                    Text(item)
                }
            }
            .padding(.horizontal)
        }
        .frame(maxHeight: 300)
    }
}

struct LazyGridView_Previews: PreviewProvider {
    static var previews: some View {
        LazyGridView()
    }
}
