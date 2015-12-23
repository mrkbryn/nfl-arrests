//
//  Crime.h
//  api-example
//
//  Created by Mark Bryan on 12/20/15.
//  Copyright © 2015 Mark Bryan. All rights reserved.
//

#import <Foundation/Foundation.h>

// CrimeType enum may be redundant, unecessary...
typedef enum CrimeType {
    DUI,
    DOMESTIC_VIOLENCE,
    DRUGS,
    ASSAULT,
    DISORDERLY_CONDUCT,
    GUN,
    PUBLIC_INTOXICATION,
    BATTERY,
    ALCOHOL,
    LICENSE,
    THEFT,
    RESISTING_ARREST,
    RECKLESS_DRIVING,
    OUTSTANDING_WARRANT,
    FAILURE_TO_APPEAR,
    SEX,
    OBSTRUCTION,
    TRESSPASSING,
    ANIMAL_ABUSE,
    VIOLATING_COURT_ORDER,
    SEXUAL_ASSAULT,
    SOLICITATION,
    PROBATION_VIOLATION,
    DOMESTIC_DISPUTE,
    PUBLIC_URINATION,
    HARASSMENT,
    MANSLAUGHTER,
    CHILD_SUPPORT,
    MURDER,
    BURGLARY,
    CRIMINAL_MISCHIEF,
    INDECENT_EXPOSURE,
    CHILD_ABUSE,
    FALSE_INFORMATION,
    DOGFIGHTING,
    ATTEMPTED_MURDER,
    DOMESTIC,
    SEXUAL_BATTERY,
    HIT_AND_RUN,
    FALSE_NAME,
    TRAFFIC_WARRANTS,
    RAPE,
    DISTURBING_THE_PEACE,
    HANDICAP_PARKING,
    STOLEN_POSSESSION,
    WEAPON,
    FRAUD,
    PIMPING,
    ANIMAL_CRUELTY,
    EVADING_ARREST,
    RECKLESS_ENDANGERMENT,
    EVADING_POLICE,
    STALKING,
    PROPERTY_DESTRUCTION,
    PRIVACY_INVASION,
    LEAVING_SCENE,
    COERCION,
    RESISTING_OFFICER,
    INTERFERING_WITH_POLICE,
    BREACH_OF_PEACE,
    ANIMAL_NEGLECT
} CrimeType;

/* A crime object with a type, description, and date */
@interface Arrest : NSObject

@property (nonatomic) NSString* date;
@property (nonatomic) NSString* category;
@property (nonatomic) NSString* encounter;
@property (nonatomic) NSString* arrestDescription;
@property (nonatomic) NSString* outcome;
@property (nonatomic) NSString* team;
@property (nonatomic) CrimeType type;

@end
