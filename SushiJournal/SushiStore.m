//
//  SushiStore.m
//  SushiJournal
//
//  Created by Raymond on 20/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SushiStore.h"
#import "SushiItem.h"

@implementation SushiStore
@synthesize  galleryViewChosen, englishChosen, showJapaneseName;

+(SushiStore *) sharedStore
{
    static SushiStore *sharedStore = nil;
    if (!sharedStore)
        sharedStore =[[super allocWithZone:nil] init];

    
    return sharedStore;    
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedStore];
}

-(void) populateWithDefault
{
    [sushiDictionary removeAllObjects];
    
    //All From LuxEat

    SushiItem *Aji = [[SushiItem alloc] 
                      initWithNameEng:@"Horse Mackerel" nameJap:@"鯵 (アジ)" defaultImageName:@"Aji"];
    [sushiDictionary addObject:Aji];
    
    SushiItem *Akagai = [[SushiItem alloc] 
                         initWithNameEng:@"Ark Shell Clam" nameJap:@"赤貝 (アカガイ)" defaultImageName:@"Akagai"];
    [sushiDictionary addObject:Akagai];
    
    SushiItem *Anago = [[SushiItem alloc] 
                        initWithNameEng:@"Salt Water Eel" nameJap:@"穴子 (アナゴ)" defaultImageName: @"Anago"];
    [sushiDictionary addObject:Anago];
    
    SushiItem *Awabi = [[SushiItem alloc] 
                        initWithNameEng:@"Abalone" nameJap:@"鮑 (アワビ)" defaultImageName:@"Abalone"];
    [sushiDictionary addObject:Awabi];
    
    SushiItem *Buri = [[SushiItem alloc] 
                       initWithNameEng:@"Japanese Amberjack" nameJap:@"鰤 (ブリ)" defaultImageName:@"Buri"];
    [sushiDictionary addObject:Buri];
    
    SushiItem *Chutoro = [[SushiItem alloc] 
                          initWithNameEng:@"Medium Fatty Tuna" nameJap:@"中とろ" defaultImageName:@"Chu-toro"];
    [sushiDictionary addObject:Chutoro];
    
    SushiItem *Ebi = [[SushiItem alloc] 
                      initWithNameEng:@"Prawn" nameJap:@"海老 (エビ)" defaultImageName:@"Ebi"];
    [sushiDictionary addObject:Ebi];
    
    SushiItem *Hamaguri = [[SushiItem alloc] 
                           initWithNameEng:@"Clam" nameJap:@"蛤 (ハマグリ)" defaultImageName:@"Hamaguri"];
    [sushiDictionary addObject:Hamaguri];
    
    SushiItem *Hirame = [[SushiItem alloc] 
                         initWithNameEng:@"Fluke" nameJap:@"鮃/平目 (ヒラメ)" defaultImageName:@"Hirame"];
    [sushiDictionary addObject:Hirame];

    SushiItem *Ika = [[SushiItem alloc] 
                        initWithNameEng:@"Squid" nameJap:@"烏賊 (いか)" defaultImageName:@"Ika"];
    [sushiDictionary addObject:Ika];    
    
    SushiItem *Ikura = [[SushiItem alloc] 
                        initWithNameEng:@"Salmon Roe" nameJap:@"イクラ" defaultImageName:@"Ikura"];
    [sushiDictionary addObject:Ikura];

    SushiItem *Iwashi = [[SushiItem alloc] 
                        initWithNameEng:@"Sardine" nameJap:@"鰯 (イワシ)" defaultImageName:@"Iwashi"];
    [sushiDictionary addObject:Iwashi];
    
    SushiItem *Kampyomaki = [[SushiItem alloc] 
                        initWithNameEng:@"Dried Gourd Roll" nameJap:@"乾瓢巻き (かんぴょうまき)" defaultImageName:@"Kampyomaki"];
    [sushiDictionary addObject:Kampyomaki];
    
    SushiItem *Kani = [[SushiItem alloc] 
                             initWithNameEng:@"Crab" nameJap:@"蟹 (カニ)" defaultImageName:@"Kani"];
    [sushiDictionary addObject:Kani];
    
    SushiItem *Karei = [[SushiItem alloc] 
                        initWithNameEng:@"Flatfish" nameJap:@"鰈 (カレイ)" defaultImageName:@"Karei"];
    [sushiDictionary addObject:Karei];
    
    SushiItem *Katsuo = [[SushiItem alloc] 
                         initWithNameEng:@"Skipjack Tuna" nameJap:@"鰹 (カツオ)" defaultImageName:@"Katsuo"];
    [sushiDictionary addObject:Katsuo];

    SushiItem *Kinmedai = [[SushiItem alloc] 
                         initWithNameEng:@"Alfonsino" nameJap:@"金目鯛 (キンメダイ)" defaultImageName:@"Kinmedai"];
    [sushiDictionary addObject:Kinmedai];
    
    SushiItem *Kobashira = [[SushiItem alloc] 
                            initWithNameEng:@"Mactra Clam" nameJap:@"小柱 (こばしら)" defaultImageName:@"Kobashira"];
    [sushiDictionary addObject:Kobashira];
    
    SushiItem *Kohada = [[SushiItem alloc] 
                         initWithNameEng:@"Gizzard Shad" nameJap:@"小鰭 (コハダ)" defaultImageName:@"Kohada"];
    [sushiDictionary addObject:Kohada];
    
    SushiItem *Maguro = [[SushiItem alloc] 
                         initWithNameEng:@"Tuna" nameJap:@"鮪 (まぐろ)" defaultImageName:@"Akami"];
    [sushiDictionary addObject:Maguro];
    
    SushiItem *Mushiawabi = [[SushiItem alloc] 
                             initWithNameEng:@"Steamed Abalone" nameJap:@"蒸し鮑 (むしアワビ)" defaultImageName:@"Mushi-awabi"];
    [sushiDictionary addObject:Mushiawabi];
    
    SushiItem *Ootoro = [[SushiItem alloc] 
                         initWithNameEng:@"Fatty Tuna" nameJap:@"大とろ" defaultImageName:@"Oo-toro"];
    [sushiDictionary addObject:Ootoro];
    
    SushiItem *Saba = [[SushiItem alloc] 
                       initWithNameEng:@"Blue Mackerel" nameJap:@"鯖 (サバ)" defaultImageName:@"Saba"];
    [sushiDictionary addObject:Saba];
    
    SushiItem *Sayori = [[SushiItem alloc] 
                         initWithNameEng:@"Halfbeak" nameJap:@"鱵/針魚 (サヨリ)" defaultImageName:@"Sayori"];
    [sushiDictionary addObject:Sayori];
    
    SushiItem *Sumiika = [[SushiItem alloc] 
                          initWithNameEng:@"Cuttlefish" nameJap:@"墨烏賊 (スミイカ)" defaultImageName:@"Sumi-ika"];
    [sushiDictionary addObject:Sumiika];

    SushiItem *Tai = [[SushiItem alloc] 
                          initWithNameEng:@"Seabream Snapper" nameJap:@"鯛 (タイ)" defaultImageName:@"Tai"];
    [sushiDictionary addObject:Tai];
    
    SushiItem *Uni = [[SushiItem alloc] 
                      initWithNameEng:@"Sea Urchin" nameJap:@"海胆 (ウニ)" defaultImageName:@"Uni"];
    [sushiDictionary addObject:Uni];   
    
    //Google Search

    SushiItem *Kappamaki = [[SushiItem alloc] 
                      initWithNameEng:@"Cucumber Roll" nameJap:@"河童巻き (カッパまき)" defaultImageName:@"Kappamaki"];
    [sushiDictionary addObject:Kappamaki];  

    SushiItem *Tekkamaki = [[SushiItem alloc] 
                            initWithNameEng:@"Tuna Roll" nameJap:@"鉄火巻 (てっかまき)" defaultImageName:@"Tekkamaki"];
    [sushiDictionary addObject:Tekkamaki];  
    
    SushiItem *Amaebi = [[SushiItem alloc] 
                            initWithNameEng:@"Sweet Shrimp" nameJap:@"甘海老 (あまえび)" defaultImageName:@"Amaebi"];
    [sushiDictionary addObject:Amaebi];  
    
    SushiItem *Shako = [[SushiItem alloc] 
                         initWithNameEng:@"Squilla" nameJap:@"蝦蛄 (しゃこ)" defaultImageName:@"Shako"];
    [sushiDictionary addObject:Shako];  
    
    SushiItem *Taco = [[SushiItem alloc] 
                        initWithNameEng:@"Octopus" nameJap:@"蛸 (たこ)" defaultImageName:@"Octopus"];
    [sushiDictionary addObject:Taco];  
    
    SushiItem *Tamago = [[SushiItem alloc] 
                        initWithNameEng:@"Egg" nameJap:@"玉子 (たまご)" defaultImageName:@"Tamago"];
    [sushiDictionary addObject:Tamago];  
    
    SushiItem *Hamachi = [[SushiItem alloc] 
                        initWithNameEng:@"Yellowtail" nameJap:@"魬 (ハマチ)" defaultImageName:@"Hamachi"];
    [sushiDictionary addObject:Hamachi];  
    
    SushiItem *Hotate = [[SushiItem alloc] 
                        initWithNameEng:@"Scallops" nameJap:@"帆立貝 (ホタテガイ)" defaultImageName:@"Hotate"];
    [sushiDictionary addObject:Hotate];  
    
    SushiItem *Kanpachi = [[SushiItem alloc] 
                        initWithNameEng:@"Greater Amberjack" nameJap:@"間八 (カンパチ)" defaultImageName:@"Kanpachi"];
    [sushiDictionary addObject:Kanpachi];  
    
    SushiItem *Sake = [[SushiItem alloc] 
                        initWithNameEng:@"Salmon" nameJap:@"鮭 (サケ)" defaultImageName:@"Sake"];
    [sushiDictionary addObject:Sake];  
    
    SushiItem *Komochikonbu = [[SushiItem alloc] 
                        initWithNameEng:@"Herring Roe on Kelp" nameJap:@"子持ち昆布 (こもちこんぶ)" defaultImageName:@"Komochikonbu"];
    [sushiDictionary addObject:Komochikonbu];  
    
    SushiItem *Unagi = [[SushiItem alloc] 
                        initWithNameEng:@"Eel" nameJap:@"鰻 (ウナギ)" defaultImageName:@"Unagi"];
    [sushiDictionary addObject:Unagi];  

    SushiItem *Sanma = [[SushiItem alloc] 
                        initWithNameEng:@"Pacific Saury" nameJap:@"秋刀魚 (サンマ)" defaultImageName:@"Sanma"];
    [sushiDictionary addObject:Sanma];  
    
    SushiItem *Isaki = [[SushiItem alloc] 
                        initWithNameEng:@"Striped Pigfish" nameJap:@"伊佐木 (イサキ)" defaultImageName:@"Isaki"];
    [sushiDictionary addObject:Isaki];  
    
    SushiItem *Engawa = [[SushiItem alloc] 
                        initWithNameEng:@"Fluke Fin" nameJap:@"縁側 (えんがわ)" defaultImageName:@"Engawa"];
    [sushiDictionary addObject:Engawa];  
    
    //sort alphabetical
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"nameEng" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray = [[[SushiStore sharedStore] sushiDictionary] sortedArrayUsingDescriptors:sortDescriptors];
    [[SushiStore sharedStore] setSushiDictionaryUsing:sortedArray];
   
    
    [self setEnglishChosen:YES];
    [self setGalleryViewChosen:YES];
    [self setShowJapaneseName:YES];
    
    BOOL success = [[SushiStore sharedStore] saveChanges]; 
    
    if (success) {
        NSLog(@"Saved all Sushi Items"); } 
    else {
        NSLog(@"Could not save any Sushi Items"); }
    
    NSLog(@"populatewithdata run");

}

-(NSString *) itemArchivePath
{
    NSArray *documentDirectories= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory=[documentDirectories objectAtIndex:0];
    
    return [documentDirectory stringByAppendingPathComponent:@"items.archive"];
}

-(BOOL)saveChanges
{
    NSString *path= [self itemArchivePath];
    return [NSKeyedArchiver archiveRootObject:sushiDictionary toFile:path];
    

}

-(id) init
{
    self=[super init];
    if (self){
        NSString *path=[self itemArchivePath];
        sushiDictionary=[[NSKeyedUnarchiver unarchiveObjectWithFile:path] mutableCopy];
        
        if(!sushiDictionary){
            sushiDictionary = [[NSMutableArray alloc] init];
        }
    }
    return self;
}


-(NSMutableArray *) sushiDictionary
{

    
    return sushiDictionary;
}



-(void) setSushiDictionaryUsing: (NSArray *) array
{
    [sushiDictionary removeAllObjects];
    [sushiDictionary addObjectsFromArray:array];
}


@end
