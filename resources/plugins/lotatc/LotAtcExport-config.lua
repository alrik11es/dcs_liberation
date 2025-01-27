-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- configuration file for the LotATC Export script
--
-- This configuration is tailored for a mission generated by DCS Liberation
-- see https://github.com/Khopa/dcs_liberation
-------------------------------------------------------------------------------------------------------------------------------------------------------------

-- LotATC Export plugin - configuration
logger:info("DCSLiberation|LotATC Export plugin - configuration")

local function discoverLotAtcDrawingsPath()
    -- establish a search pattern into the following modes
    -- 1. Environment variable LOTATC_DRAWINGS_DIR, to support server exporting with auto load from LotATC
    -- 2. DCS saved games folder as configured in DCS Liberation

    local drawingEnvDir = os.getenv("LOTATC_DRAWINGS_DIR")
    if drawingEnvDir then
        return drawingEnvDir
    else
        return lfs.writedir()..[[\Mods\services\LotAtc\userdb\drawings\]]
    end
end

if dcsLiberation then
    logger:info("DCSLiberation|LotATC Export plugin - configuration dcsLiberation")

    local exportRedAA = true
    local exportBlueAA = false
    local exportSymbols = true

    -- retrieve specific options values
    if dcsLiberation.plugins then
        logger:info("DCSLiberation|LotATC Export plugin - configuration dcsLiberation.plugins")

        if dcsLiberation.plugins.lotatc then
            logger:info("DCSLiberation|LotATC Export plugin - dcsLiberation.plugins.lotatcExport")

            exportRedAA = dcsLiberation.plugins.lotatc.exportRedAA
            logger:info(string.format("DCSLiberation|LotATC Export plugin - exportRedAA = %s",tostring(exportRedAA)))

            exportBlueAA = dcsLiberation.plugins.lotatc.exportBlueAA
            logger:info(string.format("DCSLiberation|LotATC Export plugin - exportBlueAA = %s",tostring(exportBlueAA)))

            exportBlueAA = dcsLiberation.plugins.lotatc.exportSymbols
            logger:info(string.format("DCSLiberation|LotATC Export plugin - exportSymbols = %s",tostring(exportSymbols)))
        end
    end

    -- actual configuration code
    if LotAtcExportConfig then
        LotAtcExportConfig.exportRedAA = exportRedAA
        LotAtcExportConfig.exportBlueAA = exportBlueAA
        LotAtcExportConfig.exportSymbols = exportSymbols
        LotAtcExportConfig.drawingBasePath = discoverLotAtcDrawingsPath()

        LotatcExport()
    end
end
