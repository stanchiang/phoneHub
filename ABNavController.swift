//
//  ABViewController.swift
//  phoneHub
//
//  Created by Stanley Chiang on 11/19/14.
//  Copyright (c) 2014 Stanley Chiang. All rights reserved.
//

import UIKit
import AddressBookUI
import CoreData

class ABNavController:ABPeoplePickerNavigationController, ABPeoplePickerNavigationControllerDelegate{
//	override func viewDidLoad() {
//		self.displayedProperties = [kABPersonPhoneProperty]
//	}
	let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
	
	func peoplePickerNavigationController(peoplePicker: ABPeoplePickerNavigationController!, didSelectPerson person: ABRecord!, property: ABPropertyID, identifier: ABMultiValueIdentifier) {
		//save AB record
		
		let index = ABMultiValueGetIndexForIdentifier(ABRecordCopyValue(person, kABPersonPhoneProperty).takeRetainedValue(), identifier)
		let record: AnyObject = ABRecordCopyValue(person, property).takeRetainedValue()
		let label = ABMultiValueCopyLabelAtIndex(record, index).takeRetainedValue()
		var profilePic:UIImage!
//		peoplePicker.displayedProperties = [kABPersonPhoneProperty]
		//stage data for new contact entry
		var imgData = ABPersonCopyImageDataWithFormat(person, kABPersonImageFormatThumbnail)?.takeRetainedValue()
		if imgData != nil {
			profilePic = UIImage(data:imgData!)
		} else {
			profilePic = UIImage(named:  "profpicPDFWhite")
		}
		let name = ABRecordCopyCompositeName(person).takeRetainedValue() as String
		let phone = ABMultiValueCopyValueAtIndex(record,index).takeRetainedValue() as String
		let phoneType = ABAddressBookCopyLocalizedLabel(label).takeRetainedValue() as String
		println("profile pic: \(profilePic)")
		//create new contact entry
		let newEntry:Contacts = Contacts(
			name: name,
			phone: phone,
			phoneType: phoneType,
			photo: UIImagePNGRepresentation(profilePic),
			status: "newCall",
			context: managedObjectContext
		)
	}
}