include { FASTQC } from '../modules/analysis/fastqc/main.nf'
include { helpMessage } from '../modules/helpers/main.nf'
include { setFullPathToReads } from '../modules/helpers/main.nf'
include { setLibraryName } from '../modules/helpers/main.nf'


if (params.get('help', 'false').toBoolean()) {
    helpMessage()
    exit 0
}

    
workflow MAIN_PIPELINE {

    Channel
        .from( params.get('libs') )
        .map{ it -> setLibraryName(it) }
        .map{ it -> setFullPathToReads(it) }
        .set{ libs_original }
    
    FASTQC(libs_original)
}
