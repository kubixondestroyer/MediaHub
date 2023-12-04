import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @State var selectedItems: [PhotosPickerItem] = []
    @StateObject var viewModel: EditProfileViewViewModel
    var onUpdate:() -> Void
    @Binding var avatar: Data?
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Form {
                PhotosPicker(
                    selection: $selectedItems,
                    maxSelectionCount: 1,
                    matching: .images
                ) {
                    if let data = avatar, let uiimage = UIImage(data: data) {
                        Image(uiImage: uiimage)
                            .resizable()
                            .clipShape(Circle())
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200)
                    } else {
                        Image(systemName: "person.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color.blue)
                            .frame(width: 125, height: 125)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .onChange(of: selectedItems) { newValue in
                    guard let item = selectedItems.first else {
                        return
                    }
                    item.loadTransferable(type: Data.self) { result in
                        switch result {
                        case .success(let data):
                            if let data = data {
                                avatar = data
                            } else {
                                print("Data is nil")
                            }
                        case .failure(let failure):
                            print("\(failure)")
                        }
                        
                    }
                }
                TextField("Name", text: $viewModel.name)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .disableAutocorrection(true)
                TextField("Email", text: $viewModel.email)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .disabled(true)
                CustomButtonView(text: "Save", color: .blue) {
                    if viewModel.canSave {
                        viewModel.save()
                        onUpdate()
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
        }.navigationTitle("Edit profile")
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(
            viewModel: EditProfileViewViewModel(name: "John", email: "john@example.org", joined: Date().timeIntervalSince1970),
            onUpdate: {},
            avatar: Binding.constant(nil)
        )
    }
}
