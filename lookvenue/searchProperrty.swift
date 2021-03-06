//
//  searchProperrty.swift
//  lookvenue
//
//  Created by Pradeep Chauhan on 8/6/15.
//  Copyright (c) 2015 Pradeep Chauhan. All rights reserved.
//

import UIKit

class searchProperrty:UIViewController, UITextFieldDelegate,SHMultipleSelectDelegate,KSTokenViewDelegate{
    
    @IBOutlet weak var dateOfEnquiry: UITextField!
    @IBOutlet weak var priceRange: UITextField!
    @IBOutlet weak var venueType: UITextField!
    @IBOutlet weak var city: UITextField!
   
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var venueLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    //@IBOutlet weak var tokanView: KSTokenField!
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var pageView: UIView!
    @IBOutlet weak var area: KSTokenView!

    var currentlySelectedTextField = UITextField()
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
    
    var searchDetails: SearchDetails = SearchDetails()
    //var venueSelected: [Int] = []
    //var areaSelected: [Int] = []
    
    //var selectedLocationsArray = NSMutableArray()
    
    //var priceSelected:String!

    override func viewDidLoad() {
        
        self.searchButton.layer.cornerRadius = 5
        if UIDevice().userInterfaceIdiom == .Phone {
            switch UIScreen.mainScreen().nativeBounds.height {
            case 480:
                self.scrollView.contentSize = CGSize(width: 0, height: 800)
                self.scrollView.showsVerticalScrollIndicator = true
                //print("iPhone Classic")
            case 960:
                self.scrollView.contentSize = CGSize(width: 0, height: 800)
                self.scrollView.showsVerticalScrollIndicator = true
                //print("iPhone 4 or 4S")
            case 1136:
                self.scrollView.showsVerticalScrollIndicator = false
                self.scrollView.scrollEnabled = false
                //print("iPhone 5 or 5S or 5C")
            case 1334:
                self.scrollView.showsVerticalScrollIndicator = false
                self.scrollView.scrollEnabled = false
                //print("iPhone 6 or 6S")
            case 2208:
                self.scrollView.showsVerticalScrollIndicator = false
                self.scrollView.scrollEnabled = false
                //print("iPhone 6+ or 6S+")
            default:
                print("unknown")
            }
            
        }
        
        city.text = "Delhi/NCR"
        searchButton.backgroundColor = UIColor(red: 210.0/255.0, green: 63.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        //self.scrollView.contentSize = CGSize(width: 0, height: 600)
        //self.scrollView.showsVerticalScrollIndicator = true
        view.addSubview(scrollView)
        super.viewDidLoad()
        
        cityLabel.textColor = UIColor.redColor()
        areaLabel.textColor = UIColor.redColor()
        venueLabel.textColor = UIColor.redColor()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 210.0/255.0, green: 63.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        // center image in nav bar
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        imageView.contentMode = .ScaleAspectFit
        
        let image = UIImage(named: "look-venue-logo.png")
        imageView.image = image
        //self.navigationController?.setToolbarHidden(true, animated: false)
        self.navigationItem.titleView = imageView
        
        let leftBarButton: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        //set image for button
        leftBarButton.setImage(UIImage(named: "menu-icon.png"), forState: UIControlState.Normal)
        //add function for button
        leftBarButton.addTarget(self, action: "leftSideMenuButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        //set frame
        leftBarButton.frame = CGRectMake(0, 0,20, 20)
        
        let leftMenubarButton = UIBarButtonItem(customView: leftBarButton)
        //assign button to navigationbar
        self.navigationItem.leftBarButtonItem = leftMenubarButton
        
        area.delegate = self
        dateOfEnquiry.delegate = self
        priceRange.delegate = self
        venueType.delegate = self
        city.delegate = self
        
        //tokanView.promptText = "Top 5: "
        area.placeholder = "Type to search area"
        //tokanView.descriptionText = "Languages"
        
        area.maxTokenLimit = 5
        area.minimumCharactersToSearch = 0 // Show all results without without typing anything
        area.style = .Squared
        
        let loadingProgress = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loadingProgress.labelText = "Loading"
        //loadingProgress.detailsLabelText = "Please wait"
        var methodType: String = "GET"
        var base: String = "areas/get_areas_by_city_name?city_name="
        var param: String = "Delhi/NCR"
        var urlRequest: String = base + param
        var serviceCall : WebServiceCall = WebServiceCall()
        
        serviceCall.apiCallRequest(methodType, urlRequest: urlRequest, param:[:], completion: {(resultData : NSData) -> Void in
             self.areaListArray = serviceCall.getAreaArray(resultData)
            self.getAreasArray()
            self.getVenue()
            self.getPrice()
            
        })
        
    }
    
    func leftSideMenuButtonPressed() {
        self.menuContainerViewController.toggleLeftSideMenuCompletion { () -> Void in
            
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    // venue array declare
    func getVanuesArray() -> Void
    {
        vanuesArray = vanueListArray as! NSMutableArray
        println(vanuesArray)
        
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
       
        DatePickerDialog().show(title: "Select Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .Date) {
            
            (date) -> Void in
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd-MMM-yyyy"
            self.dateOfEnquiry.text = dateFormatter.stringFromDate(date)
            self.dateOfEnquiry.resignFirstResponder()
        }
        
        
    }
    
    
    @IBAction func venueTypeButton(sender: AnyObject) {
        //self.hideKeyBoard()
        multiselectViewCall = "venue"
        var methodType: String = "GET"
        var base: String = "property_types/"
        var param: String = ""
        var urlRequest: String = base
        var serviceCall : WebServiceCall = WebServiceCall()
        
        var venueTypemultipleSelect = SHMultipleSelect()
        venueTypemultipleSelect.selectedTextField = self.currentlySelectedTextField
        venueTypemultipleSelect.delegate = self
        venueTypemultipleSelect.rowsCount = self.vanueListArray.count
        venueTypemultipleSelect.show()
        self.venueType.resignFirstResponder()
        
    }
    
    func getVenue() {
        multiselectViewCall = "venue"
        var methodType: String = "GET"
        var base: String = "property_types/"
        var param: String = ""
        var urlRequest: String = base
        var serviceCall : WebServiceCall = WebServiceCall()
        serviceCall.apiCallRequest(methodType, urlRequest: urlRequest, param:[:], completion: {(resultData : NSData) -> Void in
            self.vanueListArray = serviceCall.getAreaArray(resultData)
            self.getVanuesArray()
            
        })

    }
    func getPrice () {
        multiselectViewCall = "price"
        var methodType: String = "GET"
        var base: String = "price_ranges"
        var param: String = ""
        var urlRequest: String = base
        
        var serviceCall : WebServiceCall = WebServiceCall()
        serviceCall.apiCallRequest(methodType, urlRequest: urlRequest, param:[:]) { (resultData) -> () in
            self.priceListArray = serviceCall.getPriceArray(resultData)
            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
            self.getPriceArray()
        }
    }
    
    @IBAction func pricePickerRange(sender: AnyObject) {
        
        var priceRangemultipleSelect = SHMultipleSelect()
        priceRangemultipleSelect.selectedTextField = self.currentlySelectedTextField
        priceRangemultipleSelect.delegate = self
        priceRangemultipleSelect.rowsCount = self.priceListArray.count
        priceRangemultipleSelect.show()
        self.priceRange.resignFirstResponder()
    }
    
    
//    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
//        self.view.resignFirstResponder()
//        println("touch")
//        //return false
//    }
    
    //For venue
    
    func multipleSelectView(multipleSelectView: SHMultipleSelect!, clickedBtnAtIndex clickedBtnIndex: Int, withSelectedIndexPaths selectedIndexPaths:[AnyObject]!) {
        
        if (multiselectViewCall == "venue") {
            if(selectedIndexPaths == nil) {
                searchDetails.venueSelected.removeAllObjects()
                self.venueType.text=""
                self.venueType.resignFirstResponder()
            }
            else {
                //multipleSelectView.selectedTextField.resignFirstResponder()
                if(clickedBtnIndex != 0)
                {
                    searchDetails.venueSelected.removeAllObjects()
                    var indexPathsArray = selectedIndexPaths as NSArray
                    
                    for(var i = 0; i < indexPathsArray.count; i++)
                    {
                        var index = indexPathsArray[i] as! NSIndexPath
                        if(self.venueType.text == nil || self.venueType.text == "")
                        {
                            
                            self.venueType.text = (vanuesArray[index.row]["name"] as! String)
                            searchDetails.venueSelected.addObject(vanuesArray[index.row]["id"] as! Int)
                        }
                        else if(self.venueType.text != nil || self.venueType.text != "")
                        {
                            self.venueType.text = self.venueType.text + "," + (vanuesArray[index.row]["name"] as! String)
                            searchDetails.venueSelected.addObject(vanuesArray[index.row]["id"] as! Int)
                            
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
                searchDetails.priceSelected.removeAllObjects()
                self.priceRange.text=""
                self.priceRange.resignFirstResponder()
            }
            else {
                if(clickedBtnIndex != 0)
                {
                    if(selectedIndexPaths != nil) {
                        var indexPathsArray = selectedIndexPaths as NSArray
                        
                        searchDetails.priceSelected.removeAllObjects()
                        for(var i = 0; i < indexPathsArray.count; i++)
                        {
                            var index = indexPathsArray[i] as! NSIndexPath
                            if(self.priceRange.text == nil || self.priceRange.text == "")
                            {
                                self.priceRange.text = (priceArray[index.row]["name"] as! String)
                                searchDetails.priceSelected.addObject(priceArray[index.row]["id"] as! Int)
                                
                            }
                            else if(self.priceRange.text != nil || self.priceRange.text != "")
                            {
                                self.priceRange.text = self.priceRange.text + "," + (priceArray[index.row]["name"] as! String)
                                searchDetails.priceSelected.addObject(priceArray[index.row]["id"] as! Int)
                                
                            }
                            else {
                                searchDetails.priceSelected.removeAllObjects()
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
        
        //==
        currentlySelectedTextField.resignFirstResponder()
        
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
            for (var i = 0; i < searchDetails.venueSelected.count; i++){
                var selectedCheck = (searchDetails.venueSelected[i] as! Int) - 1
                if((indexPath.item) == selectedCheck) {
                    canSelect = true
                }
            }
        }
        
        if(multiselectViewCall == "price") {
            for (var i = 0; i < searchDetails.priceSelected.count; i++){
                var selectedCheck = (searchDetails.priceSelected[i] as! Int) - 1
                if((indexPath.item) == selectedCheck) {
                    canSelect = true
                }
            }
        }
        //println(canSelect)
        return canSelect
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        currentlySelectedTextField = textField
        textField.resignFirstResponder()

    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        currentlySelectedTextField.resignFirstResponder()
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //self.view.endEditing(true)
        
        textField.resignFirstResponder()
        return true
        
    }
    
    @IBAction func searchButton(sender: AnyObject) {
        
        var area_ids:String!
        var property_type_ids:String!
        var price_range_ids:String!
        
        // Price range ids string
        
        if((searchDetails.priceSelected).count > 1) {
            for (var i = 0; i < (searchDetails.priceSelected).count; i++) {
                price_range_ids = price_range_ids + "," + ((searchDetails.priceSelected)[i] as! String)
                
            }
        }
        else if ((searchDetails.priceSelected).count == 1 ) {
            price_range_ids = ((searchDetails.priceSelected)[0] as AnyObject) as! String
        }
        else {
            price_range_ids = ""
        }
        
        // Property type ids string
        
        if((searchDetails.venueSelected).count > 1) {
            for (var i = 0; i < (searchDetails.venueSelected).count; i++) {
                property_type_ids = property_type_ids + "," + ((searchDetails.venueSelected)[i] as! String)
                
            }
        }
        else if ((searchDetails.venueSelected).count == 1 ) {
            property_type_ids = (searchDetails.venueSelected)[0] as! String
        }
        else {
            property_type_ids = ""
        }
        
        // Area ids string
        
        if((searchDetails.selectedLocationsArray).count > 1) {
            for (var i = 0; i < (searchDetails.selectedLocationsArray).count; i++) {
                area_ids = area_ids + "," + ((searchDetails.selectedLocationsArray)[i] as! String)
                
            }
        }
        else if ((searchDetails.selectedLocationsArray).count == 1 ) {
            area_ids = (searchDetails.selectedLocationsArray)[0] as! String
        }
        else {
            area_ids = ""
        }
        
        println(area_ids + "+++" + property_type_ids + "+++" + price_range_ids)
        
        var methodType: String = "GET"
        var base1: String = "search.json?area_ids=1 \(area_ids) &property_type_ids= \(property_type_ids) &price_range_ids= \(price_range_ids)"
        println(base1)
        var base: String = "search.json?area_ids=1&property_type_ids=1,2,3&price_range_ids=1,2,3,4,5,6,7"
        
        var param: String = "Delhi/NCR"
        var urlRequest: String = base
        var serviceCall : WebServiceCall = WebServiceCall()
        
        serviceCall.apiCallRequest(methodType, urlRequest: urlRequest, param:[:], completion: {(resultData : NSData) -> Void in
            self.searchListArray = serviceCall.getSearchVenueArray(resultData)
            //println(self.searchListArray)
            self.getSearchVenueArray()
            if((self.searchListArray.count) > 0) {
                self.searchDetails.cityTextfieldValue = self.city.text
                self.searchDetails.areaTextfieldValue = self.area.descriptionText
                self.searchDetails.venueTextfieldValue = self.venueType.text
                self.searchDetails.dateTextfieldValue = self.dateOfEnquiry.text
                self.searchDetails.priceTextfieldValue = self.priceRange.text
                
                var storyBoard = UIStoryboard(name: "Main", bundle: nil)
                var dash : venueSearchResultCollectionViewController = storyBoard.instantiateViewControllerWithIdentifier("venueSearchResult") as! venueSearchResultCollectionViewController
                dash.searchVenueListArray = self.searchListArray
                dash.searchDetails = self.searchDetails
                //println(searchVenueListArray)
                self.navigationController?.pushViewController(dash, animated: true)
            }
            else {
                println("Data not found")
            }
        })
        
    }
    
    
    

}

extension searchProperrty: KSTokenViewDelegate {
    
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
            //println(tempDictionary)
            if(tempDictionary.valueForKey("name") as! NSString == title)
            {
                //println(tempDictionary.valueForKey("id") as! NSNumber)
                return tempDictionary.valueForKey("id") as! NSNumber
                
            }
            else
            {
                return NSNumber(int: 0)
            }
        }
        
        return NSNumber(int: 0)
    }
    
    func tokenView(tokenView: KSTokenView, willDeleteToken token: KSToken) {
        //println(token.title)
        var idOfObject = self.getIdOfObject(token.title)
        searchDetails.selectedLocationsArray.removeObject(idOfObject)
        //println(idOfObject)
    }
    
    func tokenView(token: KSTokenView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var object1 = (token._resultArray as NSArray).objectAtIndex(indexPath.row) as! NSDictionary
        println(object1)
        searchDetails.selectedLocationsArray.addObject(object1["id"] as! NSNumber)
        println(searchDetails.selectedLocationsArray)
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
    @IBAction func venueEndEditing(sender: AnyObject) {
        self.venueType.resignFirstResponder()
    }
    @IBAction func dateEndEditing(sender: AnyObject) {
        self.dateOfEnquiry.resignFirstResponder()
    }
    @IBAction func priceRangeEndEditing(sender: AnyObject) {
        self.priceRange.resignFirstResponder()
    }
    
}
