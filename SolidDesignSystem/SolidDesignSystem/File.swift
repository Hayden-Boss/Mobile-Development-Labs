import Foundation

// MARK: - Protocols

// ISP: Instead of forcing all cameras to support both photos and videos,
// we create separate protocols for photo and video functionality.
protocol CaptureDevice {
    var hasCamera: Bool { get }
    var aspectRatio: Int { get set }
}

protocol PhotoCapture {
    func takePhoto()
}

protocol VideoCapture {
    func takeVideo()
}

// MARK: - Camera Types

// SRP: This class is responsible ONLY for taking photos.
class PhotoCamera: CaptureDevice, PhotoCapture {
    var hasCamera: Bool
    var aspectRatio: Int
    
    init(hasCamera: Bool, aspectRatio: Int) {
        self.hasCamera = hasCamera
        self.aspectRatio = aspectRatio
    }
    
    func takePhoto() {
        print("I took a photo")
    }
}

// SRP: This class is responsible ONLY for taking videos.
class VideoCamera: CaptureDevice, VideoCapture {
    var hasCamera: Bool
    var aspectRatio: Int
    
    init(hasCamera: Bool, aspectRatio: Int) {
        self.hasCamera = hasCamera
        self.aspectRatio = aspectRatio
    }
    
    func takeVideo() {
        print("I took a video")
    }
}

// OCP: We add a new camera type without modifying existing classes.
// LSP: DualCamera follows the expected behavior of its base types (PhotoCapture and VideoCapture).
class DualCamera: CaptureDevice, PhotoCapture, VideoCapture {
    var hasCamera: Bool
    var aspectRatio: Int
    
    init(hasCamera: Bool, aspectRatio: Int) {
        self.hasCamera = hasCamera
        self.aspectRatio = aspectRatio
    }
    
    func takePhoto() {
        print("I took a photo with the dual camera")
    }
    
    func takeVideo() {
        print("I took a video with the dual camera")
    }
}

// MARK: - View Controller

// DIP: CaptureViewController depends on an abstraction (CaptureDevice),
// not a concrete implementation like PhotoCamera or VideoCamera.
class CaptureViewController {
    let camera: CaptureDevice
    
    init(camera: CaptureDevice) {
        self.camera = camera
    }
    
    func captureMedia() {
        // LSP: The controller can use any camera type without breaking functionality.
        if let photoCamera = camera as? PhotoCapture {
            photoCamera.takePhoto()
        }
        
        if let videoCamera = camera as? VideoCapture {
            videoCamera.takeVideo()
        }
    }
}
