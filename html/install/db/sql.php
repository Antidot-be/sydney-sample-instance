<?php
$currentInstallPart = (!empty($_POST['part']))? (int) $_POST['part'] : -1;

if($currentInstallPart > 0){
    $corePath = __DIR__. '/../../../../../core/';
    $sydneyPath = $corePath . 'Sydney/';
    $zendLibPath = $corePath.'library/';
    set_include_path($zendLibPath. PATH_SEPARATOR . $sydneyPath . PATH_SEPARATOR . get_include_path());
    include_once('Zend/Loader/Autoloader.php');
    $autoloader = Zend_Loader_Autoloader::getInstance();
    $autoloader->setFallbackAutoloader(true);

    $configHandler = new Sydney_IniConfig('general');
    $configHandler->addConfigFile(realpath($corePath . '/webinstances/sydney/config/config.default.ini')); // Global and default config
    $configHandler->addConfigFile(realpath(__DIR__ . '/../../../config/config.ini')); // Webinstance specific
    $configHandler->addConfigFile(realpath(__DIR__ . '/../../../config/parameters.ini')); // Parameters
    $config = $configHandler->getConfig();
    $db = null;
    try{
        $db = Zend_Db::factory($config->db);
        $db->getConnection();
        Zend_Db_Table::setDefaultAdapter($db);
    } catch(Exception $e){
        header($_SERVER['SERVER_PROTOCOL'] . ' Db connexion error', true, 500);
        echo json_encode(array('message' => 'Can not connect to the DB!'));
    }

    if(1 === $currentInstallPart){
        /* Add the structure to the DB */
        $dbStructure = file_get_contents('db-structure.sql');
        $db->exec($dbStructure);
        echo json_encode(array('message' => 'Structure added to the db!'));
    } else if(2 === $currentInstallPart){
        /* Fill the DB with basics */
        $dbStructure = file_get_contents('db-data.sql');
        $db->exec($dbStructure);
        sleep(1);
        echo json_encode(array('message' => 'Basic data\'s added to the db!'));
    } else if(3 === $currentInstallPart){
        echo json_encode(array('langs' => $db->fetchAll('SELECT * FROM languages')));
    } else if(4 === $currentInstallPart){
        $errors = array();
        $availableLangs = array_values($db->fetchCol('SELECT id FROM languages'));
        if(empty($_POST['sitename'])){
            $errors[] = 'Site name is empty';
        }

        if(empty($_POST['domain']) || filter_var($_POST['domain'], FILTER_VALIDATE_URL) === false || !preg_match('#https?://#', $_POST['domain'])){
            $errors[] = 'Domain is empty or invalid (must begin with http(s)://)';
        }

        if(empty($_POST['language']) || !in_array($_POST['language'], $availableLangs)){
            $errors[] = 'Please select a specified language';
        }

        if(!empty($errors)){
            header($_SERVER['SERVER_PROTOCOL'] . 'Some errors', true, 500);
            echo json_encode(array('message' => implode('<br/>', $errors)));
        } else{
            // Ok ! Now we add the data's
            $db->insert('safinstances', array(
                'label' => $_POST['sitename'],
                'domain' => $_POST['domain'],
                'languages_id' => (int) $_POST['language'],
                'description' => $_POST['description'],
                'metakeywords' => $_POST['metakeywords'],
                'active' => 1
            ));
            $instanceId = $db->lastInsertId('safinstances');

            $instanceIniLockContent = <<<END
[general]
db.safinstances_id=$instanceId
END;
            file_put_contents(__DIR__.'/../../../config/instance.ini.lock', $instanceIniLockContent);
            echo json_encode(array('message' => 'Website created !', 'instanceId' => $instanceId));
        }
    } else if(5 === $currentInstallPart){

        $errors = array();
        if(empty($_POST['login'])){
            $errors[] = 'Specify a login';
        }
        if(empty($_POST['fname'])){
            $errors[] = 'Specify a first name';
        }
        if(empty($_POST['lname'])){
            $errors[] = 'Specify a last name';
        }
        if($_POST['password'] !== $_POST['password-confirmation']){
            $errors[] = 'Password and the confirmation are not the same';
        }
        if($errors){
            header($_SERVER['SERVER_PROTOCOL'] . 'Some errors', true, 500);
            echo json_encode(array('message' => implode('<br/>', $errors)));
        } else{
            $instanceId = (int) $_POST['instanceId'];
            $userId = $db->insert('users', array(
                'login' => $_POST['login'],
                'fname' => $_POST['fname'],
                'lname' => $_POST['lname'],
                'password' => md5($_POST['password']),
                'usersgroups_id' => 7, // max usergroup_id = god users
                'safinstances_id' => $instanceId
            ));

            $db->insert('safinstances_users', array(
                'safinstances_id' => $instanceId,
                'users_id' => $userId
            ));

            $file = file_get_contents('db-example-page.sql');
            $file = str_replace('{instanceid}', $_POST['instanceId'], $file);

            $db->exec($file);
            echo json_encode(array('message' => 'User created !'));
        }

    }

} else{
    header($_SERVER['SERVER_PROTOCOL'] . ' No install part given', true, 500);
    echo json_encode(array('message' => 'No install part mentionned ...'));
}