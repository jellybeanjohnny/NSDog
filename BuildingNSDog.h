//
//  BuildingNSDog.h
//  BuildingNSDog
//
//  Created by Matt Amerige on 7/3/16.
//  Copyright © 2016 Wubbyland. All rights reserved.
//

#import <Foundation/Foundation.h>


#ifdef DEBUG
#define NSDog(args...) ExtendNSLog(args);
#else
#define NSDog(x...)
#endif

void ExtendNSLog(NSString *format, ...);


