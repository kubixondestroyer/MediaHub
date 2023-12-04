import SwiftUI

struct EditMovieView: View {
    @StateObject var viewModel: EditMovieViewViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var isPresentingConfirmDeleteMovie: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Title", text: $viewModel.title)
                        .textFieldStyle(DefaultTextFieldStyle())
                    TextField("Director", text: $viewModel.director)
                        .textFieldStyle(DefaultTextFieldStyle())
                    Toggle("Mark as watched", isOn: $viewModel.isWatched)
                        .toggleStyle(SwitchToggleStyle(tint: Color.blue))
                        .onChange(of: viewModel.isWatched) { newValue in
                            viewModel.toggleIsWatched()
                        }
                    Text("Watched at")
                    DatePicker("Created", selection: $viewModel.created, in: ...Date(), displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                    CustomButtonView(text: "Save", color: .blue) {
                        if viewModel.canSave {
                            viewModel.save()
                            self.presentationMode.wrappedValue.dismiss()
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
                .confirmationDialog(
                    "Do you want to delete the movie",
                    isPresented: $isPresentingConfirmDeleteMovie) {
                        Button("Delete the movie", role: .destructive) {
                            viewModel.delete()
                        }
                    }
                .onShake {
                    isPresentingConfirmDeleteMovie = true;
                }
            }
        }.navigationTitle("Details")
    }
}

struct EditMovieView_Previews: PreviewProvider {
    static var previews: some View {
        EditMovieView(viewModel: EditMovieViewViewModel(id: "1", title: "Jaws", director: "Steven Spielberg", created: Date(), isWatched: true))
    }
}
