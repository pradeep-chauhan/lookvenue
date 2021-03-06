//
//  searchPropertyWithFilterViewController.swift
//  lookvenue
//
//  Created by Pradeep Chauhan on 9/21/15.
//  Copyright (c) 2015 Pradeep Chauhan. All rights reserved.
//

import UIKit

class searchPropertyWithFilterViewController: UIViewController, UITextFieldDelegate,SHMultipleSelectDelegate,KSTokenViewDelegate, SBPickerSelectorDelegate {

    @IBOutlet weak var dateOfEnquiry: UITextField!
    @IBOutlet weak var priceRange: UITextField!
    @IBOutlet weak var venueType: UITextField!
    @IBOutlet weak var city: UITextField!
    
    @IBOutlet weak var applyFilterButton: UIButton!
    @IBOutlet weak var capacity: UITextField!
    @IBOutlet weak var coverdArea: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var venueLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    //@IBOutlet weak var tokanView: KSTokenField!
    
    @IBOutlet weak var pageView: UIView!
    @IBOutlet weak var area: KSTokenView!
    
    //var scrollView:UIScrollView!
    
    //scrollView.delegate = self
    var currentlySelectedTextField = UITextField()
    var pickerSelectValue = ""
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
    var areaSelected: [Int] = []
    
    var selectedLocationsArray = NSMutableArray()
    
    override func viewDidLoad() {
        
        self.applyFilterButton.layer.cornerRadius = 5
        self.scrollView.contentSize = CGSize(width: 0, height: 800)
        self.scrollView.showsVerticalScrollIndicator = true
        view.addSubview(scrollView)
        
        //indicator.startAnimating()
        super.viewDidLoad()
        
        cityLabel.textColor = UIColor.redColor()
        areaLabel.textColor = UIColor.redColor()
        venueLabel.textColor = UIColor.redColor()
        
        
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.title = "Apply Filter"
        
        println(searchDetails.selectedLocationsArray)
        
        let leftBarButton: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        // image for button
        leftBarButton.setImage(UIImage(named: "arrow-left.png"), forState: UIControlState.Normal)
        //set frame
        leftBarButton.frame = CGRectMake(0, 0,20, 20)
        leftBarButton.addTarget(self, action: "backButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        
        let leftMenubarButton = UIBarButtonItem(customView: leftBarButton)
        //assign button to navigationbar
        self.navigationItem.leftBarButtonItem = leftMenubarButton
        
        self.area.delegate=self
        self.dateOfEnquiry.delegate=self
        self.priceRange.delegate=self
        self.venueType.delegate=self
        self.city.delegate=self
        self.coverdArea.delegate = self
        self.capacity.delegate = self
        
        city.text = searchDetails.cityTextfieldValue
        venueType.text = searchDetails.venueTextfieldValue
        dateOfEnquiry.text = searchDetails.dateTextfieldValue
        priceRange.text = searchDetails.priceTextfieldValue
        //area.descriptionText = searchDetails.areaTextfieldValue
        area.descriptionText = "qwerty"
        
        
        
        //tokanView.promptText = "Top 5: "
        area.placeholder = "Type to search area"
        //tokanView.descriptionText = "Languages"
        
        area.maxTokenLimit = 5
        area.minimumCharactersToSearch = 0 // Show all results without without typing anything
        area.style = .Squared
        
//        var serviceCall : WebServiceCall = WebServiceCall()
//        self.areaListArray = serviceCall.getAreaArray(resultData)
//        self.getAreasArray()
        
        var methodType: String = "GET"
        var base: String = "areas/get_areas_by_city_name?city_name="
        var param: String = "Delhi/NCR"
        var urlRequest: String = base + param
        var serviceCall : WebServiceCall = WebServiceCall()
        
        serviceCall.apiCallRequest(methodType, urlRequest: urlRequest, param: [:], completion: {(resultData : NSData) -> Void in
            self.areaListArray = serviceCall.getAreaArray(resultData)
            self.getAreasArray()
            //self.indicator.stopAnimating()
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
        //indicator.startAnimating()
        serviceCall.apiCallRequest(methodType, urlRequest: urlRequest, param: [:], completion: {(resultData : NSData) -> Void in
            self.vanueListArray = serviceCall.getAreaArray(resultData)
            self.getVanuesArray()
            //self.indicator.stopAnimating()
            
            var venueTypemultipleSelect = SHMultipleSelect()
            venueTypemultipleSelect.selectedTextField = self.currentlySelectedTextField
            venueTypemultipleSelect.delegate = self
            venueTypemultipleSelect.rowsCount = self.vanueListArray.count
            venueTypemultipleSelect.show()
            self.venueType.resignFirstResponder()
        })
        
    }
    
    @IBAction func pricePickerRange(sender: AnyObject) {
        multiselectViewCall = "price"
        var methodType: String = "GET"
        var base: String = "price_ranges"
        var param: String = ""
        var urlRequest: String = base
        
        var serviceCall : WebServiceCall = WebServiceCall()
        //indicator.startAnimating()
        serviceCall.apiCallRequest(methodType, urlRequest: urlRequest, param: [:]) { (resultData) -> () in
            self.priceListArray = serviceCall.getPriceArray(resultData)
            self.getPriceArray()
            //self.indicator.stopAnimating()
            
            var priceRangemultipleSelect = SHMultipleSelect()
            priceRangemultipleSelect.selectedTextField = self.currentlySelectedTextField
            priceRangemultipleSelect.delegate = self
            priceRangemultipleSelect.rowsCount = self.priceListArray.count
            priceRangemultipleSelect.show()
            self.priceRange.resignFirstResponder()
            
        }
        
    }
    
    @IBAction func capacity(sender: AnyObject) {
        self.capacity.resignFirstResponder()
        pickerSelectValue = "capacity"
        let picker: SBPickerSelector = SBPickerSelector.picker()
        
        picker.pickerData = [["100","500","800","1000","1200","1500","2000","2500","2500"],["-"],["500","800","1000","1200","1500","2000","2500","3000","5000"]] //picker content
        picker.delegate = self
        picker.pickerType = SBPickerSelectorType.Text
        picker.doneButtonTitle = "Done"
        picker.cancelButtonTitle = "Cancel"
        picker.optionsToolBar.tintColor =  UIColor(red: 210.0/255.0, green: 63.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        
        let point: CGPoint = view.convertPoint(sender.frame.origin, fromView: sender.superview)
        var frame: CGRect = sender.frame
        frame.origin = point
        picker.showPickerIpadFromRect(frame, inView: view)
        //self.capacity.resignFirstResponder()
        
    }
    //For venue
    @IBAction func coveredArea(sender: AnyObject) {
        self.coverdArea.resignFirstResponder()
        pickerSelectValue = "coveredArea"
        let picker: SBPickerSelector = SBPickerSelector.picker()
        
        picker.pickerData = [["1","100","500"],["-"],["100","500","800"]] //picker content
        picker.delegate = self
        picker.pickerType = SBPickerSelectorType.Text
        picker.doneButtonTitle = "Done"
        picker.cancelButtonTitle = "Cancel"
        picker.optionsToolBar.tintColor =  UIColor(red: 210.0/255.0, green: 63.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        
        let point: CGPoint = view.convertPoint(sender.frame.origin, fromView: sender.superview)
        var frame: CGRect = sender.frame
        frame.origin = point
        picker.showPickerIpadFromRect(frame, inView: view)
        
    }
    
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
    

    
    @IBAction func applyFilter(sender: AnyObject) {
        var methodType: String = "GET"
        var base: String = "search.json?area_ids=1&property_type_ids=1,2,3&price_range_ids=1"
        //var param: String = "Delhi/NCR"
        var urlRequest: String = base
        var serviceCall : WebServiceCall = WebServiceCall()
        
        serviceCall.apiCallRequest(methodType, urlRequest: urlRequest, param: [:], completion: {(resultData : NSData) -> Void in
            self.searchListArray = serviceCall.getSearchVenueArray(resultData)
            self.getSearchVenueArray()
            //self.indicator.stopAnimating()
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
            println(tempDictionary)
            if(tempDictionary.valueForKey("name") as! NSString == title)
            {
                println(tempDictionary.valueForKey("id") as! NSNumber)
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
//        if((searchDetails.selectedLocationsArray).count > 0) {
//            for ( var i = 0; i < (searchDetails.selectedLocationsArray).count; i++) {
//                
//            }
//        }
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
    
    
    func pickerSelector(selector: SBPickerSelector!, selectedValue value: String!, index idx: Int) {
        if(pickerSelectValue == "coveredArea") {
            coverdArea.text = value
        }
        if(pickerSelectValue == "capacity") {
            capacity.text = value
        }
    }
    
    func backButtonPressed() {
        
        self.navigationController?.popViewControllerAnimated(true)
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

    @IBAction func capacityEndEditing(sender: AnyObject) {
        self.capacity.resignFirstResponder()
    }
    @IBAction func coveredEndEditing(sender: AnyObject) {
        self.coverdArea.resignFirstResponder()
    }

}
