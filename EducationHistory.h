//
//  EducationHistory.h
//  Zonnexions
//
//  Created by Eka Praditya GK on 6/3/16.
//  Copyright © 2016 EP. All rights reserved.
//

#import <Realm/Realm.h>

@interface EducationHistory : RLMObject

@property NSString *educationID;
@property NSString *educationLevel;
@property NSString *educationName;
@property NSString *educationLocation;
@property NSString *year;
@property bool isShare;

@end

RLM_ARRAY_TYPE(EducationExperience)
