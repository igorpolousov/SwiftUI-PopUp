//
//  Home.swift
//  SwiftUI-PopUp
//
//  Created by Igor Polousov on 14.02.2023.
//

import SwiftUI

struct Home: View {
    
    @State var onEnded =  false
    
    var body: some View {
        NavigationView {
            ZStack {
                CustomContextMenu{
                    Label {
                        Text("Unlock me")
                    } icon: {
                        Image(systemName: "lock.fill")
                    }
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 20)
                    .background(.purple)
                    .cornerRadius(8)

                } preview: {
                    // Preview
                    Image("forest")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } actions: {
                    // Actions in menu
                    //Action
                    let like = UIAction(title: "Like me", image: UIImage(systemName: "hand.thumbsup.fill")) { _ in
                        print("Like")
                    }
                    
                    let share = UIAction(title: "Share me",image: UIImage(systemName: "square.and.arrow.up.fill")) { _ in
                        print("Share")
                    }
                    
                    return UIMenu(title: "", children: [like, share])
                    
                } onEnd: {
                    print("Ended")
                    withAnimation {
                        onEnded.toggle()
                    }
                }
                
                // When view is expanded
                if onEnded {
                    
                    // for getting size
                    GeometryReader { proxi in
                        let size = proxi.size
                        
                        Image("forest")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height)
                            .cornerRadius(1)
                        
                    }
                    .ignoresSafeArea(.all, edges: .bottom)
                    // removing opacity animation
                    .transition(.identity)
                    // nav bar button for closing
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Close") {
                                withAnimation {
                                    onEnded.toggle()
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle(onEnded ? "Unlocked" : "Custom context menu")
            //changing nav bar style
            .navigationBarTitleDisplayMode(onEnded ? .inline : .large)
        }
    }
}


struct Home_Preview: PreviewProvider {
    static var previews: some View {
        Home()
    }
}




