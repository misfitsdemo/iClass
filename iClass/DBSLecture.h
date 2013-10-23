#import <Foundation/Foundation.h>

@interface DBSLecture : NSObject <NSCoding>

@property (nonatomic, copy) NSString *couchDBId;
@property (nonatomic, copy) NSString *couchDBRev;

@property (nonatomic, copy) NSString *course;
@property (nonatomic, copy) NSString *teacher;
@property (nonatomic, copy) NSString *room;
@property (nonatomic, copy) NSString *courseID;
@property (nonatomic, copy) NSString *version;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *stopTime;
@property (nonatomic, copy) NSString *year;

+ (id) courseWithName: (NSString *)course
              teacher: (NSString *)teacher
                 room: (NSString *)room
             courseID: (NSString *)courseID
              version: (NSString *)version
            startTime: (NSString *)startTime
             stopTime: (NSString *)stopTime
                 year: (NSString *)year
           daysOfWeek: (NSArray *)daysOfWeek
                weeks: (NSArray *)weeks
            couchDBId: (NSString *) couchDBId
           couchDBRev: (NSString *) couchDBRev;

- (id) initCourseWithName: (NSString *)course
                  teacher: (NSString *)teacher
                     room: (NSString *)room
                 courseID: (NSString *)courseID
                  version: (NSString *)version
                startTime: (NSString *)startTime
                 stopTime: (NSString *)stopTime
                     year: (NSString *)year
               daysOfWeek: (NSArray *)daysOfWeek
                    weeks: (NSArray *)weeks
                couchDBId: (NSString *) couchDBId
               couchDBRev: (NSString *) couchDBRev;

-(NSDictionary*) asDictionary;

-(NSMutableArray *)daysOfWeek;

-(NSMutableArray *)weeks;

@end
