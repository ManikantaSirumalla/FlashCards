//
//  ViewController.swift
//  FlashCards
//
//  Created by Bubbly Boey on 14/05/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var cardContentLabel: UILabel!
    
    enum DisplayMode {
        case questionFirst
        case answerfirst
    }
    var currentDisplayMode : DisplayMode = .questionFirst
     
    var managedObjectContext : NSManagedObjectContext!
    
    var listOfCards = [FlashCard]()
    var currentCard : FlashCard?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        managedObjectContext =  appDelegate.persistentContainer.viewContext
        
        fetchCards()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchCards()
    }
    

    func fetchCards () {
        
        let fetchRequest : NSFetchRequest < FlashCard> = FlashCard.fetchRequest()
        
        do {
            listOfCards = try managedObjectContext.fetch(fetchRequest )
            
            print("flashCards fetched successfullly")
            
        } catch {
            print("couldnot fetch the data from the managedObjectcontext")
        }
        printCards()
        
    }
    func printCards () {
        for cards in listOfCards {
            print(cards.question!)
            print(cards.answer!)
        }
    }
    
    
    @IBAction func choosedisplayModeAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0 :
            currentDisplayMode = .answerfirst
            
        case 1 :
            currentDisplayMode = .questionFirst
        default:
            currentDisplayMode = .answerfirst
        }
    }
    
    func displayCards(){
        let randonIndex =  Int(arc4random_uniform(UInt32(listOfCards.count)))
        currentCard = listOfCards[randonIndex]
        if let displayCard = currentCard {
            displayQuestionOrAnswer(cardToDiaplay: displayCard)
        } else{
        
        cardContentLabel.text = "no cards to dispaly"}
        
    }
     
    func displayQuestionOrAnswer(cardToDiaplay  card : FlashCard){
        switch currentDisplayMode {
            case .questionFirst :
                cardContentLabel.text = card.question
                
            case .answerfirst:
                cardContentLabel.text = card.answer
            
        }
    }
    
    
    @IBAction func deleteCardAction(_ sender: UIButton) {
        
        if currentCard == nil {
            
        }else {
            managedObjectContext.delete(currentCard!)
            
            do {
                try managedObjectContext.save()
                print("successfully deleted")
                fetchCards()
                displayCards()
                
            } catch {
                print("managedObjectContent cant be saved, falsh card couldnot be deleted")
            }
        }
    }
    
    
    @IBAction func swipeRightAction(_ sender: UISwipeGestureRecognizer) {
        displayCards()
    }
    
    
    @IBAction func swipeUpAction(_ sender: UISwipeGestureRecognizer) {
        if let card = currentCard {
            cardContentLabel.text = card.answer
        }
    }
    
    @IBAction func swipeDownAction(_ sender: UISwipeGestureRecognizer) {
    }
    
    
    
}

