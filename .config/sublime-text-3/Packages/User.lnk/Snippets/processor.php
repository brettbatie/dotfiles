<?php
if($argc != 2){
	echo 'usage: '.$argv[0].' /path/to/file.ctl'."\n".
		'Creates snippets for Sublime by converting editplus CTL files.'."\n";
	exit(1);
}

$handle = @fopen($argv[1], "r");
if ($handle) {
	$content = $title = '';
    while (($line = fgets($handle)) !== false) {
        if(stripos($line, '#T=') !== false){
        	saveToFile($title,$content);
        	$title = str_replace('#T=', '', trim($line));
        	$content = '';
        }else{
        	$content .= $line;
        }
    }

    if (!feof($handle)) {
        echo "Error: unexpected fgets() fail\n";
    }
    fclose($handle);

    saveToFile($title,$content);
}

function saveToFile($title,$content){
	if(empty($content) || empty($title)){return;}

	$dir = '.';
	$titleParts = explode(':', $title);
	if(count($titleParts) >= 2){
		$dir = trim($titleParts[0]);
		mkdir($dir);
		$title = trim($titleParts[1]);
	}

	$source = '';
	switch (strtolower($dir)) {
		case 'asp':
			$source = 'source.asp';
			break;
		case 'C#':
			$source = 'source.cs';
			break;
		case 'cassandra':
			$source = 'source.php';
			break;
		case 'cron':
			$source = 'text.plain';
			break;
		case 'css':
			$source = 'source.css';
			break;
		case 'htaccess':
			$source = 'source.ini';
			break;
		case 'jquery':
			$source = 'source.js';
			break;
		case 'linux':
			$source = 'source.shell';
			break;
		case 'php':
			$source = 'source.php';
			break;
		default:
			$source = 'text.html';
			break;
	}

	$content = '<snippet>
<content><![CDATA[
'.$content.'
]]></content>
	<!-- Optional: Set a tabTrigger to define how to trigger the snippet -->
	<!-- <tabTrigger>hello</tabTrigger> -->
	<!-- Optional: Set a scope to limit where the snippet will trigger -->
	<scope>'.$source.'</scope>
</snippet>
';

	file_put_contents($dir.'/'.$title, $content);
	echo $dir.'/'.$title."\n";

}

/*

#T=ASP: database
Set MyConnection = Server.CreateObject("ADODB.Connection")
MyConnection.Open("PROVIDER=SQLOLEDB;SERVER=DOC;UID=fetisql;PWD=5+heze7e;DATABASE=Junonia Development")
Set cmdTemp = Server.CreateObject("ADODB.Command")
cmdTemp.CommandType = 1
Set cmdTemp.ActiveConnection = MyConnection

MyConnection.Close
Set MyConnection = Nothing
#T=ASP: email
Set myMail=CreateObject("CDO.Message")
myMail.Subject="teacenter fedex issue (PHFedex.asp)"
myMail.From="brett@fluentedge.com"
myMail.To="brett@fluentedge.com"
myMail.TextBody="Error #: " & Err.Number & ", Error Description: " & Err.Description
myMail.Send
*/
?>