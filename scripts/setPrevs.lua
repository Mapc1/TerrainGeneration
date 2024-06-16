function setPrevs(material)
    local new_prev_octaves = {0}
    local new_prev_starting_amplitude = {0}
    local new_prev_starting_freq = {0}
    local new_prev_gain = {0}
    local new_prev_lacunarity = {0}

    getAttr("STATE", material, "OCTAVES", 0, new_prev_octaves)
    setAttr("STATE", material, "PREV_OCTAVES", 0, new_prev_octaves)
    
    getAttr("STATE", material, "STARTING_AMPLITUDE", 0, new_prev_starting_amplitude)
    setAttr("STATE", material, "PREV_STARTING_AMPLITUDE", 0, new_prev_starting_amplitude)

    getAttr("STATE", material, "STARTING_FREQ", 0, new_prev_starting_freq)
    setAttr("STATE", material, "PREV_STARTING_FREQ", 0, new_prev_starting_freq)

    getAttr("STATE", material, "GAIN", 0, new_prev_gain)
    setAttr("STATE", material, "PREV_GAIN", 0, new_prev_gain)

    getAttr("STATE", material, "LACUNARITY", 0, new_prev_lacunarity)
    setAttr("STATE", material, "PREV_LACUNARITY", 0, new_prev_lacunarity)
end

function setDisplacementVars() 
    local new_prev_continental_power = {0}
    local new_prev_erosion_power = {0}
    local new_prev_peaks_and_valleys_power = {0}
    getAttr("STATE", "TerrainGen::GenDisplacement", "CONTINENTAL_POWER", 0, new_prev_continental_power)
    setAttr("STATE", "TerrainGen::GenDisplacement", "PREV_CONTINENTAL_POWER", 0, new_prev_continental_power)
    
    getAttr("STATE", "TerrainGen::GenDisplacement", "EROSION_POWER", 0, new_prev_erosion_power)
    setAttr("STATE", "TerrainGen::GenDisplacement", "PREV_EROSION_POWER", 0, new_prev_erosion_power)
    
    getAttr("STATE", "TerrainGen::GenDisplacement", "PEAKS_AND_VALLEYS_POWER", 0, new_prev_peaks_and_valleys_power)
    setAttr("STATE", "TerrainGen::GenDisplacement", "PREV_PEAKS_AND_VALLEYS_POWER", 0, new_prev_peaks_and_valleys_power)
end

prevs = function ()
    setPrevs("TerrainGen::GenContinental")
    setPrevs("TerrainGen::GenErosion")
    setPrevs("TerrainGen::GenPeaksAndValleys")
    setPrevs("TerrainGen::GenHumidity")
    setPrevs("TerrainGen::GenTemperature")
    setDisplacementVars()
end