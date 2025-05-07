// Gather all modules
include { gatherAllVariants } from './modules/sjogren_variants'


// necessary parameters
params.input = ""
params.linking_table = ""
params.rna_dir = ""
params.differential_result = ""
params.pathway_result = ""
params.output = ""

// run the following workflow
workflow{
    vip_output_channel = Channel.fromPath(params.input+'/*.vcf.gz')
    gatherAllVariants(vip_output_channel)
}