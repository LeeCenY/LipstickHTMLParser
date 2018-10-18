//
//  CLChanelModel.m
//  LipstickHTMLParser
//
//  Created by TTLGZMAC6 on 2018/10/18.
//  Copyright © 2018 LeeCen. All rights reserved.
//

#import "CLChanelModel.h"

static NSString *const URLString = @"https://www.chanel.cn/zh_CN/fragrance-beauty/makeup/p/lips.html";

@implementation CLChanelModel

+ (NSArray *)getChanel {
    NSMutableArray *array = [NSMutableArray array];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:URLString]];
    
    NSString *goodList = @"//*[@id='fnb_products-grid']/div[1]";
    NSString *plpSlideItem = @"div/article/div[3]/div";
    
    ONOXMLDocument *doc = [ONOXMLDocument HTMLDocumentWithData:data error:nil];
    ONOXMLElement *element = [doc firstChildWithXPath:goodList];

    [element.children enumerateObjectsUsingBlock:^(ONOXMLElement * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ONOXMLElement *children = [obj firstChildWithXPath:plpSlideItem];
        [children.children enumerateObjectsUsingBlock:^(ONOXMLElement * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CLChanelModel *model = [CLChanelModel initWithHTMLString:obj];
            if (model) {
                [array addObject:model];
                NSLog(@"%@ === %@", model.image, model.title);
            }
        }];
    }];
    return array;
}

+ (instancetype)initWithHTMLString:(ONOXMLElement *)element {
    CLChanelModel *model = [[CLChanelModel alloc] init];
    ONOXMLElement *spanElement = [element firstChildWithXPath:@"img"];
    model.image = [@"https://www.chanel.cn" stringByAppendingString: [spanElement valueForAttribute:@"src"]];
    model.title = [spanElement valueForAttribute:@"alt"];
    return model;
}



@end
