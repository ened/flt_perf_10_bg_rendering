//
//  triggerCpuCapture.swift
//  Runner
//
//  Created by Sebastian Roth on 30/06/2020.
//

import Foundation
import Metal

@available(iOS 13.0, *)
func triggerProgrammaticMetalCapture() {
    let captureManager = MTLCaptureManager.shared()
    let captureDescriptor = MTLCaptureDescriptor()
    captureDescriptor.captureObject = MTLCreateSystemDefaultDevice()
    do {
        try captureManager.startCapture(with: captureDescriptor)
    }
    catch
    {
        fatalError("error when trying to capture: \(error)")
    }
}
