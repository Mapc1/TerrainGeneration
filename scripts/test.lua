function testPass(material)
    local octaves = {0}
    local prev_octaves = {0}
    getAttr("STATE", material, "OCTAVES", 0, octaves)
    getAttr("STATE", material, "PREV_OCTAVES", 0, prev_octaves)

    local starting_amplitude = {0}
    local prev_starting_amplitude = {0}
    getAttr("STATE", material, "STARTING_AMPLITUDE", 0, starting_amplitude)
    getAttr("STATE", material, "PREV_STARTING_AMPLITUDE", 0, prev_starting_amplitude)

    local starting_freq = {0}
    local prev_starting_freq = {0}
    getAttr("STATE", material, "STARTING_FREQ", 0, starting_freq)
    getAttr("STATE", material, "PREV_STARTING_FREQ", 0, prev_starting_freq)

    local gain = {0}
    local prev_gain = {0}
    getAttr("STATE", material, "GAIN", 0, gain)
    getAttr("STATE", material, "PREV_GAIN", 0, prev_gain)

    local lacunarity = {0}
    local prev_lacunarity = {0}
    getAttr("STATE", material, "LACUNARITY", 0, lacunarity)
    getAttr("STATE", material, "PREV_LACUNARITY", 0, prev_lacunarity)
    
    if prev_octaves[1] ~= octaves[1] or
       prev_starting_amplitude[1] ~= starting_amplitude[1] or
       prev_starting_freq[1] ~= starting_freq[1] or
       prev_gain[1] ~= gain[1] or
       prev_lacunarity[1] ~= lacunarity[1]
    then
        return true
    end

    return false
end

function testOtherParams()
    local continental_power = {0}
    local prev_continental_power = {0}
    getAttr("STATE", "TerrainGen::GenDisplacement", "CONTINENTAL_POWER", 0, continental_power)
    getAttr("STATE", "TerrainGen::GenDisplacement", "PREV_CONTINENTAL_POWER", 0, prev_continental_power)

    local erosion_power = {0}
    local prev_erosion_power = {0}
    getAttr("STATE", "TerrainGen::GenDisplacement", "EROSION_POWER", 0, erosion_power)
    getAttr("STATE", "TerrainGen::GenDisplacement", "PREV_EROSION_POWER", 0, prev_erosion_power)

    local peaks_and_valleys_power = {0}
    local prev_peaks_and_valleys_power = {0}
    getAttr("STATE", "TerrainGen::GenDisplacement", "PEAKS_AND_VALLEYS_POWER", 0, peaks_and_valleys_power)
    getAttr("STATE", "TerrainGen::GenDisplacement", "PREV_PEAKS_AND_VALLEYS_POWER", 0, prev_peaks_and_valleys_power)

    return prev_continental_power[1] ~= continental_power[1] or
       prev_erosion_power[1] ~= erosion_power[1] or
       prev_peaks_and_valleys_power[1] ~= peaks_and_valleys_power[1]
end

test = function ()
    local traverse = {0}
    getAttr("RENDERER", "CURRENT", "TRAVERSE", 0, traverse)

    return 
        traverse[1] ~= 0 or
        testPass("TerrainGen::GenContinental") or
        testPass("TerrainGen::GenErosion") or
        testPass("TerrainGen::GenPeaksAndValleys") or
        testPass("TerrainGen::GenHumidity") or
        testPass("TerrainGen::GenTemperature") or
        testOtherParams()
end