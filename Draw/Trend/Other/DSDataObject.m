//
//  DSDataObject.m
//  DSBet
//
//  Created by Selena on 2018/1/1.
//  Copyright © 2018年 Bill. All rights reserved.
//

#import "DSDataObject.h"

@implementation DSDataObject


#pragma mark - 序列化 反序列化
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        const char *name = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:name];
        id propertyValue = [self valueForKey:propertyName];
        [aCoder encodeObject:propertyValue forKey:propertyName];
    }
    free(properties);
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self) {
        unsigned int count = 0;
        objc_property_t *properties = class_copyPropertyList([self class], &count);
        for (int i = 0; i < count; i++) {
            objc_property_t property = properties[i];
            const char *name = property_getName(property);
            NSString *propertyName = [NSString stringWithUTF8String:name];
            id propertyValue = [aDecoder decodeObjectForKey:propertyName];
            if (propertyValue) {
                [self setValue:propertyValue forKey:propertyName];
            }
        }
        free(properties);
    }
    return self;
}
- (id)copyWithZone:(NSZone *)zone
{
    DSDataObject * object = [[self class] allocWithZone:zone];
    return object;
}

- (void)parseServerData:(id)data
{
    NSLog(@"子类必须重写");
}


@end
