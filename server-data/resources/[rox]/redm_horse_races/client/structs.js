exports('GetGroundZFor_3dCoord', (x, y, z, ignoreWater) => {
    const ground = new DataView(new ArrayBuffer(4));
    const result = Citizen.invokeNative('0x24FA4267BB8D2431', x, y, z, ground, ignoreWater);

    return result == true ? ground.getFloat32(0, true) : false;
});

exports('UiFeedPostFeedTicker', (duration, varStr) => {
    const struct1 = new DataView(new ArrayBuffer(48));
    struct1.setInt32(0 * 8, duration, true);

    const struct2 = new DataView(new ArrayBuffer(64));
    struct2.setBigInt64(1 * 8, BigInt(varStr), true);

    Citizen.invokeNative('0xB2920B9760F0F36B', struct1, struct2, 1);
});

exports('UiFeedPostOneTextShard', (duration, text) => {
    const struct1 = new DataView(new ArrayBuffer(48));
    struct1.setInt32(0 * 8, duration, true);

    const struct2 = new DataView(new ArrayBuffer(64));
    struct2.setBigInt64(1 * 8, BigInt(CreateVarString(10, 'LITERAL_STRING', text)), true);

    Citizen.invokeNative('0x860DDFE97CC94DF0', struct1, struct2, 1);
});

exports('UiFeedPostSampleToast', (duration, text, subtext, iconDict, iconName, colorHash, soundDict, soundName) => {
    const struct1 = new DataView(new ArrayBuffer(48));
    struct1.setInt32(0, duration, true);

    if (soundDict && soundName) {
        struct1.setBigInt64(1 * 8, BigInt(CreateVarString(10, "LITERAL_STRING", args[6])), true);
        struct1.setBigInt64(2 * 8, BigInt(CreateVarString(10, "LITERAL_STRING", args[7])), true);
    }

    const struct2 = new DataView(new ArrayBuffer(56));
    struct2.setBigInt64(1 * 8, BigInt(CreateVarString(10, "LITERAL_STRING", text)), true);
    struct2.setBigInt64(2 * 8, BigInt(CreateVarString(10, "LITERAL_STRING", subtext)), true);
    struct2.setBigInt64(4 * 8, BigInt(iconDict), true);
    struct2.setBigInt64(5 * 8, BigInt(iconName), true);
    struct2.setBigInt64(6 * 8, BigInt(colorHash || GetHashKey('COLOR_WHITE')), true);

    Citizen.invokeNative('0x26E87218390E6729', struct1, struct2, 1, 1);
});

exports('GetAnimSceneEntityLocationData', (animScene, entityName, p3, playbackListName, p5) => {
    const struct = new DataView(new ArrayBuffer(128));

    Citizen.invokeNative('0x8398438D8F14F56D', animScene, entityName, struct, p3, playbackListName, p5);

    return [
        struct.getFloat32(0 * 8, true),
        struct.getFloat32(1 * 8, true),
        struct.getFloat32(2 * 8, true),
        struct.getFloat32(3 * 8, true),
        struct.getFloat32(4 * 8, true),
        struct.getFloat32(5 * 8, true)
    ];
});

exports('TaskShootWithWeapon', (playerPed, x, y, z, duration, p6, p7) => {
    const struct = new DataView(new ArrayBuffer(128));
    struct.setFloat32(1 * 8, x, true);
    struct.setFloat32(2 * 8, y, true);
    struct.setFloat32(3 * 8, z, true);
    struct.setInt32(4 * 8, duration, true);
    struct.setInt32(6 * 8, p6, true);
    struct.setInt32(7 * 8, p7, true);

    Citizen.invokeNative('0x08AA95E8298AE772', playerPed, struct);
});

exports('GetPedCurrentMoveBlendRatio', (ped) => {
    const speedX = new DataView(new ArrayBuffer(4));
    const speedY = new DataView(new ArrayBuffer(4));
    const result = Citizen.invokeNative('0xF60165E1D2C5370B', ped, speedX, speedY);

    return result == true ? [speedX.getFloat32(0, true), speedY.getFloat32(0, true)] : false;
})

exports('AnimpostfxHasEventTriggeredByStackhash', (stackhash, p1, p2) => {
    const p3 = new DataView(new ArrayBuffer(4));
    const retVal = Citizen.invokeNative('0x9AB192A9EF980EED', stackhash, p1, p2, p3);

    return retVal;
});

exports('EventsUiPeekMessage', (eventChannel) => {
    const retStruct = new DataView(new ArrayBuffer(32));
    Citizen.invokeNative('0x90237103F27F7937', eventChannel, retStruct);

    return {
        eventType: retStruct.getInt32(8 * 0, true),
        intParam: retStruct.getInt32(8 * 1, true),
        hashParam: retStruct.getInt32(8 * 2, true),
        datastoreParam: retStruct.getInt32(8 * 3, true)
    };
});

exports('UiflowblockRelease', (entry, hash) => {
    const struct = new DataView(new ArrayBuffer(128));
    struct.setBigInt64(0 * 8, BigInt(entry), true);
    struct.setBigInt64(1 * 8, BigInt(hash), true);

    return Citizen.invokeNative('0xF320A77DD5F781DF', struct);
});