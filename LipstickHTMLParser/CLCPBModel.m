//
//  CLCPBModel.m
//  LipstickHTMLParser
//
//  Created by TTLGZMAC6 on 2018/10/18.
//  Copyright © 2018 LeeCen. All rights reserved.
//

#import "CLCPBModel.h"

static NSString *const YSLURLString = @"https://www.cledepeau-beaute.com.cn/lipstick.html";

@implementation CLCPBModel

+ (NSArray *)getCPB {
    NSMutableArray *array = [NSMutableArray array];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:YSLURLString]];
    
    NSString *goodList = @"/html/body/div[5]/div[1]/div[2]/div[2]";
    NSString *plpSlideItem = @"div[1]/div/div[2]/ul";

    ONOXMLDocument *doc = [ONOXMLDocument HTMLDocumentWithData:data error:nil];
    ONOXMLElement *element = [doc firstChildWithXPath:goodList];
    
    [element.children enumerateObjectsUsingBlock:^(ONOXMLElement * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

        if (idx == 1) {
            NSString *title =  [obj stringValue];
            NSLog(@"%@", title);
        }
        
        if (idx == 4) {
            ONOXMLElement *children = [obj firstChildWithXPath:plpSlideItem];
            [children.children enumerateObjectsUsingBlock:^(ONOXMLElement * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                CLCPBModel *model = [CLCPBModel initWithHTMLString:obj];
                if (model) {
                    [array addObject:model];
                    NSLog(@"%@ === %@", model.image, model.title);
                }
            }];
        }
    }];
    return array;
}

+ (instancetype)initWithHTMLString:(ONOXMLElement *)element {
    CLCPBModel *model = [[CLCPBModel alloc] init];
    ONOXMLElement *spanElement = [element firstChildWithXPath:@"img"];
    model.image = [@"https://www.cledepeau-beaute.com.cn" stringByAppendingString: [spanElement valueForAttribute:@"src"]];
    model.title = [[element firstChildWithXPath:@"span"] stringValue];
    return model;
}

@end
