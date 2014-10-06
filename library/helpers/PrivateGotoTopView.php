<?php

class Helper_PrivateGotoTopView extends Zend_View_Helper_Abstract
{
    public function privateGotoTopView($actionsHtml = '', $content = '', $dbId = 0, $order = 0, $params = array(), $moduleName = 'adminpages', $pagstructureId = 0, $sharedInIds = '')
    {
        return '<li class="' . $params['addClass'] . ' sydney_editor_li"
                        data-content-type="goto-top-block"
						dbid="' . $dbId . '"
						dborder="' . $order . '"
						pagstructureid="' . $pagstructureId . '">
			' . $actionsHtml . '
			<div class="content">
				Go to top preview!
			</div>
		</li>';
    }
}