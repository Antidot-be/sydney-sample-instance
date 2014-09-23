<?php
include_once '../../../core/library/Sydney/Bootstrapper.php';

$modules = array(
    'default',
    'admin',
    'publicms'
);
$app = new Sydney_Bootstrapper();
// If you want to re-locate the core just change the following :
$app->setCorePath(realpath(__DIR__.'/../../../core'));
$app->setInstancePath(realpath(__DIR__.'/../'));
$app->setModules($modules);
$app->run();
