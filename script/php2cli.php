<?php
include('inc/basic.inc');
$conf = is_file(__DIR__.'/inc/hs_conf.inc') ? __DIR__.'/inc/hs_conf.inc' : __DIR__.'/inc/conf.inc';
include($conf);
$version_file = _VERSION_FILE;
$version = _VERSION;

if (!Phar::canWrite()) {
    die("Phar is in read-only mode, try php -d phar.readonly=0 cli/create.php\n");
}
if(count($argv) !=  3 ){
    e("no arguament -\$action -\$file ",'red');
}else{

    $cmd = $argv[1];
    $file_name = $argv[2];
    $real_file = realpath($file_name);
    $path_vars =  pathinfo($file_name);
    $_dir = $path_vars['dirname'];
}

if(!is_file($real_file)){
    e("file not found ".$_dir.$argv[2],'red');
}else{
    $row=explode('.',$file_name);
    $phar_name=$row[0].'.phar';
    $script=$row[0];
}


@unlink($_dir. '/'.$phar_name);
$p = new Phar($_dir. '/'.$phar_name, 0, $phar_name);
$p->buildFromDirectory($_dir,'/\.php$|\.inc$|hs_*/');


$stub = <<<EOD
#!/usr/bin/env php
<?php
Phar::interceptFileFuncs();

\$path_info = pathinfo(__FILE__);

if (!isset(\$path_info['extension'])){
    \$inc = HS_LIB.\$path_info['basename'].'.phar';
}else{
    \$inc = __FILE__;
}

\$path ="phar://" . \$inc. "/$file_name";


include "\$path";
__HALT_COMPILER();
EOD;
$p->setStub($stub);
chmod($_dir. '/'.$phar_name,0755);

$path_info = pathinfo($phar_name);
$new_name=$path_info['filename'];

if($cmd == '-i'){
    e("mkdir -p ".HS_LIB.";mv $phar_name ".HS_LIB.";ln -s ".HS_LIB."/$phar_name /usr/local/bin/$new_name");
    system("mkdir -p ".HS_LIB.";mv $phar_name ".HS_LIB.";ln -s ".HS_LIB."/$phar_name /usr/local/bin/$new_name");
} else if($cmd == '-b'){
    file_put_contents($version_file,$version);
    e("mv $phar_name ../build/;mv $version_file ../build/");
    system("mv $phar_name ../build/;mv $version_file ../build/");
}

