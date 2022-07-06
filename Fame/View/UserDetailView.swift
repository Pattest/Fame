//
//  UserDetailView.swift
//  Fame
//
//  Created by Baptiste Cadoux on 05/07/2022.
//

import SwiftUI

struct UserDetailView: View {
    @State var user: User

    var body: some View {
        Image(uiImage: user.image)
            .resizable()
            .scaledToFit()
            .navigationTitle(user.name)
    }
}
