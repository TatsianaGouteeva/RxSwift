//
//  UIViewController+Navigation.swift
//  ArrayOfDevelopers
//
//  Created by developer on 11/10/20.
//

import RxSwift
import RxCocoa
import Rswift
import SegueManager

extension Reactive where Base: UIViewController & SeguePerformer {
    
    func navigate<Segue, Destination, Value>(with segue: StoryboardSegueIdentifier<Segue, Base, Destination>,
                                             segueHandler: ((TypedStoryboardSegueInfo<Segue, Base, Destination>, Value) -> Void)? = nil) -> Binder<Value> {
        return Binder(base) { viewController, value in
            print("++++++++++")
            
            if let handler = segueHandler {
                viewController.performSegue(withIdentifier: segue) { handler($0, value) }
            } else {
                viewController.performSegue(withIdentifier: segue)
            }
        }
    }
}

class SegueManagerTableViewController: UITableViewController, SeguePerformer {
    public lazy var segueManager: SegueManager = { return SegueManager(viewController: self) }()
    
    override open func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segueManager.prepare(for: segue)
    }
}

