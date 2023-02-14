//
//  ContextMenuHelper.swift
//  SwiftUI-PopUp
//
//  Created by Igor Polousov on 14.02.2023.
//


import SwiftUI

// Custom view for context menu ...

struct ContextMenuHelper<Content: View, Preview: View>: UIViewRepresentable {
    

    var content: Content
    var preview: Preview
    var actions: UIMenu
    var onEnd: ()->()
    
    init(content: Content, preview: Preview, actions: UIMenu, onEnd: @escaping ()->()) {
        self.content = content
        self.preview = preview
        self.actions = actions
        self.onEnd = onEnd // !!!
    }
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        view.backgroundColor = .clear
        
        // setting our content view as Main Interaction view
        let hostView =  UIHostingController(rootView: content)
        view.addSubview(hostView.view)
        
        //setting constraints
        hostView.view.translatesAutoresizingMaskIntoConstraints = false
        
        // constraints
        let constraints = [
            hostView.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostView.view.leadingAnchor.constraint(equalTo: view.trailingAnchor),
            
            hostView.view.widthAnchor.constraint(equalTo: view.widthAnchor),
            hostView.view.heightAnchor.constraint(equalTo: view.heightAnchor)
            
        ]
        
        view.addConstraints(constraints)
        
        // setting interaction
        let interaction = UIContextMenuInteraction(delegate: context.coordinator)
        view.addInteraction(interaction)
    
        return view
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        //
    }
    
    // Context menu delegate
    class Coordinator: NSObject, UIContextMenuInteractionDelegate {
        
        var parent: ContextMenuHelper
        
        init(parent: ContextMenuHelper) {
            self.parent = parent
        }
        
        func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
            //
            
            return UIContextMenuConfiguration(identifier: nil) {
                // view here
                let previewController = UIHostingController(rootView: self.parent.preview)
                previewController.view.backgroundColor = .clear
             
                return previewController
                
            } actionProvider: { items in
                //actions here
                
                return self.parent.actions
            }

        }
        
     // if needed to expand context menu
        
        func contextMenuInteraction(_ interaction: UIContextMenuInteraction, willEndFor configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionAnimating?) {
            animator?.addCompletion {
                self.parent.onEnd()
            }
        }
    }
}


