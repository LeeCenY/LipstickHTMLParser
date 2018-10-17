//
//  CLYSLModel.h
//  LipstickHTMLParser
//
//  Created by TTLGZMAC6 on 2018/10/17.
//  Copyright © 2018 LeeCen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLYSLModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *image;

+ (NSArray *)getYSL;

@end

NS_ASSUME_NONNULL_END
