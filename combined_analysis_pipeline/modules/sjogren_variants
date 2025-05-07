process getVariants{

    publishDir "$params.output/all_variants", mode: 'copy'

    input: 
    path vcf_file

    output:
    tuple (stdout), path ("*_all_variants.csv")

    script:
    """
    sample_id=\$(${CMD_BCFTOOLS} query -l ${vcf_file})
    echo \${sample_id}
    ${CMD_BCFTOOLS} +split-vep ${vcf_file} -f "\${sample_id},%CHROM,%POS,%REF,%ALT,%Feature,%SYMBOL,%InheritanceModesGene,%Consequence,%IMPACT,%VIPC,%VIPP,%HGVSc,%Gene,%DISTANCE\n" -d -i 'VIPC~"VUS"| VIPC~"P" | VIPC~"LP"' -o "\${sample_id}_all_variants.csv"
    """
}

process getOutliers{
    publishDir "$params.output/outlier_variants", mode: 'copy'

    input:
    tuple val(sample_id), path (variants_csv)

    output:
    path ("*_outlier_output.csv"), optional: true

    script:
    """
    /bin/python3 ${projectDir}/scripts/outliers_sjogren.py -l $params.linking_table -r $params.rna_dir -i ${variants_csv} -s ${sample_id}
    """
}

process getDifferential{
    input:
    tuple val(sample_id), path (variants_csv)

    output:
        stdout

    script:
    """
    ${projectDir}/scripts/get_differential_variants.sh $params.differential_result ${variants_csv}
    """    
}

process getPathway{
    input:
    tuple val(sample_id), path (variants_csv)

    output:
        stdout

    script:
    """
    ${projectDir}/scripts/get_differential_variants.sh $params.pathway_result ${variants_csv}
    """    
}


workflow gatherAllVariants{
    take:
    vip_vcf

    main:
    getVariants(vip_vcf)
    getOutliers(getVariants.out)
    getDifferential(getVariants.out).collectFile(name: 'all_differential_variants.csv', 
                                                storeDir: params.output)
    getPathway(getVariants.out).collectFile(name: 'all_pathway_variants.csv', 
                                                storeDir: params.output)



    emit:
    outliers_found = getOutliers.out
}