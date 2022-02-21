//
//  TrailerViewController.swift
//  Flix
//
//  Created by Brian Velecela on 2/20/22.
//

import UIKit
import WebKit

class TrailerViewController: UIViewController, WKUIDelegate {
    var movieVideos : [String : Any]!
    
    //@IBOutlet weak var webView: WKWebView!
    var url: String! //recieving the url to webView View Controller
    var WebView :WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        WebView = WKWebView(frame: .zero, configuration: webConfiguration)
        
        WebView.uiDelegate = self
        view = WebView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Pass the url request and loading the request
        let myurl = URL(string: url)!
        let request = URLRequest(url: myurl)
        WebView.load(request)
       
    }
}
