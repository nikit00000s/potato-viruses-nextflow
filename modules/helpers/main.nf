def helpMessage() {
    log.info"""
    Seriously? I don't have time for this ahahaha
    """.stripIndent()
}

def setFullPathToReads(lib_info) {
    lib_mask = params.get('pattern_for_reads').replaceFirst(/\*/, "$lib_info.meta.idx")
    lib_info['path_1'] = new File(
        params.get('path_to_libs'), 
        lib_mask.replaceFirst(/\*/, '1')).getCanonicalPath()
    lib_info['path_2'] = new File(
        params.get('path_to_libs'), 
        lib_mask.replaceFirst(/\*/, '2')).getCanonicalPath()
    return lib_info
}

String getLibraryName(idx) {
    return params.get('pattern_for_libs').replaceFirst(/\*/, "$idx")
}

def setLibraryName(lib_info) {
    lib_info['meta']['lib_name'] = getLibraryName(lib_info.meta.idx)
    return lib_info
}

String getOutputDir(output_type) {
    return new File(
        params.get('path_to_working_dir'))
}