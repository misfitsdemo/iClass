#import <Foundation/Foundation.h>

@interface DBSMessage : NSObject <NSCoding>

@property (nonatomic, copy) NSString* sender;
@property (nonatomic, copy) NSString* text;

+(id) messageWithSender: (NSString *)sender
               receiver: (NSArray *)receiver
                   text: (NSString *)text;

-(id) initMessageWithSender: (NSString *)sender
                   receiver: (NSArray *)receiver
                       text: (NSString *)text;

-(NSMutableArray *) receiver;

@end
