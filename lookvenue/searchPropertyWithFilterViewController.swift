//
//  searchPropertyWithFilterViewController.swift
//  lookvenue
//
//  Created by Pradeep Chauhan on 9/21/15.
//  Copyright (c) 2015 Pradeep Chauhan. All rights reserved.
//

import UIKit

class searchPropertyWithFilterViewController: UIViewController, UITextFieldDelegate,SHMultipleSelectDelegate,KSTokenViewDelegate {

    @IBOutlet weak var dateOfEnquiry: UITextField!
    @IBOutlet weak var priceRange: UITextField!
    @IBOutlet weak var venueType: UITextField!
    @IBOutlet weak var city: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var venueLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    //@IBOutlet weak var tokanView: KSTokenField!
    
    @IBOutlet weak var area: KSTokenView!
    
    //var scrollView:UIScrollView!
    
    //scrollView.delegate = self
    var multiselectViewCall: String!
    
    var vanueListArray : NSArray!
    var vanuesArray : NSMutableArray = NSMutableArray()
    
    var areaListArray : NSArray!
    var areaArray : NSMutableArray = NSMutableArray()
    
    var priceListArray : NSArray!
    var priceArray : NSMutableArray = NSMutableArray()
    
    var searchListArray : NSArray!
    var searchArray : NSMutableArray = NSMutableArray()
    
    //selected value
    
    var priceSelected: [Int] = []
    var venueSelected: [Int] = []
    var areaSelected: [Int] = []
    
    var selectedLocationsArray = NSMutableArray()
    
    var searchDetails: SearchDetails = SearchDetails()
    //var priceSelected:String!
    
    override func viewDidLoad() {
        
        self.scrollView.contentSize = CGSize(width: 0, height: 800)
        self.scrollView.showsVerticalScrollIndicator = true
        view.addSubview(scrollView)
        
        indicator.startAnimating()
        super.viewDidLoad()
        
        cityLabel.textColor = UIColor.redColor()
        areaLabel.textColor = UIColor.redColor()
        venueLabel.textColor = UIColor.redColor()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        
        // center image in nav bar
        
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
//        imageView.contentMode = .ScaleAspectFit
//        
//        let image = UIImage(named: "look-venue-logo.png")
//        imageView.image = image
//        
//        self.navigationItem.titleView = imageView
        self.navigationItem.title = "Apply Filter"
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "OpenSans", size: 10)!]
        self.navigationController?.setToolbarHidden(true, animated: true)
        
//        let leftBarButton: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
//        //set image for button
//        leftBarButton.setImage(UIImage(named: "menu-icon.png"), forState: UIControlState.Normal)
//        //add function for button
//        leftBarButton.addTarget(self, action: "ToggleButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
//        //set frame
//        leftBarButton.frame = CGRectMake(0, 0,20, 20)
//        
//        let leftMenubarButton = UIBarButtonItem(customView: leftBarButton)
//        //assign button to navigationbar
//        self.navigationItem.leftBarButtonItem = leftMenubarButton
        
        self.area.delegate=self
        self.dateOfEnquiry.delegate=self
        self.priceRange.delegate=self
        self.venueType.delegate=self
        self.city.delegate=self
        
        //tokanView.promptText = "Top 5: "
        area.placeholder = "Type to search area"
        //tokanView.descriptionText = "Languages"
        
        area.maxTokenLimit = 5
        area.minimumCharactersToSearch = 0 // Show all results without without typing anything
        area.style = .Squared
        
        
        
        var methodType: String = "GET"
        var base: String = "areas/get_areas_by_city_name?city_name="
        var param: String = "Delhi/NCR"
        var urlRequest: String = base + param
        var serviceCall : WebServiceCall = WebServiceCall()
        
        serviceCall.apiCallRequest(methodType, urlRequest: urlRequest, completion: {(resultData : NSData) -> Void in
            self.areaListArray = serviceCall.getAreaArray(resultData)
            self.getAreasArray()
            self.indicator.stopAnimating()
        })
        
    }
    
    // venue array declare
    func getVanuesArray() -> Void
    {
        vanuesArray = vanueListArray as! NSMutableArray
        
    }
    
    func getAreasArray() -> Void
    {
        areaArray = areaListArray as! NSMutableArray
        //println(areaArray)
    }
    
    func getPriceArray() -> Void
    {
        priceArray = priceListArray as! NSMutableArray
    }
    
    func getSearchVenueArray() -> Void
    {
        searchArray = searchListArray as! NSMutableArray
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func datePicker(sender: AnyObject) {
        dateOfEnquiry.resignFirstResponder()
        DatePickerDialog().show(title: "Select Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .Date) {
            
            (date) -> Void in
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd-MMM-yyyy"
            self.dateOfEnquiry.text = dateFormatter.stringFromDate(date)
            
        }
        
        
    }
    
    
    @IBAction func venueTypeButton(sender: AnyObject) {
        //self.hideKeyBoard()
        venueType.resignFirstResponder()
        multiselectViewCall = "venue"
        var methodType: String = "GET"
        var base: String = "property_types/"
        var param: String = ""
        var urlRequest: String = base
        var serviceCall : WebServiceCall = WebServiceCall()
        indicator.startAnimating()
        serviceCall.apiCallRequest(methodType, urlRequest: urlRequest, completion: {(resultData : NSData) -> Void in
            self.vanueListArray = serviceCall.getAreaArray(resultData)
            self.getVanuesArray()
            self.indicator.stopAnimating()
            
            var venueTypemultipleSelect = SHMultipleSelect()
            venueTypemultipleSelect.delegate = self
            venueTypemultipleSelect.rowsCount = self.vanueListArray.count
            venueTypemultipleSelect.show()
        })
        
    }
    
    @IBAction func pricePickerRange(sender: AnyObject) {
        priceRange.resignFirstResponder()
        multiselectViewCall = "price"
        var methodType: String = "GET"
        var base: String = "price_ranges"
        var param: String = ""
        var urlRequest: String = base
        
        var serviceCall : WebServiceCall = WebServiceCall()
        indicator.startAnimating()
        serviceCall.apiCallRequest(methodType, urlRequest: urlRequest) { (resultData) -> () in
            self.priceListArray = serviceCall.getPriceArray(resultData)
            self.getPriceArray()
            self.indicator.stopAnimating()
            
            var priceRangemultipleSelect = SHMultipleSelect()
            priceRangemultipleSelect.delegate = self
            priceRangemultipleSelect.rowsCount = self.priceListArray.count
            priceRangemultipleSelect.show()
        }
        
        
    }
    
    //For venue
    
    func multipleSelectView(multipleSelectView: SHMultipleSelect!, clickedBtnAtIndex clickedBtnIndex: Int, withSelectedIndexPaths selectedIndexPaths:[AnyObject]!) {
        
        if (multiselectViewCall == "venue") {
            if(selectedIndexPaths == nil) {
                venueSelected.removeAll()
                self.venueType.text=""
            }
            else {
                if(clickedBtnIndex != 0)
                {
                    venueSelected.removeAll()
                    var indexPathsArray = selectedIndexPaths as NSArray
                    
                    for(var i = 0; i < indexPathsArray.count; i++)
                    {
                        var index = indexPathsArray[i] as! NSIndexPath
                        if(self.venueType.text == nil || self.venueType.text == "")
                        {
                            
                            self.venueType.text = (vanuesArray[index.row]["name"] as! String)
                            venueSelected.append(vanuesArray[index.row]["id"] as! Int)
                        }
                        else if(self.venueType.text != nil || self.venueType.text != "")
                        {
                            self.venueType.text = self.venueType.text + "," + (vanuesArray[index.row]["name"] as! String)
                            venueSelected.append(vanuesArray[index.row]["id"] as! Int)
                            
                        }
                        else {
                            self.venueType.text=""
                        }
                    }
                }
                else {
                    //venueSelected.removeAll()
                    self.venueType.text=""
                }
            }
            
        }
        
        
        if (multiselectViewCall == "price") {
            if(selectedIndexPaths == nil) {
                priceSelected.removeAll()
                self.priceRange.text=""
            }
            else {
                if(clickedBtnIndex != 0)
                {
                    if(selectedIndexPaths != nil) {
                        var indexPathsArray = selectedIndexPaths as NSArray
                        
                        priceSelected.removeAll()
                        for(var i = 0; i < indexPathsArray.count; i++)
                        {
                            var index = indexPathsArray[i] as! NSIndexPath
                            if(self.priceRange.text == nil || self.priceRange.text == "")
                            {
                                self.priceRange.text = (priceArray[index.row]["name"] as! String)
                                priceSelected.append(priceArray[index.row]["id"] as! Int)
                                
                            }
                            else if(self.priceRange.text != nil || self.priceRange.text != "")
                            {
                                self.priceRange.text = self.priceRange.text + "," + (priceArray[index.row]["name"] as! String)
                                priceSelected.append(priceArray[index.row]["id"] as! Int)
                                
                            }
                            else {
                                priceSelected.removeAll()
                                self.priceRange.text=""
                            }
                        }
                    }
                    else {
                        self.priceRange.text=""
                    }
                    
                }
                else {
                    //priceSelected.removeAll()
                    self.priceRange.text=""
                }
            }
            
            
        }        
    }
    
    
    func multipleSelectView(multipleSelectView: SHMultipleSelect, titleForRowAtIndexPath indexPath: NSIndexPath) -> String {
        
        var returnResponse: String!
        if (multiselectViewCall == "venue") {
            returnResponse = vanueListArray[indexPath.row]["name"] as! String
        }
        
        if (multiselectViewCall == "price") {
            returnResponse = priceListArray[indexPath.row]["name"] as! String
        }
        return returnResponse
    }
    
    func multipleSelectView(multipleSelectView: SHMultipleSelect, setSelectedForRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        var canSelect: Bool = false
        
        if(multiselectViewCall == "venue") {
            for (var i = 0; i < venueSelected.count; i++){
                var selectedCheck = (venueSelected[i]) - 1
                if((indexPath.item) == selectedCheck) {
                    canSelect = true
                }
            }
        }
        
        if(multiselectViewCall == "price") {
            for (var i = 0; i < priceSelected.count; i++){
                var selectedCheck = (priceSelected[i]) - 1
                if((indexPath.item) == selectedCheck) {
                    canSelect = true
                }
            }
        }
        //println(canSelect)
        return canSelect
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
        
    }
    
    @IBAction func searchButton(sender: AnyObject) {
        var methodType: String = "GET"
        var base: String = "search.json?area_ids=1&property_type_ids=1,2,3&price_range_ids=1"
        var param: String = "Delhi/NCR"
        var urlRequest: String = base
        var serviceCall : WebServiceCall = WebServiceCall()
        
        serviceCall.apiCallRequest(methodType, urlRequest: urlRequest, completion: {(resultData : NSData) -> Void in
            self.searchListArray = serviceCall.getSearchVenueArray(resultData)
            self.getSearchVenueArray()
            self.indicator.stopAnimating()
            if((self.searchListArray.count) > 0) {
                var storyBoard = UIStoryboard(name: "Main", bundle: nil)
                var dash : venueSearchResultCollectionViewController = storyBoard.instantiateViewControllerWithIdentifier("venueSearchResult") as! venueSearchResultCollectionViewController
                dash.searchVenueListArray = self.searchListArray
                self.navigationController?.pushViewController(dash, animated: true)
            }
            else {
                println("Data not found")
            }
        })
        
    }
    
    // side bar call
    
    func ToggleButtonAction(sender:UIButton)
    {
        toggleSideMenuView()
    }
    // MARK: - ENSideMenu Delegate
    func sideMenuWillOpen() {
        //println("sideMenuWillOpen")
    }
    
    func sideMenuWillClose() {
        //println("sideMenuWillClose")
    }
    
    func sideMenuShouldOpenSideMenu() -> Bool {
        //println("sideMenuShouldOpenSideMenu")
        return true
    }
    
    
}

extension searchPropertyWithFilterViewController: KSTokenViewDelegate {
    
    func tokenView(token: KSTokenView, performSearchWithString string: String, completion: ((results: Array<AnyObject>) -> Void)?) {
        
        if (isEmpty(string)){
            
            completion!(results: areaArray as Array)
            
            return
        }
        
        var data: NSMutableArray = NSMutableArray()
        //        for value: String in names {
        for value in areaArray {
            
            if ((value as! NSDictionary).valueForKey("name") as! String).lowercaseString.rangeOfString(string.lowercaseString) != nil {
                data.addObject((value as! NSDictionary).valueForKey("name") as! String)
            }
        }
        completion!(results: data as Array)
        
    }
    
    func getIdOfObject(title : NSString) -> NSNumber
    {
        for var i = 0; i < areaArray.count; i++
        {
            var tempDictionary = areaArray[i] as! NSDictionary
            if(tempDictionary.valueForKey("name") as! NSString == title)
            {
                return tempDictionary.valueForKey("id") as! NSNumber
            }
            else
            {
                return NSNumber(int: 0)
            }
        }
        
        return NSNumber(int: 0)
    }
    
    //    func tokenView(tokenView: KSTokenView, willDeleteToken token: KSToken) {
    //        println(token.title)
    //        var idOfObject = self.getIdOfObject(token.title)
    //        selectedLocationsArray.removeObject(idOfObject)
    //    }
    //
    func tokenView(token: KSTokenView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var object = areaArray.objectAtIndex(indexPath.row) as! NSDictionary
        selectedLocationsArray.addObject(object["id"] as! NSNumber)
        
    }
    
    func tokenView(token: KSTokenView, displayTitleForObject object: AnyObject) -> String {
        if(object.isKindOfClass(NSDictionary))
        {
            //return NSString(format: "%d",(object["id"] as! NSNumber).intValue) as! String
            return object["name"] as! String
        }
        else
        {
            return object as! String
        }
        
    }


}
