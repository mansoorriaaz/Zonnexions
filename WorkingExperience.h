//
//  WorkingExperience.h
//  Zonnexions
//
//  Created by Eka Praditya GK on 6/3/16.
//  Copyright © 2016 EP. All rights reserved.
//

#import <Realm/Realm.h>

@interface WorkingExperience : RLMObject

@property NSString *companyID;
@property NSString *companyName;
@property NSString *companyLocation;
@property NSString *year;
@property bool isShare;

@end

RLM_ARRAY_TYPE(WorkingExperience)
