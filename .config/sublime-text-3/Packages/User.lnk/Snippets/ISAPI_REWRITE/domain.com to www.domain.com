<snippet>
<content><![CDATA[
RewriteCond Host: ^(domain\.com)$
RewriteRule (.*) http://www.$1$2 [I,R]

]]></content>
	<!-- Optional: Set a tabTrigger to define how to trigger the snippet -->
	<!-- <tabTrigger>hello</tabTrigger> -->
	<!-- Optional: Set a scope to limit where the snippet will trigger -->
	<scope>text.html</scope>
</snippet>
