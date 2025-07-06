//
//  Untitled.swift
//  APOD
//
//  Created by Michael Haß on 06.07.25.
//

import Foundation
import SwiftUI

final class APODErrorModel: ObservableObject {
    @Published
    var message: String? = nil
}
