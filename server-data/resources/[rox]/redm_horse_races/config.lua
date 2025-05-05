Config = {}

Config.Debug = false

Config.UseIntegration = false -- 'redemrp' / 'vorp' / false

Config.DefaultRaceStartDelay = 60 * 2 -- default: 60 * 2
Config.DefaultRaceEndTimerDelay = 30 -- default: 30
Config.DefaultRaceCleanupDelay = 15 -- default: 30

Config.EnableRespawnProtection = true
Config.RespawnProtectionMinSpeed = 1.5 -- default: 1.5
Config.RespawnProtectionMinDist = 0.5 -- default: 0.5
Config.RespawnProtectionMaxTime = 6000 -- default: 6000

Config.EnablePopulationRestrictions = true
Config.DefaultPedDensity = 0.0 -- default: 0.0
Config.DefaultAnimalDensity = 0.0 -- default: 0.0
Config.DefaultVehicleDensity = 0.0 -- default: 0.0

Config.EnableRoutingBuckets = true
Config.RoutingBucketRangeStart = 65 -- default: 65
Config.RoutingBucketRangeEnd = 128 -- default: 128

Config.CoronasEnabled = true
Config.CoronasEnableUi = true -- if you experience draw natives bugs set this to false or read README.md for more details
Config.CoronasRenderDistance = 235.0 -- default: 235.0

Config.EnableRaceMusic = true
Config.EnableReverseCamTransition = true
Config.EnableIntroLoadingScreen = true
Config.EnableIntroFlowCutscene = true
Config.EnableRaceEndTimer = true
Config.EnableEndFlowCutsceneAndLeaderboard = true
Config.EnableCloudsTransition = true

Config.SyncedActionRegisterMountsTimeout = 3 -- default: 3 (secs)
Config.SyncedActionInitRaceTimeout = 24 -- default: 24 (secs)
Config.SyncedActionFinishIntroFlowTimeout = 22 -- default: 22 (secs)
Config.SyncedActionPrepareCountdownTimeout = 6 -- default: 6 (secs)
Config.SyncedActionFinishCountdownTimeout = 6 -- default: 6 (secs)
Config.SyncedActionEndRaceTimeout = 12 -- default: 12 (secs)
Config.SyncedActionPrepareEndFlowTimeout = 20 -- default: 20 (secs)
Config.SyncedActionFinishEndFlowTimeout = 36 -- default: 36 (secs)

Config.MsgMountNotFound = 'You\'ll need a mount to join the horse race.'
Config.MsgMountInvalidRider = 'You\'ll need be a rider of mount to join the horse race.'
Config.MsgMountSeatNotFree = 'You\'ll need be a only rider of mount to join the horse race.'
Config.MsgRcNotEnoughPlayers = 'Race canceled, not enough players!'
Config.UiCoronaHostIncreaseRace = 'Increase laps'
Config.UiCoronaHostLowerRace = 'Lower laps'
Config.UiCoronaHostRace = 'Host race: %s, %i laps'
Config.UiCoronaJoinRace = 'Join race: %s, %i laps'
Config.UiCoronaQuitRace = 'Quit race: %s, %i laps'

Config.Races = {
    {
        name = 'Gaptooth Ridge',
        description = 'Lap race around Gaptooth Breach a camp and prominent gang hideout. Located in Gaptooth Ridge region of the New Austin territory.',
        route = {
            vector4(-6112.28, -3312.84, -4.89, 22.95),
            vector4(-6124.53, -3150.53, -1.42, 321.78),
            vector4(-6073.98, -3121.22, -0.93, 223.09),
            vector4(-6013.09, -3198.22, -4.66, 300.43),
            vector4(-5929.79, -3172.43, -5.77, 294.99),
            vector4(-5876.93, -3151.31, -9.97, 204.7),
            vector4(-5884.55, -3216.4, -16.74, 122.34),
            vector4(-5981.42, -3267.58, -21.82, 158.74),
            vector4(-5999.59, -3312.96, -21.91, 148.54),
            vector4(-6037.85, -3409.45, -9.62, 41.29),
            vector4(-6088.19, -3348.17, -6.33, 40.0)
        },
        startPoints = {
            vector4(-6090.19, -3349.91, -6.21, 40.0),
            vector4(-6088.19, -3348.17, -6.33, 40.0),
            vector4(-6086.51, -3346.8, -6.37, 40.0)
        },
        corona = {
            coords = vector3(-6072.06, -3338.33, -4.97),
            heading = 318.02
        },
        props = {
            {
                model = 'mp001_s_mp_finishline01x',
                pos = vector3(-6088.19, -3348.17, -6.33),
                rot = vector3(0.0, 0.0, 40.0)
            },{
                model= 'mp001_s_mp_finishline_banner01x',
                pos = vector3(-6083.66, -3359.42, -6.55),
                rot = vector3(0.0, 0.0, 42.96 + 90.0)
            },{
                model= 'mp001_s_mp_finishline_banner01x',
                pos = vector3(-6077.14, -3353.45, -6.62),
                rot = vector3(0.0, 0.0, 43.49 - 90.0)
            },{
                model= 'mp001_s_mp_finishline_banner02x',
                pos = vector3(-6077.97, -3367.42, -6.97),
                rot = vector3(0.0, 0.0, 35.96 + 90.0)
            },{
                model= 'mp001_s_mp_finishline_banner02x',
                pos = vector3(-6070.14, -3360.45, -7.1),
                rot = vector3(0.0, 0.0, 26.49 - 90.0)
            },{
                model = 'mp001_p_racesignpost03x',
                pos = vector3(-6095.06, -3334.48, -5.14),
                rot = vector3(0.0, 0.0, 25.75 + 180.0)
            },{
                model = 'mp001_p_racesignpost03x',
                pos = vector3(-6102.02, -3337.47, -5.04),
                rot = vector3(0.0, 0.0, 25.82 + 180.0)
            },{
                model = 'mp001_s_mp_racecheckflag02x',
                pos = vector3(-6116.99, -3314.3, -4.26),
                rot = vector3(0.0, 0.0, 8.24 + 90.0)
            },{
                model = 'mp001_s_mp_racecheckflag02x',
                pos = vector3(-6107.31, -3311.82, -4.46),
                rot = vector3(0.0, 0.0, 8.24 - 90.0)
            },{
                model = 'mp001_s_mp_racecheckflag02x',
                pos = vector3(-6129.02, -3149.79, -1.26),
                rot = vector3(0.0, 0.0, 8.24 + 90.0)
            },{
                model = 'mp001_s_mp_racecheckflag02x',
                pos = vector3(-6120.74, -3152.69, -1.18),
                rot = vector3(0.0, 0.0, 8.24 - 90.0)
            },{
                model = 'mp001_p_racesignpost01x',
                pos = vector3(-6120.58, -3139.14, -1.13),
                rot = vector3(0.0, 0.0, 336.83 + 180.0)
            },{
                model = 'mp001_s_mp_racecheckflag02x',
                pos = vector3(-6071.89, -3118.89, -0.69),
                rot = vector3(0.0, 0.0, 226.21 + 90.0)
            },{
                model = 'mp001_s_mp_racecheckflag02x',
                pos = vector3(-6076.23, -3123.83, -0.84),
                rot = vector3(0.0, 0.0, 230.81 - 90.0)
            },{
                model = 'mp001_p_racesignpost12x',
                pos = vector3(-6047.52, -3152.65, -1.37),
                rot = vector3(0.0, 0.0, 200.27 + 180.0)
            },{
                model = 'mp001_s_mp_racecheckflag02x',
                pos = vector3(-6014.53, -3195.26, -4.09),
                rot = vector3(0.0, 0.0, 296.0 + 90.0)
            },{
                model = 'mp001_s_mp_racecheckflag02x',
                pos = vector3(-6011.13, -3201.07, -4.69),
                rot = vector3(0.0, 0.0, 302.2 - 90.0)
            },{
                model = 'mp001_s_mp_racecheckflag02x',
                pos = vector3(-5930.31, -3169.68, -5.37),
                rot = vector3(0.0, 0.0, 290.4 + 90.0)
            },{
                model = 'mp001_s_mp_racecheckflag02x',
                pos = vector3(-5928.75, -3176.22, -5.98),
                rot = vector3(0.0, 0.0, 283.4 - 90.0)
            },{
                model = 'mp001_p_racesignpost05x',
                pos = vector3(-5911.59, -3154.13, -4.77),
                rot = vector3(0.0, 0.0, 297.51 + 180.0)
            },{
                model = 'mp001_p_racesignpost05x',
                pos = vector3(-5906.07, -3161.83, -5.82),
                rot = vector3(0.0, 0.0, 295.17 + 180.0)
            },{
                model = 'mp001_p_racesignpost01x',
                pos = vector3(-5890.12, -3154.63, -7.82),
                rot = vector3(0.0, 0.0, 263.0 + 180.0)
            },{
                model = 'mp001_p_racesignpost01x',
                pos = vector3(-5888.78, -3145.21, -6.7),
                rot = vector3(0.0, 0.0, 262.07 + 180.0)
            },{
                model = 'mp001_s_mp_racecheckflag02x',
                pos = vector3(-5871.04, -3154.9, -11.17),
                rot = vector3(0.0, 0.0, 210.45 + 90.0)
            },{
                model = 'mp001_s_mp_racecheckflag02x',
                pos = vector3(-5877.43, -3159.93, -11.52),
                rot = vector3(0.0, 0.0, 215.92 - 90.0)
            },{
                model = 'mp001_s_mp_racecheckflag02x',
                pos = vector3(-5887.72, -3213.37, -16.7),
                rot = vector3(0.0, 0.0, 124.51 - 90.0)
            },{
                model = 'mp001_s_mp_racecheckflag02x',
                pos = vector3(-5883.24, -3219.88, -16.77),
                rot = vector3(0.0, 0.0, 124.51 + 90.0)
            },{
                model = 'mp001_p_racesignpost03x',
                pos = vector3(-5897.99, -3220.21, -16.96),
                rot = vector3(0.0, 0.0, 119.21 + 180.0)
            },{
                model = 'mp001_p_mp_track_leftturn03',
                pos = vector3(-5971.8, -3265.06, -21.75-1),
                rot = vector3(0.0, 0.0, 82.58),
                isTrackElement = true
            },{
                model = 'mp001_p_mp_track_single01',
                pos = vector3(-5970.6, -3260.09, -21.55),
                rot = vector3(0.0, 0.0, 280.99),
                isTrackElement = true
            },{
                model = 'mp001_p_mp_track_single01',
                pos = vector3(-5972.01 - 0.5, -3270.1, -21.65 - 1),
                rot = vector3(0.0, 0.0, 277.87),
                isTrackElement = true
            },{
                model = 'mp001_p_mp_track_single01',
                pos = vector3(-5954.5, -3256.8, -21.65 - 0.9),
                rot = vector3(3.0, 6.0, 318.33),
                isTrackElement = true
            },{
                model = 'mp001_p_mp_jump_fenceshort02',
                pos = vector3(-5953.8, -3266.75, -21.68 - 1),
                rot = vector3(0.0, 0.0, 198.58),
                isTrackElement = true
            },{
                model = 'mp001_p_mp_track_single01',
                pos = vector3(-5942.0, -3258.0, -21.3 - 1),
                rot = vector3(6.0, 0.0, 290.01),
                noAutoAlignToGround = true,
                isTrackElement = true
            },{
                model = 'mp005_p_mp_cover_sh_ado',
                pos = vector3(-5945.2, -3260.94, -21.65),
                rot = vector3(0.0, 0.0, 228.98),
                isTrackElement = true
            },{
                model = 'mp001_s_mp_racecheckflag02x',
                pos = vector3(-5976.0, -3270.68, -21.61 - 1),
                rot = vector3(0.0, 0.0, 156.3 + 90.0),
                noAutoAlignToGround = true
            },{
                model = 'mp001_s_mp_racecheckflag02x',
                pos = vector3(-5985.2, -3265.92, -21.63),
                rot = vector3(0.0, 0.0, 149.34 - 90.0)
            },{
                model = 'mp001_p_mp_track_straight03',
                pos = vector3(-5982.0, -3271.04, -21.76 - 1),
                rot = vector3(0.0, 0.0, 165.81),
                noAutoAlignToGround = true,
                isTrackElement = true
            },{
                model = 'mp001_p_mp_track_straight03',
                pos = vector3(-5985.5, -3285.13, -21.92 - 1),
                rot = vector3(0.0, 0.0, 152.14),
                isTrackElement = true
            },{
                model = 'mp001_s_mp_racecheckflag02x',
                pos = vector3(-5996.23, -3315.87, -21.91),
                rot = vector3(0.0, 0.0, 156.27 + 90.0)
            },{
                model = 'mp001_s_mp_racecheckflag02x',
                pos = vector3(-6003.66, -3311.35, -21.51),
                rot = vector3(0.0, 0.0, 150.07 - 90.0)
            },{
                model = 'mp001_p_racesignpost03x',
                pos = vector3(-6002.27, -3331.87, -20.05 - 1),
                rot = vector3(0.0, 0.0, 152.12 + 180.0)
            },{
                model = 'mp001_p_racesignpost03x',
                pos = vector3(-6011.76, -3324.94, -20.85 - 1),
                rot = vector3(0.0, 0.0, 110.39 + 180.0)
            },{
                model = 'mp001_p_mp_track_joint03',
                pos = vector3(-5993.3, -3299.62, -22.08 - 1),
                rot = vector3(0.0, 0.0, 150.53),
                isTrackElement = true
            },{
                model = 'mp001_s_mp_racecheckflag02x',
                pos = vector3(-6037.53, -3415.23, -9.07 - 1),
                rot = vector3(0.0, 0.0, 85.11 + 90.0)
            },{
                model = 'mp001_s_mp_racecheckflag02x',
                pos = vector3(-6037.92, -3405.8, -9.61 - 1),
                rot = vector3(0.0, 0.0, 110.39 - 90.0)
            },{
                model = 'mp001_p_mp_track_single01',
                pos = vector3(-6037.02, -3415.21, -9.05 - 1),
                rot = vector3(0.75, 0.0, 112.38),
                isTrackElement = true
            },{
                model = 'mp001_p_mp_track_single01',
                pos = vector3(-6036.8, -3415.2, -9.04 - 1),
                rot = vector3(-2.8, 0.0, 312.67),
                isTrackElement = true
            },{
                model = 'mp001_p_mp_track_single01',
                pos = vector3(-6024.87, -3403.99, -10.13 - 1),
                rot = vector3(-10.0, 0.0, 344.44),
                isTrackElement = true
            }
        }
    }, {
        name = 'Gaptooth Ridge TestTrack',
        description = 'Lap race around Gaptooth Breach a camp and prominent gang hideout. Located in Gaptooth Ridge region of the New Austin territory.',
        route = {
            vector4(-6112.28, -3312.84, -4.89, 22.95),
            vector4(-6124.53, -3150.53, -1.42, 321.78)
        },
        startPoints = {
            vector4(-6090.19, -3349.91, -6.21, 40.0),
            vector4(-6088.19, -3348.17, -6.33, 40.0),
            vector4(-6086.51, -3346.8, -6.37, 40.0)
        }
    }
}