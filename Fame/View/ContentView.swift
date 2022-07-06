//
//  ContentView.swift
//  Fame
//
//  Created by Baptiste Cadoux on 05/07/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.users.sorted(), id: \.name) { user in
                    NavigationLink(destination: UserDetailView(user: user)) {
                        Image(uiImage: user.image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 40)
                        Text(user.name)
                    }
                    
                }
            }
            .navigationTitle("Fame")
            .onChange(of: viewModel.inputImage) { _ in
                askForName()
            }
            .sheet(isPresented: $viewModel.showingImagePicker) {
                ImagePicker(image: $viewModel.inputImage)
            }
            .toolbar {
                Button {
                    viewModel.showingImagePicker = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .alert("Please enter your name.",
                   isPresented: $viewModel.showingAlert,
                   actions: {
                TextField("name", text: $viewModel.username)
                
                Button("Ok", action: {
                    viewModel.addUser()
                    viewModel.resetInputs()
                })
                Button("Cancel", action: {})
            })
        }
    }

    func askForName() {
        if viewModel.inputImage != nil {
            viewModel.showingAlert = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
