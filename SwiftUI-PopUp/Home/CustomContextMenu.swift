//
//  CustomContextMenu.swift
//  SwiftUI-PopUp
//
//  Created by Igor Polousov on 14.02.2023.
//

import SwiftUI

// Custom view builder

struct CustomContextMenu<Content: View, Preview: View>: View {
    
    var content: Content
    var preview: Preview
    
    // List of actions
    var menu: UIMenu
    var onEnd: ()->()
    
    init(@ViewBuilder content: @escaping ()->Content, @ViewBuilder preview: @escaping ()->Preview, actions: @escaping ()->UIMenu, onEnd: @escaping ()->()) {
        self.content = content()
        self.preview = preview()
        self.menu = actions()
        self.onEnd = onEnd
    }
    
    var body: some View {
        ZStack {
            content
            // hiding Main View
                .hidden()
                .overlay {
                    ContextMenuHelper(content: content, preview: preview,actions: menu, onEnd: onEnd)
                }
        }
    }
}

struct CustomContextMenu_Previews: PreviewProvider {
    static var previews: some View {
       Home()
    }
}
