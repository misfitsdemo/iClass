#import "DBSDatabaseService.h"
#import "DBSLecture.h"
#import "DBSNote.h"
#import "DBSUser.h"
#import "DBSMessage.h"

NSString *const usersDB = @"http://misfits.iriscouch.com/schoolapp-users/";
NSString *const lecturesDB = @"http://misfits.iriscouch.com/schoolapp-schedules/";
NSString *const notificationsDB = @"http://misfits.iriscouch.com/schoolapp-notifications/";
NSString *const getAll = @"_all_docs?include_docs=true";

@implementation DBSDatabaseService
{
    NSMutableDictionary *users;
    NSMutableDictionary *notifications;
    NSMutableArray *lectures;
}

+ (DBSDatabaseService *)database
{
    // Singleton
    static DBSDatabaseService *database = nil;
    if (!database) {
        database = [[super allocWithZone:nil] init];
    }
    return database;
}

+(id)createDatabase
{
    return [self database];
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self database];
}

-(id)init
{
    return [self initDatabase];
}
-(id)initDatabase
{
    if(self = [super init])
    {
        users = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                 [NSMutableArray array], @"ADMIN",
                 [NSMutableArray array], @"STUDENT", nil];
        notifications = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                         [NSMutableArray array], @"NOTES",
                         [NSMutableArray array], @"MESSAGES", nil];
        lectures = [NSMutableArray array];
    }
    return self;
}

/*********************************************************************
 METHOD : POST LECTURE OBJECT TO LECTURE DATABASE
 ACCEPTS: Lecture object as NSDictionary
 RETURNS: Result NSDictionary response
 *********************************************************************/
-(NSDictionary*) lectureToDataBase:(NSDictionary*)lecture
{
    NSData *tempData;
    if([NSJSONSerialization isValidJSONObject:lecture]) {
        tempData = [NSJSONSerialization dataWithJSONObject:lecture
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:NULL];
    }
    //REQUEST
    NSString *urlString = [NSString stringWithString: lecturesDB];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    NSString *contentType = [NSString stringWithFormat:@"application/json"];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    NSMutableData *postBody = [NSMutableData data];
    [postBody appendData:tempData];
    [request setHTTPBody:postBody];
    
    //RESPONSE
    //RESPONSE
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    NSMutableDictionary *result = [NSJSONSerialization
                                   JSONObjectWithData:responseData
                                   options:NSJSONReadingMutableContainers
                                   error:NULL];
    return result;
}

/*********************************************************************
 METHOD : POST NOTE OBJECT TO NOTIFICATION DATABASE
 ACCEPTS: Note object as NSDictionary
 RETURNS: Result NSDictionary response
 *********************************************************************/
-(NSDictionary*) noteToDataBase:(NSDictionary*)note
{
    NSData *tempData;
    if([NSJSONSerialization isValidJSONObject:note]) {
        tempData = [NSJSONSerialization dataWithJSONObject:note
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:NULL];
    }
    //REQUEST
    NSString *urlString = [NSString stringWithString: notificationsDB];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    NSString *contentType = [NSString stringWithFormat:@"application/json"];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    NSMutableData *postBody = [NSMutableData data];
    [postBody appendData:tempData];
    [request setHTTPBody:postBody];
    
    //RESPONSE
    //RESPONSE
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    NSMutableDictionary *result = [NSJSONSerialization
                                   JSONObjectWithData:responseData
                                   options:NSJSONReadingMutableContainers
                                   error:NULL];
    return result;
}

/*********************************************************************
 METHOD : POST MESSAGE OBJECT TO NOTIFICATION DATABASE
 ACCEPTS: Message object as NSDictionary
 RETURNS: Result NSDictionary response
 *********************************************************************/
-(NSDictionary*) messageToDataBase:(NSDictionary*)message
{
    NSData *tempData;
    if([NSJSONSerialization isValidJSONObject:message]) {
        tempData = [NSJSONSerialization dataWithJSONObject:message
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:NULL];
    }
    //REQUEST
    NSString *urlString = [NSString stringWithString: notificationsDB];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    NSString *contentType = [NSString stringWithFormat:@"application/json"];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    NSMutableData *postBody = [NSMutableData data];
    [postBody appendData:tempData];
    [request setHTTPBody:postBody];
    
    //RESPONSE
    //RESPONSE
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    NSMutableDictionary *result = [NSJSONSerialization
                                   JSONObjectWithData:responseData
                                   options:NSJSONReadingMutableContainers
                                   error:NULL];
    return result;
}

/*********************************************************************
 METHOD : GET ALL USER OBJECTS FROM USERS DATABASE
 ACCEPTS: NONE
 RETURNS: NSDictionary with lists of Student and Admin objects
 *********************************************************************/
-(NSDictionary*)getUsers
{
    //REQUEST
    [[users objectForKey:@"ADMIN"] removeAllObjects];
    [[users objectForKey:@"STUDENT"] removeAllObjects];
    NSString* urlString = [NSString stringWithFormat:@"%@%@", usersDB, getAll];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    NSString* contentType = [NSString stringWithFormat:@"application/json"];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    NSError* error;
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:NULL
                                                     error:&error];
    if(!data) {
        NSLog(@"FAILED: %@", [error localizedDescription]);
        return nil;
    }
    else {
        NSMutableDictionary *usersDic = [NSJSONSerialization
                                         JSONObjectWithData:data
                                         options:NSJSONReadingMutableContainers
                                         error:NULL];
        
        usersDic = [usersDic objectForKey:@"rows"]; // Step into 'rows'
        for (NSDictionary *object in usersDic) {    // Step into JSON array (single index)
            NSDictionary* dict = [object objectForKey:@"doc"]; // Step into 'doc' (current object key/values)
            
            DBSUser* usr = [DBSUser userWithName:[dict objectForKey:@"firstName"]
                                        lastName:[dict objectForKey:@"lastName"]
                                        password:[dict objectForKey:@"password"]
                                     mailAddress:[dict objectForKey:@"mailAddress"]
                                     phoneNumber:[dict objectForKey:@"phoneNumber"]
                                           admin:[dict objectForKey:@"admin"]
                                         courses:[dict objectForKey:@"courses"]];
            
            if([[dict objectForKey:@"admin"]isEqualToString:@"0"]) {
                [[users objectForKey:@"STUDENT"] addObject:usr];
            }
            else {
                [[users objectForKey:@"ADMIN"] addObject:usr];
            }
        }
        return users;
    }
}

/*********************************************************************
 METHOD : GET ALL LECTURE OBJECTS FROM LECTURE DATABASE
 ACCEPTS: NONE
 RETURNS: NSMutableArray list with Lecture objects
 *********************************************************************/
-(NSMutableArray*)getLectures
{
    //REQUEST
    [lectures removeAllObjects];
    NSString* urlString = [NSString stringWithFormat:@"%@%@", lecturesDB, getAll];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    NSString* contentType = [NSString stringWithFormat:@"application/json"];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    NSError* error;
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:NULL
                                                     error:&error];
    if(!data) {
        NSLog(@"FAILED: %@", [error localizedDescription]);
        return nil;
    }
    else {
        NSMutableDictionary *usersDic = [NSJSONSerialization
                                         JSONObjectWithData:data
                                         options:NSJSONReadingMutableContainers
                                         error:NULL];
        
        usersDic = [usersDic objectForKey:@"rows"]; // Step into 'rows'
        for (NSDictionary *object in usersDic) {    // Step into JSON array (single index)
            NSDictionary* dict = [object objectForKey:@"doc"]; // Step into 'doc' (current object key/values)
            DBSLecture* lecture = [DBSLecture courseWithName:[dict objectForKey:@"course"]
                                                     teacher:[dict objectForKey:@"teacher"]
                                                        room:[dict objectForKey:@"room"]
                                                    courseID:[dict objectForKey:@"courseID"]
                                                     version:[dict objectForKey:@"version"]
                                                   startTime:[dict objectForKey:@"startTime"]
                                                    stopTime:[dict objectForKey:@"stopTime"]
                                                        year:[dict objectForKey:@"year"]
                                                  daysOfWeek:[dict objectForKey:@"daysOfWeek"]
                                                       weeks:[dict objectForKey:@"weeks"]
                                                   couchDBId:[dict objectForKey:@"_id"]
                                                  couchDBRev:[dict objectForKey:@"_rev"]];
            [lectures addObject:lecture];
        }
        return lectures;
    }
}
/*********************************************************************
 METHOD : GET ALL NOTE AND MESSAGE OBJECTS FROM NOTIFICATION DATABASE
 ACCEPTS: NONE
 RETURNS: NSDictionary with lists of Note and Message objects
 *********************************************************************/
-(NSDictionary*)getNotifications
{
    //REQUEST
    [[notifications objectForKey:@"NOTES"] removeAllObjects];
    [[notifications objectForKey:@"MESSAGES"] removeAllObjects];
    NSString* urlString = [NSString stringWithFormat:@"%@%@", notificationsDB, getAll];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    NSString* contentType = [NSString stringWithFormat:@"application/json"];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    NSError* error;
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:NULL
                                                     error:&error];
    if(!data) {
        NSLog(@"FAILED: %@", [error localizedDescription]);
        return nil;
    }
    else {
        NSMutableDictionary *noticesDic = [NSJSONSerialization
                                           JSONObjectWithData:data
                                           options:NSJSONReadingMutableContainers
                                           error:NULL];
        
        noticesDic = [noticesDic objectForKey:@"rows"]; // Step into 'rows'
        for (NSDictionary *object in noticesDic) {    // Step into JSON array (single index)
            NSDictionary* dict = [object objectForKey:@"doc"]; // Step into 'doc' (current object key/values)
            if([[dict objectForKey:@"type"]isEqualToString:@"note"]) {
                DBSNote* note = [DBSNote noteWithText:[dict objectForKey:@"text"]
                                                 week:[dict objectForKey:@"week"]
                                                  day:[dict objectForKey:@"day"]
                                             courseID:[dict objectForKey:@"courseID"]];
                [[notifications objectForKey:@"NOTES"] addObject:note];
            }
            else if ([[dict objectForKey:@"type"]isEqualToString:@"message"]){
                DBSMessage* message = [DBSMessage messageWithSender:[dict objectForKey:@"sender"]
                                                           receiver:[dict objectForKey:@"receiver"]
                                                               text:[dict objectForKey:@"text"]];
                [[notifications objectForKey:@"MESSAGES"] addObject:message];
            }
        }
        return notifications;
    }
}

@end

