import SwiftUI

struct AddMovieView: View {
    @StateObject var viewModel = AddMovieViewViewModel()
    @Binding var newItemPresented: Bool
    
    var body: some View {
        VStack {
            Text("Add movie")
                .font(.system(size: 32))
                .bold()
                .padding(.top, 50)
                .padding(.bottom, 50)
            Form {
                TextField("Title", text: $viewModel.title)
                    .textFieldStyle(DefaultTextFieldStyle())
                TextField("Director", text: $viewModel.director)
                    .textFieldStyle(DefaultTextFieldStyle())
                Toggle("Mark as watched", isOn: $viewModel.isWatched)
                    .toggleStyle(SwitchToggleStyle(tint: Color.blue))
                Text("Watched at")
                DatePicker("Created", selection: $viewModel.created, in: ...Date(), displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                CustomButtonView(text: "Save", color: .blue) {
                    if viewModel.canSave {
                        viewModel.save()
                        newItemPresented = false
                    } else {
                        viewModel.showAlert = true
                    }
                }
                .padding(.top)
                .padding(.bottom)
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error"), message: Text(viewModel.errorMessage))
            }
        }
    }
}

struct AddMovieView_Previews: PreviewProvider {
    static var previews: some View {
        AddMovieView(newItemPresented: Binding(get: {
            return true
        }, set: { _ in
            
        }))
    }
}
