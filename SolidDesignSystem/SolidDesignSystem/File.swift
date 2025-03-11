import Foundation


//camera



protocol CaptureDevice {
    var hasCamera: Bool { get }
    var aspectRatio: Int { get set }
}

class PhotoCamera: CaptureDevice {
    var hasCamera: Bool
    var aspectRatio: Int
    
    init(hasCamera: Bool, aspectRatio: Int) {
        self.hasCamera = hasCamera
        self.aspectRatio = aspectRatio
    }
    
    func takePhoto() {
        
    }
}

// This is single responsibility because only video camera can take a video
class VideoCamera: CaptureDevice {
    var hasCamera: Bool
    var aspectRatio: Int
    
    init(hasCamera: Bool, aspectRatio: Int) {
            self.hasCamera = hasCamera
            self.aspectRatio = aspectRatio
        
    func takeVideo() {
        print("I took a video")
    }
}

class CaptureViewController {
    let camera: CaptureDevice
    
    init(camera: CaptureDevice) {
        self.camera = camera
    }
    
}




//class videoViewController: Camera {
//    var hasCamera: Bool
//    
//    var aspectRatio: Int
//    
//    func takePicture() {
//        <#code#>
//    }
//    
//    func takeVideo() {
//        <#code#>
//    }
//    
//    func startVideo() {
//        print("starting video")
//    }
//    func endVideo() {
//        print("ending video")
//    }
//}
//    extension Camera {
//        func zoomIn() {
//            print("zooming in")
//        }
//        func zoomOut() {
//            print("zooming out")
//        }
//    }
//    
//extension videoViewController {
//        func saveVideo() {
//            print("saving video")
//        }
//    }
