#!/usr/bin/php
<?php
/*
1. Loop over every file in the passed in directory
    2. run exiftool on it to get the DateTimeOriginal
        fall back to creation date
            fall back to FileModifyDate
                fall back to now
    3. Use the date to build a directory structure (in $destination) of YYYY/MM (ex. 2015/January)
    4. See if the file being processed already exists in the directory.
        a. if it does change the name with a counter and try step 4 again.
        b. if it does not, copy the file to the destination.
*/

if($argc != 3){
    echo 'Usage: '.$argv[0].' sourceDirectory destinationDirectory'."\n\n".
    'Copies all files to the destination directory and puts the files in a directory structure of YYYY/MM based on the images create date (but falls back to modified date or now if a creation date is not found.'."\n\n".
    'sourceDirectory - the directory that contains images that will be copied to the destination directory.'."\n\n".
    'destinationDirectory - the directory that all files will be copied to'."\n";
    exit(1);
}

$sourceDirectory = $argv[1];
$destinationDirectory = $argv[2];

if(!is_dir($sourceDirectory)){
    echo 'The sourceDirectory does not exist.'."\n";
    exit(1);
}

@mkdir($destinationDirectory, 0755, true);
if(!is_dir($destinationDirectory)) {
    echo 'The destinationDirectory could not be created'."\n";
    exit(1);
}

$processedFiles=$totalFilesFound=0;

// Recursively loop over all files in the given directory
$di = new RecursiveDirectoryIterator($sourceDirectory, FilesystemIterator::SKIP_DOTS );
foreach (new RecursiveIteratorIterator($di) as $filename => $fileInfo) {
    if(!$fileInfo->isFile()){continue;}
    $totalFilesFound++;
    if(!$fileInfo->isReadable()){continue;}


    $date = exifGetCreationDate($filename);
    $parseDate = date_parse($date);
    if(empty($parseDate['year'])){
        $parseDate['year'] = date('Y');
    }

    if(empty($parseDate['month'])){
        $parseDate['month'] = date('M');
    }else{
        $parseDate['month'] = DateTime::createFromFormat('!n', $parseDate['month'])->format('M');
    }
    
    // build the directory structure
    $currentDestinationDirectory = rtrim($destinationDirectory,'/').'/'.$parseDate['year'].'/'.$parseDate['month'];
    @mkdir($currentDestinationDirectory,0755, true);
    if(!is_dir($currentDestinationDirectory)){
        echo 'ERROR: Could not make directory: '.$currentDestinationDirectory."\n";
        continue;
    }

    $currentDestinationFile = $currentDestinationDirectory.'/'.$fileInfo->getFilename();
    
    // if the file already exists in this location increment the name of the file
    $counter = 0;
    while(file_exists($currentDestinationFile)){
        $currentDestinationFile = $currentDestinationDirectory.'/'.pathinfo($fileInfo->getFilename(), PATHINFO_FILENAME).'_'.(++$counter).pathinfo($fileInfo->getFilename(), PATHINFO_EXTENSION);
    }
    
    // copy the file to the new location
    echo 'copying: '.$filename.' --> '.$currentDestinationFile."\n";
    if(!copy($filename, $currentDestinationFile)){
        echo 'ERROR: Could not copy to destination.';
        continue;
    }
    $processedFiles++;
}

echo 'Successfully Processed: '.$processedFiles."\n";
echo 'Failed to Process: '.($totalFilesFound-$processedFiles)."\n";

function exifGetCreationDate($filename){
    // try to get DatetimeOriginal
    $creationDate = trim(shell_exec('/usr/bin/exiftool -q -s -DateTimeOriginal '.escapeshellarg($filename)));

    // fall back to CreateDate
    if(empty($creationDate)){
        $creationDate = trim(shell_exec('/usr/bin/exiftool -q -s -CreateDate '.escapeshellarg($filename)));
    }

    // fall back to FileModifydate
    if(empty($creationDate)){
        $creationDate = trim(shell_exec('/usr/bin/exiftool -q -s -FileModifyDate '.escapeshellarg($filename)));
    }

    // fall back to now()
    if(empty($creationDate)){
        $creationDate = date('c');
        echo 'default'."\n";
    }
    // parse the time from the exiftool output
    else{
        $creationDate = trim(substr($creationDate,strpos($creationDate,':')+1));
    }

    return $creationDate;
}
?>