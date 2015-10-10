//
//  locationViewController.swift
//  lookvenue
//
//  Created by Pradeep Chauhan on 8/12/15.
//  Copyright (c) 2015 Pradeep Chauhan. All rights reserved.
//

import UIKit
import MapKit
class locationViewController: UIViewController {
    
    
    var lat:Double = Double()
    var lng:Double = Double()
    var markerTitle:String = String()
    var markerSubTitle:String = String()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var zipcode: UILabel!
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var area: UILabel!
    
   
    
    override func viewDidLoad() {
        
        self.navigationController?.setToolbarHidden(false, animated: true)
        super.viewDidLoad()
        var loc = CLLocationCoordinate2D(
            latitude: lat,
            longitude: lng
        )
        var span = MKCoordinateSpanMake(0.05, 0.05)
        var region = MKCoordinateRegion(center: loc, span: span)
        mapView.setRegion(region, animated: true)
        
        
        //3
        var annotation = MKPointAnnotation()
        annotation.coordinate = loc
        annotation.title = markerTitle
        annotation.subtitle = markerSubTitle
        mapView.addAnnotation(annotation)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
