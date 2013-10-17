<snippet>
<content><![CDATA[
<?php include('include/headtags.php'); ?>
</head>
<body>
<div id="content">
<?php include('include/top.php'); ?>

<?php include('include/bottom.php'); ?>

]]></content>
	<!-- Optional: Set a tabTrigger to define how to trigger the snippet -->
	<!-- <tabTrigger>hello</tabTrigger> -->
	<!-- Optional: Set a scope to limit where the snippet will trigger -->
	<scope>text.html</scope>
</snippet>
