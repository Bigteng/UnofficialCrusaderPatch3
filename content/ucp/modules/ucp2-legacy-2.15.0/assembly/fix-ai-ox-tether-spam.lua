
local writeCode = core.writeCode
local scanForAOB = core.scanForAOB

-- 0x004EFF9A
writeCode(scanForAOB("0F 85 B0 00 00 00 8B 86 ? ? ? ? 8B 8E ? ? ? ? 8B 15 ? ? ? ? 50 51 8B CE 89 54 24 18"), {0x90, 0xE9})