//
//  ImageDefault.swift
//  CineTrack
//
//  Created by John on 19/09/24.
//

import UIKit

class ImageDefault: UIImageView {
    
    init(clipsToBounds: Bool = false) {
        super.init(frame: .zero)
        
        initDefault(clipsToBounds)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initDefault(_ clips: Bool) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = clips
    }
}
