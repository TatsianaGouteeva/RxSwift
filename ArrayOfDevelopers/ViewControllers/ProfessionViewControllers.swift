//
//  ProfessionViewControllers.swift
//  ArrayOfDevelopers
//
//  Created by developer on 11/10/20.
//


import UIKit
import RxSwift
import RxCocoa

class ProfessionViewControllers: UIViewController {
    
    @IBOutlet weak var information: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var addButton: UIButton!
    
    var selectedInformation: Developer?
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let name = selectedInformation?.name ?? ""
        let profession = selectedInformation?.profession ?? ""
        
        information.text = ("name: " + name + ", profession: " + profession)
        
        let imagePicker = imagePickerScene(on: self)
        
        addButton.rx.tap.debug()
            .flatMapLatest { Observable.create(imagePicker) }
            .compactMap { $0[.originalImage] as? UIImage }
            .bind { image in
                print("we are here")
                self.imageView.clipsToBounds = true
                self.imageView.image = image
            }
            .disposed(by: disposeBag)
    }
    
    func imagePickerScene(on presenter: UIViewController) -> (_ observer: AnyObserver<[UIImagePickerController.InfoKey: AnyObject]>) -> Disposable {
        return { [weak presenter] observer in
            
            let picker = UIImagePickerController()
            presenter?.present(picker, animated: true)
            
            return picker.rx.didFinishPickingMediaWithInfo.debug()
                .do(onNext: { _ in
                    presenter?.dismiss(animated: true)
                })
                .subscribe(observer)
        }}
}






















//
//
//
//
////extension Reactive where Base: UIImagePickerController {
////
////    public var didFinishPickingMediaWithInfo: Observable<[UIImagePickerController.InfoKey: Any]> {
////        return RxImagePickerProxy.proxy(for: base)
////            .didFinishPickingMediaWithInfoSubject
////            .asObservable()
////            .do(onCompleted: {
////                self.base.dismiss(animated: true, completion: nil)
////            })
////    }
////
////    public var didCancel: Observable<Void> {
////        return RxImagePickerProxy.proxy(for: base)
////            .didCancelSubject
////            .asObservable()
////            .do(onCompleted: {
////                self.base.dismiss(animated: true, completion: nil)
////            })
////    }
////
////}
//
//extension Reactive where Base: UIImagePickerController {
//
//    /**
//     Reactive wrapper for `delegate` message.
//     */
//    public var didFinishPickingMediaWithInfo: Observable<[UIImagePickerController.InfoKey : AnyObject]> {
//        return RxImagePickerProxy.proxy(for: base)
//            .methodInvoked(#selector(UIImagePickerControllerDelegate.imagePickerController(_:didFinishPickingMediaWithInfo:)))
//            .map({ (a) in
//                return try castOrThrow(Dictionary<UIImagePickerController.InfoKey, AnyObject>.self, a[1])
//            })
//    }
//
//    /**
//     Reactive wrapper for `delegate` message.
//     */
//    public var didCancel: Observable<()> {
//        return RxImagePickerProxy.proxy(for: base)
//            .methodInvoked(#selector(UIImagePickerControllerDelegate.imagePickerControllerDidCancel(_:)))
//            .map {_ in () }
//    }
//
//    private func castOrThrow<T>(_ resultType: T.Type, _ object: Any) throws -> T {
//        guard let returnValue = object as? T else {
//            throw RxCocoaError.castingError(object: object, targetType: resultType)
//        }
//
//        return returnValue
//    }
//
//
//}
//
//public typealias ImagePickerDelegate = UIImagePickerControllerDelegate & UINavigationControllerDelegate
//
//extension UIImagePickerController: HasDelegate {
//    public typealias Delegate = ImagePickerDelegate
//}
//
//class RxImagePickerProxy: DelegateProxy<UIImagePickerController, ImagePickerDelegate>, DelegateProxyType, UIImagePickerControllerDelegate, UINavigationControllerDelegate
//{
//    public init(imagePicker: UIImagePickerController) {
//        super.init(parentObject: imagePicker, delegateProxy: RxImagePickerProxy.self)
//    }
//
//    //MARK:- DelegateProxyType
//    public static func registerKnownImplementations() {
//        self.register { RxImagePickerProxy(imagePicker: $0) }
//    }
//
//    static func currentDelegate(for object: UIImagePickerController) -> ImagePickerDelegate? {
//        return object.delegate
//    }
//
//    static func setCurrentDelegate(_ delegate: ImagePickerDelegate?, to object: UIImagePickerController) {
//        object.delegate = delegate
//    }
//
//    //MARK:- Proxy Subject
//    internal lazy var didFinishPickingMediaWithInfoSubject = PublishSubject<[String : Any]>()
//    internal lazy var didCancelSubject = PublishSubject<Void>()
//
//    //MARK:- UIImagePickerControllerDelegate
//    func imagePickerController(_ picker: UIImagePickerController,
//                               didFinishPickingMediaWithInfo info: [String: Any]) {
//        didFinishPickingMediaWithInfoSubject.onNext(info)
//        didFinishPickingMediaWithInfoSubject.onCompleted()
//        didCancelSubject.onCompleted()
//    }
//
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        didCancelSubject.onNext(())
//        didCancelSubject.onCompleted()
//        didFinishPickingMediaWithInfoSubject.onCompleted()
//    }
//
//    //MARK:- Completed
//    deinit {
//        self.didFinishPickingMediaWithInfoSubject.onCompleted()
//        self.didCancelSubject.onCompleted()
//    }
//
//}






//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ProfessionViewControllers.imageTapped(gesture:)))
//
//        imageView.addGestureRecognizer(tapGesture)
//        imageView.isUserInteractionEnabled = true



//    @objc func imageTapped(gesture: UIGestureRecognizer) {
//
//        let picker = UIImagePickerController()
//        picker.sourceType = .photoLibrary
//        picker.allowsEditing = true
//
//        picker.rx.didCancel.debug()
//            .bind(onNext: { [weak self] in
//                print("info1")
//            })
//            .disposed(by: disposeBag)
//
//        picker.rx.didFinishPickingMediaWithInfo.debug()
//            .bind(onNext: { [weak self] info in
//                print("info2")
//            })
//            .disposed(by: disposeBag)
//
////        if (gesture.view as? UIImageView) != nil {
////            print("Image Tapped")
////
////            let vc = UIImagePickerController()
////            vc.sourceType = .photoLibrary
////            vc.allowsEditing = true
////            vc.delegate = self
////            present(vc, animated: true)
////        }
//    }
