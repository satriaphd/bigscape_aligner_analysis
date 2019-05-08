#!/bin/bash

rm -rf ../preprocessed/bigscape_res/
mkdir ../preprocessed/bigscape_res
echo "" > ../preprocessed/bash_log.txt
for i in ../preprocessed/samples/*.txt
do
    s=${i##*/}
    s=${s%.txt}
    a=""
    if [ "$1" == "alignonly" ]; then
        a=" --stop_at_alignment"
    fi
    echo "--------------------------------------------------$s--------------------------------------------------" >> ../preprocessed/bash_log.txt
    echo "$s-hmmalign"
    python BiG-SCAPE/bigscape_hmmalign.py$a --domtable_folder ../preprocessed/domtable/ -i $i -o ../preprocessed/bigscape_res/$s-hmmalign/ -c 8 --mix --pfam_dir ../inputs/ >> ../preprocessed/bash_log.txt
    echo "$s-muscle"
    python BiG-SCAPE/bigscape_muscle.py$a --domtable_folder ../preprocessed/domtable/ -i $i -o ../preprocessed/bigscape_res/$s-muscle/ -c 8 --mix --pfam_dir ../inputs/ >> ../preprocessed/bash_log.txt
    echo "$s-mafft"
    python BiG-SCAPE/bigscape_mafft.py$a --domtable_folder ../preprocessed/domtable/ -i $i -o ../preprocessed/bigscape_res/$s-mafft/ -c 8 --mix --pfam_dir ../inputs/ >> ../preprocessed/bash_log.txt    
    echo "--------------------------------------------------$s--------------------------------------------------" >> ../preprocessed/bash_log.txt
done
