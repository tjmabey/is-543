//
//  ScriptureViewController.swift
//  Map Scriptures
//
//  Created by Tyler Mabey on 11/10/17.
//  Copyright © 2017 Tyler Mabey. All rights reserved.
//

import UIKit
import WebKit
import MapKit

class ScriptureViewController : UIViewController, WKNavigationDelegate {
    
    // MARK: - Properties
    
    var book: Book!
    var chapter = 0
    var places = [GeoPlace]()
    var focus = 0
    
    private struct Storyboard {
        static let ShowMap = "Show Map"
        static let RightBarButton = "Map"
        static let ShowChaptersSegue = "Show Chapters"
    }
    
    private var webView: WKWebView!
    private weak var mapViewController: MapViewController?
    
    // MARK: - Outlets
    
    @IBOutlet weak var navBar: UINavigationItem!
    
    // MARK: - View controller lifecycle
    
    override func loadView() {
        let webViewConfiguration = WKWebViewConfiguration()
        
        webViewConfiguration.preferences.javaScriptEnabled = false
        
        webView = WKWebView(frame: .zero, configuration: webViewConfiguration)
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        configureDetailViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let (html, geoplaces) = ScriptureRenderer.sharedRenderer.htmlForBookId(book.id, chapter: chapter)
        webView.loadHTMLString(html, baseURL: nil)
        
        places = geoplaces
        
        configureDetailViewController()
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.ShowMap {
            let navVC = segue.destination as? UINavigationController
            if let mapVC = navVC?.topViewController as? MapViewController {
                // load all the pins into the map
                mapVC.pins = places
                mapVC.book = book
                mapVC.chapter = chapter
                mapVC.focus = focus
            }
        }
    }
    
    // MARK: - Web kit navigation delegate
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let path = navigationAction.request.url?.absoluteString {
            if path.hasPrefix(ScriptureRenderer.Constant.baseUrl) {
                focus = Int(path.substring(fromOffset: ScriptureRenderer.Constant.baseUrl.count))!
                
                if let mapVC = mapViewController {
                    // handle a tap on a location from text
                    mapVC.pins = places
                    mapVC.book = book
                    mapVC.chapter = chapter
                    mapVC.focus = focus
                    
                    mapVC.configureCamera()
                } else {
                    performSegue(withIdentifier: Storyboard.ShowMap, sender: self)
                }
                decisionHandler(.cancel)
                return
            }
        }
        
        decisionHandler(.allow)

    }
    
    // MARK: - Helpers
    
    func configureDetailViewController() {
        // if there is a split view (the map) is present
        if let splitVC = splitViewController {
            if let navVC = splitVC.viewControllers.last as? UINavigationController {
                mapViewController = navVC.topViewController as? MapViewController
                mapViewController?.pins = places
                mapViewController?.book = book
                mapViewController?.chapter = chapter
                mapViewController?.focus = 0
                mapViewController?.viewDidAppear(true)
            } else {
                mapViewController = splitVC.viewControllers.last as? MapViewController
                
            }
        } else {
            mapViewController = nil
        }
        
        if !((splitViewController?.viewControllers.last as? UINavigationController)?.topViewController is MapViewController) {
            navBar.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(ScriptureViewController.goToMap))
            navBar.rightBarButtonItem?.title = Storyboard.RightBarButton
        }
        
    }
    
    // MARK: - Actions
    
    @objc func goToMap(){
        performSegue(withIdentifier: Storyboard.ShowMap, sender: self)
    }
    
    
}
