//
//  DevelopersViewController.swift
//  ArrayOfDevelopers
//
//  Created by developer on 11/9/20.
//

import UIKit
import RxSwift
import RxCocoa
import SegueManager

class DevelopersViewController: SegueManagerViewController {

    //MARK: - IBOutlet
    @IBOutlet var devTableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    private let bag = DisposeBag()
    private let viewModel = DevelopersViewModel()
    let usecase = RandomNameUseCase()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindAddButton()
    }


    func bindAddButton() {
        let input = DevelopersViewModel.Input(addTap: addButton.rx.tap.asDriver().debug())
        
        let output = viewModel.transform(input: input)
        output.elements.drive(devTableView.rx.items(cellIdentifier: "cell", cellType: DevelopersTableViewCell.self)) { (row,item,cell) in
            cell.nameLabel.text = item.name
            cell.professionLabel.text = item.profession
        }.disposed(by: bag)
        
        devTableView.rx.modelSelected(Developer.self).bind(to: rx.navigate(with: R.segue.developersViewController.navigationFromDevelopers, segueHandler: { segue, value in
            segue.destination.selectedInformation = value
        })).disposed(by: bag)

    }
}
