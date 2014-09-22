<?php include 'tpl/top.php';

######### PHP CHECK #########
$PHP = array('valid' => PHP_VERSION_ID > 50300);
$PHP['alert'] = (!$PHP)? 'You are using a too old version of PHP please use the most recent version you can' : 'Your PHP version seems ok! (version : ' . PHP_VERSION . ')';

$corePath = __DIR__. '/../../../../core/';
$sydneyPath = $corePath . 'Sydney/';



######### ZEND CHECK #########
$zendLibPath = $corePath.'library/';
set_include_path(
    $zendLibPath. PATH_SEPARATOR . $sydneyPath . PATH_SEPARATOR . get_include_path()
);

$ZEND['alert'] = '';
if (!is_readable($zendLibPath.'/Zend/Loader/Autoloader.php')) {
    $ZEND['valid'] = false;
    $ZEND['alert'] = 'Zend is not correctly installed on your system. Zend must be locate in : ' . realpath($zendLibPath);
} else{
    include_once('Zend/Loader/Autoloader.php');
    $autoloader = Zend_Loader_Autoloader::getInstance();
    $autoloader->setFallbackAutoloader(true);
    $ZEND['valid'] = true;
    $ZEND['alert'] = 'Zend is installed! (version: '.Zend_Version::VERSION.')';
}


$mustWritablePaths = array(
    __DIR__ . '/../../config/',
    __DIR__ . '/../../var/',
);
$RIGHTS['valid'] = false;
$RIGHTS['alert'] = '';
foreach($mustWritablePaths as $path){
    if(!is_writable($path)){
        $RIGHTS['alert'] .= 'It seems that "' . realpath($path) . '" is not writable.<br/>';
    }
}

if(empty($RIGHTS['alert'])){
    $RIGHTS['valid'] = true;
    $RIGHTS['alert'] = 'Rights on files seems ok!';
}


######### DB CHECK #########
$DB['valid'] = false;
if($ZEND['valid']){
    $configHandler = new Sydney_IniConfig('general');
    $configHandler->addConfigFile(realpath($corePath . '/webinstances/sydney/config/config.default.ini')); // Global and default config
    $configHandler->addConfigFile(realpath(__DIR__ . '/../../config/config.ini')); // Webinstance specific
    $configHandler->addConfigFile(realpath(__DIR__ . '/../../config/parameters.ini')); // Parameters
    $config = $configHandler->getConfig();

    if($config->db->adapter && $config->db->params->host && $config->db->params->username && $config->db->params->password  && $config->db->params->dbname ){

        try{
            $db = Zend_Db::factory($config->db);
            $db->getConnection()->exec("SET NAMES 'utf8' COLLATE 'utf8_unicode_ci'");
            Zend_Db_Table::setDefaultAdapter($db);

            if(!in_array('safinstances', $db->fetchCol('SHOW TABLES'))){
                $DB['valid'] = true;
                $DB['alert'] = 'Everything seems ok !';
            } else{
                $DB['alert'] = 'It seems that you have allready install Sydney !';
            }

        } catch(Exception $e){
            $DB['alert'] = 'It seems that one or more of the params are incorrect ! Canno\'t access to the database. Got this message : ' . $e->getMessage();
        }

    } else {
        $DB['alert'] = 'Some params in your parameters.ini are missing !';
    }

} else{
    $DB['alert'] = 'Zend required to use the database !';
}

?>
    <h1>Sydney</h1>

    <div class="panel panel-default">

        <div class="panel-heading">Welcome to the Sydney install!</div>
        <div class="panel-body">
            <p>Before you can begin with your new Sydney installation you need to check those requirements.</p>
        </div>

        <!-- List group -->
        <ul class="list-group">
            <li class="list-group-item">
                PHP version <br/>
                <div class="text-<?=($PHP['valid'])? 'success': 'danger';?>">
                    <span class="glyphicon glyphicon-<?=($PHP['valid'])? 'ok': 'remove';?>"></span> <?= $PHP['alert'];?>
                </div>
            </li>
            <li class="list-group-item">
                Zend <br/>
                <div class="text-<?=($ZEND['valid'])? 'success': 'danger';?>">
                    <span class="glyphicon glyphicon-<?=($ZEND['valid'])? 'ok': 'remove';?>"></span>  <?= $ZEND['alert'];?>
                </div>
            </li>
            <li class="list-group-item">
                Rights on folders <br/>
                <div class="text-<?=($RIGHTS['valid'])? 'success': 'danger';?>">
                    <span class="glyphicon glyphicon-<?=($RIGHTS['valid'])? 'ok': 'remove';?>"></span>  <?= $RIGHTS['alert'];?>
                </div>
            </li>
            <li class="list-group-item">
                Database <br/>
                <div class="text-<?=($DB['valid'])? 'success': 'danger';?>">
                    <span class="glyphicon glyphicon-<?=($DB['valid'])? 'ok': 'remove';?>"></span>  <?= $DB['alert'];?>
                </div>
            </li>
        </ul>
    </div>

    <div class="alerts-container"></div>

    <div class="progress hide">
        <div class="progress-bar progress-bar-striped active progress-bar-install" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">
            0%
        </div>
    </div>

    <div class="instance-form hide">
        <form method="post" action="" class="form-horizontal">

            <div class="form-group">
                <label for="sitename" class="col-sm-2 control-label">Site name</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="sitename" name="sitename" placeholder="ex: My super website">
                </div>
            </div>
            <div class="form-group">
                <label for="domain" class="col-sm-2 control-label">Domain of your website</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="domain" name="domain" placeholder="ex: http://mysite.com">
                </div>
            </div>
            <div class="form-group">
                <label for="description" class="col-sm-2 control-label">Description</label>
                <div class="col-sm-10">
                    <textarea name="description" id="description" class="form-control"></textarea>
                </div>
            </div>

            <div class="form-group">
                <label for="metakeywords" class="col-sm-2 control-label">Meta keywords</label>
                <div class="col-sm-10">
                    <textarea name="metakeywords" id="metakeywords" class="form-control"></textarea>
                </div>
            </div>
            <div class="form-group">
                <label for="domain" class="col-sm-2 control-label">Language</label>
                <div class="col-sm-10">
                    <select name="language" class="form-control"></select>
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <button type="submit" class="btn btn-primary btn-lg btn-block">Create website</button>
                </div>
            </div>
        </form>
    </div>

    <div class="user-form hide">
        <form method="post" action="" class="form-horizontal">
            <div class="form-group">
                <label for="fname" class="col-sm-2 control-label">First name</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="fname" name="fname" placeholder="Ex: John">
                </div>
            </div>
            <div class="form-group">
                <label for="lname" class="col-sm-2 control-label">Last name</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="lname" name="lname" placeholder="Ex: Doe">
                </div>
            </div>
            <div class="form-group">
                <label for="login" class="col-sm-2 control-label">Login</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="login" name="login" placeholder="Ex: mylogin or myadress@mail.com">
                </div>
            </div>
            <div class="form-group">
                <label for="password" class="col-sm-2 control-label">Password</label>
                <div class="col-sm-10">
                    <input type="password" class="form-control" id="password" name="password" placeholder="password">
                </div>
            </div>
            <div class="form-group">
                <label for="password" class="col-sm-2 control-label">Confirmation password</label>
                <div class="col-sm-10">
                    <input type="password" class="form-control" id="password" name="password-confirmation" placeholder="password confirmation">
                </div>
            </div>


            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <button type="submit" class="btn btn-primary btn-lg btn-block">Create user</button>
                </div>
            </div>
        </form>
    </div>

    <div class="page-header hide">
        <h1>Installation finish !</h1>
        <p>
            Congratulations !<br/>
            You can now log with the user previously create <a href="" class="admin-website">on the admin</a> or go <a href="" class="website">on your website</a>.
        </p>
    </div>

    <?php if($PHP['valid'] && $ZEND['valid'] && $DB['valid'] && $RIGHTS['valid']):?>
        <button type="button" class="btn btn-primary btn-lg btn-block install">Launch install now !</button>
    <?php endif; ?>


<?php include 'tpl/bottom.php'; ?>