//
//  DSDataObject.h
//  DSBet
//
//  Created by Selena on 2018/1/1.
//  Copyright © 2018年 Bill. All rights reserved.
//
#import "objc/runtime.h"

//解析 Longlong类型的

#define PARSE_SERVER_LONG_LONG(_PropertyName,_JsonKey,_JsonSource)   id _PropertyName = _JsonSource[_JsonKey];\
if (IS_NUMBER(_PropertyName)) {\
self._PropertyName = [_PropertyName longLongValue];\
}

//解析 Long类型的
#define PARSE_SERVER_LONG(_PropertyName,_JsonKey,_JsonSource)   id _PropertyName = _JsonSource[_JsonKey];\
if (IS_NUMBER(_PropertyName)) {\
self._PropertyName = [_PropertyName longValue];\
}

//解析NSString
#define PARSE_SERVER_STRING(_PropertyName,_JsonKey,_JsonSource)   id _PropertyName = _JsonSource[_JsonKey];\
if (IS_STRING(_PropertyName)) {\
self._PropertyName = _PropertyName;\
}


//解析NSInteger
#define PARSE_SERVER_INTEGER(_PropertyName,_JsonKey,_JsonSource)   id _PropertyName = _JsonSource[_JsonKey];\
if (IS_NUMBER(_PropertyName)) {\
self._PropertyName = [_PropertyName integerValue];\
}

//解析CGFloat
#define PARSE_SERVER_FLOAT(_PropertyName,_JsonKey,_JsonSource)   id _PropertyName = _JsonSource[_JsonKey];\
if (IS_NUMBER(_PropertyName)) {\
self._PropertyName = [_PropertyName floatValue];\
}

//解析double
#define PARSE_SERVER_DOUBLE(_PropertyName,_JsonKey,_JsonSource)   id _PropertyName = _JsonSource[_JsonKey];\
if (IS_NUMBER(_PropertyName)) {\
self._PropertyName = [_PropertyName doubleValue];\
}




//解析ID
#define PARSE_SERVER_ID_WITH_KEY(_PropertyName,_JsonKey,_JsonSource)   id _PropertyName = _JsonSource[_JsonKey];\
if (IS_NUMBER(_PropertyName)) {\
self._PropertyName = [_PropertyName longLongValue];\
}

#define PARSE_SERVER_ID(_PropertyName,_JsonSource) PARSE_SERVER_ID_WITH_KEY(_PropertyName,@"id",_JsonSource)


//解析时间
#define PARSE_SERVER_TIME_WITH_KEY(_PropertyName,_JsonKey,_JsonSource)   id _PropertyName = _JsonSource[_JsonKey];\
if (IS_NUMBER(_PropertyName)) {\
self._PropertyName = [_PropertyName longLongValue] / TIME_PRECISION;\
}


#define PARSE_SERVER_TIME(_PropertyName,_JsonSource) PARSE_SERVER_TIME_WITH_KEY(_PropertyName,@"time",_JsonSource)



//解析经纬度
#define PARSE_SERVER_LAT_LNG_WITH_KEY(_PropertyName,_JsonKey,_JsonSource)   id _PropertyName = _JsonSource[_JsonKey];\
if (IS_NUMBER(_PropertyName)) {\
self._PropertyName = [_PropertyName longLongValue] / LOCATION_PRECISION;\
}


#define PARSE_SERVER_LAT_WITH_KEY(_PropertyName,_JsonSource) PARSE_SERVER_LAT_LNG_WITH_KEY(_PropertyName,@"lat",_JsonSource)

#define PARSE_SERVER_LNG_WITH_KEY(_PropertyName,_JsonSource) PARSE_SERVER_LAT_LNG_WITH_KEY(_PropertyName,@"lng",_JsonSource)

//序列化 反序列化宏
#undef    ENCODE_DECODER_IMP
#define ENCODE_DECODER_IMP \
- (void)encodeWithCoder:(NSCoder *)aCoder \
{\
[super encodeWithCoder:aCoder];\
unsigned int count = 0;\
objc_property_t *properties = class_copyPropertyList([self class], &count);\
for (int i = 0; i < count; i++) {\
objc_property_t property = properties[i];\
const char *name = property_getName(property);\
NSString *propertyName = [NSString stringWithUTF8String:name];\
id propertyValue = [self valueForKey:propertyName];\
[aCoder encodeObject:propertyValue forKey:propertyName];\
}\
free(properties);\
}\
\
- (id)initWithCoder:(NSCoder *)aDecoder\
{\
self = [super initWithCoder:aDecoder];\
if (self) {\
unsigned int count = 0;\
objc_property_t *properties = class_copyPropertyList([self class], &count);\
for (int i = 0; i < count; i++) {\
objc_property_t property = properties[i];\
const char *name = property_getName(property);\
NSString *propertyName = [NSString stringWithUTF8String:name];\
id propertyValue = [aDecoder decodeObjectForKey:propertyName];\
if (propertyValue) {\
[self setValue:propertyValue forKey:propertyName];\
}\
}\
free(properties);\
}\
return self;\
}
#import <Foundation/Foundation.h>

@interface DSDataObject : NSObject <NSCoding,NSCopying>
//为了处理新的序列化反序列化实现方法， 继承此类的实体不需要重写序列化反序列化方法
/**
 *  解析数据
 *
 *  @param data 原始数据
 */
- (void)parseServerData:(id)data;


- (void)encodeWithCoder:(NSCoder *)aCoder;
- (id)initWithCoder:(NSCoder *)aDecoder;
- (id)copyWithZone:(NSZone *)zone;


@end
