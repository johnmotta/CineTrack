//
//  LabelDefault.swift
//  CineTrack
//
//  Created by John on 19/09/24.
//

import UIKit

class LabelDefault: UILabel {
    
    init(fontSize: CGFloat, fontWeight: UIFont.Weight, opacity: CGFloat = 1, numberOfLines: Int = 0, textAligment: NSTextAlignment = .natural) {
        super.init(frame: .zero)
        
        self.initDefault(fontSize, fontWeight, opacity, numberOfLines, textAligment)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initDefault(_ fontSize: CGFloat, _ fontWeight: UIFont.Weight,_ opacity: CGFloat,_ numberOfLines: Int, _ textAligment: NSTextAlignment) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.font = .systemFont(ofSize: fontSize, weight: fontWeight)
        self.textAlignment = textAligment
        self.textColor = .label
        self.alpha = opacity
        self.numberOfLines = numberOfLines
    }
}
