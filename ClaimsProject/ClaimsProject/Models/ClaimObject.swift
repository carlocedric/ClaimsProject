//
//  ClaimObject.swift
//  ClaimsProject
//
//  Created by Lijauco, Carlo Cedric on 07/09/2016.
//  Copyright © 2016 arvato. All rights reserved.
//

import UIKit

enum InfoStatus{
    case green
    case yellow
    case red
}

enum ClaimType:String{
    case dental = "Dental"
    case dependentPass = "DependentPass"
    case insurancePlan = "Insurance Plan"
    case internet = "Internet"
    case ITGadget = "IT Gadget"
    case learning = "Learning"
    case leave = "Leave"
    case maternity = "Maternity"
    case optical = "Optical"
    case medical = "Medical"
    case passportRenewal = "Passport Renewal"
    case travel = "Travel"
}

enum CurrencyType{
    case myr
    case usd
    case eur
    case php
    case rmb
}

class ClaimObject {
    var status:InfoStatus?
    var post:Bool = false
    var documentDate:NSDate?
    var claimType:ClaimType?
    var costCenter = ""
    var projectID = ""
    var GSTRelevant = ""
    var currencyKey:CurrencyType?
    var rate:Double?
    var amount:Double?
    var itemText = ""

    init(status:InfoStatus?,post:Bool,documentDate:NSDate,claimtype:ClaimType,costCenter:String,projectID:String,GSTRelevant:String,currencyKey:CurrencyType,rate:Double,amount:Double,itemText:String){
        self.status = status
        self.post = post
        self.documentDate = documentDate
        self.claimType = claimtype
        self.costCenter = costCenter
        self.projectID = projectID
        self.GSTRelevant = GSTRelevant
        self.currencyKey = currencyKey
        self.rate = rate
        self.amount = amount
        self.itemText = itemText
    }
}

