#!/usr/bin/php
<?php
if($argc != 3){
    echo 'Usage: ./smartImageDupeRemover.php pathToPictures  pathTo/dupes.txt'."\n\n".
        'pathToPictures - example: /home/share/Pictures - this is where the script will run from'."\n".
        'pathTo/dupes.txt - example: /home/share/Pictures/dupes.txt - this is where the dupes.txt'."\n".
        "\t\t".' file is that is generated with the command: fdupes -r -A -n . > dupes.txt';
    exit(1);
}
if(chdir($argv[1])){
    echo 'changing to directory: '.$argv[1]."\n\n";
}else{
    echo 'Could not change to directory'.$argv[1]."\n";
    exit(1);
}

if(!file_exists($argv[2])){
    echo 'Fdupes file does not exist: '.$argv[2];
    exit(1);
}

// Loops over an fdupes file (fdupes -r -A . > dupes.txt) and determines the 
// duplicate file to detelet by the images that have the fewest tags. 
// It will not delete the two images if they have the same amount of tags.
$handle = fopen($argv[2], "r");
$allFiles = $found = array();
$countDoubles = $countNoKeywords = $countJustOne =0;
$countNotDeleted = 0;
if ($handle) {
    while (($line = fgets($handle)) !== false) {
        $line = trim($line);
        if(empty($line)) {
            echo "\n\n";
            // Finished searching the group of files

            // We found 1 images with keywords, so delete others
            if(count($found) == 1){
                foreach($allFiles as $file){
                    // skip found file
                    if(in_array($file,$found)){
                        echo 'skipping tagged file:'.$file."\n";
                        $countNotDeleted++;
                        continue;
                    }

                    echo 'Deleting: '.$file."\n";
                    unlink($file);
                    $countJustOne++;
                }
            }// We found 0 images with keywords, so delete all but first
            elseif(count($found) == 0){
                for($i=0;$i<count($allFiles);$i++) {
                    if($i==0){
                        echo 'skipping first file:'.$allFiles[$i]."\n";
                        $countNotDeleted++;
                        continue;
                    }
                    echo 'Deleting file'.$allFiles[$i]."\n";
                    unlink($allFiles[$i]);
                    $countNoKeywords++;
                }
            }// We found 2 or more images with keywords, report it and do nothing.
            elseif(count($found) > 1){
                for($i=0;$i<count($allFiles);$i++) {
                    if($i==0){
                        echo 'skipping first file:'.$allFiles[$i]."\n";
                        $countNotDeleted++;
                        continue;
                    }
                    echo 'Deleting file'.$allFiles[$i]."\n";
                    unlink($allFiles[$i]);
                    $countNoKeywords++;
                }
            }

            $allFiles = array();
            $found = array();
        }else{
            // Get the keyword/subject tags
            $output = shell_exec("/usr/bin/exiftool -R --common /home/share/Pictures/".escapeshellarg($line)." | /bin/grep -iE '^(Keywords)|(Subject)\s+:(.*)'");
            $allFiles[] = $line;
            // if the keyword/subject is not empty
            if(preg_match('#.+?:(.+)#',$output, $matches)){
                if(!empty(trim($matches[1]))){
                    // add this to the keep list
                    echo 'found a tag: '.$matches[1]."\n";
                    $found[] = $line;
                }
            }
        }
    }
    echo 'Doubles: '.$countDoubles.', No Keywords:'.$countNoKeywords.', Just One:'.$countJustOne.', Not Deleted:'.$countNotDeleted."\n";
    if (!feof($handle)) {
        echo "Error: unexpected fgets() fail\n";
    }
    fclose($handle);
}
?>