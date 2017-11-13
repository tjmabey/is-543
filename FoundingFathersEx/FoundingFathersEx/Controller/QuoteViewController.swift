//
//  QuoteViewController.swift
//  FoundingFathersEx
//
//  Created by Tyler Mabey on 9/19/17.
//  Copyright © 2017 Tyler Mabey. All rights reserved.
//

import UIKit
import WebKit

class QuoteViewController : UIViewController {
    
    // MARK: - Constants
    
    private struct Storyboard{
        static let QuoteOfTheDayTitle = "Quote of the Day"
        static let ShowTopicSegueIdentifier = "ShowTopics"
        static let TodayTitle = "Today"
        static let TopicsTitle = "Topics"
    }
    // MARK: - Outlets
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var toggleButton: UIBarButtonItem!
    
    // MARK: - Properties
    
    var currentQuoteIndex = 0
    var quotes: [Quote]!
    var topic: String?
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quotes = QuoteDeck.sharedInstance.quotes
        chooseQuoteOfTheDay()
        updateUI()
        
    }
    
    // MARK: - Actions
    
    @IBAction func showQuoteOfTheDay() {
        topic = nil
        configure()
    }
    
    @IBAction func toggleTopics(_ sender: UIBarButtonItem) {
        if sender.title == Storyboard.TopicsTitle {
            performSegue(withIdentifier: Storyboard.ShowTopicSegueIdentifier, sender: sender)
        } else {
            showQuoteOfTheDay()
        }
    }
    
    
    // MARK: - Helpers
    
    private func chooseQuoteOfTheDay() {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "DDD"
        if let dayInYear = Int(formatter.string(from: Date())) {
            currentQuoteIndex = dayInYear % QuoteDeck.sharedInstance.quotes.count
        }
    }
    
    private func configure() {
        if let currentTopic = topic {
            toggleButton.title = Storyboard.TodayTitle
            quotes = QuoteDeck.sharedInstance.quotesForTag(currentTopic)
            currentQuoteIndex = 0
            updateUI()
        } else {
            toggleButton.title = Storyboard.TopicsTitle
            quotes = QuoteDeck.sharedInstance.quotes
            chooseQuoteOfTheDay()
        }
        updateUI()
    }
    
    private func updateUI() {
        let currentQuote = quotes[currentQuoteIndex]
        
        if let currentTopic = topic {
            toggleButton.title = Storyboard.TodayTitle
            title = "\(currentTopic.capitalized) \(currentQuoteIndex + 1) of \(quotes.count)"
        } else {
            toggleButton.title = Storyboard.TopicsTitle
            title = Storyboard.QuoteOfTheDayTitle
        }
        webView.loadHTMLString(currentQuote.htmlPage(), baseURL: nil)
    }
    
    // MARK: - Segues
    
    @IBAction func exitModalScene(_ segue: UIStoryboardSegue){
        // target for the unwind segue
        topic = nil
        configure()
    }
    
    @IBAction func showTopicQuotes(_ segue: UIStoryboardSegue) {
        configure()
    }
    
}
