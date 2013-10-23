#import "DBSMessage.h"

@implementation DBSMessage
{
    NSMutableArray *allReceivers;
}

@synthesize sender = _sender;
@synthesize text = _text;

+(id)messageWithSender:(NSString *)sender
              receiver:(NSArray *)receiver
                  text:(NSString *)text {
    return [[self alloc]initMessageWithSender:sender
                                     receiver:receiver
                                         text:text];
}

-(id)initMessageWithSender:(NSString *)sender
                  receiver:(NSArray *)receiver
                      text:(NSString *)text {
    if(self = [super init]) {
        allReceivers = [NSMutableArray array];
        for (NSDictionary *object in receiver) {
            [allReceivers addObject:object];
        }
        _sender = sender;
        _text = text;
        
    }
    return self;
}

-(NSMutableArray *)receiver {
    return allReceivers;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    NSLog(@"MESSAGE");
    [aCoder encodeObject: _sender forKey:@"sender"];
    [aCoder encodeObject: allReceivers forKey:@"receiver"];
    [aCoder encodeObject: _text forKey:@"text"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        [self setSender:[aDecoder decodeObjectForKey:@"sender"]];
        allReceivers = [aDecoder decodeObjectForKey:@"receiver"];
        [self setText:[aDecoder decodeObjectForKey:@"text"]];
    }
    return self;
}

@end