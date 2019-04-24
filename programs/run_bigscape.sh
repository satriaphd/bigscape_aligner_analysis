#!/bin/bash

rm -rf ../preprocessed/bigscape_res/
mkdir ../preprocessed/bigscape_res
echo "" > ../preprocessed/bash_log.txt
for i in ../preprocessed/samples/*.txt
do
    s=${i##*/}
    s=${s%.txt}
    echo "--------------------------------------------------$s--------------------------------------------------" >> ../preprocessed/bash_log.txt
    python BiG-SCAPE/bigscape_hmmalign.py -i $i -o ../preprocessed/bigscape_res/$s-hmmalign/ -c 16 --mix --no_classify --pfam_dir ../inputs/ >> ../preprocessed/bash_log.txt
    python BiG-SCAPE/bigscape_muscle.py -i $i -o ../preprocessed/bigscape_res/$s-muscle/ -c 16 --mix --no_classify --pfam_dir ../inputs/ >> ../preprocessed/bash_log.txt
    python BiG-SCAPE/bigscape_mafft.py -i $i -o ../preprocessed/bigscape_res/$s-mafft/ -c 16 --mix --no_classify --pfam_dir ../inputs/ >> ../preprocessed/bash_log.txt    
    echo "--------------------------------------------------$s--------------------------------------------------" >> ../preprocessed/bash_log.txt
done
