//
//  Enums.swift
//  Coy_Test
//
//  Created by Coy Coburn on 12/5/22.
//

import Foundation

/* Enums available */
enum pcacSettingsIndex: Int, CaseIterable {
    
    case psv,
     rof,
     fio,
     inspTime,
     inspPres,
     peep,
     ventMeas
}

enum pcacManagementIndex: Int, CaseIterable {
    
    case blood,
    ioxy,
    doxy,
    hyper,
    hypo
}

enum pcacTipsIndex: Int, CaseIterable {
    
    case xray,
    leak,
    gasTime,
    trans,
    sens,
    lowTidal
}

enum pcsimvSettingsIndex: Int, CaseIterable {
    
    case volume,
     rof,
     fio,
     inspTime,
     peep,
     ventMeas
}

enum pcsimvManagementIndex: Int, CaseIterable {
    
    case blood,
    ioxy,
    doxy,
    hyper,
    hypo
}

enum pcsimvTipsIndex: Int, CaseIterable {
    
    case xray,
    leak,
    gasTime,
    trans,
    sens,
    lowTidal
}

enum pcpsvSettingsIndex: Int, CaseIterable {
    
    case psv,
     rof,
     fio,
     inspTime,
     inspPres,
     peep,
     ventMeas
}

enum pcpsvManagementIndex: Int, CaseIterable {
    
    case blood,
    ioxy,
    doxy,
    hyper,
    hypo
}

enum pcpsvTipsIndex: Int, CaseIterable {
    
    case xray,
    leak,
    gasTime,
    trans
}

enum hfjvOverviewIndex: Int, CaseIterable {
    
    case advOne = 1,
    flow,
    advTwo
}

enum hfjvSettingsIndex: Int, CaseIterable {
    
    case pip,
    freq,
    inspiratory,
    deltaP,
    pressure,
    peep,
    backup
}

enum hfjvManagementIndex: Int, CaseIterable {
    
    case gasOne,
    gasTwo,
    gasThree,
    gasFour,
    hyper,
    hypo,
    lung,
    monitor,
    weaning
}

enum hfovSettingsIndex: Int, CaseIterable {
    
    case map,
    bias,
    delta,
    freq,
    ieratio,
    power,
    backup
}

enum hfovManagementIndex: Int, CaseIterable {
    
    case gasOne,
    gasTwo,
    gasThree,
    gasFour,
    hyper,
    hypo,
    lung,
    monitor,
    weaning
}

enum hfovVideosIndex: Int, CaseIterable {
    
    case freqOne,
    freqTwo,
    oscOne,
    oscTwo
}
