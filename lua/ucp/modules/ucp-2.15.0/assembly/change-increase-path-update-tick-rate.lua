
local writeCode = core.writeCode
local scanForAOB = core.scanForAOB

-- 0x00499605
writeCode(scanForAOB("3B C1 A3 ? ? ? ? 7E 0A 5E 33 C0 5B 8B E5 5D C2 04 00 C7 05 ? ? ? ? C8 00 00 00 39 4E 6C")+25, {0x32})