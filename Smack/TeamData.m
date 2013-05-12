//
//  TeamData.m
//  FifaSmack
//
//  Created by Zack Ulrich on 1/4/13.
//
//

#import "TeamData.h"
#import "Parse/Parse.h"
#import "SVProgressHUD.h"


@implementation TeamData

static TeamData *myTeamData;
-(id)init
{
    if(self == [super init])
    {
        imageDictionary = [[NSMutableDictionary alloc] init];
        [self initArray];
        [self loadTeamDataFromParse];
    }
    
    return self;
}
    
+(TeamData *)FifaTeams
{
    static dispatch_once_t once;
    dispatch_once(&once, ^ { myTeamData = [[self alloc] init]; });
    return myTeamData;
}

-(NSData *)getImageForTeamName:(NSString *)name
{
    return [imageDictionary objectForKey:name];
}

-(void)startLoading
{//used to init the fifa teams
    
}
-(void)loadTeamDataFromParse
{
    PFQuery *query = [PFQuery queryWithClassName:@"FifaTeams"];
    query.cachePolicy = kPFCachePolicyCacheElseNetwork;
//    [query whereKey:@"name" equalTo:@""];
    query.limit = 25;
    NSLog(@"IN cache %d", [query hasCachedResult]);
    [SVProgressHUD showWithStatus:@"Loading Team Data"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (!error)
        {
            NSLog(@"Successfully retrieved %d TESTING.", objects.count);
            for (int i = 0; i < [objects count]; i++)
            {
                
                PFObject *obj = [objects objectAtIndex:i];
                if(obj!= nil)
                {
                    NSString *imageName = [obj objectForKey:@"name"];
                    NSLog(@"Queried image name is: %@ index is %d", imageName, i);                    
                    PFFile *theFile = [obj objectForKey:@"logo"];
                    NSData *imageData = [theFile getData];
                    if(imageData != nil)
                    {
//                        NSLog(@"Added name: %@ , at index: %d", imageName, i);
                        [imageDictionary setObject:imageData forKey:imageName];
                    }
                }
                
            }
            
        } else {
            // The network was inaccessible and we have no cached data for
            // this query.
            NSLog(@"Error getting team data: %@ %@", error, [error userInfo]);
            [SVProgressHUD showErrorWithStatus:@"Team Images Load Error"];
        }
        [SVProgressHUD showSuccessWithStatus:@"Done Enjoy"];
        
    }];
 
    
}

-(void)initArray
{
        teamInfo = [[NSMutableArray alloc] initWithObjects:
                      
                      [[Team alloc] initWithName:@"Adelaide United" andLeague:@"Australia A-League" andImage:@"s111393.png" andCountry:@"Australia"],
                      [[Team alloc] initWithName:@"Brisbane Roar" andLeague:@"Australia A-League" andImage:@"s111395.png" andCountry:@"Australia"],
                      [[Team alloc] initWithName:@"Central Coast" andLeague:@"Australia A-League" andImage:@"s111396.png" andCountry:@"Australia"],
                      [[Team alloc] initWithName:@"Gold Coast Utd" andLeague:@"Australia A-League" andImage:@"s112078.png" andCountry:@"Australia"],
                      [[Team alloc] initWithName:@"Melb. Victory" andLeague:@"Australia A-League" andImage:@"s111397.png" andCountry:@"Australia"],
                      [[Team alloc] initWithName:@"Melbourne Heart" andLeague:@"Australia A-League" andImage:@"s112224.png" andCountry:@"Australia"],
                      [[Team alloc] initWithName:@"Newcastle Jets" andLeague:@"Australia A-League" andImage:@"s111398.png" andCountry:@"Australia"],
                      [[Team alloc] initWithName:@"Perth Glory" andLeague:@"Australia A-League" andImage:@"s111399.png" andCountry:@"Australia"],
                      [[Team alloc] initWithName:@"Sydney FC" andLeague:@"Australia A-League" andImage:@"s111400.png" andCountry:@"Australia"],
                      [[Team alloc] initWithName:@"Well. Pheonix" andLeague:@"Australia A-League" andImage:@"s111766.png" andCountry:@"Australia"],
                      [[Team alloc] initWithName:@"Admira" andLeague:@"Austria A. Bundesliga" andImage:@"s111821.png" andCountry:@"Austria"],
                      [[Team alloc] initWithName:@"FK Austria" andLeague:@"Austria A. Bundesliga" andImage:@"s256.png" andCountry:@"Austria"],
                      [[Team alloc] initWithName:@"Innsbruck" andLeague:@"Austria A. Bundesliga" andImage:@"s2045.png" andCountry:@"Austria"],
                      [[Team alloc] initWithName:@"KSV 1919" andLeague:@"Austria A. Bundesliga" andImage:@"s15011.png" andCountry:@"Austria"],
                      [[Team alloc] initWithName:@"RB Salzburg" andLeague:@"Austria A. Bundesliga" andImage:@"s191.png" andCountry:@"Austria"],
                      [[Team alloc] initWithName:@"SK Rapid Wien" andLeague:@"Austria A. Bundesliga" andImage:@"s254.png" andCountry:@"Austria"],
                      [[Team alloc] initWithName:@"SK Sturm Graz" andLeague:@"Austria A. Bundesliga" andImage:@"s209.png" andCountry:@"Austria"],
                      [[Team alloc] initWithName:@"SV Mattersburg" andLeague:@"Austria A. Bundesliga" andImage:@"s1785.png" andCountry:@"Austria"],
                      [[Team alloc] initWithName:@"SV Ried" andLeague:@"Austria A. Bundesliga" andImage:@"s780.png" andCountry:@"Austria"],
                      [[Team alloc] initWithName:@"Wiener Neustadt" andLeague:@"Austria A. Bundesliga" andImage:@"s111373.png" andCountry:@"Austria"],
                      [[Team alloc] initWithName:@"Beerschot AC" andLeague:@"Belgium Pro League" andImage:@"s675.png" andCountry:@"Belgium"],
                      [[Team alloc] initWithName:@"Cercle Brugge" andLeague:@"Belgium Pro League" andImage:@"s1750.png" andCountry:@"Belgium"],
                      [[Team alloc] initWithName:@"Club Brugge" andLeague:@"Belgium Pro League" andImage:@"s231.png" andCountry:@"Belgium"],
                      [[Team alloc] initWithName:@"KAA Gent" andLeague:@"Belgium Pro League" andImage:@"s674.png" andCountry:@"Belgium"],
                      [[Team alloc] initWithName:@"KRC Genk" andLeague:@"Belgium Pro League" andImage:@"s673.png" andCountry:@"Belgium"],
                      [[Team alloc] initWithName:@"KV Kortrijk" andLeague:@"Belgium Pro League" andImage:@"s100081.png" andCountry:@"Belgium"],
                      [[Team alloc] initWithName:@"KV Mechelen" andLeague:@"Belgium Pro League" andImage:@"s110724.png" andCountry:@"Belgium"],
                      [[Team alloc] initWithName:@"KVC Westerlo" andLeague:@"Belgium Pro League" andImage:@"s681.png" andCountry:@"Belgium"],
                      [[Team alloc] initWithName:@"Lierse SK" andLeague:@"Belgium Pro League" andImage:@"s239.png" andCountry:@"Belgium"],
                      [[Team alloc] initWithName:@"OHL" andLeague:@"Belgium Pro League" andImage:@"s100087.png" andCountry:@"Belgium"],
                      [[Team alloc] initWithName:@"RAEC Mons" andLeague:@"Belgium Pro League" andImage:@"s1747.png" andCountry:@"Belgium"],
                      [[Team alloc] initWithName:@"RSC Anderlecht" andLeague:@"Belgium Pro League" andImage:@"s229.png" andCountry:@"Belgium"],
                      [[Team alloc] initWithName:@"Sint-Truidense" andLeague:@"Belgium Pro League" andImage:@"s680.png" andCountry:@"Belgium"],
                      [[Team alloc] initWithName:@"Sport. Lokeren" andLeague:@"Belgium Pro League" andImage:@"s2007.png" andCountry:@"Belgium"],
                      [[Team alloc] initWithName:@"Standard Liege" andLeague:@"Belgium Pro League" andImage:@"s232.png" andCountry:@"Belgium"],
                      [[Team alloc] initWithName:@"Zulte-Waregem" andLeague:@"Belgium Pro League" andImage:@"s15005.png" andCountry:@"Belgium"],
                      [[Team alloc] initWithName:@"A. Goiania" andLeague:@"Brazil Liga do Brasil" andImage:@"s112119.png" andCountry:@"Brazil"],
                      [[Team alloc] initWithName:@"A. Minas G. " andLeague:@"Brazil Liga do Brasil" andImage:@"s112001.png" andCountry:@"Brazil"],
                      [[Team alloc] initWithName:@"A.Florianopolis" andLeague:@"Brazil Liga do Brasil" andImage:@"s111976.png" andCountry:@"Brazil"],
                      [[Team alloc] initWithName:@"Atl. Mineiro" andLeague:@"Brazil Liga do Brasil" andImage:@"s1035.png" andCountry:@"Brazil"],
                      [[Team alloc] initWithName:@"Atl. Paranaense" andLeague:@"Brazil Liga do Brasil" andImage:@"s1039.png" andCountry:@"Brazil"],
                      [[Team alloc] initWithName:@"Bahia" andLeague:@"Brazil Liga do Brasil" andImage:@"s1598.png" andCountry:@"Brazil"],
                      [[Team alloc] initWithName:@"Botafogo" andLeague:@"Brazil Liga do Brasil" andImage:@"s517.png" andCountry:@"Brazil"],
                      [[Team alloc] initWithName:@"C. Nordeste" andLeague:@"Brazil Liga do Brasil" andImage:@"s111059.png" andCountry:@"Brazil"],
                      [[Team alloc] initWithName:@"Corinthians" andLeague:@"Brazil Liga do Brasil" andImage:@"s1041.png" andCountry:@"Brazil"],
                      [[Team alloc] initWithName:@"Coritiba" andLeague:@"Brazil Liga do Brasil" andImage:@"s111044.png" andCountry:@"Brazil"],
                      [[Team alloc] initWithName:@"Cruzeiro" andLeague:@"Brazil Liga do Brasil" andImage:@"s568.png" andCountry:@"Brazil"],
                      [[Team alloc] initWithName:@"Flamengo" andLeague:@"Brazil Liga do Brasil" andImage:@"s1043.png" andCountry:@"Brazil"],
                      [[Team alloc] initWithName:@"Fluminense" andLeague:@"Brazil Liga do Brasil" andImage:@"s567.png" andCountry:@"Brazil"],
                      [[Team alloc] initWithName:@"Gremio" andLeague:@"Brazil Liga do Brasil" andImage:@"s1629.png" andCountry:@"Brazil"],
                      [[Team alloc] initWithName:@"I. Porto Alegre" andLeague:@"Brazil Liga do Brasil" andImage:@"s1048.png" andCountry:@"Brazil"],
                      [[Team alloc] initWithName:@"Palmeiras" andLeague:@"Brazil Liga do Brasil" andImage:@"s383.png" andCountry:@"Brazil"],
                      [[Team alloc] initWithName:@"Santa Catarina" andLeague:@"Brazil Liga do Brasil" andImage:@"s11104.png" andCountry:@"Brazil"],
                      [[Team alloc] initWithName:@"Santos" andLeague:@"Brazil Liga do Brasil" andImage:@"s110144.png" andCountry:@"Brazil"],
                      [[Team alloc] initWithName:@"Sao Paulo" andLeague:@"Brazil Liga do Brasil" andImage:@"s598.png" andCountry:@"Brazil"],
                      [[Team alloc] initWithName:@"Vasco da Gama" andLeague:@"Brazil Liga do Brasil" andImage:@"s569.png" andCountry:@"Brazil"],
                      [[Team alloc] initWithName:@"Aalborg BK" andLeague:@"Denmark Superliga" andImage:@"s820.png" andCountry:@"Denmark"],
                      [[Team alloc] initWithName:@"Aarhus GF" andLeague:@"Denmark Superliga" andImage:@"s271.png" andCountry:@"Denmark"],
                      [[Team alloc] initWithName:@"AC Horsens" andLeague:@"Denmark Superliga" andImage:@"s1446.png" andCountry:@"Denmark"],
                      [[Team alloc] initWithName:@"Brondby IF" andLeague:@"Denmark Superliga" andImage:@"s269.png" andCountry:@"Denmark"],
                      [[Team alloc] initWithName:@"FC Kobenhavn" andLeague:@"Denmark Superliga" andImage:@"s819.png" andCountry:@"Denmark"],
                      [[Team alloc] initWithName:@"FC Midtjylland" andLeague:@"Denmark Superliga" andImage:@"s1516.png" andCountry:@"Denmark"],
                      [[Team alloc] initWithName:@"FC Nordsjaelland" andLeague:@"Denmark Superliga" andImage:@"s1788.png" andCountry:@"Denmark"],
                      [[Team alloc] initWithName:@"HB Koge" andLeague:@"Denmark Superliga" andImage:@"s826.png" andCountry:@"Denmark"],
                      [[Team alloc] initWithName:@"Lyngby BK" andLeague:@"Denmark Superliga" andImage:@"s15001.png" andCountry:@"Denmark"],
                      [[Team alloc] initWithName:@"Odense Boldklub" andLeague:@"Denmark Superliga" andImage:@"s272.png" andCountry:@"Denmark"],
                      [[Team alloc] initWithName:@"Silkeborg IF" andLeague:@"Denmark Superliga" andImage:@"s270.png" andCountry:@"Denmark"],
                      [[Team alloc] initWithName:@"SonderjyskE" andLeague:@"Denmark Superliga" andImage:@"s1447.png" andCountry:@"Denmark"],
                      [[Team alloc] initWithName:@"Arsenal" andLeague:@"England Barclays PL" andImage:@"s1.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Aston Villa" andLeague:@"England Barclays PL" andImage:@"s2.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Blackburn Rvrs" andLeague:@"England Barclays PL" andImage:@"s3.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Bolton" andLeague:@"England Barclays PL" andImage:@"s4.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Chelsea" andLeague:@"England Barclays PL" andImage:@"s5.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Everton" andLeague:@"England Barclays PL" andImage:@"s7.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Fulham" andLeague:@"England Barclays PL" andImage:@"s144.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Liverpool" andLeague:@"England Barclays PL" andImage:@"s9.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Manchester City" andLeague:@"England Barclays PL" andImage:@"s10.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Manchester Utd" andLeague:@"England Barclays PL" andImage:@"s11.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Newcastle Utd" andLeague:@"England Barclays PL" andImage:@"s13.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Norwich City" andLeague:@"England Barclays PL" andImage:@"s1792.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"QPR" andLeague:@"England Barclays PL" andImage:@"s15.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Stoke City" andLeague:@"England Barclays PL" andImage:@"s1806.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Sunderland" andLeague:@"England Barclays PL" andImage:@"s106.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Swansea City" andLeague:@"England Barclays PL" andImage:@"s1960.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Tottenham" andLeague:@"England Barclays PL" andImage:@"s18.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"West Brom" andLeague:@"England Barclays PL" andImage:@"s109.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Wigan Athletic" andLeague:@"England Barclays PL" andImage:@"s1917.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Wolverhampton" andLeague:@"England Barclays PL" andImage:@"s110.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Barnsley" andLeague:@"England npower Champ." andImage:@"s1932.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Birmingham City" andLeague:@"England npower Champ." andImage:@"s88.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Blackpool" andLeague:@"England npower Champ." andImage:@"s1926.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Brighton" andLeague:@"England npower Champ." andImage:@"s1808.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Bristol City" andLeague:@"England npower Champ." andImage:@"s1919.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Burnley" andLeague:@"England npower Champ." andImage:@"s1796.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Cardiff City" andLeague:@"England npower Champ." andImage:@"s1961.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Coventry City" andLeague:@"England npower Champ." andImage:@"s1800.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Crystal Palace" andLeague:@"England npower Champ." andImage:@"s1799.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Derby County" andLeague:@"England npower Champ." andImage:@"s91.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Doncaster" andLeague:@"England npower Champ." andImage:@"s142.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Hull City" andLeague:@"England npower Champ." andImage:@"s1952.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Ipswich Town" andLeague:@"England npower Champ." andImage:@"s94.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Leeds United" andLeague:@"England npower Champ." andImage:@"s8.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Leicester City" andLeague:@"England npower Champ." andImage:@"s95.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Middlesbrough" andLeague:@"England npower Champ." andImage:@"s12.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Millwall" andLeague:@"England npower Champ." andImage:@"s97.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Nott'm Forest" andLeague:@"England npower Champ." andImage:@"s14.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Peterborough" andLeague:@"England npower Champ." andImage:@"s1938.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Portsmouth" andLeague:@"England npower Champ." andImage:@"s1790.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Reading" andLeague:@"England npower Champ." andImage:@"s1793.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Southampton" andLeague:@"England npower Champ." andImage:@"s17.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Watford" andLeague:@"England npower Champ." andImage:@"s1795.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"West Ham" andLeague:@"England npower Champ." andImage:@"s19.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Bournemouth" andLeague:@"England npower League 1" andImage:@"s1943.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Brentford" andLeague:@"England npower League 1" andImage:@"s1925.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Bury" andLeague:@"England npower League 1" andImage:@"s1945.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Carlisle United" andLeague:@"England npower League 1" andImage:@"s1480.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Charlton Ath" andLeague:@"England npower League 1" andImage:@"s89.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Chesterfield" andLeague:@"England npower League 1" andImage:@"s1924.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Colchester" andLeague:@"England npower League 1" andImage:@"s1935.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Exeter City" andLeague:@"England npower League 1" andImage:@"s143.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Hartlepool" andLeague:@"England npower League 1" andImage:@"s1941.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Huddersfield" andLeague:@"England npower League 1" andImage:@"s1939.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Leyton Orient" andLeague:@"England npower League 1" andImage:@"s1958.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"MK Dons" andLeague:@"England npower League 1" andImage:@"s1798.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Notts County" andLeague:@"England npower League 1" andImage:@"s1937.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Oldham Athletic" andLeague:@"England npower League 1" andImage:@"s1920.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Preston" andLeague:@"England npower League 1" andImage:@"s1801.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Rochdale" andLeague:@"England npower League 1" andImage:@"s1955.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Scunthorpe Utd" andLeague:@"England npower League 1" andImage:@"s1949.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Sheffield Utd" andLeague:@"England npower League 1" andImage:@"s1794.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Sheffield Wed" andLeague:@"England npower League 1" andImage:@"s1807.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Stevenage" andLeague:@"England npower League 1" andImage:@"s361.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Tranmere Rovers" andLeague:@"England npower League 1" andImage:@"s15048.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Walsall" andLeague:@"England npower League 1" andImage:@"s1803.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Wycombe" andLeague:@"England npower League 1" andImage:@"s1933.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Yeovil Town" andLeague:@"England npower League 1" andImage:@"s346.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Accrington" andLeague:@"England npower League 2" andImage:@"s110313.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"AFC Wimbledon" andLeague:@"England npower League 2" andImage:@"s112259.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Aldershot Town" andLeague:@"England npower League 2" andImage:@"s382.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Barnet" andLeague:@"England npower League 2" andImage:@"s189.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Bradford City" andLeague:@"England npower League 2" andImage:@"s1804.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Bristol Rovers" andLeague:@"England npower League 2" andImage:@"s1962.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Burton Albion" andLeague:@"England npower League 2" andImage:@"s15015.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Cheltenham Town" andLeague:@"England npower League 2" andImage:@"s1936.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Crawley Town" andLeague:@"England npower League 2" andImage:@"s110890.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Crewe Alexandra" andLeague:@"England npower League 2" andImage:@"s121.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Dagenham" andLeague:@"England npower League 2" andImage:@"s373.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Gillingham" andLeague:@"England npower League 2" andImage:@"s1802.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Hereford" andLeague:@"England npower League 2" andImage:@"s147.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Macclesfield" andLeague:@"England npower League 2" andImage:@"s1959.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Morecambe" andLeague:@"England npower League 2" andImage:@"s357.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Northampton" andLeague:@"England npower League 2" andImage:@"s1920.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Oxford United" andLeague:@"England npower League 2" andImage:@"s1951.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Plymouth Argyle" andLeague:@"England npower League 2" andImage:@"s1929.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Port Vale" andLeague:@"England npower League 2" andImage:@"s1928.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Rotherham Utd" andLeague:@"England npower League 2" andImage:@"s1797.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Shrewsbury" andLeague:@"England npower League 2" andImage:@"s127.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Southend United" andLeague:@"England npower League 2" andImage:@"s1954.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Swindon Town" andLeague:@"England npower League 2" andImage:@"s1934.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"Torquay United" andLeague:@"England npower League 2" andImage:@"s1946.png" andCountry:@"England"],
                      [[Team alloc] initWithName:@"AC Ajaccio" andLeague:@"France Ligue 1" andImage:@"s614.png" andCountry:@"France"],
                      [[Team alloc] initWithName:@"AJ Auxerre" andLeague:@"France Ligue 1" andImage:@"s57.png" andCountry:@"France"],
                      [[Team alloc] initWithName:@"AS Nancy" andLeague:@"France Ligue 1" andImage:@"s1823.png" andCountry:@"France"],
                      [[Team alloc] initWithName:@"Bordeaux" andLeague:@"France Ligue 1" andImage:@"s59.png" andCountry:@"France"],
                      [[Team alloc] initWithName:@"Dijon FCO" andLeague:@"France Ligue 1" andImage:@"s110569.png" andCountry:@"France"],
                      [[Team alloc] initWithName:@"Evian Thonon FC" andLeague:@"France Ligue 1" andImage:@"s111271.png" andCountry:@"France"],
                      [[Team alloc] initWithName:@"FC Lorient" andLeague:@"France Ligue 1" andImage:@"s217.png" andCountry:@"France"],
                      [[Team alloc] initWithName:@"FC Sochaux" andLeague:@"France Ligue 1" andImage:@"s226.png" andCountry:@"France"],
                      [[Team alloc] initWithName:@"LOSC Lille" andLeague:@"France Ligue 1" andImage:@"s65.png" andCountry:@"France"],
                      [[Team alloc] initWithName:@"Marseille" andLeague:@"France Ligue 1" andImage:@"s219.png" andCountry:@"France"],
                      [[Team alloc] initWithName:@"Montpellier HSC" andLeague:@"France Ligue 1" andImage:@"s70.png" andCountry:@"France"],
                      [[Team alloc] initWithName:@"OGC Nice" andLeague:@"France Ligue 1" andImage:@"s72.png" andCountry:@"France"],
                      [[Team alloc] initWithName:@"Olympique Lyon" andLeague:@"France Ligue 1" andImage:@"s66.png" andCountry:@"France"],
                      [[Team alloc] initWithName:@"PSG" andLeague:@"France Ligue 1" andImage:@"s73.png" andCountry:@"France"],
                      [[Team alloc] initWithName:@"Saint-Etienne" andLeague:@"France Ligue 1" andImage:@"s1819.png" andCountry:@"France"],
                      [[Team alloc] initWithName:@"SM Caen" andLeague:@"France Ligue 1" andImage:@"s210.png" andCountry:@"France"],
                      [[Team alloc] initWithName:@"Stade Brest" andLeague:@"France Ligue 1" andImage:@"s378.png" andCountry:@"France"],
                      [[Team alloc] initWithName:@"Stade Rennes" andLeague:@"France Ligue 1" andImage:@"s74.png" andCountry:@"France"],
                      [[Team alloc] initWithName:@"Toulouse FC" andLeague:@"France Ligue 1" andImage:@"s1809.png" andCountry:@"France"],
                      [[Team alloc] initWithName:@"Valenciennes FC" andLeague:@"France Ligue 1" andImage:@"s110456.png" andCountry:@"France"],
                      [[Team alloc] initWithName:@"AC Arles" andLeague:@"France Ligue 2" andImage:@"s111989.png" andCountry:@"France"],
                      [[Team alloc] initWithName:@"Amiens SC" andLeague:@"France Ligue 2" andImage:@"s1816.png" andCountry:@"France"],
                      [[Team alloc] initWithName:@"Angers SCO" andLeague:@"France Ligue 2" andImage:@"s1530.png" andCountry:@"France"],
                      [[Team alloc] initWithName:@"AS Monaco" andLeague:@"France Ligue 2" andImage:@"s69.png" andCountry:@"France"],
                      [[Team alloc] initWithName:@"Clermont Foot" andLeague:@"France Ligue 2" andImage:@"s1815.png" andCountry:@"France"],
                      [[Team alloc] initWithName:@"CS Sedan" andLeague:@"France Ligue 2" andImage:@"s613.png" andCountry:@"France"],
                      [[Team alloc] initWithName:@"EA Guingamp" andLeague:@"France Ligue 2" andImage:@"s62.png" andCountry:@"France"],
                      [[Team alloc] initWithName:@"ES Troyes" andLeague:@"France Ligue 2" andImage:@"s294.png" andCountry:@"France"],
                      [[Team alloc] initWithName:@"FC Istres" andLeague:@"France Ligue 2" andImage:@"s1820.png" andCountry:@"France"],
                      [[Team alloc] initWithName:@"FC Metz" andLeague:@"France Ligue 2" andImage:@"s68.png" andCountry:@"France"],
                      [[Team alloc] initWithName:@"FC Nantes" andLeague:@"France Ligue 2" andImage:@"s71.png" andCountry:@"France"],
                      [[Team alloc] initWithName:@"LB Chateauroux" andLeague:@"France Ligue 2" andImage:@"s212.png" andCountry:@"France"],
                      [[Team alloc] initWithName:@"Le Havre AC" andLeague:@"France Ligue 2" andImage:@"s1738.png" andCountry:@"France"],
                      [[Team alloc] initWithName:@"Le Mans FC" andLeague:@"France Ligue 2" andImage:@"s1739.png" andCountry:@"France"],
                      [[Team alloc] initWithName:@"RC Lens" andLeague:@"France Ligue 2" andImage:@"s64.png" andCountry:@"France"],
                      [[Team alloc] initWithName:@"SC Bastia" andLeague:@"France Ligue 2" andImage:@"s58.png" andCountry:@"France"],
                      [[Team alloc] initWithName:@"Stade Lavallois" andLeague:@"France Ligue 2" andImage:@"s1814.png" andCountry:@"France"],
                      [[Team alloc] initWithName:@"Stade Reims" andLeague:@"France Ligue 2" andImage:@"s379.png" andCountry:@"France"],
                      [[Team alloc] initWithName:@"Tours FC" andLeague:@"France Ligue 2" andImage:@"s110326.png" andCountry:@"France"],
                      [[Team alloc] initWithName:@"US Boulogne" andLeague:@"France Ligue 2" andImage:@"s111376.png" andCountry:@"France"],
                      [[Team alloc] initWithName:@"1860 Munchen" andLeague:@"Germany 2. Bundesliga" andImage:@"s33.png" andCountry:@"Germany"],
                      [[Team alloc] initWithName:@"Aleman. Aachen" andLeague:@"Germany 2. Bundesliga" andImage:@"s1826.png" andCountry:@"Germany"],
                      [[Team alloc] initWithName:@"Braunschweig" andLeague:@"Germany 2. Bundesliga" andImage:@"s110500.png" andCountry:@"Germany"],
                      [[Team alloc] initWithName:@"Dynamo Dresden" andLeague:@"Germany 2. Bundesliga" andImage:@"s503.png" andCountry:@"Germany"],
                      [[Team alloc] initWithName:@"Eint. Frankfurt" andLeague:@"Germany 2. Bundesliga" andImage:@"s1824.png" andCountry:@"Germany"],
                      [[Team alloc] initWithName:@"Energie Cottbus" andLeague:@"Germany 2. Bundesliga" andImage:@"s162.png" andCountry:@"Germany"],
                      [[Team alloc] initWithName:@"Erzgebirge Aue" andLeague:@"Germany 2. Bundesliga" andImage:@"s506.png" andCountry:@"Germany"],
                      [[Team alloc] initWithName:@"F. Dusseldorf" andLeague:@"Germany 2. Bundesliga" andImage:@"s110636.png" andCountry:@"Germany"],
                      [[Team alloc] initWithName:@"FC Ingolstadt" andLeague:@"Germany 2. Bundesliga" andImage:@"s111239.png" andCountry:@"Germany"],
                      [[Team alloc] initWithName:@"FC St. Pauli" andLeague:@"Germany 2. Bundesliga" andImage:@"s110329.png" andCountry:@"Germany"],
                      [[Team alloc] initWithName:@"FSV Frankfurt" andLeague:@"Germany 2. Bundesliga" andImage:@"s110596.png" andCountry:@"Germany"],
                      [[Team alloc] initWithName:@"Greuther Furth" andLeague:@"Germany 2. Bundesliga" andImage:@"s165.png" andCountry:@"Germany"],
                      [[Team alloc] initWithName:@"Hansa Rostock" andLeague:@"Germany 2. Bundesliga" andImage:@"s27.png" andCountry:@"Germany"],
                      [[Team alloc] initWithName:@"Karlsruher SC" andLeague:@"Germany 2. Bundesliga" andImage:@"s1832.png" andCountry:@"Germany"],
                      [[Team alloc] initWithName:@"MSV Duisburg" andLeague:@"Germany 2. Bundesliga" andImage:@"s1825.png" andCountry:@"Germany"],
                      [[Team alloc] initWithName:@"SC Paderborn" andLeague:@"Germany 2. Bundesliga" andImage:@"s10030.png" andCountry:@"Germany"],
                      [[Team alloc] initWithName:@"Union Berlin" andLeague:@"Germany 2. Bundesliga" andImage:@"s1831.png" andCountry:@"Germany"],
                      [[Team alloc] initWithName:@"VfL Bochum" andLeague:@"Germany 2. Bundesliga" andImage:@"s160.png" andCountry:@"Germany"],
                      [[Team alloc] initWithName:@"1. FC K'lautern" andLeague:@"Germany Bundesliga" andImage:@"s29.png" andCountry:@"Germany"],
                      [[Team alloc] initWithName:@"1. FC Koln" andLeague:@"Germany Bundesliga" andImage:@"s31.png" andCountry:@"Germany"],
                      [[Team alloc] initWithName:@"1. FC Nurnberg" andLeague:@"Germany Bundesliga" andImage:@"s171.png" andCountry:@"Germany"],
                      [[Team alloc] initWithName:@"1. FSV Mainz 05" andLeague:@"Germany Bundesliga" andImage:@"s169.png" andCountry:@"Germany"],
                      [[Team alloc] initWithName:@"1899 Hoffenheim" andLeague:@"Germany Bundesliga" andImage:@"s10029.png" andCountry:@"Germany"],
                      [[Team alloc] initWithName:@"Bay. Leverkusen" andLeague:@"Germany Bundesliga" andImage:@"s32.png" andCountry:@"Germany"],
                      [[Team alloc] initWithName:@"Bayern Munchen" andLeague:@"Germany Bundesliga" andImage:@"s21.png" andCountry:@"Germany"],
                      [[Team alloc] initWithName:@"Bor. Dortmund" andLeague:@"Germany Bundesliga" andImage:@"s22.png" andCountry:@"Germany"],
                      [[Team alloc] initWithName:@"Bor. M'gladbach" andLeague:@"Germany Bundesliga" andImage:@"s23.png" andCountry:@"Germany"],
                      [[Team alloc] initWithName:@"FC Augsburg" andLeague:@"Germany Bundesliga" andImage:@"fca.png" andCountry:@"Germany"],
                      [[Team alloc] initWithName:@"FC Shalke 04" andLeague:@"Germany Bundesliga" andImage:@"s34.png" andCountry:@"Germany"],
                      [[Team alloc] initWithName:@"Hamburger SV" andLeague:@"Germany Bundesliga" andImage:@"s28.png" andCountry:@"Germany"],
                      [[Team alloc] initWithName:@"Hannover 96" andLeague:@"Germany Bundesliga" andImage:@"s485.png" andCountry:@"Germany"],
                      [[Team alloc] initWithName:@"Hertha BSC" andLeague:@"Germany Bundesliga" andImage:@"s166.png" andCountry:@"Germany"],
                      [[Team alloc] initWithName:@"SC Freiburg" andLeague:@"Germany Bundesliga" andImage:@"s25.png" andCountry:@"Germany"],
                      [[Team alloc] initWithName:@"VfB Stuttgart" andLeague:@"Germany Bundesliga" andImage:@"s36.png" andCountry:@"Germany"],
                      [[Team alloc] initWithName:@"VfL Wolfsburg" andLeague:@"Germany Bundesliga" andImage:@"s38.png" andCountry:@"Germany"],
                      [[Team alloc] initWithName:@"Werder Bremen" andLeague:@"Germany Bundesliga" andImage:@"s38.png" andCountry:@"Germany"],
                      [[Team alloc] initWithName:@"Argentina" andLeague:@"International" andImage:@"s1369.png" andCountry:@"International"],
                      [[Team alloc] initWithName:@"Australia" andLeague:@"International" andImage:@"s1415.png" andCountry:@"International"],
                      [[Team alloc] initWithName:@"Austria" andLeague:@"International" andImage:@"s1322.png" andCountry:@"International"],
                      [[Team alloc] initWithName:@"Belgium" andLeague:@"International" andImage:@"s1325.png" andCountry:@"International"],
                      [[Team alloc] initWithName:@"Brazil" andLeague:@"International" andImage:@"s1370.png" andCountry:@"International"],
                      [[Team alloc] initWithName:@"Bulgaria" andLeague:@"International" andImage:@"s1327.png" andCountry:@"International"],
                      [[Team alloc] initWithName:@"Cameroon" andLeague:@"International" andImage:@"s1395.png" andCountry:@"International"],
                      [[Team alloc] initWithName:@"Chile" andLeague:@"International" andImage:@"s111459.png" andCountry:@"International"],
                      [[Team alloc] initWithName:@"Colombia" andLeague:@"International" andImage:@"s111109.png" andCountry:@"International"],
                      [[Team alloc] initWithName:@"Cote d'Ivoire" andLeague:@"International" andImage:@"sIvory.png" andCountry:@"International"],
                      [[Team alloc] initWithName:@"Croatia" andLeague:@"International" andImage:@"s1328.png" andCountry:@"International"],
                      [[Team alloc] initWithName:@"Denmark" andLeague:@"International" andImage:@"s1331.png" andCountry:@"International"],
                      [[Team alloc] initWithName:@"Ecuador" andLeague:@"International" andImage:@"s111465.png" andCountry:@"International"],
                      [[Team alloc] initWithName:@"Egypt" andLeague:@"International" andImage:@"s111130.png" andCountry:@"International"],
                      [[Team alloc] initWithName:@"England" andLeague:@"International" andImage:@"s1318.png" andCountry:@"International"],
                      [[Team alloc] initWithName:@"Finland" andLeague:@"International" andImage:@"s1334.png" andCountry:@"International"],
                      [[Team alloc] initWithName:@"France" andLeague:@"International" andImage:@"s1335.png" andCountry:@"International"],
                      [[Team alloc] initWithName:@"Germany" andLeague:@"International" andImage:@"s1337.png" andCountry:@"International"],
                      [[Team alloc] initWithName:@"Greece" andLeague:@"International" andImage:@"s1338.png" andCountry:@"International"],
                      [[Team alloc] initWithName:@"Hungary" andLeague:@"International" andImage:@"s1886.png" andCountry:@"International"],
                      [[Team alloc] initWithName:@"Ireland" andLeague:@"International" andImage:@"s111112.png" andCountry:@"International"],
                      [[Team alloc] initWithName:@"Italy" andLeague:@"International" andImage:@"s1343.png" andCountry:@"International"],
                      [[Team alloc] initWithName:@"Korea Republic" andLeague:@"International" andImage:@"s974.png" andCountry:@"International"],
                      [[Team alloc] initWithName:@"Mexico" andLeague:@"International" andImage:@"s1386.png" andCountry:@"International"],
                      [[Team alloc] initWithName:@"Netherlands" andLeague:@"International" andImage:@"sDutch.png" andCountry:@"International"],
                      [[Team alloc] initWithName:@"New Zealand" andLeague:@"International" andImage:@"s111473.png" andCountry:@"International"],
                      [[Team alloc] initWithName:@"Northern Ireland" andLeague:@"International" andImage:@"s110081.png" andCountry:@"International"],
                      [[Team alloc] initWithName:@"Norway" andLeague:@"International" andImage:@"sNorway.png" andCountry:@"International"],
                      [[Team alloc] initWithName:@"Peru" andLeague:@"International" andImage:@"s111459.png" andCountry:@"International"],
                      [[Team alloc] initWithName:@"Poland" andLeague:@"International" andImage:@"s1353.png" andCountry:@"International"],
                      [[Team alloc] initWithName:@"Portugal" andLeague:@"International" andImage:@"s1354.png" andCountry:@"International"],
                      [[Team alloc] initWithName:@"Romania" andLeague:@"International" andImage:@"s1356.png" andCountry:@"International"],
                      [[Team alloc] initWithName:@"Russia" andLeague:@"International" andImage:@"s1357.png" andCountry:@"International"],
                      [[Team alloc] initWithName:@"Scotland" andLeague:@"International" andImage:@"s1359.png" andCountry:@"International"],
                      [[Team alloc] initWithName:@"Slovenia" andLeague:@"International" andImage:@"s1361.png" andCountry:@"International"],
                      [[Team alloc] initWithName:@"South Africa" andLeague:@"International" andImage:@"s111099.png" andCountry:@"International"],
                      [[Team alloc] initWithName:@"Spain" andLeague:@"International" andImage:@"s1362.png" andCountry:@"International"],
                      [[Team alloc] initWithName:@"Sweden" andLeague:@"International" andImage:@"s1363.png" andCountry:@"International"],
                      [[Team alloc] initWithName:@"Switzerland" andLeague:@"International" andImage:@"s1364.png" andCountry:@"International"],
                      [[Team alloc] initWithName:@"Turkey" andLeague:@"International" andImage:@"s1365.png" andCountry:@"International"],
                      [[Team alloc] initWithName:@"United States" andLeague:@"International" andImage:@"s1387.png" andCountry:@"International"],
                      [[Team alloc] initWithName:@"Uruguay" andLeague:@"International" andImage:@"s1377.png" andCountry:@"International"],
                      [[Team alloc] initWithName:@"Atalanta" andLeague:@"Italy Serie A" andImage:@"s39.png" andCountry:@"Italy"],
                      [[Team alloc] initWithName:@"Bologna" andLeague:@"Italy Serie A" andImage:@"s189.png" andCountry:@"Italy"],
                      [[Team alloc] initWithName:@"Cagliari" andLeague:@"Italy Serie A" andImage:@"s1842.png" andCountry:@"Italy"],
                      [[Team alloc] initWithName:@"Catania" andLeague:@"Italy Serie A" andImage:@"s110364.png" andCountry:@"Italy"],
                      [[Team alloc] initWithName:@"Cesena" andLeague:@"Italy Serie A" andImage:@"s110915.png" andCountry:@"Italy"],
                      [[Team alloc] initWithName:@"Chievo Verona" andLeague:@"Italy Serie A" andImage:@"s192.png" andCountry:@"Italy"],
                      [[Team alloc] initWithName:@"Fiorentina" andLeague:@"Italy Serie A" andImage:@"s110374.png" andCountry:@"Italy"],
                      [[Team alloc] initWithName:@"Genoa" andLeague:@"Italy Serie A" andImage:@"s110556.png" andCountry:@"Italy"],
                      [[Team alloc] initWithName:@"Inter" andLeague:@"Italy Serie A" andImage:@"s44.png" andCountry:@"Italy"],
                      [[Team alloc] initWithName:@"Juventus" andLeague:@"Italy Serie A" andImage:@"s45.png" andCountry:@"Italy"],
                      [[Team alloc] initWithName:@"Lazio" andLeague:@"Italy Serie A" andImage:@"s46.png" andCountry:@"Italy"],
                      [[Team alloc] initWithName:@"Lecce" andLeague:@"Italy Serie A" andImage:@"s347.png" andCountry:@"Italy"],
                      [[Team alloc] initWithName:@"Milan" andLeague:@"Italy Serie A" andImage:@"s47.png" andCountry:@"Italy"],
                      [[Team alloc] initWithName:@"Napoli" andLeague:@"Italy Serie A" andImage:@"s48.png" andCountry:@"Italy"],
                      [[Team alloc] initWithName:@"Novara" andLeague:@"Italy Serie A" andImage:@"s112225.png" andCountry:@"Italy"],
                      [[Team alloc] initWithName:@"Palermo" andLeague:@"Italy Serie A" andImage:@"s1843.png" andCountry:@"Italy"],
                      [[Team alloc] initWithName:@"Parma" andLeague:@"Italy Serie A" andImage:@"s50.png" andCountry:@"Italy"],
                      [[Team alloc] initWithName:@"Roma" andLeague:@"Italy Serie A" andImage:@"s52.png" andCountry:@"Italy"],
                      [[Team alloc] initWithName:@"Siena" andLeague:@"Italy Serie A" andImage:@"s1838.png" andCountry:@"Italy"],
                      [[Team alloc] initWithName:@"Udinese" andLeague:@"Italy Serie A" andImage:@"s55.png" andCountry:@"Italy"],
                      [[Team alloc] initWithName:@"A. Leffe" andLeague:@"Italy Serie B" andImage:@"s2044.png" andCountry:@"Italy"],
                      [[Team alloc] initWithName:@"Ascoli" andLeague:@"Italy Serie B" andImage:@"s1846.png" andCountry:@"Italy"],
                      [[Team alloc] initWithName:@"Bari" andLeague:@"Italy Serie B" andImage:@"s1848.png" andCountry:@"Italy"],
                      [[Team alloc] initWithName:@"Brescia" andLeague:@"Italy Serie B" andImage:@"s190.png" andCountry:@"Italy"],
                      [[Team alloc] initWithName:@"C. Stabia" andLeague:@"Italy Serie B" andImage:@"s112124.png" andCountry:@"Italy"],
                      [[Team alloc] initWithName:@"Cittadella" andLeague:@"Italy Serie B" andImage:@"s111993.png" andCountry:@"Italy"],
                      [[Team alloc] initWithName:@"Crotone" andLeague:@"Italy Serie B" andImage:@"s110734.png" andCountry:@"Italy"],
                      [[Team alloc] initWithName:@"Empoli" andLeague:@"Italy Serie B" andImage:@"s1746.png" andCountry:@"Italy"],
                      [[Team alloc] initWithName:@"F. Torino" andLeague:@"Italy Serie B" andImage:@"s54.png" andCountry:@"Italy"],
                      [[Team alloc] initWithName:@"Grosseto" andLeague:@"Italy Serie B" andImage:@"s111491.png" andCountry:@"Italy"],
                      [[Team alloc] initWithName:@"Gubbio" andLeague:@"Italy Serie B" andImage:@"s112281.png" andCountry:@"Italy"],
                      [[Team alloc] initWithName:@"H. Verona" andLeague:@"Italy Serie B" andImage:@"s206.png" andCountry:@"Italy"],
                      [[Team alloc] initWithName:@"Livorno" andLeague:@"Italy Serie B" andImage:@"s1844.png" andCountry:@"Italy"],
                      [[Team alloc] initWithName:@"Modena" andLeague:@"Italy Serie B" andImage:@"s1744.png" andCountry:@"Italy"],
                      [[Team alloc] initWithName:@"N. Inferiore" andLeague:@"Italy Serie B" andImage:@"sNocer.png" andCountry:@"Italy"],
                      [[Team alloc] initWithName:@"Padua" andLeague:@"Italy Serie B" andImage:@"s110912.png" andCountry:@"Italy"],
                      [[Team alloc] initWithName:@"Pescara" andLeague:@"Italy Serie B" andImage:@"s200.png" andCountry:@"Italy"],
                      [[Team alloc] initWithName:@"Reggina" andLeague:@"Italy Serie B" andImage:@"s203.png" andCountry:@"Italy"],
                      [[Team alloc] initWithName:@"Sampdoria" andLeague:@"Italy Serie B" andImage:@"s1837.png" andCountry:@"Italy"],
                      [[Team alloc] initWithName:@"Sassuolo" andLeague:@"Italy Serie B" andImage:@"s111974.png" andCountry:@"Italy"],
                      [[Team alloc] initWithName:@"Varese" andLeague:@"Italy Serie B" andImage:@"s112237.png" andCountry:@"Italy"],
                      [[Team alloc] initWithName:@"Vicenza" andLeague:@"Italy Serie B" andImage:@"s1847.png" andCountry:@"Italy"],
                      [[Team alloc] initWithName:@"Busan I'Park" andLeague:@"Korea Republic Sonata K-League" andImage:@"s1476.png" andCountry:@"South Korea"],
                      [[Team alloc] initWithName:@"Chunham Dragons" andLeague:@"Korea Republic Sonata K-League" andImage:@"s1475.png" andCountry:@"South Korea"],
                      [[Team alloc] initWithName:@"Daegu FC" andLeague:@"Korea Republic Sonata K-League" andImage:@"s2056.png" andCountry:@"South Korea"],
                      [[Team alloc] initWithName:@"Daejong Citizen" andLeague:@"Korea Republic Sonata K-League" andImage:@"s980.png" andCountry:@"South Korea"],
                      [[Team alloc] initWithName:@"FC Seoul" andLeague:@"Korea Republic Sonata K-League" andImage:@"s982.png" andCountry:@"South Korea"],
                      [[Team alloc] initWithName:@"Gangwon FC" andLeague:@"Korea Republic Sonata K-League" andImage:@"s112115.png" andCountry:@"South Korea"],
                      [[Team alloc] initWithName:@"GwangJu FC" andLeague:@"Korea Republic Sonata K-League" andImage:@"s112258.png" andCountry:@"South Korea"],
                      [[Team alloc] initWithName:@"GyeongNam FC" andLeague:@"Korea Republic Sonata K-League" andImage:@"s111588.png" andCountry:@"South Korea"],
                      [[Team alloc] initWithName:@"Incheon United" andLeague:@"Korea Republic Sonata K-League" andImage:@"s110675.png" andCountry:@"South Korea"],
                      [[Team alloc] initWithName:@"Jeju United FC" andLeague:@"Korea Republic Sonata K-League" andImage:@"s1478.png" andCountry:@"South Korea"],
                      [[Team alloc] initWithName:@"Jeonbuk FC" andLeague:@"Korea Republic Sonata K-League" andImage:@"s1477.png" andCountry:@"South Korea"],
                      [[Team alloc] initWithName:@"Pohang Steelers" andLeague:@"Korea Republic Sonata K-League" andImage:@"s1474.png" andCountry:@"South Korea"],
                      [[Team alloc] initWithName:@"SangJu Sangmu" andLeague:@"Korea Republic Sonata K-League" andImage:@"sSangju.png" andCountry:@"South Korea"],
                      [[Team alloc] initWithName:@"Sengnam Ilhwa" andLeague:@"Korea Republic Sonata K-League" andImage:@"s981.png" andCountry:@"South Korea"],
                      [[Team alloc] initWithName:@"Suwon Bluewings" andLeague:@"Korea Republic Sonata K-League" andImage:@"s983.png" andCountry:@"South Korea"],
                      [[Team alloc] initWithName:@"Ulsan Hyundai" andLeague:@"Korea Republic Sonata K-League" andImage:@"s1473.png" andCountry:@"South Korea"],
                      [[Team alloc] initWithName:@"America" andLeague:@"Mexico Primera Div Mex" andImage:@"s1879.png" andCountry:@"Mexico"],
                      [[Team alloc] initWithName:@"Atlante" andLeague:@"Mexico Primera Div Mex" andImage:@"s101116.png" andCountry:@"Mexico"],
                      [[Team alloc] initWithName:@"Atlas" andLeague:@"Mexico Primera Div Mex" andImage:@"s101114.png" andCountry:@"Mexico"],
                      [[Team alloc] initWithName:@"Chiapas" andLeague:@"Mexico Primera Div Mex" andImage:@"s110151.png" andCountry:@"Mexico"],
                      [[Team alloc] initWithName:@"Cruz Azul" andLeague:@"Mexico Primera Div Mex" andImage:@"s1878.png" andCountry:@"Mexico"],
                      [[Team alloc] initWithName:@"Estudiantes" andLeague:@"Mexico Primera Div Mex" andImage:@"s110780.png" andCountry:@"Mexico"],
                      [[Team alloc] initWithName:@"Guadalajara" andLeague:@"Mexico Primera Div Mex" andImage:@"s1880.png" andCountry:@"Mexico"],
                      [[Team alloc] initWithName:@"Monarcas" andLeague:@"Mexico Primera Div Mex" andImage:@"s1028.png" andCountry:@"Mexico"],
                      [[Team alloc] initWithName:@"Monterrey" andLeague:@"Mexico Primera Div Mex" andImage:@"s1032.png" andCountry:@"Mexico"],
                      [[Team alloc] initWithName:@"Pachuca" andLeague:@"Mexico Primera Div Mex" andImage:@"s110147.png" andCountry:@"Mexico"],
                      [[Team alloc] initWithName:@"Puebla" andLeague:@"Mexico Primera Div Mex" andImage:@"s110152.png" andCountry:@"Mexico"],
                      [[Team alloc] initWithName:@"Queretaro" andLeague:@"Mexico Primera Div Mex" andImage:@"s110150.png" andCountry:@"Mexico"],
                      [[Team alloc] initWithName:@"San Luis" andLeague:@"Mexico Primera Div Mex" andImage:@"s110149.png" andCountry:@"Mexico"],
                      [[Team alloc] initWithName:@"Santos Laguna" andLeague:@"Mexico Primera Div Mex" andImage:@"s110144.png" andCountry:@"Mexico"],
                      [[Team alloc] initWithName:@"Tigres" andLeague:@"Mexico Primera Div Mex" andImage:@"s1970.png" andCountry:@"Mexico"],
                      [[Team alloc] initWithName:@"Tijuana" andLeague:@"Mexico Primera Div Mex" andImage:@"s111678.png" andCountry:@"Mexico"],
                      [[Team alloc] initWithName:@"Toluca" andLeague:@"Mexico Primera Div Mex" andImage:@"s1882.png" andCountry:@"Mexico"],
                      [[Team alloc] initWithName:@"U.N.A.M." andLeague:@"Mexico Primera Div Mex" andImage:@"s1881.png" andCountry:@"Mexico"],
                      [[Team alloc] initWithName:@"ADO Den Haag" andLeague:@"Netherlands Eredivisie" andImage:@"s650.png" andCountry:@"Netherlands"],
                      [[Team alloc] initWithName:@"Ajax" andLeague:@"Netherlands Eredivisie" andImage:@"s245.png" andCountry:@"Netherlands"],
                      [[Team alloc] initWithName:@"AZ Alkmaar" andLeague:@"Netherlands Eredivisie" andImage:@"s1906.png" andCountry:@"Netherlands"],
                      [[Team alloc] initWithName:@"De Graafschap" andLeague:@"Netherlands Eredivisie" andImage:@"s635.png" andCountry:@"Netherlands"],
                      [[Team alloc] initWithName:@"FC Groningen" andLeague:@"Netherlands Eredivisie" andImage:@"s1915.png" andCountry:@"Netherlands"],
                      [[Team alloc] initWithName:@"FC Twente" andLeague:@"Netherlands Eredivisie" andImage:@"s1908.png" andCountry:@"Netherlands"],
                      [[Team alloc] initWithName:@"FC Utrecht" andLeague:@"Netherlands Eredivisie" andImage:@"s1903.png" andCountry:@"Netherlands"],
                      [[Team alloc] initWithName:@"Feyenoord" andLeague:@"Netherlands Eredivisie" andImage:@"s246.png" andCountry:@"Netherlands"],
                      [[Team alloc] initWithName:@"Heracles Almelo" andLeague:@"Netherlands Eredivisie" andImage:@"s100634.png" andCountry:@"Netherlands"],
                      [[Team alloc] initWithName:@"N.E.C." andLeague:@"Netherlands Eredivisie" andImage:@"s1910.png" andCountry:@"Netherlands"],
                      [[Team alloc] initWithName:@"NAC Breda" andLeague:@"Netherlands Eredivisie" andImage:@"s1904.png" andCountry:@"Netherlands"],
                      [[Team alloc] initWithName:@"PSV" andLeague:@"Netherlands Eredivisie" andImage:@"s247.png" andCountry:@"Netherlands"],
                      [[Team alloc] initWithName:@"RKC Waalwijk" andLeague:@"Netherlands Eredivisie" andImage:@"s1905.png" andCountry:@"Netherlands"],
                      [[Team alloc] initWithName:@"Roda JC" andLeague:@"Netherlands Eredivisie" andImage:@"s1902.png" andCountry:@"Netherlands"],
                      [[Team alloc] initWithName:@"SBV Excelsior" andLeague:@"Netherlands Eredivisie" andImage:@"s1971.png" andCountry:@"Netherlands"],
                      [[Team alloc] initWithName:@"sc Heerenveen" andLeague:@"Netherlands Eredivisie" andImage:@"s1913.png" andCountry:@"Netherlands"],
                      [[Team alloc] initWithName:@"Vitesse" andLeague:@"Netherlands Eredivisie" andImage:@"s1909.png" andCountry:@"Netherlands"],
                      [[Team alloc] initWithName:@"VVV-Venlo" andLeague:@"Netherlands Eredivisie" andImage:@"s100651.png" andCountry:@"Netherlands"],
                      [[Team alloc] initWithName:@"Aalesunds FK" andLeague:@"Norway Tippeligaen" andImage:@"s1755.png" andCountry:@"Norway"],
                      [[Team alloc] initWithName:@"FK Haugesund" andLeague:@"Norway Tippeligaen" andImage:@"s1463.png" andCountry:@"Norway"],
                      [[Team alloc] initWithName:@"Fredrikstad FK" andLeague:@"Norway Tippeligaen" andImage:@"s2041.png" andCountry:@"Norway"],
                      [[Team alloc] initWithName:@"Lillestrom SK" andLeague:@"Norway Tippeligaen" andImage:@"s299.png" andCountry:@"Norway"],
                      [[Team alloc] initWithName:@"Molde FK" andLeague:@"Norway Tippeligaen" andImage:@"s417.png" andCountry:@"Norway"],
                      [[Team alloc] initWithName:@"ODD" andLeague:@"Norway Tippeligaen" andImage:@"s1456.png" andCountry:@"Norway"],
                      [[Team alloc] initWithName:@"Rosenborg BK" andLeague:@"Norway Tippeligaen" andImage:@"s298.png" andCountry:@"Norway"],
                      [[Team alloc] initWithName:@"Sarpsborg" andLeague:@"Norway Tippeligaen" andImage:@"s112199.png" andCountry:@"Norway"],
                      [[Team alloc] initWithName:@"SK Brann" andLeague:@"Norway Tippeligaen" andImage:@"s919.png" andCountry:@"Norway"],
                      [[Team alloc] initWithName:@"Sogndal" andLeague:@"Norway Tippeligaen" andImage:@"s1465.png" andCountry:@"Norway"],
                      [[Team alloc] initWithName:@"Stabaek Fotball" andLeague:@"Norway Tippeligaen" andImage:@"s917.png" andCountry:@"Norway"],
                      [[Team alloc] initWithName:@"Start" andLeague:@"Norway Tippeligaen" andImage:@"s1524.png" andCountry:@"Norway"],
                      [[Team alloc] initWithName:@"Stromsgodset" andLeague:@"Norway Tippeligaen" andImage:@"s922.png" andCountry:@"Norway"],
                      [[Team alloc] initWithName:@"Tromso IL" andLeague:@"Norway Tippeligaen" andImage:@"s418.png" andCountry:@"Norway"],
                      [[Team alloc] initWithName:@"Valerenga" andLeague:@"Norway Tippeligaen" andImage:@"s920.png" andCountry:@"Norway"],
                      [[Team alloc] initWithName:@"Viking FK" andLeague:@"Norway Tippeligaen" andImage:@"s300.png" andCountry:@"Norway"],
                      [[Team alloc] initWithName:@"Bielsko-Biala" andLeague:@"Poland Polska Liga" andImage:@"s111087.png" andCountry:@"Poland"],
                      [[Team alloc] initWithName:@"C. Krakow" andLeague:@"Poland Polska Liga" andImage:@"s1873.png" andCountry:@"Poland"],
                      [[Team alloc] initWithName:@"G. Belchatow" andLeague:@"Poland Polska Liga" andImage:@"s110744.png" andCountry:@"Poland"],
                      [[Team alloc] initWithName:@"G. Zabrze" andLeague:@"Poland Polska Liga" andImage:@"s420.png" andCountry:@"Poland"],
                      [[Team alloc] initWithName:@"Gdansk" andLeague:@"Poland Polska Liga" andImage:@"s111091.png" andCountry:@"Poland"],
                      [[Team alloc] initWithName:@"J. Bialystok" andLeague:@"Poland Polska Liga" andImage:@"s110745.png" andCountry:@"Poland"],
                      [[Team alloc] initWithName:@"Kielce" andLeague:@"Poland Polska Liga" andImage:@"s111083.png" andCountry:@"Poland"],
                      [[Team alloc] initWithName:@"L. Poznan" andLeague:@"Poland Polska Liga" andImage:@"s420.png" andCountry:@"Poland"],
                      [[Team alloc] initWithName:@"L. Warszawa" andLeague:@"Poland Polska Liga" andImage:@"s1871.png" andCountry:@"Poland"],
                      [[Team alloc] initWithName:@"Lodz" andLeague:@"Poland Polska Liga" andImage:@"s111085.png" andCountry:@"Poland"],
                      [[Team alloc] initWithName:@"Lubin" andLeague:@"Poland Polska Liga" andImage:@"s110749.png" andCountry:@"Poland"],
                      [[Team alloc] initWithName:@"P. Warszawa" andLeague:@"Poland Polska Liga" andImage:@"s1570.png" andCountry:@"Poland"],
                      [[Team alloc] initWithName:@"R. Chorzow" andLeague:@"Poland Polska Liga" andImage:@"s874.png" andCountry:@"Poland"],
                      [[Team alloc] initWithName:@"W. Krakow" andLeague:@"Poland Polska Liga" andImage:@"s110747.png" andCountry:@"Poland"],
                      [[Team alloc] initWithName:@"W. Lodz" andLeague:@"Poland Polska Liga" andImage:@"s301.png" andCountry:@"Poland"],
                      [[Team alloc] initWithName:@"Wroclaw" andLeague:@"Poland Polska Liga" andImage:@"s111092.png" andCountry:@"Poland"],
                      [[Team alloc] initWithName:@"Academica" andLeague:@"Portugal Liga Portuguesa" andImage:@"s1901.png" andCountry:@"Portugal"],
                      [[Team alloc] initWithName:@"C. Funchal" andLeague:@"Portugal Liga Portuguesa" andImage:@"s1893.png" andCountry:@"Portugal"],
                      [[Team alloc] initWithName:@"CD Nacional" andLeague:@"Portugal Liga Portuguesa" andImage:@"s1891.png" andCountry:@"Portugal"],
                      [[Team alloc] initWithName:@"F. Santa Maria" andLeague:@"Portugal Liga Portuguesa" andImage:@"sSanta.png" andCountry:@"Portugal"],
                      [[Team alloc] initWithName:@"FC Porto" andLeague:@"Portugal Liga Portuguesa" andImage:@"s236.png" andCountry:@"Portugal"],
                      [[Team alloc] initWithName:@"Pacos Ferreira" andLeague:@"Portugal Liga Portuguesa" andImage:@"s1892.png" andCountry:@"Portugal"],
                      [[Team alloc] initWithName:@"Rio Ave FC" andLeague:@"Portugal Liga Portuguesa" andImage:@"s744.png" andCountry:@"Portugal"],
                      [[Team alloc] initWithName:@"S. C. Olhanense" andLeague:@"Portugal Liga Portuguesa" andImage:@"s111540.png" andCountry:@"Portugal"],
                      [[Team alloc] initWithName:@"SC Beira Mar" andLeague:@"Portugal Liga Portuguesa" andImage:@"s1897.png" andCountry:@"Portugal"],
                      [[Team alloc] initWithName:@"SC Braga" andLeague:@"Portugal Liga Portuguesa" andImage:@"s1896.png" andCountry:@"Portugal"],
                      [[Team alloc] initWithName:@"SL Benfica" andLeague:@"Portugal Liga Portuguesa" andImage:@"s234.png" andCountry:@"Portugal"],
                      [[Team alloc] initWithName:@"Sporting CP" andLeague:@"Portugal Liga Portuguesa" andImage:@"s237.png" andCountry:@"Portugal"],
                      [[Team alloc] initWithName:@"UD Leiria SAD" andLeague:@"Portugal Liga Portuguesa " andImage:@"s1895.png" andCountry:@"Portugal"],
                      [[Team alloc] initWithName:@"V. Barcelos" andLeague:@"Portugal Liga Portuguesa" andImage:@"s1888.png" andCountry:@"Portugal"],
                      [[Team alloc] initWithName:@"Vit. Guimaraes" andLeague:@"Portugal Liga Portuguesa" andImage:@"s1887.png" andCountry:@"Portugal"],
                      [[Team alloc] initWithName:@"Vitoria FC" andLeague:@"Portugal Liga Portuguesa" andImage:@"sVitoria.png" andCountry:@"Portugal"],
                      [[Team alloc] initWithName:@"Bohemians FC" andLeague:@"Republic of Ireland Airtricity League" andImage:@"s305.png" andCountry:@"Ireland"],
                      [[Team alloc] initWithName:@"Bray Wanderers" andLeague:@"Republic of Ireland Airtricity League" andImage:@"s838.png" andCountry:@"Ireland"],
                      [[Team alloc] initWithName:@"Derry City" andLeague:@"Republic of Ireland Airtricity League" andImage:@"s445.png" andCountry:@"Ireland"],
                      [[Team alloc] initWithName:@"Drogheda Utd" andLeague:@"Republic of Ireland Airtricity League" andImage:@"s11572.png" andCountry:@"Ireland"],
                      [[Team alloc] initWithName:@"Dundalk" andLeague:@"Republic of Ireland Airtricity League" andImage:@"s837.png" andCountry:@"Ireland"],
                      [[Team alloc] initWithName:@"Galway United" andLeague:@"Republic of Ireland Airtricity League" andImage:@"s1571.png" andCountry:@"Ireland"],
                      [[Team alloc] initWithName:@"Shamrock Rovers" andLeague:@"Republic of Ireland Airtricity League" andImage:@"s306.png" andCountry:@"Ireland"],
                      [[Team alloc] initWithName:@"Sligo Rovers" andLeague:@"Republic of Ireland Airtricity League" andImage:@"s563.png" andCountry:@"Ireland"],
                      [[Team alloc] initWithName:@"St. Pats" andLeague:@"Republic of Ireland Airtricity League" andImage:@"s423.png" andCountry:@"Ireland"],
                      [[Team alloc] initWithName:@"UCD AFC" andLeague:@"Republic of Ireland Airtricity League" andImage:@"s111132.png" andCountry:@"Ireland"],
                      [[Team alloc] initWithName:@"AEK Athens" andLeague:@"Rest of World" andImage:@"s278.png" andCountry:@"Rest of World"],
                      [[Team alloc] initWithName:@"Boca Juniors" andLeague:@"Rest of World" andImage:@"s1877.png" andCountry:@"Rest of World"],
                      [[Team alloc] initWithName:@"Classic XI" andLeague:@"Rest of World" andImage:@"s111205.png" andCountry:@"Rest of World"],
                      [[Team alloc] initWithName:@"Galatasaray SK" andLeague:@"Rest of World" andImage:@"s325.png" andCountry:@"Rest of World"],
                      [[Team alloc] initWithName:@"Kaizer Chiefs" andLeague:@"Rest of World" andImage:@"s110929.png" andCountry:@"Rest of World"],
                      [[Team alloc] initWithName:@"Olympiakos CFP" andLeague:@"Rest of World" andImage:@"s280.png" andCountry:@"Rest of World"],
                      [[Team alloc] initWithName:@"Orlando Pirates" andLeague:@"Rest of World" andImage:@"s110930.png" andCountry:@"Rest of World"],
                      [[Team alloc] initWithName:@"Panathinaikos" andLeague:@"Rest of World" andImage:@"s1884.png" andCountry:@"Rest of World"],
                      [[Team alloc] initWithName:@"PAOK" andLeague:@"Rest of World" andImage:@"s393.png" andCountry:@"Rest of World"],
                      [[Team alloc] initWithName:@"Racing Club" andLeague:@"Rest of World" andImage:@"sRacing.png" andCountry:@"Rest of World"],
                      [[Team alloc] initWithName:@"River Plate" andLeague:@"Rest of World" andImage:@"s1876.png" andCountry:@"Rest of World"],
                      [[Team alloc] initWithName:@"World XI" andLeague:@"Rest of World" andImage:@"s111205.png" andCountry:@"Rest of World"],
                      [[Team alloc] initWithName:@"A. Makhachkala" andLeague:@"Russia Russian League" andImage:@"sAnzi.png" andCountry:@"Russia"],
                      [[Team alloc] initWithName:@"Amkar Perm" andLeague:@"Russia Russian League" andImage:@"s110234.png" andCountry:@"Russia"],
                      [[Team alloc] initWithName:@"CSKA Moskva" andLeague:@"Russia Russian League" andImage:@"s315.png" andCountry:@"Russia"],
                      [[Team alloc] initWithName:@"Dinamo Moskva" andLeague:@"Russia Russian League" andImage:@"s312.png" andCountry:@"Russia"],
                      [[Team alloc] initWithName:@"FC Krasnodar" andLeague:@"Russia Russian League" andImage:@"s112218.png" andCountry:@"Russia"],
                      [[Team alloc] initWithName:@"FC Rostov" andLeague:@"Russia Russian League" andImage:@"s110231.png" andCountry:@"Russia"],
                      [[Team alloc] initWithName:@"Krylya Sovetov" andLeague:@"Russia Russian League" andImage:@"sKrylia.png" andCountry:@"Russia"],
                      [[Team alloc] initWithName:@"Kuban Krasnodar" andLeague:@"Russia Russian League" andImage:@"s110089.png" andCountry:@"Russia"],
                      [[Team alloc] initWithName:@"Lokomotiv" andLeague:@"Russia Russian League" andImage:@"sLokomotiv.png" andCountry:@"Russia"],
                      [[Team alloc] initWithName:@"Rubin Kazan" andLeague:@"Russia Russian League" andImage:@"s110227.png" andCountry:@"Russia"],
                      [[Team alloc] initWithName:@"Spartak Moskva" andLeague:@"Russia Russian League" andImage:@"sSpartak.png" andCountry:@"Russia"],
                      [[Team alloc] initWithName:@"Spartak Nalchik" andLeague:@"Russia Russian League" andImage:@"s110103.png" andCountry:@"Russia"],
                      [[Team alloc] initWithName:@"Terek Grozny" andLeague:@"Russia Russian League" andImage:@"s110109.png" andCountry:@"Russia"],
                      [[Team alloc] initWithName:@"Tom Tomsk" andLeague:@"Russia Russian League" andImage:@"s110233.png" andCountry:@"Russia"],
                      [[Team alloc] initWithName:@"Volga" andLeague:@"Russia Russian League" andImage:@"s112217.png" andCountry:@"Russia"],
                      [[Team alloc] initWithName:@"Zenit" andLeague:@"Russia Russian League" andImage:@"sZenit.png" andCountry:@"Russia"],
                      [[Team alloc] initWithName:@"Aberdeen" andLeague:@"Scotland SPL" andImage:@"s77.png" andCountry:@"Scotland"],
                      [[Team alloc] initWithName:@"Celtic" andLeague:@"Scotland SPL" andImage:@"s78.png" andCountry:@"Scotland"],
                      [[Team alloc] initWithName:@"Dundee United" andLeague:@"Scotland SPL" andImage:@"s181.png" andCountry:@"Scotland"],
                      [[Team alloc] initWithName:@"Dunfermline" andLeague:@"Scotland SPL" andImage:@"s182.png" andCountry:@"Scotland"],
                      [[Team alloc] initWithName:@"Hearts" andLeague:@"Scotland SPL" andImage:@"s80.png" andCountry:@"Scotland"],
                      [[Team alloc] initWithName:@"Hibernian" andLeague:@"Scotland SPL" andImage:@"s81.png" andCountry:@"Scotland"],
                      [[Team alloc] initWithName:@"Inverness CT" andLeague:@"Scotland SPL" andImage:@"s620.png" andCountry:@"Scotland"],
                      [[Team alloc] initWithName:@"Kilmarnock" andLeague:@"Scotland SPL" andImage:@"s82.png" andCountry:@"Scotland"],
                      [[Team alloc] initWithName:@"Motherwell" andLeague:@"Scotland SPL" andImage:@"s83.png" andCountry:@"Scotland"],
                      [[Team alloc] initWithName:@"Rangers" andLeague:@"Scotland SPL" andImage:@"s86.png" andCountry:@"Scotland"],
                      [[Team alloc] initWithName:@"St. Johnstone" andLeague:@"Scotland SPL" andImage:@"sStJohnstone.png" andCountry:@"Scotland"],
                      [[Team alloc] initWithName:@"St. Mirren" andLeague:@"Scotland SPL" andImage:@"sStMirren.png" andCountry:@"Scotland"],
                      [[Team alloc] initWithName:@"AD Alcorcon" andLeague:@"Spain Liga Adelante" andImage:@"sAdAl.png" andCountry:@"Spain"],
                      [[Team alloc] initWithName:@"CD Alcoyano" andLeague:@"Spain Liga Adelante" andImage:@"s110833.png" andCountry:@"Spain"],
                      [[Team alloc] initWithName:@"CD Guadalajara" andLeague:@"Spain Liga Adelante" andImage:@"s1880.png" andCountry:@"Spain"],
                      [[Team alloc] initWithName:@"CD Numancia" andLeague:@"Spain Liga Adelante" andImage:@"s477.png" andCountry:@"Spain"],
                      [[Team alloc] initWithName:@"Celta Vigo" andLeague:@"Spain Liga Adelante" andImage:@"s450.png" andCountry:@"Spain"],
                      [[Team alloc] initWithName:@"Cordoba CF" andLeague:@"Spain Liga Adelante" andImage:@"s1867.png" andCountry:@"Spain"],
                      [[Team alloc] initWithName:@"Elche CF" andLeague:@"Spain Liga Adelante" andImage:@"s468.png" andCountry:@"Spain"],
                      [[Team alloc] initWithName:@"FC Barcelona B" andLeague:@"Spain Liga Adelante" andImage:@"s110704.png" andCountry:@"Spain"],
                      [[Team alloc] initWithName:@"FC Cartagena" andLeague:@"Spain Liga Adelante" andImage:@"sFcCart.png" andCountry:@"Spain"],
                      [[Team alloc] initWithName:@"Gimnastic" andLeague:@"Spain Liga Adelante" andImage:@"s15019.png" andCountry:@"Spain"],
                      [[Team alloc] initWithName:@"Girona CF" andLeague:@"Spain Liga Adelante" andImage:@"s110062.png" andCountry:@"Spain"],
                      [[Team alloc] initWithName:@"Hercules CF" andLeague:@"Spain Liga Adelante" andImage:@"sHerc.png" andCountry:@"Spain"],
                      [[Team alloc] initWithName:@"RC Deportivo" andLeague:@"Spain Liga Adelante" andImage:@"s242.png" andCountry:@"Spain"],
                      [[Team alloc] initWithName:@"RC Recreativo" andLeague:@"Spain Liga Adelante" andImage:@"s571.png" andCountry:@"Spain"],
                      [[Team alloc] initWithName:@"Real Murcia" andLeague:@"Spain Liga Adelante" andImage:@"s1855.png" andCountry:@"Spain"],
                      [[Team alloc] initWithName:@"Real Valladolid" andLeague:@"Spain Liga Adelante" andImage:@"s462.png" andCountry:@"Spain"],
                      [[Team alloc] initWithName:@"Sabadell FC" andLeague:@"Spain Liga Adelante" andImage:@"s15021.png" andCountry:@"Spain"],
                      [[Team alloc] initWithName:@"SD Huesca" andLeague:@"Spain Liga Adelante" andImage:@"s110839.png" andCountry:@"Spain"],
                      [[Team alloc] initWithName:@"UD Almeria" andLeague:@"Spain Liga Adelante" andImage:@"s1861.png" andCountry:@"Spain"],
                      [[Team alloc] initWithName:@"UD Las Palmas" andLeague:@"Spain Liga Adelante" andImage:@"s472.png" andCountry:@"Spain"],
                      [[Team alloc] initWithName:@"Villarrael B" andLeague:@"Spain Liga Adelante" andImage:@"s483.png" andCountry:@"Spain"],
                      [[Team alloc] initWithName:@"Xerez CD" andLeague:@"Spain Liga Adelante" andImage:@"s1742.png" andCountry:@"Spain"],
                      [[Team alloc] initWithName:@"Athletic Bilbao" andLeague:@"Spain Liga BBVA" andImage:@"s448.png" andCountry:@"Spain"],
                      [[Team alloc] initWithName:@"Atletico Madrid" andLeague:@"Spain Liga BBVA" andImage:@"s240.png" andCountry:@"Spain"],
                      [[Team alloc] initWithName:@"CA Osasuna" andLeague:@"Spain Liga BBVA" andImage:@"s479.png" andCountry:@"Spain"],
                      [[Team alloc] initWithName:@"FC Barcelona" andLeague:@"Spain Liga BBVA" andImage:@"s241.png" andCountry:@"Spain"],
                      [[Team alloc] initWithName:@"Getafe CF" andLeague:@"Spain Liga BBVA" andImage:@"s1860.png" andCountry:@"Spain"],
                      [[Team alloc] initWithName:@"Granada CF" andLeague:@"Spain Liga BBVA" andImage:@"s110832.png" andCountry:@"Spain"],
                      [[Team alloc] initWithName:@"Levante UD" andLeague:@"Spain Liga BBVA" andImage:@"s1853.png" andCountry:@"Spain"],
                      [[Team alloc] initWithName:@"Malaga CF" andLeague:@"Spain Liga BBVA" andImage:@"s573.png" andCountry:@"Spain"],
                      [[Team alloc] initWithName:@"Racing Club Spain" andLeague:@"Spain Liga BBVA" andImage:@"s456.png" andCountry:@"Spain"],
                      [[Team alloc] initWithName:@"Rayo Vallecano" andLeague:@"Spain Liga BBVA" andImage:@"s480.png" andCountry:@"Spain"],
                      [[Team alloc] initWithName:@"RCD Espanyol" andLeague:@"Spain Liga BBVA" andImage:@"s452.png" andCountry:@"Spain"],
                      [[Team alloc] initWithName:@"RCD Mallorca" andLeague:@"Spain Liga BBVA" andImage:@"s453.png" andCountry:@"Spain"],
                      [[Team alloc] initWithName:@"Real Betis" andLeague:@"Spain Liga BBVA" andImage:@"s449.png" andCountry:@"Spain"],
                      [[Team alloc] initWithName:@"Real Madrid" andLeague:@"Spain Liga BBVA" andImage:@"s243.png" andCountry:@"Spain"],
                      [[Team alloc] initWithName:@"Real Sociedad" andLeague:@"Spain Liga BBVA" andImage:@"s457.png" andCountry:@"Spain"],
                      [[Team alloc] initWithName:@"Real Sporting" andLeague:@"Spain Liga BBVA" andImage:@"s459.png" andCountry:@"Spain"],
                      [[Team alloc] initWithName:@"Real Zaragoza" andLeague:@"Spain Liga BBVA" andImage:@"s244.png" andCountry:@"Spain"],
                      [[Team alloc] initWithName:@"Sevilla FC" andLeague:@"Spain Liga BBVA" andImage:@"s481.png" andCountry:@"Spain"],
                      [[Team alloc] initWithName:@"Valencia CF" andLeague:@"Spain Liga BBVA" andImage:@"s461.png" andCountry:@"Spain"],
                      [[Team alloc] initWithName:@"Villarrael CF" andLeague:@"Spain Liga BBVA" andImage:@"s110902.png" andCountry:@"Spain"],
                      [[Team alloc] initWithName:@"AIK Fotboll" andLeague:@"Sweden Allsvenskan" andImage:@"s433.png" andCountry:@"Sweden"],
                      [[Team alloc] initWithName:@"BK Hacken" andLeague:@"Sweden Allsvenskan" andImage:@"s711.png" andCountry:@"Sweden"],
                      [[Team alloc] initWithName:@"Djurgardens IF" andLeague:@"Sweden Allsvenskan" andImage:@"s710.png" andCountry:@"Sweden"],
                      [[Team alloc] initWithName:@"GAIS" andLeague:@"Sweden Allsvenskan" andImage:@"s111594.png" andCountry:@"Sweden"],
                      [[Team alloc] initWithName:@"Gefle IF" andLeague:@"Sweden Allsvenskan" andImage:@"s111277.png" andCountry:@"Sweden"],
                      [[Team alloc] initWithName:@"Halmstads BK" andLeague:@"Sweden Allsvenskan" andImage:@"s321.png" andCountry:@"Sweden"],
                      [[Team alloc] initWithName:@"Halsingborgs IF" andLeague:@"Sweden Allsvenskan" andImage:@"s432.png" andCountry:@"Sweden"],
                      [[Team alloc] initWithName:@"IF Elfsborg" andLeague:@"Sweden Allsvenskan" andImage:@"s700.png" andCountry:@"Sweden"],
                      [[Team alloc] initWithName:@"IFK Goteborg" andLeague:@"Sweden Allsvenskan" andImage:@"s319.png" andCountry:@"Sweden"],
                      [[Team alloc] initWithName:@"IFK Norrkoping" andLeague:@"Sweden Allsvenskan" andImage:@"s702.png" andCountry:@"Sweden"],
                      [[Team alloc] initWithName:@"Kalmar FF" andLeague:@"Sweden Allsvenskan" andImage:@"s1439.png" andCountry:@"Sweden"],
                      [[Team alloc] initWithName:@"Malmo FF" andLeague:@"Sweden Allsvenskan" andImage:@"s320.png" andCountry:@"Sweden"],
                      [[Team alloc] initWithName:@"Mjallby AIF" andLeague:@"Sweden Allsvenskan" andImage:@"s112072.png" andCountry:@"Sweden"],
                      [[Team alloc] initWithName:@"Orebro SK" andLeague:@"Sweden Allsvenskan" andImage:@"s705.png" andCountry:@"Sweden"],
                      [[Team alloc] initWithName:@"Syrianska" andLeague:@"Sweden Allsvenskan" andImage:@"s112267.png" andCountry:@"Sweden"],
                      [[Team alloc] initWithName:@"Trelleborgs FF" andLeague:@"Sweden Allsvenskan" andImage:@"s703.png" andCountry:@"Sweden"],
                      [[Team alloc] initWithName:@"BSC Young Boys" andLeague:@"Switzerland Axpo SL" andImage:@"s900.png" andCountry:@"Switzerland"],
                      [[Team alloc] initWithName:@"FC Basel" andLeague:@"Switzerland Axpo SL" andImage:@"s896.png" andCountry:@"Switzerland"],
                      [[Team alloc] initWithName:@"FC Lausanne" andLeague:@"Switzerland Axpo SL" andImage:@"s1862.png" andCountry:@"Switzerland"],
                      [[Team alloc] initWithName:@"FC Luzern" andLeague:@"Switzerland Axpo SL" andImage:@"s897.png" andCountry:@"Switzerland"],
                      [[Team alloc] initWithName:@"FC Sion" andLeague:@"Switzerland Axpo SL" andImage:@"s110770.png" andCountry:@"Switzerland"],
                      [[Team alloc] initWithName:@"FC Thun" andLeague:@"Switzerland Axpo SL" andImage:@"s1715.png" andCountry:@"Switzerland"],
                      [[Team alloc] initWithName:@"FC Zurich" andLeague:@"Switzerland Axpo SL" andImage:@"s894.png" andCountry:@"Switzerland"],
                      [[Team alloc] initWithName:@"Grasshopper" andLeague:@"Switzerland Axpo SL" andImage:@"s322.png" andCountry:@"Switzerland"],
                      [[Team alloc] initWithName:@"Neuchatel Xamax" andLeague:@"Switzerland Axpo SL" andImage:@"s435.png" andCountry:@"Switzerland"],
                      [[Team alloc] initWithName:@"Servette FC" andLeague:@"Switzerland Axpo SL" andImage:@"s324.png" andCountry:@"Switzerland"],
                      [[Team alloc] initWithName:@"Chicago Fire" andLeague:@"United States MLS" andImage:@"s693.png" andCountry:@"USA"],
                      [[Team alloc] initWithName:@"Chivas USA" andLeague:@"United States MLS" andImage:@"s111070.png" andCountry:@"USA"],
                      [[Team alloc] initWithName:@"Colorado Rapids" andLeague:@"United States MLS" andImage:@"s694.png" andCountry:@"USA"],
                      [[Team alloc] initWithName:@"Columbus Crew" andLeague:@"United States MLS" andImage:@"s687.png" andCountry:@"USA"],
                      [[Team alloc] initWithName:@"D.C. United" andLeague:@"United States MLS" andImage:@"s688.png" andCountry:@"USA"],
                      [[Team alloc] initWithName:@"FC Dallas" andLeague:@"United States MLS" andImage:@"s695.png" andCountry:@"USA"],
                      [[Team alloc] initWithName:@"Houston Dynamo" andLeague:@"United States MLS" andImage:@"s698.png" andCountry:@"USA"],
                      [[Team alloc] initWithName:@"L.A. Galaxy" andLeague:@"United States MLS" andImage:@"s697.png" andCountry:@"USA"],
                      [[Team alloc] initWithName:@"New England" andLeague:@"United States MLS" andImage:@"s691.png" andCountry:@"USA"],
                      [[Team alloc] initWithName:@"NY Red Bulls" andLeague:@"United States MLS" andImage:@"s689.png" andCountry:@"USA"],
                      [[Team alloc] initWithName:@"Philadelphia" andLeague:@"United States MLS" andImage:@"s112134.png" andCountry:@"USA"],
                      [[Team alloc] initWithName:@"Portland" andLeague:@"United States MLS" andImage:@"s111140.png" andCountry:@"USA"],
                      [[Team alloc] initWithName:@"Real Salt Lake" andLeague:@"United States MLS" andImage:@"s111065.png" andCountry:@"USA"],
                      [[Team alloc] initWithName:@"SJ Earthquakes" andLeague:@"United States MLS" andImage:@"s111928.png" andCountry:@"USA"],
                      [[Team alloc] initWithName:@"Sounders FC" andLeague:@"United States MLS" andImage:@"s111144.png" andCountry:@"USA"],
                      [[Team alloc] initWithName:@"Sporting KC" andLeague:@"United States MLS" andImage:@"s696.png" andCountry:@"USA"],
                      [[Team alloc] initWithName:@"Toronto FC" andLeague:@"United States MLS" andImage:@"s111651.png" andCountry:@"USA"],
                      [[Team alloc] initWithName:@"Whitecaps FC" andLeague:@"United States MLS" andImage:@"sWhitecaps.png" andCountry:@"USA"],
                      
                      nil];
        
        [self sortAtoZ];
        return;
}

-(NSMutableArray *)getCopyTeamData
{
    NSMutableArray *returnArr = [[NSMutableArray alloc] initWithArray:teamInfo];
    return returnArr;
}

    
-(NSUInteger)teamInfoCount
{
        return [teamInfo count];
}
    
- (id)getTeamAtIndex:(NSUInteger)index
{
        //[self.team
        return [teamInfo objectAtIndex:index];
}
    
-(void)sortAtoZ
{
    NSComparator sortAscending = ^(Team *t1, Team *t2)
    {
        return [t1.name compare:t2.name];
    };
        
        [teamInfo sortUsingComparator:sortAscending];
        [self setIndexes];
}
    
-(void)setIndexes
{
    for (int i = 0; i < [teamInfo count]; i++)
    {
        [[teamInfo objectAtIndex:i] setIndex:[NSNumber numberWithInt:i]];
    }
}


@end