import os
T_PEAKS = [-1, -0.6, 0.4, 1]; 
T_CONTINENTAL = [-1, 0, 0.5, 1]; 
T_EROSION = [-1, -0.6, 0.4, 1]; 
T_TEMPERATURE = [-1, -0.5, 0.5, 1]; 
T_HUMIDITY = [-1, -0.5, 0.5, 1]; 

# Nome: (ID, Peaks, Continental, Erosion, Humidity, Temperature)
biomes = {
    'Peaks' : (5, T_PEAKS[1], T_CONTINENTAL[1], -1, -1, T_TEMPERATURE[0]),
    'Snow_M' : (3, T_PEAKS[1], T_CONTINENTAL[1],  -1, -1, -1),

    'Plain' : (1, -1, -1, T_EROSION[0], -1, T_TEMPERATURE[0]),
    'Desert' : (4, -1, T_CONTINENTAL[0], T_EROSION[0], -1, T_TEMPERATURE[1]),
    'Florest' : (2, -1, T_CONTINENTAL[0], T_EROSION[0], T_HUMIDITY[0], T_TEMPERATURE[0]),
    'Snow_P' : (7, -1, T_CONTINENTAL[0], T_EROSION[0], -1, -1),
    'Jungle' : (9, -1, T_CONTINENTAL[0], T_EROSION[0], T_HUMIDITY[0], T_TEMPERATURE[1]),

    'Plateau' : (6, -1, T_CONTINENTAL[0], T_EROSION[1], -1, -1)
}

biomes = [
    {
        'KeyWord' : 'PEAKS',
        'ThresHolds' : [
            #Primeiro
            {(T_PEAKS[2],T_PEAKS[3]),(1,1),(1,1),(1,1),(1,1)},
            #Segundo
            {(1,1),(1,1),(1,1),(1,1),(1,1)},
        ]
    },
    {
        'KeyWord' : 'SNOW_MOUNTAIN',
        'ThresHolds' : [
            #Primeiro
            {(1,1),(1,1),(1,1),(1,1),(1,1)},
            #Segundo
            {(1,1),(1,1),(1,1),(1,1),(1,1)},
        ]
    },
    {
        'KeyWord' : 'FOREST',
        'ThresHolds' : [
            #Primeiro
            {(1,1),(1,1),(1,1),(1,1),(1,1)},
            #Segundo
            {(1,1),(1,1),(1,1),(1,1),(1,1)},
        ]
    },
    {
        'KeyWord' : 'JUNGLE',
        'ThresHolds' : [
            #Primeiro
            {(1,1),(1,1),(1,1),(1,1),(1,1)},
            #Segundo
            {(1,1),(1,1),(1,1),(1,1),(1,1)},
        ]
    },
    {
        'KeyWord' : 'DESERT',
        'ThresHolds' : [
            #Primeiro
            {(1,1),(1,1),(1,1),(1,1),(1,1)},
            #Segundo
            {(1,1),(1,1),(1,1),(1,1),(1,1)},
        ]
    },
    {
        'KeyWord' : 'SNOW_PLAINS',
        'ThresHolds' : [
            #Primeiro
            {(1,1),(1,1),(1,1),(1,1),(1,1)},
            #Segundo
            {(1,1),(1,1),(1,1),(1,1),(1,1)},
        ]
    },
    {
        'KeyWord' : 'PLAIN',
        'ThresHolds' : [
            #Primeiro
            {(1,1),(1,1),(1,1),(1,1),(1,1)},
            #Segundo
            {(1,1),(1,1),(1,1),(1,1),(1,1)},
        ]
    },
    {
        'KeyWord' : 'PLATEAU',
        'ThresHolds' : [
            #Primeiro
            {(1,1),(1,1),(1,1),(1,1),(1,1)},
            #Segundo
            {(1,1),(1,1),(1,1),(1,1),(1,1)},
        ]
    }
]

#const int OCEAN = 0,
#        PLAIN = 1,
#        FOREST = 2,
#
#        DESERT = 4,
#        PLATEAU = 6, //More optional than the others
#        SNOW_PLAINS = 7, //More optional than the others
#        FROZEN_OCEAN = 8,
#        JUNGLE = 9,
#        DEBUG = 10;



{{{{{
    
}}}}}
peaksIndices = []
continentalIndices = []
erosionIndices = []
humidityIndices = []
temperatureIndices = []

lut = {}

def addTemp(name, idx, temp, tab):
    tab[temp] = (name, idx)

def addHumid(name, idx, humid, temp, tab):
    if humid not in tab:
        tab[humid] = {}

    addTemp(name,idx,temp,tab[humid])

def addErosion(name, idx, erosion, humid, temp, tab):
    if erosion not in tab:
        tab[erosion] = {}

    addHumid(name, idx, humid, temp, tab[erosion])

def addCont(name, idx, cont, erosion, humid, temp, tab):
    if cont not in tab:
        tab[cont] = {}

    addErosion(name, idx, erosion, humid, temp, tab[cont])

def addPeaks(name, idx, peaks, cont, erosion, humid, temp, tab):
    if peaks not in tab:
        tab[peaks] = {}

    addCont(name, idx, cont, erosion, humid, temp, tab[peaks])
    

def writeTemperature(tab) -> str:
    values = list(tab.values())
    length = len(values)

    string = '\t\t\t\t{'
    for i in range(length):
        string += str(values[i][1])
        if i != length-1:
            string += ','
    string += '}'

    return string

def writeHumidity(tab) -> str:
    values = list(tab.values())
    length = len(values)

    string = '\n\t\t\t{\n'
    for i in range(length):
        string += writeTemperature(values[i])
        if i != length-1:
            string += ','
    string += '\n\t\t\t}'

    return string


def writeErosion(tab) -> str:
    values = list(tab.values())
    length = len(values)

    string = '\n\t\t{\n'
    for i in range(length):
        string += writeHumidity(values[i])
        if i != length-1:
            string += ','
    string += '\n\t\t}'

    return string

def writeCont(tab) -> str:
    values = list(tab.values())
    length = len(values)

    string = '\n\t{\n'
    for i in range(length):
        string += writeErosion(values[i])
        if i != length-1:
            string += ','
    string += '\n\t}'

    return string

def writePeaks(tab) -> str:
    values = list(tab.values())
    length = len(values)

    string = '\n{\n'
    for i in range(length):
        string += f'{writeCont(values[i])}'
        if i != length-1:
            string += ','
    string += '\n};'

    return string

def writeLUT() -> str:
    return f'int BIOME_LUT[][][][][] = {writePeaks(lut)}'
    

def writeIndices(name, values) -> str:
    length = len(values)
    string = f'float {name}[{length}] = '

    string += '{'
    for i in range(length):
        string += str(values[i])
        if i != length-1:
            string += ', '
    string += '};\n'

    return string


for name, (idx, peaks, cont, erosion, humid, temp) in biomes.items():
    addPeaks(name, idx, peaks, cont, erosion, humid, temp, lut)

peakSet = set()
contSet = set()
erosionSet = set()
humidSet = set()
tempSet = set()

for peaks, tab1 in lut.items():
    peakSet.add(peaks)
    
    for cont, tab2 in tab1.items():
        contSet.add(cont)

        for erosion, tab3 in tab2.items():
            erosionSet.add(erosion)

            for humid, tab4 in tab3.items():
                humidSet.add(humid)

                for temp in tab4.keys():
                    tempSet.add(temp)
    

peakSet.add(1.0)
contSet.add(1.0)
erosionSet.add(1.0)
humidSet.add(1.0)
tempSet.add(1.0)

peaksIndices = list(peakSet)
continentalIndices = list(contSet)
erosionIndices = list(erosionSet)
humidityIndices = list(humidSet)
temperatureIndices = list(tempSet)

peaksIndices.sort()
continentalIndices.sort()
erosionIndices.sort()
humidityIndices.sort()
temperatureIndices.sort()
    
with open('biomeLUT.glsl', 'w') as file:
    file.write(writeIndices('PEAKS_IDX', peaksIndices))
    file.write(writeIndices('CONTINENTAL_IDX', continentalIndices))
    file.write(writeIndices('EROSION_IDX', erosionIndices))
    file.write(writeIndices('HUMIDITY_IDX', humidityIndices))
    file.write(writeIndices('TEMPERATURE_IDX', temperatureIndices))
    file.write('\n')
    file.write(writeLUT())