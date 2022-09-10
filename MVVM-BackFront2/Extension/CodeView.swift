//
//  CodeView.swift
//  MVVM-BackFront2
//
//  Created by Edgar Arlindo on 08/09/22.
//

import Foundation

protocol CodeView {
    func buildHierarchy()
    func setupConstrains()
    func setupAdditionaConfiguration()
    func setupView()
}

extension CodeView {
    func setupView() {
        buildHierarchy()
        setupConstrains()
        setupAdditionaConfiguration()
    }
    
    func setupAdditionaConfiguration() {}
}
