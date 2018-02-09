//
//  HashMe_Rule_Engine
//
//  This file contains all business rules for Predictions
//
//  Created by Dheeru on 2/08/18.
//  Copyright © 2018 Dheeru. All rights reserved.
//

"use strict";

// Utility function for removing time component from date
Date.prototype.withoutTime = function () {
    var d = new Date(this);
    d.setHours(0, 0, 0, 0);
    return d;
}

// Validate departure and return dates
var validateDates = function (startDate, endDate) {
    var oneDay = 24 * 60 * 60 * 1000; // hours*minutes*seconds*milliseconds
    var durationInDays = Math.round(Math.abs((startDate.getTime() - endDate.getTime()) / (oneDay)));
    var isStartAndEndSame = startDate.withoutTime().getTime() === endDate.withoutTime().getTime();
    var twoYearsFromNowDate = new Date(new Date().setFullYear(new Date().getFullYear() + 2))
    
    //Business Rule 1: No trip duration beyound 30 days
    if (durationInDays > 30) {
        return "Travel duration cannot exceed 30days. You may add a second notification to cover longer periods of travel.";
    }
    
    //Business Rule 2: Could not have same return and departure date
    if (isStartAndEndSame) {
        return "Your Departure Date must be at least one day before the Return date.";
    }
    
    //Business Rule 3: Could not have return date beyond 2 year
    if (endDate > twoYearsFromNowDate) {
        return "Your return date could not exceed two years.";
    }
    return null;
};

//Business Rule: User is allowed to show maximum 10 tags for iPad
var maximumTagsForIpad = function () {
    return 10;
}

//Business Rule: User is allowed to show maximum 7 tags for iPhone
var maximumTagsForIphone = function () {
    return 7;
}

//Business Rule: Contactus email id
var contactUsEmailId = function() {
    return "hashallcontactus@gmail.com"
}

//Business Rule: Contactus email subject
var contactUsEmailSubject = function() {
    return "HashAll-ContactUs"
}
