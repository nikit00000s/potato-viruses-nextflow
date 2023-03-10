include { FASTQC } from '../modules/analysis/fastqc/main.nf'
include { helpMessage } from '../modules/helpers/main.nf'
include { setFullPathToReads } from '../modules/helpers/main.nf'
include { setLibraryName } from '../modules/helpers/main.nf'
//include {TEST} from '../modules/test/main.nf'



// Show help message
if (params.get('help', 'false').toBoolean()) {
    helpMessage()
    exit 0
}

Channel
    .from( params.get('libs') )
    .map{ it -> setFullPathToReads(it) }
    .map{ it -> setLibraryName(it) }
    .set{ libs_original }

//.map{ getFullPathToLib(it, params.get('path_to_libs'), params.get('libs_regex')) }
    
workflow MAIN_PIPELINE {
    FASTQC(libs_original)
}
