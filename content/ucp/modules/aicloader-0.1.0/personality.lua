local AIPersonalityFields = {
    WallDecoration                  = { fieldIndex = 0  , fieldType = "integer"                      },
    Unknown000                      = { fieldIndex = 0  , fieldType = "integer"                      },
    Unknown001                      = { fieldIndex = 1  , fieldType = "integer"                      },
    Unknown002                      = { fieldIndex = 2  , fieldType = "integer"                      },
    Unknown003                      = { fieldIndex = 3  , fieldType = "integer"                      },
    Unknown004                      = { fieldIndex = 4  , fieldType = "integer"                      },
    Unknown005                      = { fieldIndex = 5  , fieldType = "integer"                      },
    CriticalPopularity              = { fieldIndex = 6  , fieldType = "integer"                      },
    LowestPopularity                = { fieldIndex = 7  , fieldType = "integer"                      },
    HighestPopularity               = { fieldIndex = 8  , fieldType = "integer"                      },
    TaxesMin                        = { fieldIndex = 9  , fieldType = "integer"                      },
    TaxesMax                        = { fieldIndex = 10 , fieldType = "integer"                      },
    Unknown011                      = { fieldIndex = 11 , fieldType = "integer"                      },
    Farm1                           = { fieldIndex = 12 , fieldType = "FarmBuildingEnum"             },
    Farm2                           = { fieldIndex = 13 , fieldType = "FarmBuildingEnum"             },
    Farm3                           = { fieldIndex = 14 , fieldType = "FarmBuildingEnum"             },
    Farm4                           = { fieldIndex = 15 , fieldType = "FarmBuildingEnum"             },
    Farm5                           = { fieldIndex = 16 , fieldType = "FarmBuildingEnum"             },
    Farm6                           = { fieldIndex = 17 , fieldType = "FarmBuildingEnum"             },
    Farm7                           = { fieldIndex = 18 , fieldType = "FarmBuildingEnum"             },
    Farm8                           = { fieldIndex = 19 , fieldType = "FarmBuildingEnum"             },
    PopulationPerFarm               = { fieldIndex = 20 , fieldType = "integer"                      },
    PopulationPerWoodcutter         = { fieldIndex = 21 , fieldType = "integer"                      },
    PopulationPerQuarry             = { fieldIndex = 22 , fieldType = "integer"                      },
    PopulationPerIronmine           = { fieldIndex = 23 , fieldType = "integer"                      },
    PopulationPerPitchrig           = { fieldIndex = 24 , fieldType = "integer"                      },
    MaxQuarries                     = { fieldIndex = 25 , fieldType = "integer"                      },
    MaxIronmines                    = { fieldIndex = 26 , fieldType = "integer"                      },
    MaxWoodcutters                  = { fieldIndex = 27 , fieldType = "integer"                      },
    MaxPitchrigs                    = { fieldIndex = 28 , fieldType = "integer"                      },
    MaxFarms                        = { fieldIndex = 29 , fieldType = "integer"                      },
    BuildInterval                   = { fieldIndex = 30 , fieldType = "integer"                      },
    ResourceRebuildDelay            = { fieldIndex = 31 , fieldType = "integer"                      },
    MaxFood                         = { fieldIndex = 32 , fieldType = "integer"                      },
    MinimumApples                   = { fieldIndex = 33 , fieldType = "integer"                      },
    MinimumCheese                   = { fieldIndex = 34 , fieldType = "integer"                      },
    MinimumBread                    = { fieldIndex = 35 , fieldType = "integer"                      },
    MinimumWheat                    = { fieldIndex = 36 , fieldType = "integer"                      },
    MinimumHop                      = { fieldIndex = 37 , fieldType = "integer"                      },
    TradeAmountFood                 = { fieldIndex = 38 , fieldType = "integer"                      },
    TradeAmountEquipment            = { fieldIndex = 39 , fieldType = "integer"                      },
    AIRequestDelay                  = { fieldIndex = 40 , fieldType = "integer"                      },
    Unknown040                      = { fieldIndex = 40 , fieldType = "integer"                      },
    MinimumGoodsRequiredAfterTrade  = { fieldIndex = 41 , fieldType = "integer"                      },
    DoubleRationsFoodThreshold      = { fieldIndex = 42 , fieldType = "integer"                      },
    MaxWood                         = { fieldIndex = 43 , fieldType = "integer"                      },
    MaxStone                        = { fieldIndex = 44 , fieldType = "integer"                      },
    MaxResourceOther                = { fieldIndex = 45 , fieldType = "integer"                      },
    MaxEquipment                    = { fieldIndex = 46 , fieldType = "integer"                      },
    MaxBeer                         = { fieldIndex = 47 , fieldType = "integer"                      },
    MaxResourceVariance             = { fieldIndex = 48 , fieldType = "integer"                      },
    RecruitGoldThreshold            = { fieldIndex = 49 , fieldType = "integer"                      },
    BlacksmithSetting               = { fieldIndex = 50 , fieldType = "BlacksmithSettingEnum"        },
    FletcherSetting                 = { fieldIndex = 51 , fieldType = "FletcherSettingEnum"          },
    PoleturnerSetting               = { fieldIndex = 52 , fieldType = "PoleturnerSettingEnum"        },
    SellResource01                  = { fieldIndex = 53 , fieldType = "ResourceEnum"                 },
    SellResource02                  = { fieldIndex = 54 , fieldType = "ResourceEnum"                 },
    SellResource03                  = { fieldIndex = 55 , fieldType = "ResourceEnum"                 },
    SellResource04                  = { fieldIndex = 56 , fieldType = "ResourceEnum"                 },
    SellResource05                  = { fieldIndex = 57 , fieldType = "ResourceEnum"                 },
    SellResource06                  = { fieldIndex = 58 , fieldType = "ResourceEnum"                 },
    SellResource07                  = { fieldIndex = 59 , fieldType = "ResourceEnum"                 },
    SellResource08                  = { fieldIndex = 60 , fieldType = "ResourceEnum"                 },
    SellResource09                  = { fieldIndex = 61 , fieldType = "ResourceEnum"                 },
    SellResource10                  = { fieldIndex = 62 , fieldType = "ResourceEnum"                 },
    SellResource11                  = { fieldIndex = 63 , fieldType = "ResourceEnum"                 },
    SellResource12                  = { fieldIndex = 64 , fieldType = "ResourceEnum"                 },
    SellResource13                  = { fieldIndex = 65 , fieldType = "ResourceEnum"                 },
    SellResource14                  = { fieldIndex = 66 , fieldType = "ResourceEnum"                 },
    SellResource15                  = { fieldIndex = 67 , fieldType = "ResourceEnum"                 },
    DefWallPatrolRallyTime          = { fieldIndex = 68 , fieldType = "integer"                      },
    DefWallPatrolGroups             = { fieldIndex = 69 , fieldType = "integer"                      },
    DefSiegeEngineGoldThreshold     = { fieldIndex = 70 , fieldType = "integer"                      },
    DefSiegeEngineBuildDelay        = { fieldIndex = 71 , fieldType = "integer"                      },
    Unknown072                      = { fieldIndex = 72 , fieldType = "integer"                      },
    Unknown073                      = { fieldIndex = 73 , fieldType = "integer"                      },
    RecruitProbDefDefault           = { fieldIndex = 74 , fieldType = "integer"                      },
    RecruitProbDefWeak              = { fieldIndex = 75 , fieldType = "integer"                      },
    RecruitProbDefStrong            = { fieldIndex = 76 , fieldType = "integer"                      },
    RecruitProbRaidDefault          = { fieldIndex = 77 , fieldType = "integer"                      },
    RecruitProbRaidWeak             = { fieldIndex = 78 , fieldType = "integer"                      },
    RecruitProbRaidStrong           = { fieldIndex = 79 , fieldType = "integer"                      },
    RecruitProbAttackDefault        = { fieldIndex = 80 , fieldType = "integer"                      },
    RecruitProbAttackWeak           = { fieldIndex = 81 , fieldType = "integer"                      },
    RecruitProbAttackStrong         = { fieldIndex = 82 , fieldType = "integer"                      },
    SortieUnitRangedMin             = { fieldIndex = 83 , fieldType = "integer"                      },
    SortieUnitRanged                = { fieldIndex = 84 , fieldType = "UnitEnum"                     },
    SortieUnitMeleeMin              = { fieldIndex = 85 , fieldType = "integer"                      },
    SortieUnitMelee                 = { fieldIndex = 86 , fieldType = "UnitEnum"                     },
    DefDiggingUnitMax               = { fieldIndex = 87 , fieldType = "integer"                      },
    DefDiggingUnit                  = { fieldIndex = 88 , fieldType = "UnitEnum"                     },
    RecruitInterval                 = { fieldIndex = 89 , fieldType = "integer"                      },
    RecruitIntervalWeak             = { fieldIndex = 90 , fieldType = "integer"                      },
    RecruitIntervalStrong           = { fieldIndex = 91 , fieldType = "integer"                      },
    DefTotal                        = { fieldIndex = 92 , fieldType = "integer"                      },
    OuterPatrolGroupsCount          = { fieldIndex = 93 , fieldType = "integer"                      },
    OuterPatrolGroupsMove           = { fieldIndex = 94 , fieldType = "boolean"                      },
    OuterPatrolRallyDelay           = { fieldIndex = 95 , fieldType = "integer"                      },
    DefWalls                        = { fieldIndex = 96 , fieldType = "integer"                      },
    DefUnit1                        = { fieldIndex = 97 , fieldType = "UnitEnum"                     },
    DefUnit2                        = { fieldIndex = 98 , fieldType = "UnitEnum"                     },
    DefUnit3                        = { fieldIndex = 99 , fieldType = "UnitEnum"                     },
    DefUnit4                        = { fieldIndex = 100, fieldType = "UnitEnum"                     },
    DefUnit5                        = { fieldIndex = 101, fieldType = "UnitEnum"                     },
    DefUnit6                        = { fieldIndex = 102, fieldType = "UnitEnum"                     },
    DefUnit7                        = { fieldIndex = 103, fieldType = "UnitEnum"                     },
    DefUnit8                        = { fieldIndex = 104, fieldType = "UnitEnum"                     },
    RaidUnitsBase                   = { fieldIndex = 105, fieldType = "integer"                      },
    RaidUnitsRandom                 = { fieldIndex = 106, fieldType = "integer"                      },
    RaidUnit1                       = { fieldIndex = 107, fieldType = "UnitEnum"                     },
    RaidUnit2                       = { fieldIndex = 108, fieldType = "UnitEnum"                     },
    RaidUnit3                       = { fieldIndex = 109, fieldType = "UnitEnum"                     },
    RaidUnit4                       = { fieldIndex = 110, fieldType = "UnitEnum"                     },
    RaidUnit5                       = { fieldIndex = 111, fieldType = "UnitEnum"                     },
    RaidUnit6                       = { fieldIndex = 112, fieldType = "UnitEnum"                     },
    RaidUnit7                       = { fieldIndex = 113, fieldType = "UnitEnum"                     },
    RaidUnit8                       = { fieldIndex = 114, fieldType = "UnitEnum"                     },
    HarassingSiegeEngine1           = { fieldIndex = 115, fieldType = "HarassingSiegeEngineEnum"     },
    HarassingSiegeEngine2           = { fieldIndex = 116, fieldType = "HarassingSiegeEngineEnum"     },
    HarassingSiegeEngine3           = { fieldIndex = 117, fieldType = "HarassingSiegeEngineEnum"     },
    HarassingSiegeEngine4           = { fieldIndex = 118, fieldType = "HarassingSiegeEngineEnum"     },
    HarassingSiegeEngine5           = { fieldIndex = 119, fieldType = "HarassingSiegeEngineEnum"     },
    HarassingSiegeEngine6           = { fieldIndex = 120, fieldType = "HarassingSiegeEngineEnum"     },
    HarassingSiegeEngine7           = { fieldIndex = 121, fieldType = "HarassingSiegeEngineEnum"     },
    HarassingSiegeEngine8           = { fieldIndex = 122, fieldType = "HarassingSiegeEngineEnum"     },
    HarassingSiegeEnginesMax        = { fieldIndex = 123, fieldType = "integer"                      },
    RaidRetargetDelay               = { fieldIndex = 124, fieldType = "integer"                      },
    Unknown124                      = { fieldIndex = 124, fieldType = "integer"                      },
    AttForceBase                    = { fieldIndex = 125, fieldType = "integer"                      },
    AttForceRandom                  = { fieldIndex = 126, fieldType = "integer"                      },
    AttForceSupportAllyThreshold    = { fieldIndex = 127, fieldType = "integer"                      },
    AttForceRallyPercentage         = { fieldIndex = 128, fieldType = "integer"                      },
    Unknown129                      = { fieldIndex = 129, fieldType = "integer"                      },
    AttAssaultDelay                 = { fieldIndex = 130, fieldType = "integer"                      },
    Unknown130                      = { fieldIndex = 130, fieldType = "integer"                      },
    AttUnitPatrolRecommandDelay     = { fieldIndex = 131, fieldType = "integer"                      },
    Unknown132                      = { fieldIndex = 132, fieldType = "integer"                      },
    SiegeEngine1                    = { fieldIndex = 133, fieldType = "SiegeEngineEnum"              },
    SiegeEngine2                    = { fieldIndex = 134, fieldType = "SiegeEngineEnum"              },
    SiegeEngine3                    = { fieldIndex = 135, fieldType = "SiegeEngineEnum"              },
    SiegeEngine4                    = { fieldIndex = 136, fieldType = "SiegeEngineEnum"              },
    SiegeEngine5                    = { fieldIndex = 137, fieldType = "SiegeEngineEnum"              },
    SiegeEngine6                    = { fieldIndex = 138, fieldType = "SiegeEngineEnum"              },
    SiegeEngine7                    = { fieldIndex = 139, fieldType = "SiegeEngineEnum"              },
    SiegeEngine8                    = { fieldIndex = 140, fieldType = "SiegeEngineEnum"              },
    CowThrowInterval                = { fieldIndex = 141, fieldType = "integer"                      },
    Unknown142                      = { fieldIndex = 142, fieldType = "integer"                      },
    AttMaxEngineers                 = { fieldIndex = 143, fieldType = "integer"                      },
    AttDiggingUnit                  = { fieldIndex = 144, fieldType = "UnitEnum"                     },
    AttDiggingUnitMax               = { fieldIndex = 145, fieldType = "integer"                      },
    AttUnitVanguard                 = { fieldIndex = 146, fieldType = "UnitEnum"                     },
    AttUnit2                        = { fieldIndex = 146, fieldType = "UnitEnum"                     },
    AttUnitVanguardMax              = { fieldIndex = 147, fieldType = "integer"                      },
    AttUnit2Max                     = { fieldIndex = 147, fieldType = "integer"                      },
    AttMaxAssassins                 = { fieldIndex = 148, fieldType = "integer"                      },
    AttMaxLaddermen                 = { fieldIndex = 149, fieldType = "integer"                      },
    AttMaxTunnelers                 = { fieldIndex = 150, fieldType = "integer"                      },
    AttUnitPatrol                   = { fieldIndex = 151, fieldType = "UnitEnum"                     },
    AttUnitPatrolMax                = { fieldIndex = 152, fieldType = "integer"                      },
    AttUnitPatrolGroupsCount        = { fieldIndex = 153, fieldType = "integer"                      },
    AttUnitBackup                   = { fieldIndex = 154, fieldType = "UnitEnum"                     },
    AttUnitBackupMax                = { fieldIndex = 155, fieldType = "integer"                      },
    AttUnitBackupGroupsCount        = { fieldIndex = 156, fieldType = "integer"                      },
    AttUnitEngage                   = { fieldIndex = 157, fieldType = "UnitEnum"                     },
    AttUnitEngageMax                = { fieldIndex = 158, fieldType = "integer"                      },
    AttUnitSiegeDef                 = { fieldIndex = 159, fieldType = "UnitEnum"                     },
    AttUnitSiegeDefMax              = { fieldIndex = 160, fieldType = "integer"                      },
    AttUnitSiegeDefGroupsCount      = { fieldIndex = 161, fieldType = "integer"                      },
    AttUnitMain1                    = { fieldIndex = 162, fieldType = "UnitEnum"                     },
    AttUnitMain2                    = { fieldIndex = 163, fieldType = "UnitEnum"                     },
    AttUnitMain3                    = { fieldIndex = 164, fieldType = "UnitEnum"                     },
    AttUnitMain4                    = { fieldIndex = 165, fieldType = "UnitEnum"                     },
    AttMaxDefault                   = { fieldIndex = 166, fieldType = "integer"                      },
    AttMainGroupsCount              = { fieldIndex = 167, fieldType = "integer"                      },
    TargetChoice                    = { fieldIndex = 168, fieldType = "TargetingTypeEnum"            },
}

return AIPersonalityFields