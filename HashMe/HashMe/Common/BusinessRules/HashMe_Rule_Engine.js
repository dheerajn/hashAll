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

//Business Rule: Append "#" for a string

var appendHashToString = function(toBeHashedString) {
    var string = toBeHashedString
    string = "#" + string
    return string
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
    return "hashallcontactus@gmail.com";
};

//Business Rule: Contactus email subject
var contactUsEmailSubject = function() {
    return "HashAll-ContactUs";
};
