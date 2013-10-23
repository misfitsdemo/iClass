#import "DBSLecture.h"

@implementation DBSLecture {
    NSMutableArray *lessonDays;
    NSMutableArray *lessonWeeks;
}

@synthesize couchDBId = _couchDBId;
@synthesize couchDBRev = _couchDBRev;

@synthesize course = _course;
@synthesize teacher = _teacher;
@synthesize room = _room;
@synthesize courseID = _courseID;
@synthesize version = _version;
@synthesize startTime = _startTime;
@synthesize stopTime = _stopTime;
@synthesize year = _year;

+(id) courseWithName:(NSString *)course
             teacher: (NSString*)teacher
                room: (NSString*)room
            courseID:(NSString *)courseID
             version:(NSString *)version
           startTime:(NSString *)startTime
            stopTime:(NSString *)stopTime
                year:(NSString *)year
          daysOfWeek:(NSArray *)daysOfWeek
               weeks:(NSArray *)weeks
           couchDBId: (NSString *) couchDBId
          couchDBRev: (NSString *) couchDBRev{
    return [[self alloc]initCourseWithName:course
                                   teacher:teacher
                                      room:room
                                  courseID:courseID
                                   version:version
                                 startTime:startTime
                                  stopTime:stopTime
                                      year:year
                                daysOfWeek:daysOfWeek
                                     weeks:weeks
                                 couchDBId:couchDBId
                                couchDBRev:couchDBRev];
}

-(id) initCourseWithName:(NSString *)course
                 teacher:(NSString*)teacher
                    room:(NSString*)room
                courseID:(NSString *)courseID
                 version:(NSString *)version
               startTime:(NSString *)startTime
                stopTime:(NSString *)stopTime
                    year:(NSString *)year
              daysOfWeek:(NSArray *)daysOfWeek
                   weeks:(NSArray *)weeks
               couchDBId:(NSString *) couchDBId
              couchDBRev:(NSString *) couchDBRev; {
    if(self = [super init]) {
        
        lessonDays = [NSMutableArray array];
        for (NSDictionary *object in daysOfWeek) {
            [lessonDays addObject:object];
        }
        lessonWeeks = [NSMutableArray array];
        for (NSDictionary *object in weeks) {
            [lessonWeeks addObject:object];
        }
        
        _course = course;
        _teacher = teacher;
        _room = room;
        _courseID = courseID;
        _version = version;
        _startTime = startTime;
        _stopTime = stopTime;
        _year = year;
        _couchDBId = couchDBId;
        _couchDBRev = couchDBRev;
    }
    return self;
}

-(NSDictionary*) asDictionary {
    
    if (self.couchDBId) {
        return [NSDictionary dictionaryWithObjectsAndKeys:self.course, @"course",
                self.teacher, @"teacher",
                self.room, @"room",
                self.courseID, @"courseID",
                self.version, @"version",
                self.startTime, @"startTime",
                self.stopTime, @"stopTime",
                self.year, @"year",
                self.couchDBId, @"_id",
                self.couchDBRev, @"_rev",
                lessonDays, @"lessondays",
                lessonWeeks, @"lessonWeeks",
                nil];
    }
    else {
        return [NSDictionary dictionaryWithObjectsAndKeys:self.course, @"course",
                self.teacher, @"teacher",
                self.room, @"room",
                self.courseID, @"courseID",
                self.version, @"version",
                self.startTime, @"startTime",
                self.stopTime, @"stopTime",
                self.year, @"year",
                lessonDays, @"lessondays",
                lessonWeeks, @"lessonWeeks",
                nil];
    }
}


-(NSMutableArray *)daysOfWeek {
    return lessonDays;
}

-(NSMutableArray *)weeks {
    return lessonWeeks;
}

-(NSString *)description {
    return [NSString stringWithFormat:@"\nCourse: %@, \nTeacher: %@, \nRoom: %@, \nCourseID: %@, \nVersion: %@, \nTime: %@-%@, \nYear: %@, \nDays: %@ \nWeeks: %@",
            self.course,
            self.teacher,
            self.room,
            self.courseID,
            self.version,
            self.startTime,
            self.stopTime,
            self.year,
            [lessonDays componentsJoinedByString:@", "], [lessonWeeks componentsJoinedByString:@", "]];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject: _courseID forKey:@"courseID"];
    [aCoder encodeObject: _version forKey:@"version"];
    [aCoder encodeObject: _course forKey:@"course"];
    [aCoder encodeObject: _teacher forKey:@"teacher"];
    [aCoder encodeObject: _room forKey:@"room"];
    [aCoder encodeObject: _startTime forKey:@"startTime"];
    [aCoder encodeObject: _stopTime forKey:@"stopTime"];
    [aCoder encodeObject: _stopTime forKey:@"year"];
    [aCoder encodeObject: lessonDays forKey:@"daysOfWeek"];
    [aCoder encodeObject: lessonWeeks forKey:@"weeks"];
    
    [aCoder encodeObject: _couchDBId forKey:@"couchDBId"];
    [aCoder encodeObject: _couchDBRev forKey:@"couchDBRev"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        [self setCourseID:[aDecoder decodeObjectForKey:@"courseID"]];
        [self setVersion:[aDecoder decodeObjectForKey:@"version"]];
        [self setCourse:[aDecoder decodeObjectForKey:@"course"]];
        [self setTeacher:[aDecoder decodeObjectForKey:@"teacher"]];
        [self setRoom:[aDecoder decodeObjectForKey:@"room"]];
        [self setStartTime:[aDecoder decodeObjectForKey:@"startTime"]];
        [self setStopTime:[aDecoder decodeObjectForKey:@"stopTime"]];
        lessonDays = [aDecoder decodeObjectForKey:@"daysOfWeek"];
        lessonWeeks = [aDecoder decodeObjectForKey:@"weeks"];
        
        [self setCouchDBId:[aDecoder decodeObjectForKey:@"couchDBId"]];
        [self setCouchDBRev:[aDecoder decodeObjectForKey:@"couchDBRev"]];
    }
    return self;
}


@end
