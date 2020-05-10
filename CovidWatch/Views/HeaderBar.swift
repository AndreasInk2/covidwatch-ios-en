//
//  Created by Zsombor Szabo on 03/05/2020.
//  
//

import SwiftUI

struct HeaderBar: View {
    
    let showMenu: Bool
    
    let showDismissButton: Bool
    
    let logoImage: Image
    
    @State var isShowingMenu: Bool = false
    
    @EnvironmentObject var userData: UserData
    
    @EnvironmentObject var localStore: LocalStore
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    init(showMenu: Bool = true, showDismissButton: Bool = false, logoImage: Image = Image("Bear")) {
        self.showMenu = showMenu
        self.showDismissButton = showDismissButton
        self.logoImage = logoImage
    }
    
    var body: some View {
        
        ZStack(alignment: .top) {
            
            BlurView(style: .systemChromeMaterial)
                .edgesIgnoringSafeArea(.all)
            
            HStack {
                
                logoImage
                
                Spacer()
                
                if self.showMenu {
                    Button(action: {
                        self.isShowingMenu.toggle()
                    }) {
                        Image("Menu Button").frame(minWidth: 44, minHeight: 44)
                    }.sheet(isPresented: self.$isShowingMenu) {
                        Menu()
                            .environmentObject(self.userData)
                            .environmentObject(self.localStore)
                    }
                }
                
                if self.showDismissButton {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image("Dismiss Button")
                            .frame(minWidth: 44, minHeight: 44)
                    }
                }
                
            }
            .padding(.top, 2 * .standardSpacing)
            .padding(.horizontal, 2 * .standardSpacing)
            
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .headerHeight, alignment: .topLeading)
    }
}

struct TopBar_Previews: PreviewProvider {
    static var previews: some View {
        HeaderBar()
    }
}
