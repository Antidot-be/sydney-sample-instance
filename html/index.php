<?php
/** We initialize the autoloader of Zend */
set_include_path(__DIR__ . '/../../../core/library/' . PATH_SEPARATOR . get_include_path());
include_once 'Zend/Loader/Autoloader.php';
$autoloader = Zend_Loader_Autoloader::getInstance();
$autoloader->setFallbackAutoloader(true);

/** Initialization of the Sydney Application */
$app = new Sydney_Bootstrapper();
// If you want to re-locate the core just change the following :
$app->setCorePath(realpath(__DIR__.'/../../../core'));
$app->setInstancePath(realpath(__DIR__.'/../'));
$app->setModules(array(
    'default',
    'admin',
    'publicms'
));
$app->registerDefaultHelpers();
$app->registerContentTypeHelper('goto-top-block', 'Goto top', 'publicGotoTopView', 'privateGotoTopView', 'editorGotoTopView');
$app->registerContentTypeHelper('carousel-block', 'Carousel', 'publicCarouselView', 'privateCarouselView', 'editorCarouselView');
$app->run();