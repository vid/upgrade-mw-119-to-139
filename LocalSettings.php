<?php
$wgSitename         = "mw transition";

$wgMetaNamespace = "interim";
$wgServer = "https://localhost";
$wgScriptPath = "/mw";
$wgArticlePath      = "/w/$1";

$wgResourceBasePath = $wgScriptPath;

$wgEnableEmail = true;
$wgEnableUserEmail = true; 

$wgEnotifUserTalk = false;
$wgEnotifWatchlist = false; 
$wgEmailAuthentication = true;

## Database settings
$wgDBtype = "mysql";
$wgDBserver = getenv("MW_WG_DBSERVER") ?: "mariadb";
$wgDBname = getenv("MW_WG_DBNAME") ?: "mediawiki";
$wgDBuser = getenv("MW_WG_DBUSER") ?: "root";
$wgDBpassword       = getenv("MW_WG_DBPASSWORD") ?: "secret";

