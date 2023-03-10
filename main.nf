#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { MAIN_PIPELINE } from './workflows/main_pipeline.nf'

workflow {
    MAIN_PIPELINE()
}