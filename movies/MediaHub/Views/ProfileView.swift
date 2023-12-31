import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if let user = viewModel.user {
                    if let data = viewModel.avatar, let uiimage = UIImage(data: data) {
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
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Name: ")
                                .bold()
                            Text(user.name)
                        }
                        .padding()
                        HStack {
                            Text("Email: ")
                                .bold()
                            Text(user.email)
                        }
                        .padding()
                        HStack {
                            Text("Member since: ")
                                .bold()
                            Text("\(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))")
                        }
                        .padding()
                    }
                    .padding()
                    Button("Log out") {
                        viewModel.logOut()
                    }
                    .tint(.red)
                    .padding()
                    Spacer()
                    NavigationLink(destination: EditProfileView(
                        viewModel: EditProfileViewViewModel(
                            name: user.name,
                            email: user.email,
                            joined: user.joined
                        ),
                        onUpdate: onProfileUpdate,
                        avatar: $viewModel.avatar
                    )) {
                        Text("Edit profile")
                    }
                    Spacer()
                } else {
                    Text("Loading profile...")
                }
            }
            .navigationTitle("Profile")
        }.onAppear() {
            viewModel.fetchUser()
        }
    }
    
    func onProfileUpdate() -> Void {
        viewModel.fetchUser()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
