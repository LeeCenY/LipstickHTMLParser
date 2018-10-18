//
//  CLYSLModel.m
//  LipstickHTMLParser
//
//  Created by TTLGZMAC6 on 2018/10/17.
//  Copyright © 2018 LeeCen. All rights reserved.
//

#import "CLYSLModel.h"
#import <Ono.h>

static NSString *const YSLURLString = @"https://www.yslbeautycn.com/makeup-lipstick";

@implementation CLYSLModel

+ (NSArray *)getYSL {
    NSMutableArray *array = [NSMutableArray array];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:YSLURLString]];
    
    
    NSString *goodList = @"//*[@id='wrapper']/section/article/div/div[2]/div/div[2]/div";
    NSString *plpSlideItem = @"div/div[2]/div[1]/div/div[1]/div";
    NSString *series = @"span";
    

    ONOXMLDocument *doc = [ONOXMLDocument HTMLDocumentWithData:data error:nil];
    ONOXMLElement *element = [doc firstChildWithXPath:goodList];
    [element.children enumerateObjectsUsingBlock:^(ONOXMLElement * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        ONOXMLElement *children = [obj firstChildWithXPath:plpSlideItem];
        [children.children enumerateObjectsUsingBlock:^(ONOXMLElement * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

            NSString *title = [[obj firstChildWithXPath:series] valueForAttribute: @"data-title"];
            NSLog(@"%@", title);
            CLYSLModel *model = [CLYSLModel initWithHTMLString:obj];
            if (model) {
                [array addObject:model];
                NSLog(@"%@ === %@", model.image, model.title);
            }
        }];
    }];
    
    return array;
}

+ (instancetype)initWithHTMLString:(ONOXMLElement *)element {
    CLYSLModel *model = [[CLYSLModel alloc] init];
    ONOXMLElement *spanElement = [element firstChildWithXPath:@"span/img"];
    model.image = [spanElement valueForAttribute:@"src"];
    model.title = [spanElement valueForAttribute:@"title"];
    return model;
}

- (void)setTitle:(NSString *)title {

    self.title = [[[[[title stringByReplacingOccurrencesOfString:@"N°" withString:@""] stringByReplacingOccurrencesOfString:@" (HOT)" withString:@""] stringByReplacingOccurrencesOfString:@"（HOT）" withString:@""] stringByReplacingOccurrencesOfString:@" (热卖)" withString:@""] stringByReplacingOccurrencesOfString:@"(热卖)" withString:@""];
    
}

@end
