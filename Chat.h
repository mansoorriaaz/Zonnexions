//
//  Chat.h
//  Zonnexions
//
//  Created by Eka Praditya GK on 12/22/15.
//  Copyright © 2015 EP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>


@interface Chat : RLMObject

@property NSString *chatWith;
@property NSString *message;
@property NSString *timeStamp;
@property bool is_me;


@end

RLM_ARRAY_TYPE(chat)
