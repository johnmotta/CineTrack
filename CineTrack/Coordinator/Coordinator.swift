//
//  Coordinator.swift
//  CineTrack
//
//  Created by John on 19/09/24.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get }
    
    init(navigationController: UINavigationController)
    
    func start()
}
