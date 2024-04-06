# upgrade-mw-119-to-139

script to step through updating mediawiki from 1.19 to 1.39 using docker

You will need to be on a bash compatible system, and have docker-composer
installed. on some systems, you wil need to change the script to use "docker
compose" instead.


Instructions: Clone this repo, put your mysqldump file in the import directory, named either import.mysqldump or import.mysqldump.gz.

Then run sh ./do-119-to-139.sh

Once finished, you should have a mediawiki-1.39.mysqldump file.

No warranties &c but "works for me."  Please [contact me](https://zooid.org/~vid) if you need commercial mediawiki/semantic mediawiki assistance. 


