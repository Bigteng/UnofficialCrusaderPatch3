
local writeCode = core.writeCode
local scanForAOB = core.scanForAOB

writeCode(scanForAOB("5E 5D 5B C3 8B 0D ? ? ? ? 69 C9 90 04 00 00 5F 5E 5D 66 C7 81 ? ? ? ? 03 00 5B C3")+19, {0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90})